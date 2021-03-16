

@testset "type layouts" begin
	rng = MersenneTwister(0)
	for _test in LAYOUT_TESTS
		for aggregate in ("struct", "union")
			for strategy in ("packed", nothing)
				for kind in (:random, :ones)
					val = kind === :ones ? Core.Intrinsics.sext_int(UInt128, 0xff) : rand(rng, UInt128)
					test = replace(_test, r"^\s*struct" => aggregate)
					test = isnothing(strategy) ? test : replace(test, r"};\s*$" => "} __attribute__(($(strategy)));")
					
					@debug "$(kind)\n$(test)"
					if VERSION >= v"1.6-" || !occursin("_Alignas", test)
						@test checkC(test, val) == checkJL(test, val)
					else
						@test_skip checkC(test, val) == checkJL(test, val)  # _Alignas is not yet supported using Clang 9 (Julia 1.5)
					end
				end
			end
		end
	end
end

