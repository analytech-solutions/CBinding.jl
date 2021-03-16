

macro cxx_str(exprs...) return clang_str(__module__, __source__, :cxx, exprs...) end
macro cxx_cmd(exprs...) return clang_cmd(__module__, __source__, :cxx, exprs...) end


Base.String(::Type{Context{:cxx}}) = "C++"


# TODO: implement me!

