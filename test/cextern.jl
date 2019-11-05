

@testset "@cextern + @cbindings" begin
	lib = Clibrary()
	
	@eval function jl_gc_total_bytes end
	@test length(methods(jl_gc_total_bytes)) == 0
	@cextern jl_gc_total_bytes()::Int64 lib
	@test length(methods(jl_gc_total_bytes)) == 1
	
	@cextern jl_main_module::Ptr{@cstruct jl_module_t} lib
	@cextern jl_core_module::Ptr{@cstruct jl_module_t} lib
	@test jl_main_module[] != C_NULL
	@test jl_core_module[] != C_NULL
	@test jl_main_module[] != jl_core_module[]
	
	@cbindings Clibrary() begin
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
		
		@cextern jl_base_module::Ptr{@cstruct jl_module_t}
		
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
	@test jl_base_module[] != C_NULL
	
	opts = Base.JLOptions()
	@test unsafe_string(opts.julia_bin) == unsafe_string(jl_options[].julia_bin)
	@test opts.opt_level == jl_options[].opt_level
	@test opts.debug_level == jl_options[].debug_level
end

