

field(ca::CA, arg) where {CA<:Union{Caggregate, Carray}} = field(typeof(ca), arg)

field(::Type{CA}, i::Integer) where {T, N, CA<:Carrays{T, N}} = Tuple{T, bitstype(T), integraltype(T), sizeof(Carray{T, i-1}), 0, -1}

field(::Type{CA}, sym::Symbol) where {CA<:Caggregates} = field(fields(bitstype(CA)), Val(sym))
@generated function field(::Type{fields}, ::Val{sym}) where {fields<:Tuple, sym}
	for T in fields
		(n, t) = T
		n === sym && return t
	end
	return nothing
end


function bitmask(::Type{uint}, bits::Integer) where {uint}
	mask = zero(uint)
	for i in 1:bits
		mask = (mask << one(uint)) | one(uint)
	end
	return uint(mask)
end


function loadmasked(::Type{int}, isptr::Bool, bytes::Integer, bits::Integer, size::Integer) where {int<:Integer}
	expr = []
	
	uint = unsigned(int)
	m = bitmask(uint, size)
	push!(expr, :(load = (load >> $(uint)($(bits))) & $(uint)($(m))))
	int <: Signed && push!(expr, :(load = Bool((load >> $(size-1)) & 1) ? load | (~zero($(uint)) & ~$(uint)($(m))) : load))
	
	return expr
end


function storemasked(::Type{int}, isptr::Bool, bytes::Integer, bits::Integer, size::Integer) where {int<:Integer}
	expr = []
	
	uint = unsigned(int)
	mask = bitmask(uint, size) << bits
	append!(expr, loadbytes(int, isptr, bytes, bits, size))
	push!(expr, :(store = ((store << $(bits)) & $(uint)($(mask))) | (load & ~$(uint)($(mask)))))
	
	return expr
end


function loadbytes(::Type{int}, isptr::Bool, bytes::Integer, bits::Integer, size::Integer) where {int<:Integer}
	expr = []
	
	uint = unsigned(int)
	size = size < 0 ? sizeof(uint)*8 : size
	
	push!(expr, :(load = zero($(uint))))
	for i in (ENDIAN_BOM == 0x01020304 ? (1:sizeof(uint)) : reverse(1:sizeof(uint)))
		push!(expr, :(load = (load << 8)))
		if bits÷8 <= i-1 <= (bits+size-1)÷8
			if isptr
				push!(expr, :(load |= $(uint)(unsafe_load(Core.Intrinsics.bitcast(Cptr{UInt8}, ca), $(bytes+i)))))
			else
				push!(expr, :(load |= $(uint)(getfield(ca, :mem)[$(bytes+i)])))
			end
		end
	end
	
	return expr
end


function storebytes(::Type{int}, isptr::Bool, bytes::Integer, bits::Integer, size::Integer) where {int<:Integer}
	expr = []
	
	uint = unsigned(int)
	size = size < 0 ? sizeof(uint)*8 : size
	
	isptr || push!(expr, :(mem = getfield(ca, :mem)))
	for i in (ENDIAN_BOM == 0x01020304 ? reverse(1:sizeof(uint)) : (1:sizeof(uint)))
		if bits÷8 <= i-1 <= (bits+size-1)÷8
			if isptr
				push!(expr, :(unsafe_store!(Core.Intrinsics.bitcast(Cptr{UInt8}, ca), store & 0xff, $(bytes+i))))
			else
				push!(expr, :(mem = (mem[1:$(bytes+i-1)]..., UInt8(store & 0xff), mem[$(bytes+i+1):end]...,)))
			end
		end
		push!(expr, :(store = store >> 8))
	end
	
	return expr
end




load(ca::CA, ::Type{Tuple{t, u, i, o, b, s}}) where {CA<:Union{Caggregate, Carray, Cptr{<:Caggregates}}, t, u, i, o, b, s} = load(ca, Tuple{t, u, i, o, b, s}, Val(!(CA <: Cptr) || s >= 0))

function load(ca::CA, ::Type{Tuple{t, u, i, o, b, s}}, ::Val) where {CA<:Union{Caggregate, Carray}, t, u, i<:Nothing, o, b, s}
	u <: Union{Caggregate, Carray} || return error("Unexpected type $(t) in load function")
	return u(undef, getfield(ca, :mem)[o+1:o+sizeof(u)])
end

function load(ca::CA, ::Type{Tuple{t, u, i, o, b, s}}, ::Val{false}) where {CA<:Cptr{<:Caggregates}, t, u, i, o, b, s}
	i <: Integer || u <: Union{Caggregate, Carray} || return error("Unexpected type $(t) in load function")
	x = isqualifiedwith(eltype(CA), Cconst) && !isqualifiedwith(t, Cconst) ? Cconst{t} : t
	return Core.Intrinsics.bitcast(Cptr{x}, Core.Intrinsics.bitcast(Cptr{UInt8}, ca) + o)
end

@generated function load(ca::CA, ::Type{Tuple{t, u, i, o, b, s}}, ::Val{true}) where {CA<:Union{Caggregate, Carray, Cptr{<:Caggregates}}, t, u, i<:Integer, o, b, s}
	expr = quote end
	
	append!(expr.args, loadbytes(i, CA <: Cptr, o, b, s))
	s >= 0 && append!(expr.args, loadmasked(i, CA <: Cptr, o, b, s))
	push!(expr.args, :(return Core.Intrinsics.bitcast($(u), load)))
	
	return expr
end



store!(ca::CA, ::Type{Tuple{t, u, i, o, b, s}}, val) where {CA<:Union{Caggregate, Carray, Cptr{<:Caggregates}}, t, u, i, o, b, s} = store!(ca, Tuple{t, u, i, o, b, s}, Val(!(CA <: Cptr) || s >= 0), val)

function store!(ca::CA, ::Type{Tuple{t, u, i, o, b, s}}, ::Val, val) where {CA<:Union{Caggregate, Carray}, t, u, i<:Nothing, o, b, s}
	u <: Union{Caggregate, Carray} || return error("Unexpected type $(t) in store! function")
	return CA(undef, (getfield(ca, :mem)[1:o]..., getfield(convert(u, val), :mem)..., getfield(ca, :mem)[o+sizeof(u)+1:end]...,))
end

function store!(ca::CA, ::Type{Tuple{t, u, i, o, b, s}}, ::Val{false}, val) where {CA<:Cptr{<:Caggregates}, t, u, i, o, b, s}
	u <: Union{Caggregate, Carray} || return error("Unexpected type $(t) in store! function")
	unsafe_store!(Core.Intrinsics.bitcast(Cptr{u}, Core.Intrinsics.bitcast(Cptr{UInt8}, ca) + o), convert(u, val))
	return val
end

@generated function store!(ca::CA, ::Type{Tuple{t, u, i, o, b, s}}, ::Val{true}, val) where {CA<:Union{Caggregate, Carray, Cptr{<:Caggregates}}, t, u, i<:Integer, o, b, s}
	expr = quote end
	
	uint = unsigned(i)
	push!(expr.args, :(store = Core.Intrinsics.bitcast($(uint), convert($(u), val))))
	s >= 0 && append!(expr.args, storemasked(i, CA <: Cptr, o, b, s))
	append!(expr.args, storebytes(i, CA <: Cptr, o, b, s))
	push!(expr.args, CA <: Cptr ? :(return val) : :(return CA(undef, mem)))
	
	return expr
end

