

Base.Enums.basetype(::Type{CE}) where {CE<:Cenum} = Base.Enums.basetype(bitstype(CE))

Base.Enums.namemap(ce::Cenum) = Base.Enums.namemap(typeof(ce))
function Base.Enums.namemap(::Type{CE}) where {CE<:Cenum}
	result = ()
	for (n, v) in values(bitstype(CE))
		result = (result..., (n, v))
	end
	return result
end



(::Type{CE})(val::Integer = 0) where {CE<:Cenum} = Core.Intrinsics.bitcast(bitstype(CE), convert(Base.Enums.basetype(CE), val))::CE
(::Type{T})(ce::CE) where {T<:Integer, CE<:Cenum} = convert(T, Core.Intrinsics.bitcast(Base.Enums.basetype(CE), ce))::T

Base.sizeof(::Type{CE}) where {CE<:Cenum} = invoke(sizeof, Tuple{Any}, bitstype(CE))
Base.zero(::Type{CE}) where {CE<:Cenum} = CE()

Base.convert(::Type{CE}, val::Integer) where {CE<:Cenum} = CE(val)
Base.convert(::Type{T}, ce::CE) where {CE<:Cenum, T<:Integer} = T(ce)

Base.promote_rule(::Type{T}, ::Type{CE}) where {T<:Integer, CE<:Cenum} = promote_type(T, Base.Enums.basetype(CE))
Base.:(~)(ce::CE) where {CE<:Cenum} = ~convert(Base.Enums.basetype(CE), ce)
for op in (:+, :-, :&, :|, :xor, :(==))
	@eval begin
		Base.$(op)(x::CE, y::CE) where {CE<:Cenum} = ($op)(Core.Intrinsics.bitcast(Base.Enums.basetype(CE), x), Core.Intrinsics.bitcast(Base.Enums.basetype(CE), y))
		Base.$(op)(x::CE, y::T) where {CE<:Cenum, T<:Integer} = ($op)(promote_type(T, CE)(x), promote_type(T, CE)(y))
		Base.$(op)(x::T, y::CE) where {T<:Integer, CE<:Cenum} = ($op)(promote_type(T, CE)(x), promote_type(T, CE)(y))
	end
end


function Base.typemin(::Type{CE}) where {CE<:Cenum}
	x = nothing
	for (n, v) in Base.Enums.namemap(CE)
		x = x === nothing || v < x ? v : x
	end
	return x === nothing ? CE() : CE(x)
end

function Base.typemax(::Type{CE}) where {CE<:Cenum}
	x = nothing
	for (n, v) in Base.Enums.namemap(CE)
		x = x === nothing || v >= x ? v : x
	end
	return x === nothing ? CE() : CE(x)
end

function Base.instances(::Type{CE}) where {CE<:Cenum}
	result = ()
	for (n, v) in Base.Enums.namemap(CE)
		result = (result..., CE(v))
	end
	return result
end

function Base.Symbol(ce::Cenum)
	for (n, v) in Base.Enums.namemap(ce)
		typeof(v)(ce) == v && return n::Symbol
	end
	error("Value of $(typeof(ce)) is not one of $(join(map(first, Base.Enums.namemap(ce)), ", "))")
end


function Base.show(io::IO, ce::Cenum)
	for (ind, val) in enumerate(sort(collect(instances(typeof(ce))), by = val -> convert(Base.Enums.basetype(typeof(ce)), val)))
		if ce == val
			print(io, Symbol(ce))
			return
		end
	end
	
	show(io, typeof(ce))
	print(io, " (")
	show(io, convert(Base.Enums.basetype(typeof(ce)), ce))
	println(io, ')')
end

function Base.show(io::IO, m::MIME"text/plain", ce::Cenum)
	show(io, typeof(ce))
	print(io, " (")
	show(io, convert(Base.Enums.basetype(typeof(ce)), ce))
	println(io, ')')
	
	numvals = length(instances(typeof(ce)))
	maxwidth = mapreduce(val -> length(String(Symbol(val))), max, instances(typeof(ce)), init = 0)
	
	indent = get(io, :indent, 1)
	prefix = repeat("  ", indent-1)
	for (ind, val) in enumerate(sort(collect(instances(typeof(ce))), by = val -> convert(Base.Enums.basetype(typeof(ce)), val)))
		select = ce == val ? "->" : "  "
		print(io, prefix, select, rpad(String(Symbol(val)), maxwidth), " (")
		show(io, convert(Base.Enums.basetype(typeof(ce)), val))
		print(io, ')')
		ind < numvals && println(io)
	end
end

function Base.show(io::IO, m::MIME"text/plain", ce::Type{<:Cenum})
	show(io, ce)
	
	numvals = length(instances(ce))
	println(io, " (", numvals, " option", numvals > 1 ? "s)" : ")")
	
	maxwidth = mapreduce(val -> length(String(Symbol(val))), max, instances(ce), init = 0)
	
	indent = get(io, :indent, 1)
	prefix = repeat("  ", indent)
	for (ind, val) in enumerate(sort(collect(instances(ce)), by = val -> convert(Base.Enums.basetype(ce), val)))
		print(io, prefix, rpad(String(Symbol(val)), maxwidth), " (")
		show(io, convert(Base.Enums.basetype(ce), val))
		print(io, ')')
		ind < numvals && println(io)
	end
end


