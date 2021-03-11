

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

