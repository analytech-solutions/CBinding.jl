

@testset "@cextern + @cbindings" begin
	@cextern asprintf(str::Ptr{Ptr{Cchar}}, fmt::Cstring, args...)::Cint
	str = Ref(Ptr{Cchar}(C_NULL))
	len = asprintf(str, "%s i%c %d great test of CBinding.jl v%3.1f%c\n", "This", 's', 0x01, 0.1, '!')
	expect = "This is 1 great test of CBinding.jl v0.1!\n"
	@test len == length(expect)
	@test unsafe_string(str[]) == expect
	Libc.free(str[])
	@test_throws MethodError asprintf(1234)
	@test_throws MethodError asprintf(1234, "still wrong")
	
	@cextern (asprintf => my_asprintf)(str::Ptr{Ptr{Cchar}}, fmt::Cstring, args...)::Cint
	len = my_asprintf(str, "%s i%c %d great test of CBinding.jl v%3.1f%c\n", "This", 's', 0x01, 0.1, '!')
	@test len == length(expect)
	@test unsafe_string(str[]) == expect
	Libc.free(str[])
	
	@cextern ("".asprintf => my_asprintf)(str::Ptr{Ptr{Cchar}}, fmt::Cstring, args...)::Cint
	len = my_asprintf(str, "%s i%c %d great test of CBinding.jl v%3.1f%c\n", "This", 's', 0x01, 0.1, '!')
	@test len == length(expect)
	@test unsafe_string(str[]) == expect
	Libc.free(str[])
	
	@cextern "".asprintf(str::Ptr{Ptr{Cchar}}, fmt::Cstring, args...)::Cint
	len = asprintf(str, "%s i%c %d great test of CBinding.jl v%3.1f%c\n", "This", 's', 0x01, 0.1, '!')
	@test len == length(expect)
	@test unsafe_string(str[]) == expect
	Libc.free(str[])
	
	
	@eval function jl_ver_major end
	@test length(methods(jl_ver_major)) == 0
	@cextern jl_ver_major()::Cint
	@test length(methods(jl_ver_major)) == 1
	
	if !Sys.iswindows() || !(VERSION >= v"1.6-")
		@cextern jl_main_module::Ptr{@cstruct jl_module_t}
		@cextern jl_core_module::Ptr{@cstruct jl_module_t}
		@test jl_main_module()[] != C_NULL
		@test jl_core_module()[] != C_NULL
		@test jl_main_module()[] != jl_core_module()[]
	end
	
	@eval @cbindings begin
		@ctypedef jl_value_t @cstruct _jl_value_t
		
		@cextern jl_gc_enable(on::Cint)::Cint
		@cextern jl_gc_is_enabled()::Cint
		
		@cextern jl_gc_alloc_0w()::Ptr{jl_value_t}
		@cextern jl_gc_alloc_1w()::Ptr{jl_value_t}
		@cextern jl_gc_alloc_2w()::Ptr{jl_value_t}
		false || @cextern jl_gc_alloc_3w()::Ptr{jl_value_t}
		if true
			@cextern jl_gc_allocobj(sz::Csize_t)::Ptr{jl_value_t}
		end
		
		if !Sys.iswindows() || !(VERSION >= v"1.6-")
			@cextern jl_base_module::Ptr{@cstruct jl_module_t}
		end
		
		@cextern jl_options::@cstruct {
			quiet::Int8
			banner::Int8
			julia_bindir::Cstring
			julia_bin::Cstring
			cmds::Ptr{Cstring}
			image_file::Cstring
			cpu_target::Cstring
			nprocs::Int32
			machine_file::Cstring
			project::Cstring
			isinteractive::Int8
			color::Int8
			historyfile::Int8
			startupfile::Int8
			compile_enabled::Int8
			code_coverage::Int8
			malloc_log::Int8
			opt_level::Int8
			debug_level::Int8
			check_bounds::Int8
			depwarn::Int8
			warn_overwrite::Int8
			can_inline::Int8
			polly::Int8
			trace_compile::Cstring
			fast_math::Int8
			worker::Int8
			cookie::Cstring
			handle_signals::Int8
			use_sysimage_native_code::Int8
			use_compiled_modules::Int8
			bindto::Cstring
			outputbc::Cstring
			outputunoptbc::Cstring
			outputjitbc::Cstring
			outputo::Cstring
			outputji::Cstring
			output_code_coverage::Cstring
			incremental::Int8
			image_file_specified::Int8
		}
	end
	@test length(methods(jl_gc_enable)) == 1
	@test length(methods(jl_gc_is_enabled)) == 1
	@test length(methods(jl_gc_alloc_0w)) == 1
	@test length(methods(jl_gc_alloc_1w)) == 1
	@test length(methods(jl_gc_alloc_2w)) == 1
	@test length(methods(jl_gc_alloc_3w)) == 1
	@test length(methods(jl_gc_allocobj)) == 1
	if !Sys.iswindows() || !(VERSION >= v"1.6-")
		@test jl_base_module()[] != C_NULL
	end
	
	opts = Base.JLOptions()
	@test unsafe_string(opts.julia_bin) == unsafe_string(jl_options().julia_bin)
	@test opts.opt_level == jl_options().opt_level
	@test opts.debug_level == jl_options().debug_level
end

