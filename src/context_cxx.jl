

macro cxx_str(exprs...) return clang_str(__module__, __source__, :cxx, exprs...) end
macro cxx_cmd(exprs...) return clang_cmd(__module__, __source__, :cxx, exprs...) end


const CXX_HEADER = joinpath(@__DIR__, "$(nameof(@__MODULE__)).hpp")
header(::Type{Context{:cxx}}) = CXX_HEADER
Base.String(::Type{Context{:cxx}}) = "C++"


# TODO: implement me!

