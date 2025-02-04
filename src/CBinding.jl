module CBinding
	using Libdl
	using Markdown
	using Scratch
	
	
	# TODO: something for Base?
	Base.iterate(::Type{T}, state::Type{<:Tuple} = T) where {T<:Tuple} = state === Tuple{} ? nothing : (Base.tuple_type_head(state), Base.tuple_type_tail(state))
	
	
	export @cc_cmd
	export @c_cmd, @c_str
	# export @cxx_cmd, @cxx_str
	export Cbool, Ccomplex, Cmem8, Cmem16, Cmem32, Cmem64, Cmem128, Clongdouble
	export Cptr, Cstruct, Cunion, Cenum, Carray
	export Cfunction, Cbinding, Cconst, Crestrict, Cvolatile
	export isqualifiedwith, unqualifiedtype, bitstype
	
	
	const Cbool    = Cuchar
	const Ccomplex = Complex
	primitive type Cmem8 <: Unsigned 8 end
	primitive type Cmem16 <: Unsigned 16 end
	primitive type Cmem32 <: Unsigned 32 end
	primitive type Cmem64 <: Unsigned 64 end
	primitive type Cmem128 <: Unsigned 128 end
	primitive type Clongdouble <: AbstractFloat 2*sizeof(Cdouble)*8 end
	
	primitive type Cptr{T} <: Ref{T} sizeof(Ptr)*8 end
	
	abstract type Caggregate end
	abstract type Cstruct <: Caggregate end
	abstract type Cunion <: Caggregate end
	
	abstract type Cenum end
	
	
	# TODO: whenever `incomplete type` becomes available, this can become Carray{T, N} with NTuple{N, T}
	struct Carray{T, N, S} <: AbstractVector{T}
		mem::NTuple{S, UInt8}
		
		Carray{T, N, S}(::UndefInitializer, mem::NTuple{S, UInt8}) where {T, N, S} = new{T, N, S}(mem)
	end
	
	
	struct Cfunction{ret, args<:Tuple, conv}
		let constructor = false end
	end
	
	abstract type Cbinding{T, lib, name} end
	Base.eltype(::Type{CB}) where {T, CB<:Cbinding{T}} = T
	
	struct Cvariadic
		let constructor = false end
	end
	
	
	abstract type Cqualifier{T} end
	Base.eltype(::Type{CQ}) where {T, CQ<:Cqualifier{T}} = T
	
	struct Cconst{T} <: Cqualifier{T}
		let constructor = false end
	end
	
	struct Crestrict{T} <: Cqualifier{T}
		let constructor = false end
	end
	
	struct Cvolatile{T} <: Cqualifier{T}
		let constructor = false end
	end
	
	
	const Cqualifiers{T} = Union{T, Cconst{T}, Crestrict{T}, Cvolatile{T}} where {T}
	const Cptrs{T} = Union{Cptr{T}, Cconst{Cptr{T}}} where {T}
	const Carrays{T, N} = Union{Carray{T, N}, Cconst{Carray{T, N}}} where {T, N}
	const Caggregates = Union{CA, Cconst{CA}} where {CA<:Caggregate}
	const Cenums = Union{CE, Cconst{CE}} where {CE<:Cenum}
	
	
	isqualifiedwith(::Type{T}, ::Type{CQ}) where {T, CQ<:Cqualifier} = T <: Cqualifier ? T <: CQ ? true : isqualifiedwith(eltype(T)) : false
	
	unqualifiedtype(::Type{T}) where {T} = T <: Cconst || T <: Cvolatile || T <: Crestrict ? unqualifiedtype(eltype(T)) : T
	
	function integraltype(::Type{T}) where {T}
		U = bitstype(T)
		isprimitivetype(U) || return Nothing
		U <: Cenum && return Base.Enums.basetype(U)
		I = sizeof(U) == 1 ? UInt8 : sizeof(U) == 2 ? UInt16 : sizeof(U) == 4 ? UInt32 : sizeof(U) == 8 ? UInt64 : UInt128
		return U <: Signed ? signed(I) : unsigned(I)
	end
	
	bitstype(::Type{T}; raise::Bool = true) where {T} = isbitstype(T) ? T : raise ? error("Failure to obtain a bits-type") : nothing
	bitstype(::Type{CQ}; kwargs...) where {CQ<:Cqualifier} = bitstype(unqualifiedtype(CQ); kwargs...)
	bitstype(::Type{CA}; kwargs...) where {T, N, CA<:Carray{T, N}} = bitstype(T; kwargs...) === nothing ? nothing : Carray{bitstype(T), N, sizeof(bitstype(T))*N}
	
	values(::Type{CE}) where {CE<:Cenum} = bitstype(CE; raise = false) === nothing ? () : values(bitstype(CE))
	
	fields(::Type{CA}) where {CA<:Caggregate} = bitstype(CA; raise = false) === nothing ? () : fields(bitstype(CA))
	
	
	include("longdouble.jl")
	include("arrays.jl")
	include("bindings.jl")
	include("pointers.jl")
	include("functions.jl")
	include("enums.jl")
	include("aggregates.jl")
	include("accessors.jl")
	
	
	include("libclang.jl")
	
	
	struct CodeLocation
		file::String
		line::Int
		column::Int
	end
	
	struct CodeBlock
		loc::LineNumberNode
		lines::UnitRange{Int64}
		flags::NamedTuple
		inlines::Vector{String}
	end
	
	mutable struct Context{lang}
		mod::Module
		args::Vector{String}
		ind::Union{CXIndex, Nothing}
		tu::Ref{CXTranslationUnit}
		line::Int
		libs::Vector{Pair}
		hdrs::Dict{String, String}
		macros::Dict{String, CXCursor}
		bindings::Vector{Symbol}
		blocks::Vector{CodeBlock}
		src::IOBuffer
		
		function Context{lang}(mod::Module, args...) where {lang}
			ctx = new{lang}(mod, map(String, collect(args)), nothing, Ref(CXTranslationUnit(C_NULL)), 0, Pair[], Dict{String, String}(), Dict{String, CXCursor}(), Symbol[], CodeBlock[], IOBuffer())
			finalizer(ctx) do x
				x.tu[] == C_NULL || clang_disposeTranslationUnit(x.tu[])
				isnothing(x.ind) || x.ind == C_NULL || clang_disposeIndex(x.ind)
				foreach(lib -> dlclose(lib.first), x.libs)
			end
			
			configure!(ctx)
			parse!(ctx)
			
			return ctx
		end
	end
	
	
	include("context.jl")
	include("context_c.jl")
	include("context_cxx.jl")
	include("comments.jl")
end
