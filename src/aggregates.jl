

(::Type{CA})(::UndefInitializer) where {CA<:Caggregate} = init(bitstype(CA), Val(sizeof(CA)))
@generated function init(::Type{CA}, ::Val{size}) where {CA<:Caggregate, size}
	init = ((zero(UInt8) for _ in 1:size)...,)
	return :(CA(undef, $(init)))
end


function (::Type{CA})(init::Union{NTuple{N, UInt8} where {N}, CA, Cbinding{CA}, Cptrs{CA}, UndefInitializer} = undef; kwargs...) where {CA<:Caggregate}
	result =
		init isa UndefInitializer ? bitstype(CA)(undef) :
		init isa Tuple ? bitstype(CA)(undef, init) :
		init isa Cbinding ? init[] :
		init isa Cptrs ? init[] :
		init
	
	for kwarg in kwargs
		result = initproperty(result, kwarg...)
	end
	
	return result
end

Base.read(io::IO, ::Type{CA}) where {CA<:Caggregate} = CA(((read(io, UInt8) for _ in 1:sizeof(CA))...,))

Base.sizeof(::Type{CA}) where {CA<:Caggregate} = invoke(sizeof, Tuple{Any}, bitstype(CA))
Base.zero(::Type{CA}) where {CA<:Caggregate} = CA()
Base.convert(::Type{CA}, nt::NamedTuple) where {CA<:Caggregate} = CA(; nt...)


Base.fieldcount(::Type{CA}) where {CA<:Caggregates} = length(fieldnames(CA))
Base.fieldtypes(::Type{CA}) where {CA<:Caggregates} = ((Base.tuple_type_head(t) for (n, t) in fields(CA))...,)
Base.fieldnames(::Type{CA}) where {CA<:Caggregates} = ((n for (n, t) in fields(CA))...,)
Base.propertynames(::CA) where {CA<:Caggregates} = fieldnames(CA)


Base.getproperty(ca::CA, sym::Symbol) where {CA<:Caggregates} = field(CA, sym) === nothing ? error("type $(CA) has no field $(sym)") : load(ca, field(CA, sym))
Base.setproperty!(ca::CA, sym::Symbol, val) where {CA<:Caggregate} = error("cannot set value of field $(sym) in type $(CA)")
initproperty(ca::CA, sym::Symbol, val) where {CA<:Caggregate} = field(CA, sym) === nothing ? error("type $(CA) has no field $(sym)") : store!(ca, field(CA, sym), val)


function Base.show(io::IO, m::MIME"text/plain", ::Type{C}) where {C<:Union{Caggregates, Cenums, Carrays, Cptrs}}
	if isbitstype(C)
		# TODO: pretty-print types into c"Module.libmodule.struct S" format
		Base.show_datatype(io, C)
	else
		invoke(show, Tuple{IO, MIME"text/plain", Type}, io, m, C)
	end
end

function Base.show(io::IO, ca::Caggregate)
	show(io, typeof(ca))
	print(io, '(')
	if get(io, :compact, false)
		print(io, "...")
	else
		for (ind, name) in enumerate(fieldnames(typeof(ca)))
			ind > 1 && print(io, ", ")
			print(io, name, "=")
			show(io, getproperty(ca, name))
		end
	end
	print(io, ')')
end

function Base.show(io::IO, m::MIME"text/plain", ca::Caggregate)
	show(io, typeof(ca))
	println(io, " (", sizeof(ca), "-byte ", ca isa Cstruct ? "struct)" : "union)")
	
	numfields = length(fieldnames(typeof(ca)))
	maxwidth = 0
	for (ind, name) in enumerate(fieldnames(typeof(ca)))
		if ind < numfields && getproperty(ca, name) isa Union{Caggregates, Cenums}
			maxwidth = 0
			break
		end
		maxwidth = max(maxwidth, length(String(name)))
	end
	
	indent = get(io, :indent, 1)
	prefix = repeat("  ", indent)
	sub = IOContext(io, :indent => indent+1)
	for (ind, name) in enumerate(fieldnames(typeof(ca)))
		field = getproperty(ca, name)
		print(sub, prefix, rpad(String(name), maxwidth), " = ")
		field isa Union{Caggregates, Cenums} ? show(sub, m, field) : show(sub, field)
		ind < numfields && println(sub)
	end
end



