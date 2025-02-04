begin
    const basedir = "$(CBinding.dirname(CBinding.dirname(CBinding.libclang_path())))"
    const incdir = "$(basedir)/include"
    const libdir = "$(basedir)/$(if Sys.iswindows()
    "bin"
else
    "lib"
end)"
    const libpath = Symbol("$(libdir)/libclang")
    const var"c\"time_t\"" = Nothing
    const var"c\"size_t\"" = UInt64
    begin
        CBinding.include_dependency("$(incdir)/clang-c/Documentation.h")
        CBinding.include_dependency("$(incdir)/clang-c/CXErrorCode.h")
        CBinding.include_dependency("$(incdir)/clang-c/ExternC.h")
        CBinding.include_dependency("$(incdir)/clang-c/Platform.h")
        CBinding.include_dependency("$(incdir)/clang-c/Index.h")
        CBinding.include_dependency("$(incdir)/clang-c/BuildSystem.h")
        CBinding.include_dependency("$(incdir)/clang-c/CXString.h")
        CBinding.include_dependency("$(incdir)/clang-c/CXDiagnostic.h")
        CBinding.include_dependency("$(incdir)/clang-c/CXSourceLocation.h")
        CBinding.include_dependency("$(incdir)/clang-c/CXFile.h")
        abstract type var"c\"enum CXErrorCode\"" <: Cenum end
        const CXErrorCode = var"c\"enum CXErrorCode\""
        export var"c\"enum CXErrorCode\""
        export CXErrorCode
        var"c\"enum CXErrorCode\""
        primitive type var"(c\"enum CXErrorCode\")" <: var"c\"enum CXErrorCode\"" 32 end
        (::(Type){var"(c\"enum CXErrorCode\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXErrorCode\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXErrorCode\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXError_Success\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXError_Failure\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXError_Crashed\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXError_InvalidArguments\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXError_ASTReadError\""), 0x0000000000000004}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXErrorCode\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXErrorCode\")"}) = begin
                var"(c\"enum CXErrorCode\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXErrorCode\""}) = begin
                var"(c\"enum CXErrorCode\")"
            end
        const var"c\"CXError_Success\"" = var"(c\"enum CXErrorCode\")"(0x0000000000000000)
        const var"c\"CXError_Failure\"" = var"(c\"enum CXErrorCode\")"(0x0000000000000001)
        const var"c\"CXError_Crashed\"" = var"(c\"enum CXErrorCode\")"(0x0000000000000002)
        const var"c\"CXError_InvalidArguments\"" = var"(c\"enum CXErrorCode\")"(0x0000000000000003)
        const var"c\"CXError_ASTReadError\"" = var"(c\"enum CXErrorCode\")"(0x0000000000000004)
        const CXErrorCode = var"c\"enum CXErrorCode\""
        const CXError_Success = var"c\"CXError_Success\""
        const CXError_Failure = var"c\"CXError_Failure\""
        const CXError_Crashed = var"c\"CXError_Crashed\""
        const CXError_InvalidArguments = var"c\"CXError_InvalidArguments\""
        const CXError_ASTReadError = var"c\"CXError_ASTReadError\""
        export var"c\"enum CXErrorCode\"", var"(c\"enum CXErrorCode\")", var"c\"CXError_Success\"", var"c\"CXError_Failure\"", var"c\"CXError_Crashed\"", var"c\"CXError_InvalidArguments\"", var"c\"CXError_ASTReadError\""
        export CXErrorCode, CXError_Success, CXError_Failure, CXError_Crashed, CXError_InvalidArguments, CXError_ASTReadError
        var"c\"enum CXErrorCode\""
        abstract type var"c\"CXString\"" <: Cstruct end
        const CXString = var"c\"CXString\""
        export var"c\"CXString\""
        export CXString
        var"c\"CXString\""
        struct var"(c\"CXString\")" <: var"c\"CXString\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"CXString\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXString\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:data, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}), 0, 0, -1}}, CBinding.Tuple{:private_flags, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXString\")"}) = begin
                var"(c\"CXString\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXString\""}) = begin
                var"(c\"CXString\")"
            end
        const CXString = var"c\"CXString\""
        export var"c\"CXString\"", var"(c\"CXString\")"
        export CXString
        var"c\"CXString\""
        abstract type var"c\"CXStringSet\"" <: Cstruct end
        const CXStringSet = var"c\"CXStringSet\""
        export var"c\"CXStringSet\""
        export CXStringSet
        var"c\"CXStringSet\""
        struct var"(c\"CXStringSet\")" <: var"c\"CXStringSet\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"CXStringSet\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXStringSet\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:Strings, CBinding.Tuple{CBinding.Cptr{var"c\"CXString\""}, CBinding.bitstype(CBinding.Cptr{var"c\"CXString\""}), CBinding.integraltype(CBinding.Cptr{var"c\"CXString\""}), 0, 0, -1}}, CBinding.Tuple{:Count, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXStringSet\")"}) = begin
                var"(c\"CXStringSet\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXStringSet\""}) = begin
                var"(c\"CXStringSet\")"
            end
        const CXStringSet = var"c\"CXStringSet\""
        export var"c\"CXStringSet\"", var"(c\"CXStringSet\")"
        export CXStringSet
        var"c\"CXStringSet\""
        struct Cbinding_clang_getCString{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Tuple{var"c\"CXString\""}, :cdecl}, libpath, :clang_getCString}
        end
        const var"c\"clang_getCString\"" = Cbinding_clang_getCString{:clang_getCString}()
        (func::Cbinding_clang_getCString)(var"c\"string\"") = begin
                CBinding.funccall(func, var"c\"string\"")
            end
        const clang_getCString = var"c\"clang_getCString\""
        export var"c\"clang_getCString\""
        export clang_getCString
        var"c\"clang_getCString\""
        struct Cbinding_clang_disposeString{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXString\""}, :cdecl}, libpath, :clang_disposeString}
        end
        const var"c\"clang_disposeString\"" = Cbinding_clang_disposeString{:clang_disposeString}()
        (func::Cbinding_clang_disposeString)(var"c\"string\"") = begin
                CBinding.funccall(func, var"c\"string\"")
            end
        const clang_disposeString = var"c\"clang_disposeString\""
        export var"c\"clang_disposeString\""
        export clang_disposeString
        var"c\"clang_disposeString\""
        struct Cbinding_clang_disposeStringSet{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{var"c\"CXStringSet\""}}, :cdecl}, libpath, :clang_disposeStringSet}
        end
        const var"c\"clang_disposeStringSet\"" = Cbinding_clang_disposeStringSet{:clang_disposeStringSet}()
        (func::Cbinding_clang_disposeStringSet)(var"c\"set\"") = begin
                CBinding.funccall(func, var"c\"set\"")
            end
        const clang_disposeStringSet = var"c\"clang_disposeStringSet\""
        export var"c\"clang_disposeStringSet\""
        export clang_disposeStringSet
        var"c\"clang_disposeStringSet\""
        struct Cbinding_clang_getBuildSessionTimestamp{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Culonglong, CBinding.Tuple{}, :cdecl}, libpath, :clang_getBuildSessionTimestamp}
        end
        const var"c\"clang_getBuildSessionTimestamp\"" = Cbinding_clang_getBuildSessionTimestamp{:clang_getBuildSessionTimestamp}()
        (func::Cbinding_clang_getBuildSessionTimestamp)() = begin
                CBinding.funccall(func)
            end
        const clang_getBuildSessionTimestamp = var"c\"clang_getBuildSessionTimestamp\""
        export var"c\"clang_getBuildSessionTimestamp\""
        export clang_getBuildSessionTimestamp
        var"c\"clang_getBuildSessionTimestamp\""
        abstract type var"c\"struct CXVirtualFileOverlayImpl\"" <: Cstruct end
        const CXVirtualFileOverlayImpl = var"c\"struct CXVirtualFileOverlayImpl\""
        export var"c\"struct CXVirtualFileOverlayImpl\""
        export CXVirtualFileOverlayImpl
        var"c\"struct CXVirtualFileOverlayImpl\""
        const var"c\"CXVirtualFileOverlay\"" = CBinding.Cptr{var"c\"struct CXVirtualFileOverlayImpl\""}
        const CXVirtualFileOverlay = var"c\"CXVirtualFileOverlay\""
        export var"c\"CXVirtualFileOverlay\""
        export CXVirtualFileOverlay
        var"c\"CXVirtualFileOverlay\""
        struct Cbinding_clang_VirtualFileOverlay_create{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXVirtualFileOverlay\"", CBinding.Tuple{CBinding.Cuint}, :cdecl}, libpath, :clang_VirtualFileOverlay_create}
        end
        const var"c\"clang_VirtualFileOverlay_create\"" = Cbinding_clang_VirtualFileOverlay_create{:clang_VirtualFileOverlay_create}()
        (func::Cbinding_clang_VirtualFileOverlay_create)(var"c\"options\"") = begin
                CBinding.funccall(func, var"c\"options\"")
            end
        const clang_VirtualFileOverlay_create = var"c\"clang_VirtualFileOverlay_create\""
        export var"c\"clang_VirtualFileOverlay_create\""
        export clang_VirtualFileOverlay_create
        var"c\"clang_VirtualFileOverlay_create\""
        struct Cbinding_clang_VirtualFileOverlay_addFileMapping{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXVirtualFileOverlay\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_VirtualFileOverlay_addFileMapping}
        end
        const var"c\"clang_VirtualFileOverlay_addFileMapping\"" = Cbinding_clang_VirtualFileOverlay_addFileMapping{:clang_VirtualFileOverlay_addFileMapping}()
        (func::Cbinding_clang_VirtualFileOverlay_addFileMapping)(arg1, var"c\"virtualPath\"", var"c\"realPath\"") = begin
                CBinding.funccall(func, arg1, var"c\"virtualPath\"", var"c\"realPath\"")
            end
        const clang_VirtualFileOverlay_addFileMapping = var"c\"clang_VirtualFileOverlay_addFileMapping\""
        export var"c\"clang_VirtualFileOverlay_addFileMapping\""
        export clang_VirtualFileOverlay_addFileMapping
        var"c\"clang_VirtualFileOverlay_addFileMapping\""
        struct Cbinding_clang_VirtualFileOverlay_setCaseSensitivity{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXVirtualFileOverlay\"", CBinding.Cint}, :cdecl}, libpath, :clang_VirtualFileOverlay_setCaseSensitivity}
        end
        const var"c\"clang_VirtualFileOverlay_setCaseSensitivity\"" = Cbinding_clang_VirtualFileOverlay_setCaseSensitivity{:clang_VirtualFileOverlay_setCaseSensitivity}()
        (func::Cbinding_clang_VirtualFileOverlay_setCaseSensitivity)(arg1, var"c\"caseSensitive\"") = begin
                CBinding.funccall(func, arg1, var"c\"caseSensitive\"")
            end
        const clang_VirtualFileOverlay_setCaseSensitivity = var"c\"clang_VirtualFileOverlay_setCaseSensitivity\""
        export var"c\"clang_VirtualFileOverlay_setCaseSensitivity\""
        export clang_VirtualFileOverlay_setCaseSensitivity
        var"c\"clang_VirtualFileOverlay_setCaseSensitivity\""
        struct Cbinding_clang_VirtualFileOverlay_writeToBuffer{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXVirtualFileOverlay\"", CBinding.Cuint, CBinding.Cptr{CBinding.Cptr{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_VirtualFileOverlay_writeToBuffer}
        end
        const var"c\"clang_VirtualFileOverlay_writeToBuffer\"" = Cbinding_clang_VirtualFileOverlay_writeToBuffer{:clang_VirtualFileOverlay_writeToBuffer}()
        (func::Cbinding_clang_VirtualFileOverlay_writeToBuffer)(arg1, var"c\"options\"", var"c\"out_buffer_ptr\"", var"c\"out_buffer_size\"") = begin
                CBinding.funccall(func, arg1, var"c\"options\"", var"c\"out_buffer_ptr\"", var"c\"out_buffer_size\"")
            end
        const clang_VirtualFileOverlay_writeToBuffer = var"c\"clang_VirtualFileOverlay_writeToBuffer\""
        export var"c\"clang_VirtualFileOverlay_writeToBuffer\""
        export clang_VirtualFileOverlay_writeToBuffer
        var"c\"clang_VirtualFileOverlay_writeToBuffer\""
        struct Cbinding_clang_free{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{CBinding.Cvoid}}, :cdecl}, libpath, :clang_free}
        end
        const var"c\"clang_free\"" = Cbinding_clang_free{:clang_free}()
        (func::Cbinding_clang_free)(var"c\"buffer\"") = begin
                CBinding.funccall(func, var"c\"buffer\"")
            end
        const clang_free = var"c\"clang_free\""
        export var"c\"clang_free\""
        export clang_free
        var"c\"clang_free\""
        struct Cbinding_clang_VirtualFileOverlay_dispose{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXVirtualFileOverlay\""}, :cdecl}, libpath, :clang_VirtualFileOverlay_dispose}
        end
        const var"c\"clang_VirtualFileOverlay_dispose\"" = Cbinding_clang_VirtualFileOverlay_dispose{:clang_VirtualFileOverlay_dispose}()
        (func::Cbinding_clang_VirtualFileOverlay_dispose)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_VirtualFileOverlay_dispose = var"c\"clang_VirtualFileOverlay_dispose\""
        export var"c\"clang_VirtualFileOverlay_dispose\""
        export clang_VirtualFileOverlay_dispose
        var"c\"clang_VirtualFileOverlay_dispose\""
        abstract type var"c\"struct CXModuleMapDescriptorImpl\"" <: Cstruct end
        const CXModuleMapDescriptorImpl = var"c\"struct CXModuleMapDescriptorImpl\""
        export var"c\"struct CXModuleMapDescriptorImpl\""
        export CXModuleMapDescriptorImpl
        var"c\"struct CXModuleMapDescriptorImpl\""
        const var"c\"CXModuleMapDescriptor\"" = CBinding.Cptr{var"c\"struct CXModuleMapDescriptorImpl\""}
        const CXModuleMapDescriptor = var"c\"CXModuleMapDescriptor\""
        export var"c\"CXModuleMapDescriptor\""
        export CXModuleMapDescriptor
        var"c\"CXModuleMapDescriptor\""
        struct Cbinding_clang_ModuleMapDescriptor_create{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXModuleMapDescriptor\"", CBinding.Tuple{CBinding.Cuint}, :cdecl}, libpath, :clang_ModuleMapDescriptor_create}
        end
        const var"c\"clang_ModuleMapDescriptor_create\"" = Cbinding_clang_ModuleMapDescriptor_create{:clang_ModuleMapDescriptor_create}()
        (func::Cbinding_clang_ModuleMapDescriptor_create)(var"c\"options\"") = begin
                CBinding.funccall(func, var"c\"options\"")
            end
        const clang_ModuleMapDescriptor_create = var"c\"clang_ModuleMapDescriptor_create\""
        export var"c\"clang_ModuleMapDescriptor_create\""
        export clang_ModuleMapDescriptor_create
        var"c\"clang_ModuleMapDescriptor_create\""
        struct Cbinding_clang_ModuleMapDescriptor_setFrameworkModuleName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXModuleMapDescriptor\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_ModuleMapDescriptor_setFrameworkModuleName}
        end
        const var"c\"clang_ModuleMapDescriptor_setFrameworkModuleName\"" = Cbinding_clang_ModuleMapDescriptor_setFrameworkModuleName{:clang_ModuleMapDescriptor_setFrameworkModuleName}()
        (func::Cbinding_clang_ModuleMapDescriptor_setFrameworkModuleName)(arg1, var"c\"name\"") = begin
                CBinding.funccall(func, arg1, var"c\"name\"")
            end
        const clang_ModuleMapDescriptor_setFrameworkModuleName = var"c\"clang_ModuleMapDescriptor_setFrameworkModuleName\""
        export var"c\"clang_ModuleMapDescriptor_setFrameworkModuleName\""
        export clang_ModuleMapDescriptor_setFrameworkModuleName
        var"c\"clang_ModuleMapDescriptor_setFrameworkModuleName\""
        struct Cbinding_clang_ModuleMapDescriptor_setUmbrellaHeader{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXModuleMapDescriptor\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_ModuleMapDescriptor_setUmbrellaHeader}
        end
        const var"c\"clang_ModuleMapDescriptor_setUmbrellaHeader\"" = Cbinding_clang_ModuleMapDescriptor_setUmbrellaHeader{:clang_ModuleMapDescriptor_setUmbrellaHeader}()
        (func::Cbinding_clang_ModuleMapDescriptor_setUmbrellaHeader)(arg1, var"c\"name\"") = begin
                CBinding.funccall(func, arg1, var"c\"name\"")
            end
        const clang_ModuleMapDescriptor_setUmbrellaHeader = var"c\"clang_ModuleMapDescriptor_setUmbrellaHeader\""
        export var"c\"clang_ModuleMapDescriptor_setUmbrellaHeader\""
        export clang_ModuleMapDescriptor_setUmbrellaHeader
        var"c\"clang_ModuleMapDescriptor_setUmbrellaHeader\""
        struct Cbinding_clang_ModuleMapDescriptor_writeToBuffer{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXModuleMapDescriptor\"", CBinding.Cuint, CBinding.Cptr{CBinding.Cptr{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_ModuleMapDescriptor_writeToBuffer}
        end
        const var"c\"clang_ModuleMapDescriptor_writeToBuffer\"" = Cbinding_clang_ModuleMapDescriptor_writeToBuffer{:clang_ModuleMapDescriptor_writeToBuffer}()
        (func::Cbinding_clang_ModuleMapDescriptor_writeToBuffer)(arg1, var"c\"options\"", var"c\"out_buffer_ptr\"", var"c\"out_buffer_size\"") = begin
                CBinding.funccall(func, arg1, var"c\"options\"", var"c\"out_buffer_ptr\"", var"c\"out_buffer_size\"")
            end
        const clang_ModuleMapDescriptor_writeToBuffer = var"c\"clang_ModuleMapDescriptor_writeToBuffer\""
        export var"c\"clang_ModuleMapDescriptor_writeToBuffer\""
        export clang_ModuleMapDescriptor_writeToBuffer
        var"c\"clang_ModuleMapDescriptor_writeToBuffer\""
        struct Cbinding_clang_ModuleMapDescriptor_dispose{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXModuleMapDescriptor\""}, :cdecl}, libpath, :clang_ModuleMapDescriptor_dispose}
        end
        const var"c\"clang_ModuleMapDescriptor_dispose\"" = Cbinding_clang_ModuleMapDescriptor_dispose{:clang_ModuleMapDescriptor_dispose}()
        (func::Cbinding_clang_ModuleMapDescriptor_dispose)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_ModuleMapDescriptor_dispose = var"c\"clang_ModuleMapDescriptor_dispose\""
        export var"c\"clang_ModuleMapDescriptor_dispose\""
        export clang_ModuleMapDescriptor_dispose
        var"c\"clang_ModuleMapDescriptor_dispose\""
        const var"c\"CXFile\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXFile = var"c\"CXFile\""
        export var"c\"CXFile\""
        export CXFile
        var"c\"CXFile\""
        struct Cbinding_clang_getFileName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXFile\""}, :cdecl}, libpath, :clang_getFileName}
        end
        const var"c\"clang_getFileName\"" = Cbinding_clang_getFileName{:clang_getFileName}()
        (func::Cbinding_clang_getFileName)(var"c\"SFile\"") = begin
                CBinding.funccall(func, var"c\"SFile\"")
            end
        const clang_getFileName = var"c\"clang_getFileName\""
        export var"c\"clang_getFileName\""
        export clang_getFileName
        var"c\"clang_getFileName\""
        struct Cbinding_clang_getFileTime{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"time_t\"", CBinding.Tuple{var"c\"CXFile\""}, :cdecl}, libpath, :clang_getFileTime}
        end
        const var"c\"clang_getFileTime\"" = Cbinding_clang_getFileTime{:clang_getFileTime}()
        (func::Cbinding_clang_getFileTime)(var"c\"SFile\"") = begin
                CBinding.funccall(func, var"c\"SFile\"")
            end
        const clang_getFileTime = var"c\"clang_getFileTime\""
        export var"c\"clang_getFileTime\""
        export clang_getFileTime
        var"c\"clang_getFileTime\""
        abstract type var"c\"CXFileUniqueID\"" <: Cstruct end
        const CXFileUniqueID = var"c\"CXFileUniqueID\""
        export var"c\"CXFileUniqueID\""
        export CXFileUniqueID
        var"c\"CXFileUniqueID\""
        struct var"(c\"CXFileUniqueID\")" <: var"c\"CXFileUniqueID\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXFileUniqueID\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXFileUniqueID\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:data, CBinding.Tuple{CBinding.Carray{CBinding.Culonglong, 3}, CBinding.bitstype(CBinding.Carray{CBinding.Culonglong, 3}), CBinding.integraltype(CBinding.Carray{CBinding.Culonglong, 3}), 0, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXFileUniqueID\")"}) = begin
                var"(c\"CXFileUniqueID\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXFileUniqueID\""}) = begin
                var"(c\"CXFileUniqueID\")"
            end
        const CXFileUniqueID = var"c\"CXFileUniqueID\""
        export var"c\"CXFileUniqueID\"", var"(c\"CXFileUniqueID\")"
        export CXFileUniqueID
        var"c\"CXFileUniqueID\""
        struct Cbinding_clang_getFileUniqueID{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXFile\"", CBinding.Cptr{var"c\"CXFileUniqueID\""}}, :cdecl}, libpath, :clang_getFileUniqueID}
        end
        const var"c\"clang_getFileUniqueID\"" = Cbinding_clang_getFileUniqueID{:clang_getFileUniqueID}()
        (func::Cbinding_clang_getFileUniqueID)(var"c\"file\"", var"c\"outID\"") = begin
                CBinding.funccall(func, var"c\"file\"", var"c\"outID\"")
            end
        const clang_getFileUniqueID = var"c\"clang_getFileUniqueID\""
        export var"c\"clang_getFileUniqueID\""
        export clang_getFileUniqueID
        var"c\"clang_getFileUniqueID\""
        struct Cbinding_clang_File_isEqual{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXFile\"", var"c\"CXFile\""}, :cdecl}, libpath, :clang_File_isEqual}
        end
        const var"c\"clang_File_isEqual\"" = Cbinding_clang_File_isEqual{:clang_File_isEqual}()
        (func::Cbinding_clang_File_isEqual)(var"c\"file1\"", var"c\"file2\"") = begin
                CBinding.funccall(func, var"c\"file1\"", var"c\"file2\"")
            end
        const clang_File_isEqual = var"c\"clang_File_isEqual\""
        export var"c\"clang_File_isEqual\""
        export clang_File_isEqual
        var"c\"clang_File_isEqual\""
        struct Cbinding_clang_File_tryGetRealPathName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXFile\""}, :cdecl}, libpath, :clang_File_tryGetRealPathName}
        end
        const var"c\"clang_File_tryGetRealPathName\"" = Cbinding_clang_File_tryGetRealPathName{:clang_File_tryGetRealPathName}()
        (func::Cbinding_clang_File_tryGetRealPathName)(var"c\"file\"") = begin
                CBinding.funccall(func, var"c\"file\"")
            end
        const clang_File_tryGetRealPathName = var"c\"clang_File_tryGetRealPathName\""
        export var"c\"clang_File_tryGetRealPathName\""
        export clang_File_tryGetRealPathName
        var"c\"clang_File_tryGetRealPathName\""
        abstract type var"c\"CXSourceLocation\"" <: Cstruct end
        const CXSourceLocation = var"c\"CXSourceLocation\""
        export var"c\"CXSourceLocation\""
        export CXSourceLocation
        var"c\"CXSourceLocation\""
        struct var"(c\"CXSourceLocation\")" <: var"c\"CXSourceLocation\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXSourceLocation\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXSourceLocation\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:ptr_data, CBinding.Tuple{CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 2}, CBinding.bitstype(CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 2}), CBinding.integraltype(CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 2}), 0, 0, -1}}, CBinding.Tuple{:int_data, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXSourceLocation\")"}) = begin
                var"(c\"CXSourceLocation\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXSourceLocation\""}) = begin
                var"(c\"CXSourceLocation\")"
            end
        const CXSourceLocation = var"c\"CXSourceLocation\""
        export var"c\"CXSourceLocation\"", var"(c\"CXSourceLocation\")"
        export CXSourceLocation
        var"c\"CXSourceLocation\""
        abstract type var"c\"CXSourceRange\"" <: Cstruct end
        const CXSourceRange = var"c\"CXSourceRange\""
        export var"c\"CXSourceRange\""
        export CXSourceRange
        var"c\"CXSourceRange\""
        struct var"(c\"CXSourceRange\")" <: var"c\"CXSourceRange\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXSourceRange\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXSourceRange\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:ptr_data, CBinding.Tuple{CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 2}, CBinding.bitstype(CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 2}), CBinding.integraltype(CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 2}), 0, 0, -1}}, CBinding.Tuple{:begin_int_data, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 16, 0, -1}}, CBinding.Tuple{:end_int_data, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 20, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXSourceRange\")"}) = begin
                var"(c\"CXSourceRange\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXSourceRange\""}) = begin
                var"(c\"CXSourceRange\")"
            end
        const CXSourceRange = var"c\"CXSourceRange\""
        export var"c\"CXSourceRange\"", var"(c\"CXSourceRange\")"
        export CXSourceRange
        var"c\"CXSourceRange\""
        struct Cbinding_clang_getNullLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{}, :cdecl}, libpath, :clang_getNullLocation}
        end
        const var"c\"clang_getNullLocation\"" = Cbinding_clang_getNullLocation{:clang_getNullLocation}()
        (func::Cbinding_clang_getNullLocation)() = begin
                CBinding.funccall(func)
            end
        const clang_getNullLocation = var"c\"clang_getNullLocation\""
        export var"c\"clang_getNullLocation\""
        export clang_getNullLocation
        var"c\"clang_getNullLocation\""
        struct Cbinding_clang_equalLocations{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXSourceLocation\"", var"c\"CXSourceLocation\""}, :cdecl}, libpath, :clang_equalLocations}
        end
        const var"c\"clang_equalLocations\"" = Cbinding_clang_equalLocations{:clang_equalLocations}()
        (func::Cbinding_clang_equalLocations)(var"c\"loc1\"", var"c\"loc2\"") = begin
                CBinding.funccall(func, var"c\"loc1\"", var"c\"loc2\"")
            end
        const clang_equalLocations = var"c\"clang_equalLocations\""
        export var"c\"clang_equalLocations\""
        export clang_equalLocations
        var"c\"clang_equalLocations\""
        struct Cbinding_clang_Location_isInSystemHeader{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXSourceLocation\""}, :cdecl}, libpath, :clang_Location_isInSystemHeader}
        end
        const var"c\"clang_Location_isInSystemHeader\"" = Cbinding_clang_Location_isInSystemHeader{:clang_Location_isInSystemHeader}()
        (func::Cbinding_clang_Location_isInSystemHeader)(var"c\"location\"") = begin
                CBinding.funccall(func, var"c\"location\"")
            end
        const clang_Location_isInSystemHeader = var"c\"clang_Location_isInSystemHeader\""
        export var"c\"clang_Location_isInSystemHeader\""
        export clang_Location_isInSystemHeader
        var"c\"clang_Location_isInSystemHeader\""
        struct Cbinding_clang_Location_isFromMainFile{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXSourceLocation\""}, :cdecl}, libpath, :clang_Location_isFromMainFile}
        end
        const var"c\"clang_Location_isFromMainFile\"" = Cbinding_clang_Location_isFromMainFile{:clang_Location_isFromMainFile}()
        (func::Cbinding_clang_Location_isFromMainFile)(var"c\"location\"") = begin
                CBinding.funccall(func, var"c\"location\"")
            end
        const clang_Location_isFromMainFile = var"c\"clang_Location_isFromMainFile\""
        export var"c\"clang_Location_isFromMainFile\""
        export clang_Location_isFromMainFile
        var"c\"clang_Location_isFromMainFile\""
        struct Cbinding_clang_getNullRange{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceRange\"", CBinding.Tuple{}, :cdecl}, libpath, :clang_getNullRange}
        end
        const var"c\"clang_getNullRange\"" = Cbinding_clang_getNullRange{:clang_getNullRange}()
        (func::Cbinding_clang_getNullRange)() = begin
                CBinding.funccall(func)
            end
        const clang_getNullRange = var"c\"clang_getNullRange\""
        export var"c\"clang_getNullRange\""
        export clang_getNullRange
        var"c\"clang_getNullRange\""
        struct Cbinding_clang_getRange{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceRange\"", CBinding.Tuple{var"c\"CXSourceLocation\"", var"c\"CXSourceLocation\""}, :cdecl}, libpath, :clang_getRange}
        end
        const var"c\"clang_getRange\"" = Cbinding_clang_getRange{:clang_getRange}()
        (func::Cbinding_clang_getRange)(var"c\"begin\"", var"c\"end\"") = begin
                CBinding.funccall(func, var"c\"begin\"", var"c\"end\"")
            end
        const clang_getRange = var"c\"clang_getRange\""
        export var"c\"clang_getRange\""
        export clang_getRange
        var"c\"clang_getRange\""
        struct Cbinding_clang_equalRanges{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXSourceRange\"", var"c\"CXSourceRange\""}, :cdecl}, libpath, :clang_equalRanges}
        end
        const var"c\"clang_equalRanges\"" = Cbinding_clang_equalRanges{:clang_equalRanges}()
        (func::Cbinding_clang_equalRanges)(var"c\"range1\"", var"c\"range2\"") = begin
                CBinding.funccall(func, var"c\"range1\"", var"c\"range2\"")
            end
        const clang_equalRanges = var"c\"clang_equalRanges\""
        export var"c\"clang_equalRanges\""
        export clang_equalRanges
        var"c\"clang_equalRanges\""
        struct Cbinding_clang_Range_isNull{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXSourceRange\""}, :cdecl}, libpath, :clang_Range_isNull}
        end
        const var"c\"clang_Range_isNull\"" = Cbinding_clang_Range_isNull{:clang_Range_isNull}()
        (func::Cbinding_clang_Range_isNull)(var"c\"range\"") = begin
                CBinding.funccall(func, var"c\"range\"")
            end
        const clang_Range_isNull = var"c\"clang_Range_isNull\""
        export var"c\"clang_Range_isNull\""
        export clang_Range_isNull
        var"c\"clang_Range_isNull\""
        struct Cbinding_clang_getExpansionLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXSourceLocation\"", CBinding.Cptr{var"c\"CXFile\""}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_getExpansionLocation}
        end
        const var"c\"clang_getExpansionLocation\"" = Cbinding_clang_getExpansionLocation{:clang_getExpansionLocation}()
        (func::Cbinding_clang_getExpansionLocation)(var"c\"location\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"") = begin
                CBinding.funccall(func, var"c\"location\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"")
            end
        const clang_getExpansionLocation = var"c\"clang_getExpansionLocation\""
        export var"c\"clang_getExpansionLocation\""
        export clang_getExpansionLocation
        var"c\"clang_getExpansionLocation\""
        struct Cbinding_clang_getPresumedLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXSourceLocation\"", CBinding.Cptr{var"c\"CXString\""}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_getPresumedLocation}
        end
        const var"c\"clang_getPresumedLocation\"" = Cbinding_clang_getPresumedLocation{:clang_getPresumedLocation}()
        (func::Cbinding_clang_getPresumedLocation)(var"c\"location\"", var"c\"filename\"", var"c\"line\"", var"c\"column\"") = begin
                CBinding.funccall(func, var"c\"location\"", var"c\"filename\"", var"c\"line\"", var"c\"column\"")
            end
        const clang_getPresumedLocation = var"c\"clang_getPresumedLocation\""
        export var"c\"clang_getPresumedLocation\""
        export clang_getPresumedLocation
        var"c\"clang_getPresumedLocation\""
        struct Cbinding_clang_getInstantiationLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXSourceLocation\"", CBinding.Cptr{var"c\"CXFile\""}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_getInstantiationLocation}
        end
        const var"c\"clang_getInstantiationLocation\"" = Cbinding_clang_getInstantiationLocation{:clang_getInstantiationLocation}()
        (func::Cbinding_clang_getInstantiationLocation)(var"c\"location\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"") = begin
                CBinding.funccall(func, var"c\"location\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"")
            end
        const clang_getInstantiationLocation = var"c\"clang_getInstantiationLocation\""
        export var"c\"clang_getInstantiationLocation\""
        export clang_getInstantiationLocation
        var"c\"clang_getInstantiationLocation\""
        struct Cbinding_clang_getSpellingLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXSourceLocation\"", CBinding.Cptr{var"c\"CXFile\""}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_getSpellingLocation}
        end
        const var"c\"clang_getSpellingLocation\"" = Cbinding_clang_getSpellingLocation{:clang_getSpellingLocation}()
        (func::Cbinding_clang_getSpellingLocation)(var"c\"location\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"") = begin
                CBinding.funccall(func, var"c\"location\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"")
            end
        const clang_getSpellingLocation = var"c\"clang_getSpellingLocation\""
        export var"c\"clang_getSpellingLocation\""
        export clang_getSpellingLocation
        var"c\"clang_getSpellingLocation\""
        struct Cbinding_clang_getFileLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXSourceLocation\"", CBinding.Cptr{var"c\"CXFile\""}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_getFileLocation}
        end
        const var"c\"clang_getFileLocation\"" = Cbinding_clang_getFileLocation{:clang_getFileLocation}()
        (func::Cbinding_clang_getFileLocation)(var"c\"location\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"") = begin
                CBinding.funccall(func, var"c\"location\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"")
            end
        const clang_getFileLocation = var"c\"clang_getFileLocation\""
        export var"c\"clang_getFileLocation\""
        export clang_getFileLocation
        var"c\"clang_getFileLocation\""
        struct Cbinding_clang_getRangeStart{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{var"c\"CXSourceRange\""}, :cdecl}, libpath, :clang_getRangeStart}
        end
        const var"c\"clang_getRangeStart\"" = Cbinding_clang_getRangeStart{:clang_getRangeStart}()
        (func::Cbinding_clang_getRangeStart)(var"c\"range\"") = begin
                CBinding.funccall(func, var"c\"range\"")
            end
        const clang_getRangeStart = var"c\"clang_getRangeStart\""
        export var"c\"clang_getRangeStart\""
        export clang_getRangeStart
        var"c\"clang_getRangeStart\""
        struct Cbinding_clang_getRangeEnd{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{var"c\"CXSourceRange\""}, :cdecl}, libpath, :clang_getRangeEnd}
        end
        const var"c\"clang_getRangeEnd\"" = Cbinding_clang_getRangeEnd{:clang_getRangeEnd}()
        (func::Cbinding_clang_getRangeEnd)(var"c\"range\"") = begin
                CBinding.funccall(func, var"c\"range\"")
            end
        const clang_getRangeEnd = var"c\"clang_getRangeEnd\""
        export var"c\"clang_getRangeEnd\""
        export clang_getRangeEnd
        var"c\"clang_getRangeEnd\""
        abstract type var"c\"CXSourceRangeList\"" <: Cstruct end
        const CXSourceRangeList = var"c\"CXSourceRangeList\""
        export var"c\"CXSourceRangeList\""
        export CXSourceRangeList
        var"c\"CXSourceRangeList\""
        struct var"(c\"CXSourceRangeList\")" <: var"c\"CXSourceRangeList\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"CXSourceRangeList\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXSourceRangeList\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:count, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 0, 0, -1}}, CBinding.Tuple{:ranges, CBinding.Tuple{CBinding.Cptr{var"c\"CXSourceRange\""}, CBinding.bitstype(CBinding.Cptr{var"c\"CXSourceRange\""}), CBinding.integraltype(CBinding.Cptr{var"c\"CXSourceRange\""}), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXSourceRangeList\")"}) = begin
                var"(c\"CXSourceRangeList\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXSourceRangeList\""}) = begin
                var"(c\"CXSourceRangeList\")"
            end
        const CXSourceRangeList = var"c\"CXSourceRangeList\""
        export var"c\"CXSourceRangeList\"", var"(c\"CXSourceRangeList\")"
        export CXSourceRangeList
        var"c\"CXSourceRangeList\""
        struct Cbinding_clang_disposeSourceRangeList{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{var"c\"CXSourceRangeList\""}}, :cdecl}, libpath, :clang_disposeSourceRangeList}
        end
        const var"c\"clang_disposeSourceRangeList\"" = Cbinding_clang_disposeSourceRangeList{:clang_disposeSourceRangeList}()
        (func::Cbinding_clang_disposeSourceRangeList)(var"c\"ranges\"") = begin
                CBinding.funccall(func, var"c\"ranges\"")
            end
        const clang_disposeSourceRangeList = var"c\"clang_disposeSourceRangeList\""
        export var"c\"clang_disposeSourceRangeList\""
        export clang_disposeSourceRangeList
        var"c\"clang_disposeSourceRangeList\""
        abstract type var"c\"enum CXDiagnosticSeverity\"" <: Cenum end
        const CXDiagnosticSeverity = var"c\"enum CXDiagnosticSeverity\""
        export var"c\"enum CXDiagnosticSeverity\""
        export CXDiagnosticSeverity
        var"c\"enum CXDiagnosticSeverity\""
        primitive type var"(c\"enum CXDiagnosticSeverity\")" <: var"c\"enum CXDiagnosticSeverity\"" 32 end
        (::(Type){var"(c\"enum CXDiagnosticSeverity\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXDiagnosticSeverity\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXDiagnosticSeverity\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXDiagnostic_Ignored\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXDiagnostic_Note\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXDiagnostic_Warning\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXDiagnostic_Error\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXDiagnostic_Fatal\""), 0x0000000000000004}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXDiagnosticSeverity\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXDiagnosticSeverity\")"}) = begin
                var"(c\"enum CXDiagnosticSeverity\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXDiagnosticSeverity\""}) = begin
                var"(c\"enum CXDiagnosticSeverity\")"
            end
        const var"c\"CXDiagnostic_Ignored\"" = var"(c\"enum CXDiagnosticSeverity\")"(0x0000000000000000)
        const var"c\"CXDiagnostic_Note\"" = var"(c\"enum CXDiagnosticSeverity\")"(0x0000000000000001)
        const var"c\"CXDiagnostic_Warning\"" = var"(c\"enum CXDiagnosticSeverity\")"(0x0000000000000002)
        const var"c\"CXDiagnostic_Error\"" = var"(c\"enum CXDiagnosticSeverity\")"(0x0000000000000003)
        const var"c\"CXDiagnostic_Fatal\"" = var"(c\"enum CXDiagnosticSeverity\")"(0x0000000000000004)
        const CXDiagnosticSeverity = var"c\"enum CXDiagnosticSeverity\""
        const CXDiagnostic_Ignored = var"c\"CXDiagnostic_Ignored\""
        const CXDiagnostic_Note = var"c\"CXDiagnostic_Note\""
        const CXDiagnostic_Warning = var"c\"CXDiagnostic_Warning\""
        const CXDiagnostic_Error = var"c\"CXDiagnostic_Error\""
        const CXDiagnostic_Fatal = var"c\"CXDiagnostic_Fatal\""
        export var"c\"enum CXDiagnosticSeverity\"", var"(c\"enum CXDiagnosticSeverity\")", var"c\"CXDiagnostic_Ignored\"", var"c\"CXDiagnostic_Note\"", var"c\"CXDiagnostic_Warning\"", var"c\"CXDiagnostic_Error\"", var"c\"CXDiagnostic_Fatal\""
        export CXDiagnosticSeverity, CXDiagnostic_Ignored, CXDiagnostic_Note, CXDiagnostic_Warning, CXDiagnostic_Error, CXDiagnostic_Fatal
        var"c\"enum CXDiagnosticSeverity\""
        const var"c\"CXDiagnostic\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXDiagnostic = var"c\"CXDiagnostic\""
        export var"c\"CXDiagnostic\""
        export CXDiagnostic
        var"c\"CXDiagnostic\""
        const var"c\"CXDiagnosticSet\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXDiagnosticSet = var"c\"CXDiagnosticSet\""
        export var"c\"CXDiagnosticSet\""
        export CXDiagnosticSet
        var"c\"CXDiagnosticSet\""
        struct Cbinding_clang_getNumDiagnosticsInSet{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXDiagnosticSet\""}, :cdecl}, libpath, :clang_getNumDiagnosticsInSet}
        end
        const var"c\"clang_getNumDiagnosticsInSet\"" = Cbinding_clang_getNumDiagnosticsInSet{:clang_getNumDiagnosticsInSet}()
        (func::Cbinding_clang_getNumDiagnosticsInSet)(var"c\"Diags\"") = begin
                CBinding.funccall(func, var"c\"Diags\"")
            end
        const clang_getNumDiagnosticsInSet = var"c\"clang_getNumDiagnosticsInSet\""
        export var"c\"clang_getNumDiagnosticsInSet\""
        export clang_getNumDiagnosticsInSet
        var"c\"clang_getNumDiagnosticsInSet\""
        struct Cbinding_clang_getDiagnosticInSet{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXDiagnostic\"", CBinding.Tuple{var"c\"CXDiagnosticSet\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getDiagnosticInSet}
        end
        const var"c\"clang_getDiagnosticInSet\"" = Cbinding_clang_getDiagnosticInSet{:clang_getDiagnosticInSet}()
        (func::Cbinding_clang_getDiagnosticInSet)(var"c\"Diags\"", var"c\"Index\"") = begin
                CBinding.funccall(func, var"c\"Diags\"", var"c\"Index\"")
            end
        const clang_getDiagnosticInSet = var"c\"clang_getDiagnosticInSet\""
        export var"c\"clang_getDiagnosticInSet\""
        export clang_getDiagnosticInSet
        var"c\"clang_getDiagnosticInSet\""
        abstract type var"c\"enum CXLoadDiag_Error\"" <: Cenum end
        const CXLoadDiag_Error = var"c\"enum CXLoadDiag_Error\""
        export var"c\"enum CXLoadDiag_Error\""
        export CXLoadDiag_Error
        var"c\"enum CXLoadDiag_Error\""
        primitive type var"(c\"enum CXLoadDiag_Error\")" <: var"c\"enum CXLoadDiag_Error\"" 32 end
        (::(Type){var"(c\"enum CXLoadDiag_Error\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXLoadDiag_Error\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXLoadDiag_Error\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXLoadDiag_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXLoadDiag_Unknown\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXLoadDiag_CannotLoad\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXLoadDiag_InvalidFile\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXLoadDiag_Error\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXLoadDiag_Error\")"}) = begin
                var"(c\"enum CXLoadDiag_Error\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXLoadDiag_Error\""}) = begin
                var"(c\"enum CXLoadDiag_Error\")"
            end
        const var"c\"CXLoadDiag_None\"" = var"(c\"enum CXLoadDiag_Error\")"(0x0000000000000000)
        const var"c\"CXLoadDiag_Unknown\"" = var"(c\"enum CXLoadDiag_Error\")"(0x0000000000000001)
        const var"c\"CXLoadDiag_CannotLoad\"" = var"(c\"enum CXLoadDiag_Error\")"(0x0000000000000002)
        const var"c\"CXLoadDiag_InvalidFile\"" = var"(c\"enum CXLoadDiag_Error\")"(0x0000000000000003)
        const CXLoadDiag_Error = var"c\"enum CXLoadDiag_Error\""
        const CXLoadDiag_None = var"c\"CXLoadDiag_None\""
        const CXLoadDiag_Unknown = var"c\"CXLoadDiag_Unknown\""
        const CXLoadDiag_CannotLoad = var"c\"CXLoadDiag_CannotLoad\""
        const CXLoadDiag_InvalidFile = var"c\"CXLoadDiag_InvalidFile\""
        export var"c\"enum CXLoadDiag_Error\"", var"(c\"enum CXLoadDiag_Error\")", var"c\"CXLoadDiag_None\"", var"c\"CXLoadDiag_Unknown\"", var"c\"CXLoadDiag_CannotLoad\"", var"c\"CXLoadDiag_InvalidFile\""
        export CXLoadDiag_Error, CXLoadDiag_None, CXLoadDiag_Unknown, CXLoadDiag_CannotLoad, CXLoadDiag_InvalidFile
        var"c\"enum CXLoadDiag_Error\""
        struct Cbinding_clang_loadDiagnostics{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXDiagnosticSet\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{var"c\"enum CXLoadDiag_Error\""}, CBinding.Cptr{var"c\"CXString\""}}, :cdecl}, libpath, :clang_loadDiagnostics}
        end
        const var"c\"clang_loadDiagnostics\"" = Cbinding_clang_loadDiagnostics{:clang_loadDiagnostics}()
        (func::Cbinding_clang_loadDiagnostics)(var"c\"file\"", var"c\"error\"", var"c\"errorString\"") = begin
                CBinding.funccall(func, var"c\"file\"", var"c\"error\"", var"c\"errorString\"")
            end
        const clang_loadDiagnostics = var"c\"clang_loadDiagnostics\""
        export var"c\"clang_loadDiagnostics\""
        export clang_loadDiagnostics
        var"c\"clang_loadDiagnostics\""
        struct Cbinding_clang_disposeDiagnosticSet{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXDiagnosticSet\""}, :cdecl}, libpath, :clang_disposeDiagnosticSet}
        end
        const var"c\"clang_disposeDiagnosticSet\"" = Cbinding_clang_disposeDiagnosticSet{:clang_disposeDiagnosticSet}()
        (func::Cbinding_clang_disposeDiagnosticSet)(var"c\"Diags\"") = begin
                CBinding.funccall(func, var"c\"Diags\"")
            end
        const clang_disposeDiagnosticSet = var"c\"clang_disposeDiagnosticSet\""
        export var"c\"clang_disposeDiagnosticSet\""
        export clang_disposeDiagnosticSet
        var"c\"clang_disposeDiagnosticSet\""
        struct Cbinding_clang_getChildDiagnostics{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXDiagnosticSet\"", CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_getChildDiagnostics}
        end
        const var"c\"clang_getChildDiagnostics\"" = Cbinding_clang_getChildDiagnostics{:clang_getChildDiagnostics}()
        (func::Cbinding_clang_getChildDiagnostics)(var"c\"D\"") = begin
                CBinding.funccall(func, var"c\"D\"")
            end
        const clang_getChildDiagnostics = var"c\"clang_getChildDiagnostics\""
        export var"c\"clang_getChildDiagnostics\""
        export clang_getChildDiagnostics
        var"c\"clang_getChildDiagnostics\""
        struct Cbinding_clang_disposeDiagnostic{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_disposeDiagnostic}
        end
        const var"c\"clang_disposeDiagnostic\"" = Cbinding_clang_disposeDiagnostic{:clang_disposeDiagnostic}()
        (func::Cbinding_clang_disposeDiagnostic)(var"c\"Diagnostic\"") = begin
                CBinding.funccall(func, var"c\"Diagnostic\"")
            end
        const clang_disposeDiagnostic = var"c\"clang_disposeDiagnostic\""
        export var"c\"clang_disposeDiagnostic\""
        export clang_disposeDiagnostic
        var"c\"clang_disposeDiagnostic\""
        abstract type var"c\"enum CXDiagnosticDisplayOptions\"" <: Cenum end
        const CXDiagnosticDisplayOptions = var"c\"enum CXDiagnosticDisplayOptions\""
        export var"c\"enum CXDiagnosticDisplayOptions\""
        export CXDiagnosticDisplayOptions
        var"c\"enum CXDiagnosticDisplayOptions\""
        primitive type var"(c\"enum CXDiagnosticDisplayOptions\")" <: var"c\"enum CXDiagnosticDisplayOptions\"" 32 end
        (::(Type){var"(c\"enum CXDiagnosticDisplayOptions\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXDiagnosticDisplayOptions\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXDiagnosticDisplayOptions\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXDiagnostic_DisplaySourceLocation\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXDiagnostic_DisplayColumn\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXDiagnostic_DisplaySourceRanges\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXDiagnostic_DisplayOption\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXDiagnostic_DisplayCategoryId\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXDiagnostic_DisplayCategoryName\""), 0x0000000000000020}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXDiagnosticDisplayOptions\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXDiagnosticDisplayOptions\")"}) = begin
                var"(c\"enum CXDiagnosticDisplayOptions\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXDiagnosticDisplayOptions\""}) = begin
                var"(c\"enum CXDiagnosticDisplayOptions\")"
            end
        const var"c\"CXDiagnostic_DisplaySourceLocation\"" = var"(c\"enum CXDiagnosticDisplayOptions\")"(0x0000000000000001)
        const var"c\"CXDiagnostic_DisplayColumn\"" = var"(c\"enum CXDiagnosticDisplayOptions\")"(0x0000000000000002)
        const var"c\"CXDiagnostic_DisplaySourceRanges\"" = var"(c\"enum CXDiagnosticDisplayOptions\")"(0x0000000000000004)
        const var"c\"CXDiagnostic_DisplayOption\"" = var"(c\"enum CXDiagnosticDisplayOptions\")"(0x0000000000000008)
        const var"c\"CXDiagnostic_DisplayCategoryId\"" = var"(c\"enum CXDiagnosticDisplayOptions\")"(0x0000000000000010)
        const var"c\"CXDiagnostic_DisplayCategoryName\"" = var"(c\"enum CXDiagnosticDisplayOptions\")"(0x0000000000000020)
        const CXDiagnosticDisplayOptions = var"c\"enum CXDiagnosticDisplayOptions\""
        const CXDiagnostic_DisplaySourceLocation = var"c\"CXDiagnostic_DisplaySourceLocation\""
        const CXDiagnostic_DisplayColumn = var"c\"CXDiagnostic_DisplayColumn\""
        const CXDiagnostic_DisplaySourceRanges = var"c\"CXDiagnostic_DisplaySourceRanges\""
        const CXDiagnostic_DisplayOption = var"c\"CXDiagnostic_DisplayOption\""
        const CXDiagnostic_DisplayCategoryId = var"c\"CXDiagnostic_DisplayCategoryId\""
        const CXDiagnostic_DisplayCategoryName = var"c\"CXDiagnostic_DisplayCategoryName\""
        export var"c\"enum CXDiagnosticDisplayOptions\"", var"(c\"enum CXDiagnosticDisplayOptions\")", var"c\"CXDiagnostic_DisplaySourceLocation\"", var"c\"CXDiagnostic_DisplayColumn\"", var"c\"CXDiagnostic_DisplaySourceRanges\"", var"c\"CXDiagnostic_DisplayOption\"", var"c\"CXDiagnostic_DisplayCategoryId\"", var"c\"CXDiagnostic_DisplayCategoryName\""
        export CXDiagnosticDisplayOptions, CXDiagnostic_DisplaySourceLocation, CXDiagnostic_DisplayColumn, CXDiagnostic_DisplaySourceRanges, CXDiagnostic_DisplayOption, CXDiagnostic_DisplayCategoryId, CXDiagnostic_DisplayCategoryName
        var"c\"enum CXDiagnosticDisplayOptions\""
        struct Cbinding_clang_formatDiagnostic{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXDiagnostic\"", CBinding.Cuint}, :cdecl}, libpath, :clang_formatDiagnostic}
        end
        const var"c\"clang_formatDiagnostic\"" = Cbinding_clang_formatDiagnostic{:clang_formatDiagnostic}()
        (func::Cbinding_clang_formatDiagnostic)(var"c\"Diagnostic\"", var"c\"Options\"") = begin
                CBinding.funccall(func, var"c\"Diagnostic\"", var"c\"Options\"")
            end
        const clang_formatDiagnostic = var"c\"clang_formatDiagnostic\""
        export var"c\"clang_formatDiagnostic\""
        export clang_formatDiagnostic
        var"c\"clang_formatDiagnostic\""
        struct Cbinding_clang_defaultDiagnosticDisplayOptions{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{}, :cdecl}, libpath, :clang_defaultDiagnosticDisplayOptions}
        end
        const var"c\"clang_defaultDiagnosticDisplayOptions\"" = Cbinding_clang_defaultDiagnosticDisplayOptions{:clang_defaultDiagnosticDisplayOptions}()
        (func::Cbinding_clang_defaultDiagnosticDisplayOptions)() = begin
                CBinding.funccall(func)
            end
        const clang_defaultDiagnosticDisplayOptions = var"c\"clang_defaultDiagnosticDisplayOptions\""
        export var"c\"clang_defaultDiagnosticDisplayOptions\""
        export clang_defaultDiagnosticDisplayOptions
        var"c\"clang_defaultDiagnosticDisplayOptions\""
        struct Cbinding_clang_getDiagnosticSeverity{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXDiagnosticSeverity\"", CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_getDiagnosticSeverity}
        end
        const var"c\"clang_getDiagnosticSeverity\"" = Cbinding_clang_getDiagnosticSeverity{:clang_getDiagnosticSeverity}()
        (func::Cbinding_clang_getDiagnosticSeverity)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getDiagnosticSeverity = var"c\"clang_getDiagnosticSeverity\""
        export var"c\"clang_getDiagnosticSeverity\""
        export clang_getDiagnosticSeverity
        var"c\"clang_getDiagnosticSeverity\""
        struct Cbinding_clang_getDiagnosticLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_getDiagnosticLocation}
        end
        const var"c\"clang_getDiagnosticLocation\"" = Cbinding_clang_getDiagnosticLocation{:clang_getDiagnosticLocation}()
        (func::Cbinding_clang_getDiagnosticLocation)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getDiagnosticLocation = var"c\"clang_getDiagnosticLocation\""
        export var"c\"clang_getDiagnosticLocation\""
        export clang_getDiagnosticLocation
        var"c\"clang_getDiagnosticLocation\""
        struct Cbinding_clang_getDiagnosticSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_getDiagnosticSpelling}
        end
        const var"c\"clang_getDiagnosticSpelling\"" = Cbinding_clang_getDiagnosticSpelling{:clang_getDiagnosticSpelling}()
        (func::Cbinding_clang_getDiagnosticSpelling)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getDiagnosticSpelling = var"c\"clang_getDiagnosticSpelling\""
        export var"c\"clang_getDiagnosticSpelling\""
        export clang_getDiagnosticSpelling
        var"c\"clang_getDiagnosticSpelling\""
        struct Cbinding_clang_getDiagnosticOption{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXDiagnostic\"", CBinding.Cptr{var"c\"CXString\""}}, :cdecl}, libpath, :clang_getDiagnosticOption}
        end
        const var"c\"clang_getDiagnosticOption\"" = Cbinding_clang_getDiagnosticOption{:clang_getDiagnosticOption}()
        (func::Cbinding_clang_getDiagnosticOption)(var"c\"Diag\"", var"c\"Disable\"") = begin
                CBinding.funccall(func, var"c\"Diag\"", var"c\"Disable\"")
            end
        const clang_getDiagnosticOption = var"c\"clang_getDiagnosticOption\""
        export var"c\"clang_getDiagnosticOption\""
        export clang_getDiagnosticOption
        var"c\"clang_getDiagnosticOption\""
        struct Cbinding_clang_getDiagnosticCategory{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_getDiagnosticCategory}
        end
        const var"c\"clang_getDiagnosticCategory\"" = Cbinding_clang_getDiagnosticCategory{:clang_getDiagnosticCategory}()
        (func::Cbinding_clang_getDiagnosticCategory)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getDiagnosticCategory = var"c\"clang_getDiagnosticCategory\""
        export var"c\"clang_getDiagnosticCategory\""
        export clang_getDiagnosticCategory
        var"c\"clang_getDiagnosticCategory\""
        struct Cbinding_clang_getDiagnosticCategoryName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cuint}, :cdecl}, libpath, :clang_getDiagnosticCategoryName}
        end
        const var"c\"clang_getDiagnosticCategoryName\"" = Cbinding_clang_getDiagnosticCategoryName{:clang_getDiagnosticCategoryName}()
        (func::Cbinding_clang_getDiagnosticCategoryName)(var"c\"Category\"") = begin
                CBinding.funccall(func, var"c\"Category\"")
            end
        const clang_getDiagnosticCategoryName = var"c\"clang_getDiagnosticCategoryName\""
        export var"c\"clang_getDiagnosticCategoryName\""
        export clang_getDiagnosticCategoryName
        var"c\"clang_getDiagnosticCategoryName\""
        struct Cbinding_clang_getDiagnosticCategoryText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_getDiagnosticCategoryText}
        end
        const var"c\"clang_getDiagnosticCategoryText\"" = Cbinding_clang_getDiagnosticCategoryText{:clang_getDiagnosticCategoryText}()
        (func::Cbinding_clang_getDiagnosticCategoryText)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getDiagnosticCategoryText = var"c\"clang_getDiagnosticCategoryText\""
        export var"c\"clang_getDiagnosticCategoryText\""
        export clang_getDiagnosticCategoryText
        var"c\"clang_getDiagnosticCategoryText\""
        struct Cbinding_clang_getDiagnosticNumRanges{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_getDiagnosticNumRanges}
        end
        const var"c\"clang_getDiagnosticNumRanges\"" = Cbinding_clang_getDiagnosticNumRanges{:clang_getDiagnosticNumRanges}()
        (func::Cbinding_clang_getDiagnosticNumRanges)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getDiagnosticNumRanges = var"c\"clang_getDiagnosticNumRanges\""
        export var"c\"clang_getDiagnosticNumRanges\""
        export clang_getDiagnosticNumRanges
        var"c\"clang_getDiagnosticNumRanges\""
        struct Cbinding_clang_getDiagnosticRange{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceRange\"", CBinding.Tuple{var"c\"CXDiagnostic\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getDiagnosticRange}
        end
        const var"c\"clang_getDiagnosticRange\"" = Cbinding_clang_getDiagnosticRange{:clang_getDiagnosticRange}()
        (func::Cbinding_clang_getDiagnosticRange)(var"c\"Diagnostic\"", var"c\"Range\"") = begin
                CBinding.funccall(func, var"c\"Diagnostic\"", var"c\"Range\"")
            end
        const clang_getDiagnosticRange = var"c\"clang_getDiagnosticRange\""
        export var"c\"clang_getDiagnosticRange\""
        export clang_getDiagnosticRange
        var"c\"clang_getDiagnosticRange\""
        struct Cbinding_clang_getDiagnosticNumFixIts{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXDiagnostic\""}, :cdecl}, libpath, :clang_getDiagnosticNumFixIts}
        end
        const var"c\"clang_getDiagnosticNumFixIts\"" = Cbinding_clang_getDiagnosticNumFixIts{:clang_getDiagnosticNumFixIts}()
        (func::Cbinding_clang_getDiagnosticNumFixIts)(var"c\"Diagnostic\"") = begin
                CBinding.funccall(func, var"c\"Diagnostic\"")
            end
        const clang_getDiagnosticNumFixIts = var"c\"clang_getDiagnosticNumFixIts\""
        export var"c\"clang_getDiagnosticNumFixIts\""
        export clang_getDiagnosticNumFixIts
        var"c\"clang_getDiagnosticNumFixIts\""
        struct Cbinding_clang_getDiagnosticFixIt{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXDiagnostic\"", CBinding.Cuint, CBinding.Cptr{var"c\"CXSourceRange\""}}, :cdecl}, libpath, :clang_getDiagnosticFixIt}
        end
        const var"c\"clang_getDiagnosticFixIt\"" = Cbinding_clang_getDiagnosticFixIt{:clang_getDiagnosticFixIt}()
        (func::Cbinding_clang_getDiagnosticFixIt)(var"c\"Diagnostic\"", var"c\"FixIt\"", var"c\"ReplacementRange\"") = begin
                CBinding.funccall(func, var"c\"Diagnostic\"", var"c\"FixIt\"", var"c\"ReplacementRange\"")
            end
        const clang_getDiagnosticFixIt = var"c\"clang_getDiagnosticFixIt\""
        export var"c\"clang_getDiagnosticFixIt\""
        export clang_getDiagnosticFixIt
        var"c\"clang_getDiagnosticFixIt\""
        const var"c\"CXIndex\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXIndex = var"c\"CXIndex\""
        export var"c\"CXIndex\""
        export CXIndex
        var"c\"CXIndex\""
        abstract type var"c\"struct CXTargetInfoImpl\"" <: Cstruct end
        const CXTargetInfoImpl = var"c\"struct CXTargetInfoImpl\""
        export var"c\"struct CXTargetInfoImpl\""
        export CXTargetInfoImpl
        var"c\"struct CXTargetInfoImpl\""
        const var"c\"CXTargetInfo\"" = CBinding.Cptr{var"c\"struct CXTargetInfoImpl\""}
        const CXTargetInfo = var"c\"CXTargetInfo\""
        export var"c\"CXTargetInfo\""
        export CXTargetInfo
        var"c\"CXTargetInfo\""
        abstract type var"c\"struct CXTranslationUnitImpl\"" <: Cstruct end
        const CXTranslationUnitImpl = var"c\"struct CXTranslationUnitImpl\""
        export var"c\"struct CXTranslationUnitImpl\""
        export CXTranslationUnitImpl
        var"c\"struct CXTranslationUnitImpl\""
        const var"c\"CXTranslationUnit\"" = CBinding.Cptr{var"c\"struct CXTranslationUnitImpl\""}
        const CXTranslationUnit = var"c\"CXTranslationUnit\""
        export var"c\"CXTranslationUnit\""
        export CXTranslationUnit
        var"c\"CXTranslationUnit\""
        const var"c\"CXClientData\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXClientData = var"c\"CXClientData\""
        export var"c\"CXClientData\""
        export CXClientData
        var"c\"CXClientData\""
        abstract type var"c\"struct CXUnsavedFile\"" <: Cstruct end
        const CXUnsavedFile = var"c\"struct CXUnsavedFile\""
        export var"c\"struct CXUnsavedFile\""
        export CXUnsavedFile
        var"c\"struct CXUnsavedFile\""
        struct var"(c\"struct CXUnsavedFile\")" <: var"c\"struct CXUnsavedFile\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"struct CXUnsavedFile\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"struct CXUnsavedFile\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:Filename, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), 0, 0, -1}}, CBinding.Tuple{:Contents, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), 8, 0, -1}}, CBinding.Tuple{:Length, CBinding.Tuple{CBinding.Culong, CBinding.bitstype(CBinding.Culong), CBinding.integraltype(CBinding.Culong), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"struct CXUnsavedFile\")"}) = begin
                var"(c\"struct CXUnsavedFile\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"struct CXUnsavedFile\""}) = begin
                var"(c\"struct CXUnsavedFile\")"
            end
        const CXUnsavedFile = var"c\"struct CXUnsavedFile\""
        export var"c\"struct CXUnsavedFile\"", var"(c\"struct CXUnsavedFile\")"
        export CXUnsavedFile
        var"c\"struct CXUnsavedFile\""
        abstract type var"c\"enum CXAvailabilityKind\"" <: Cenum end
        const CXAvailabilityKind = var"c\"enum CXAvailabilityKind\""
        export var"c\"enum CXAvailabilityKind\""
        export CXAvailabilityKind
        var"c\"enum CXAvailabilityKind\""
        primitive type var"(c\"enum CXAvailabilityKind\")" <: var"c\"enum CXAvailabilityKind\"" 32 end
        (::(Type){var"(c\"enum CXAvailabilityKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXAvailabilityKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXAvailabilityKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXAvailability_Available\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXAvailability_Deprecated\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXAvailability_NotAvailable\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXAvailability_NotAccessible\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXAvailabilityKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXAvailabilityKind\")"}) = begin
                var"(c\"enum CXAvailabilityKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXAvailabilityKind\""}) = begin
                var"(c\"enum CXAvailabilityKind\")"
            end
        const var"c\"CXAvailability_Available\"" = var"(c\"enum CXAvailabilityKind\")"(0x0000000000000000)
        const var"c\"CXAvailability_Deprecated\"" = var"(c\"enum CXAvailabilityKind\")"(0x0000000000000001)
        const var"c\"CXAvailability_NotAvailable\"" = var"(c\"enum CXAvailabilityKind\")"(0x0000000000000002)
        const var"c\"CXAvailability_NotAccessible\"" = var"(c\"enum CXAvailabilityKind\")"(0x0000000000000003)
        const CXAvailabilityKind = var"c\"enum CXAvailabilityKind\""
        const CXAvailability_Available = var"c\"CXAvailability_Available\""
        const CXAvailability_Deprecated = var"c\"CXAvailability_Deprecated\""
        const CXAvailability_NotAvailable = var"c\"CXAvailability_NotAvailable\""
        const CXAvailability_NotAccessible = var"c\"CXAvailability_NotAccessible\""
        export var"c\"enum CXAvailabilityKind\"", var"(c\"enum CXAvailabilityKind\")", var"c\"CXAvailability_Available\"", var"c\"CXAvailability_Deprecated\"", var"c\"CXAvailability_NotAvailable\"", var"c\"CXAvailability_NotAccessible\""
        export CXAvailabilityKind, CXAvailability_Available, CXAvailability_Deprecated, CXAvailability_NotAvailable, CXAvailability_NotAccessible
        var"c\"enum CXAvailabilityKind\""
        abstract type var"c\"struct CXVersion\"" <: Cstruct end
        const CXVersion = var"c\"struct CXVersion\""
        export var"c\"struct CXVersion\""
        export CXVersion
        var"c\"struct CXVersion\""
        struct var"(c\"struct CXVersion\")" <: var"c\"struct CXVersion\""
            mem::CBinding.NTuple{12, CBinding.UInt8}
            var"(c\"struct CXVersion\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{12, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"struct CXVersion\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:Major, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 0, 0, -1}}, CBinding.Tuple{:Minor, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 4, 0, -1}}, CBinding.Tuple{:Subminor, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"struct CXVersion\")"}) = begin
                var"(c\"struct CXVersion\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"struct CXVersion\""}) = begin
                var"(c\"struct CXVersion\")"
            end
        const CXVersion = var"c\"struct CXVersion\""
        export var"c\"struct CXVersion\"", var"(c\"struct CXVersion\")"
        export CXVersion
        var"c\"struct CXVersion\""
        const var"c\"CXVersion\"" = var"c\"struct CXVersion\""
        const CXVersion = var"c\"CXVersion\""
        export var"c\"CXVersion\""
        export CXVersion
        var"c\"CXVersion\""
        abstract type var"c\"enum CXCursor_ExceptionSpecificationKind\"" <: Cenum end
        const CXCursor_ExceptionSpecificationKind = var"c\"enum CXCursor_ExceptionSpecificationKind\""
        export var"c\"enum CXCursor_ExceptionSpecificationKind\""
        export CXCursor_ExceptionSpecificationKind
        var"c\"enum CXCursor_ExceptionSpecificationKind\""
        primitive type var"(c\"enum CXCursor_ExceptionSpecificationKind\")" <: var"c\"enum CXCursor_ExceptionSpecificationKind\"" 32 end
        (::(Type){var"(c\"enum CXCursor_ExceptionSpecificationKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCursor_ExceptionSpecificationKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCursor_ExceptionSpecificationKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_DynamicNone\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_Dynamic\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_MSAny\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_BasicNoexcept\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_ComputedNoexcept\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_Unevaluated\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_Uninstantiated\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_Unparsed\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXCursor_ExceptionSpecificationKind_NoThrow\""), 0x0000000000000009}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCursor_ExceptionSpecificationKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCursor_ExceptionSpecificationKind\")"}) = begin
                var"(c\"enum CXCursor_ExceptionSpecificationKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCursor_ExceptionSpecificationKind\""}) = begin
                var"(c\"enum CXCursor_ExceptionSpecificationKind\")"
            end
        const var"c\"CXCursor_ExceptionSpecificationKind_None\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000000)
        const var"c\"CXCursor_ExceptionSpecificationKind_DynamicNone\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000001)
        const var"c\"CXCursor_ExceptionSpecificationKind_Dynamic\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000002)
        const var"c\"CXCursor_ExceptionSpecificationKind_MSAny\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000003)
        const var"c\"CXCursor_ExceptionSpecificationKind_BasicNoexcept\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000004)
        const var"c\"CXCursor_ExceptionSpecificationKind_ComputedNoexcept\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000005)
        const var"c\"CXCursor_ExceptionSpecificationKind_Unevaluated\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000006)
        const var"c\"CXCursor_ExceptionSpecificationKind_Uninstantiated\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000007)
        const var"c\"CXCursor_ExceptionSpecificationKind_Unparsed\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000008)
        const var"c\"CXCursor_ExceptionSpecificationKind_NoThrow\"" = var"(c\"enum CXCursor_ExceptionSpecificationKind\")"(0x0000000000000009)
        const CXCursor_ExceptionSpecificationKind = var"c\"enum CXCursor_ExceptionSpecificationKind\""
        const CXCursor_ExceptionSpecificationKind_None = var"c\"CXCursor_ExceptionSpecificationKind_None\""
        const CXCursor_ExceptionSpecificationKind_DynamicNone = var"c\"CXCursor_ExceptionSpecificationKind_DynamicNone\""
        const CXCursor_ExceptionSpecificationKind_Dynamic = var"c\"CXCursor_ExceptionSpecificationKind_Dynamic\""
        const CXCursor_ExceptionSpecificationKind_MSAny = var"c\"CXCursor_ExceptionSpecificationKind_MSAny\""
        const CXCursor_ExceptionSpecificationKind_BasicNoexcept = var"c\"CXCursor_ExceptionSpecificationKind_BasicNoexcept\""
        const CXCursor_ExceptionSpecificationKind_ComputedNoexcept = var"c\"CXCursor_ExceptionSpecificationKind_ComputedNoexcept\""
        const CXCursor_ExceptionSpecificationKind_Unevaluated = var"c\"CXCursor_ExceptionSpecificationKind_Unevaluated\""
        const CXCursor_ExceptionSpecificationKind_Uninstantiated = var"c\"CXCursor_ExceptionSpecificationKind_Uninstantiated\""
        const CXCursor_ExceptionSpecificationKind_Unparsed = var"c\"CXCursor_ExceptionSpecificationKind_Unparsed\""
        const CXCursor_ExceptionSpecificationKind_NoThrow = var"c\"CXCursor_ExceptionSpecificationKind_NoThrow\""
        export var"c\"enum CXCursor_ExceptionSpecificationKind\"", var"(c\"enum CXCursor_ExceptionSpecificationKind\")", var"c\"CXCursor_ExceptionSpecificationKind_None\"", var"c\"CXCursor_ExceptionSpecificationKind_DynamicNone\"", var"c\"CXCursor_ExceptionSpecificationKind_Dynamic\"", var"c\"CXCursor_ExceptionSpecificationKind_MSAny\"", var"c\"CXCursor_ExceptionSpecificationKind_BasicNoexcept\"", var"c\"CXCursor_ExceptionSpecificationKind_ComputedNoexcept\"", var"c\"CXCursor_ExceptionSpecificationKind_Unevaluated\"", var"c\"CXCursor_ExceptionSpecificationKind_Uninstantiated\"", var"c\"CXCursor_ExceptionSpecificationKind_Unparsed\"", var"c\"CXCursor_ExceptionSpecificationKind_NoThrow\""
        export CXCursor_ExceptionSpecificationKind, CXCursor_ExceptionSpecificationKind_None, CXCursor_ExceptionSpecificationKind_DynamicNone, CXCursor_ExceptionSpecificationKind_Dynamic, CXCursor_ExceptionSpecificationKind_MSAny, CXCursor_ExceptionSpecificationKind_BasicNoexcept, CXCursor_ExceptionSpecificationKind_ComputedNoexcept, CXCursor_ExceptionSpecificationKind_Unevaluated, CXCursor_ExceptionSpecificationKind_Uninstantiated, CXCursor_ExceptionSpecificationKind_Unparsed, CXCursor_ExceptionSpecificationKind_NoThrow
        var"c\"enum CXCursor_ExceptionSpecificationKind\""
        struct Cbinding_clang_createIndex{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXIndex\"", CBinding.Tuple{CBinding.Cint, CBinding.Cint}, :cdecl}, libpath, :clang_createIndex}
        end
        const var"c\"clang_createIndex\"" = Cbinding_clang_createIndex{:clang_createIndex}()
        (func::Cbinding_clang_createIndex)(var"c\"excludeDeclarationsFromPCH\"", var"c\"displayDiagnostics\"") = begin
                CBinding.funccall(func, var"c\"excludeDeclarationsFromPCH\"", var"c\"displayDiagnostics\"")
            end
        const clang_createIndex = var"c\"clang_createIndex\""
        export var"c\"clang_createIndex\""
        export clang_createIndex
        var"c\"clang_createIndex\""
        struct Cbinding_clang_disposeIndex{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXIndex\""}, :cdecl}, libpath, :clang_disposeIndex}
        end
        const var"c\"clang_disposeIndex\"" = Cbinding_clang_disposeIndex{:clang_disposeIndex}()
        (func::Cbinding_clang_disposeIndex)(var"c\"index\"") = begin
                CBinding.funccall(func, var"c\"index\"")
            end
        const clang_disposeIndex = var"c\"clang_disposeIndex\""
        export var"c\"clang_disposeIndex\""
        export clang_disposeIndex
        var"c\"clang_disposeIndex\""
        abstract type var"c\"CXChoice\"" <: Cenum end
        const CXChoice = var"c\"CXChoice\""
        export var"c\"CXChoice\""
        export CXChoice
        var"c\"CXChoice\""
        primitive type var"(c\"CXChoice\")" <: var"c\"CXChoice\"" 32 end
        (::(Type){var"(c\"CXChoice\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXChoice\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXChoice\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXChoice_Default\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXChoice_Enabled\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXChoice_Disabled\""), 0x0000000000000002}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXChoice\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXChoice\")"}) = begin
                var"(c\"CXChoice\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXChoice\""}) = begin
                var"(c\"CXChoice\")"
            end
        const var"c\"CXChoice_Default\"" = var"(c\"CXChoice\")"(0x0000000000000000)
        const var"c\"CXChoice_Enabled\"" = var"(c\"CXChoice\")"(0x0000000000000001)
        const var"c\"CXChoice_Disabled\"" = var"(c\"CXChoice\")"(0x0000000000000002)
        const CXChoice = var"c\"CXChoice\""
        const CXChoice_Default = var"c\"CXChoice_Default\""
        const CXChoice_Enabled = var"c\"CXChoice_Enabled\""
        const CXChoice_Disabled = var"c\"CXChoice_Disabled\""
        export var"c\"CXChoice\"", var"(c\"CXChoice\")", var"c\"CXChoice_Default\"", var"c\"CXChoice_Enabled\"", var"c\"CXChoice_Disabled\""
        export CXChoice, CXChoice_Default, CXChoice_Enabled, CXChoice_Disabled
        var"c\"CXChoice\""
        abstract type var"c\"CXGlobalOptFlags\"" <: Cenum end
        const CXGlobalOptFlags = var"c\"CXGlobalOptFlags\""
        export var"c\"CXGlobalOptFlags\""
        export CXGlobalOptFlags
        var"c\"CXGlobalOptFlags\""
        primitive type var"(c\"CXGlobalOptFlags\")" <: var"c\"CXGlobalOptFlags\"" 32 end
        (::(Type){var"(c\"CXGlobalOptFlags\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXGlobalOptFlags\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXGlobalOptFlags\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXGlobalOpt_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXGlobalOpt_ThreadBackgroundPriorityForIndexing\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXGlobalOpt_ThreadBackgroundPriorityForEditing\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXGlobalOpt_ThreadBackgroundPriorityForAll\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXGlobalOptFlags\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXGlobalOptFlags\")"}) = begin
                var"(c\"CXGlobalOptFlags\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXGlobalOptFlags\""}) = begin
                var"(c\"CXGlobalOptFlags\")"
            end
        const var"c\"CXGlobalOpt_None\"" = var"(c\"CXGlobalOptFlags\")"(0x0000000000000000)
        const var"c\"CXGlobalOpt_ThreadBackgroundPriorityForIndexing\"" = var"(c\"CXGlobalOptFlags\")"(0x0000000000000001)
        const var"c\"CXGlobalOpt_ThreadBackgroundPriorityForEditing\"" = var"(c\"CXGlobalOptFlags\")"(0x0000000000000002)
        const var"c\"CXGlobalOpt_ThreadBackgroundPriorityForAll\"" = var"(c\"CXGlobalOptFlags\")"(0x0000000000000003)
        const CXGlobalOptFlags = var"c\"CXGlobalOptFlags\""
        const CXGlobalOpt_None = var"c\"CXGlobalOpt_None\""
        const CXGlobalOpt_ThreadBackgroundPriorityForIndexing = var"c\"CXGlobalOpt_ThreadBackgroundPriorityForIndexing\""
        const CXGlobalOpt_ThreadBackgroundPriorityForEditing = var"c\"CXGlobalOpt_ThreadBackgroundPriorityForEditing\""
        const CXGlobalOpt_ThreadBackgroundPriorityForAll = var"c\"CXGlobalOpt_ThreadBackgroundPriorityForAll\""
        export var"c\"CXGlobalOptFlags\"", var"(c\"CXGlobalOptFlags\")", var"c\"CXGlobalOpt_None\"", var"c\"CXGlobalOpt_ThreadBackgroundPriorityForIndexing\"", var"c\"CXGlobalOpt_ThreadBackgroundPriorityForEditing\"", var"c\"CXGlobalOpt_ThreadBackgroundPriorityForAll\""
        export CXGlobalOptFlags, CXGlobalOpt_None, CXGlobalOpt_ThreadBackgroundPriorityForIndexing, CXGlobalOpt_ThreadBackgroundPriorityForEditing, CXGlobalOpt_ThreadBackgroundPriorityForAll
        var"c\"CXGlobalOptFlags\""
        abstract type var"c\"struct CXIndexOptions\"" <: Cstruct end
        const CXIndexOptions = var"c\"struct CXIndexOptions\""
        export var"c\"struct CXIndexOptions\""
        export CXIndexOptions
        var"c\"struct CXIndexOptions\""
        struct var"(c\"struct CXIndexOptions\")" <: var"c\"struct CXIndexOptions\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"struct CXIndexOptions\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"struct CXIndexOptions\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:Size, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 0, 0, -1}}, CBinding.Tuple{:ThreadBackgroundPriorityForIndexing, CBinding.Tuple{CBinding.Cuchar, CBinding.bitstype(CBinding.Cuchar), CBinding.integraltype(CBinding.Cuchar), 4, 0, -1}}, CBinding.Tuple{:ThreadBackgroundPriorityForEditing, CBinding.Tuple{CBinding.Cuchar, CBinding.bitstype(CBinding.Cuchar), CBinding.integraltype(CBinding.Cuchar), 5, 0, -1}}, CBinding.Tuple{:ExcludeDeclarationsFromPCH, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 6, 0, 1}}, CBinding.Tuple{:DisplayDiagnostics, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 6, 1, 1}}, CBinding.Tuple{:StorePreamblesInMemory, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 6, 2, 1}}, CBinding.Tuple{:PreambleStoragePath, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), 8, 0, -1}}, CBinding.Tuple{:InvocationEmissionPath, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"struct CXIndexOptions\")"}) = begin
                var"(c\"struct CXIndexOptions\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"struct CXIndexOptions\""}) = begin
                var"(c\"struct CXIndexOptions\")"
            end
        const CXIndexOptions = var"c\"struct CXIndexOptions\""
        export var"c\"struct CXIndexOptions\"", var"(c\"struct CXIndexOptions\")"
        export CXIndexOptions
        var"c\"struct CXIndexOptions\""
        const var"c\"CXIndexOptions\"" = var"c\"struct CXIndexOptions\""
        const CXIndexOptions = var"c\"CXIndexOptions\""
        export var"c\"CXIndexOptions\""
        export CXIndexOptions
        var"c\"CXIndexOptions\""
        struct Cbinding_clang_createIndexWithOptions{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXIndex\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIndexOptions\""}}}, :cdecl}, libpath, :clang_createIndexWithOptions}
        end
        const var"c\"clang_createIndexWithOptions\"" = Cbinding_clang_createIndexWithOptions{:clang_createIndexWithOptions}()
        (func::Cbinding_clang_createIndexWithOptions)(var"c\"options\"") = begin
                CBinding.funccall(func, var"c\"options\"")
            end
        const clang_createIndexWithOptions = var"c\"clang_createIndexWithOptions\""
        export var"c\"clang_createIndexWithOptions\""
        export clang_createIndexWithOptions
        var"c\"clang_createIndexWithOptions\""
        struct Cbinding_clang_CXIndex_setGlobalOptions{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXIndex\"", CBinding.Cuint}, :cdecl}, libpath, :clang_CXIndex_setGlobalOptions}
        end
        const var"c\"clang_CXIndex_setGlobalOptions\"" = Cbinding_clang_CXIndex_setGlobalOptions{:clang_CXIndex_setGlobalOptions}()
        (func::Cbinding_clang_CXIndex_setGlobalOptions)(arg1, var"c\"options\"") = begin
                CBinding.funccall(func, arg1, var"c\"options\"")
            end
        const clang_CXIndex_setGlobalOptions = var"c\"clang_CXIndex_setGlobalOptions\""
        export var"c\"clang_CXIndex_setGlobalOptions\""
        export clang_CXIndex_setGlobalOptions
        var"c\"clang_CXIndex_setGlobalOptions\""
        struct Cbinding_clang_CXIndex_getGlobalOptions{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXIndex\""}, :cdecl}, libpath, :clang_CXIndex_getGlobalOptions}
        end
        const var"c\"clang_CXIndex_getGlobalOptions\"" = Cbinding_clang_CXIndex_getGlobalOptions{:clang_CXIndex_getGlobalOptions}()
        (func::Cbinding_clang_CXIndex_getGlobalOptions)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_CXIndex_getGlobalOptions = var"c\"clang_CXIndex_getGlobalOptions\""
        export var"c\"clang_CXIndex_getGlobalOptions\""
        export clang_CXIndex_getGlobalOptions
        var"c\"clang_CXIndex_getGlobalOptions\""
        struct Cbinding_clang_CXIndex_setInvocationEmissionPathOption{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXIndex\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_CXIndex_setInvocationEmissionPathOption}
        end
        const var"c\"clang_CXIndex_setInvocationEmissionPathOption\"" = Cbinding_clang_CXIndex_setInvocationEmissionPathOption{:clang_CXIndex_setInvocationEmissionPathOption}()
        (func::Cbinding_clang_CXIndex_setInvocationEmissionPathOption)(arg1, var"c\"Path\"") = begin
                CBinding.funccall(func, arg1, var"c\"Path\"")
            end
        const clang_CXIndex_setInvocationEmissionPathOption = var"c\"clang_CXIndex_setInvocationEmissionPathOption\""
        export var"c\"clang_CXIndex_setInvocationEmissionPathOption\""
        export clang_CXIndex_setInvocationEmissionPathOption
        var"c\"clang_CXIndex_setInvocationEmissionPathOption\""
        struct Cbinding_clang_isFileMultipleIncludeGuarded{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXFile\""}, :cdecl}, libpath, :clang_isFileMultipleIncludeGuarded}
        end
        const var"c\"clang_isFileMultipleIncludeGuarded\"" = Cbinding_clang_isFileMultipleIncludeGuarded{:clang_isFileMultipleIncludeGuarded}()
        (func::Cbinding_clang_isFileMultipleIncludeGuarded)(var"c\"tu\"", var"c\"file\"") = begin
                CBinding.funccall(func, var"c\"tu\"", var"c\"file\"")
            end
        const clang_isFileMultipleIncludeGuarded = var"c\"clang_isFileMultipleIncludeGuarded\""
        export var"c\"clang_isFileMultipleIncludeGuarded\""
        export clang_isFileMultipleIncludeGuarded
        var"c\"clang_isFileMultipleIncludeGuarded\""
        struct Cbinding_clang_getFile{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXFile\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_getFile}
        end
        const var"c\"clang_getFile\"" = Cbinding_clang_getFile{:clang_getFile}()
        (func::Cbinding_clang_getFile)(var"c\"tu\"", var"c\"file_name\"") = begin
                CBinding.funccall(func, var"c\"tu\"", var"c\"file_name\"")
            end
        const clang_getFile = var"c\"clang_getFile\""
        export var"c\"clang_getFile\""
        export clang_getFile
        var"c\"clang_getFile\""
        struct Cbinding_clang_getFileContents{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXFile\"", CBinding.Cptr{var"c\"size_t\""}}, :cdecl}, libpath, :clang_getFileContents}
        end
        const var"c\"clang_getFileContents\"" = Cbinding_clang_getFileContents{:clang_getFileContents}()
        (func::Cbinding_clang_getFileContents)(var"c\"tu\"", var"c\"file\"", var"c\"size\"") = begin
                CBinding.funccall(func, var"c\"tu\"", var"c\"file\"", var"c\"size\"")
            end
        const clang_getFileContents = var"c\"clang_getFileContents\""
        export var"c\"clang_getFileContents\""
        export clang_getFileContents
        var"c\"clang_getFileContents\""
        struct Cbinding_clang_getLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXFile\"", CBinding.Cuint, CBinding.Cuint}, :cdecl}, libpath, :clang_getLocation}
        end
        const var"c\"clang_getLocation\"" = Cbinding_clang_getLocation{:clang_getLocation}()
        (func::Cbinding_clang_getLocation)(var"c\"tu\"", var"c\"file\"", var"c\"line\"", var"c\"column\"") = begin
                CBinding.funccall(func, var"c\"tu\"", var"c\"file\"", var"c\"line\"", var"c\"column\"")
            end
        const clang_getLocation = var"c\"clang_getLocation\""
        export var"c\"clang_getLocation\""
        export clang_getLocation
        var"c\"clang_getLocation\""
        struct Cbinding_clang_getLocationForOffset{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXFile\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getLocationForOffset}
        end
        const var"c\"clang_getLocationForOffset\"" = Cbinding_clang_getLocationForOffset{:clang_getLocationForOffset}()
        (func::Cbinding_clang_getLocationForOffset)(var"c\"tu\"", var"c\"file\"", var"c\"offset\"") = begin
                CBinding.funccall(func, var"c\"tu\"", var"c\"file\"", var"c\"offset\"")
            end
        const clang_getLocationForOffset = var"c\"clang_getLocationForOffset\""
        export var"c\"clang_getLocationForOffset\""
        export clang_getLocationForOffset
        var"c\"clang_getLocationForOffset\""
        struct Cbinding_clang_getSkippedRanges{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{var"c\"CXSourceRangeList\""}, CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXFile\""}, :cdecl}, libpath, :clang_getSkippedRanges}
        end
        const var"c\"clang_getSkippedRanges\"" = Cbinding_clang_getSkippedRanges{:clang_getSkippedRanges}()
        (func::Cbinding_clang_getSkippedRanges)(var"c\"tu\"", var"c\"file\"") = begin
                CBinding.funccall(func, var"c\"tu\"", var"c\"file\"")
            end
        const clang_getSkippedRanges = var"c\"clang_getSkippedRanges\""
        export var"c\"clang_getSkippedRanges\""
        export clang_getSkippedRanges
        var"c\"clang_getSkippedRanges\""
        struct Cbinding_clang_getAllSkippedRanges{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{var"c\"CXSourceRangeList\""}, CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_getAllSkippedRanges}
        end
        const var"c\"clang_getAllSkippedRanges\"" = Cbinding_clang_getAllSkippedRanges{:clang_getAllSkippedRanges}()
        (func::Cbinding_clang_getAllSkippedRanges)(var"c\"tu\"") = begin
                CBinding.funccall(func, var"c\"tu\"")
            end
        const clang_getAllSkippedRanges = var"c\"clang_getAllSkippedRanges\""
        export var"c\"clang_getAllSkippedRanges\""
        export clang_getAllSkippedRanges
        var"c\"clang_getAllSkippedRanges\""
        struct Cbinding_clang_getNumDiagnostics{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_getNumDiagnostics}
        end
        const var"c\"clang_getNumDiagnostics\"" = Cbinding_clang_getNumDiagnostics{:clang_getNumDiagnostics}()
        (func::Cbinding_clang_getNumDiagnostics)(var"c\"Unit\"") = begin
                CBinding.funccall(func, var"c\"Unit\"")
            end
        const clang_getNumDiagnostics = var"c\"clang_getNumDiagnostics\""
        export var"c\"clang_getNumDiagnostics\""
        export clang_getNumDiagnostics
        var"c\"clang_getNumDiagnostics\""
        struct Cbinding_clang_getDiagnostic{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXDiagnostic\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getDiagnostic}
        end
        const var"c\"clang_getDiagnostic\"" = Cbinding_clang_getDiagnostic{:clang_getDiagnostic}()
        (func::Cbinding_clang_getDiagnostic)(var"c\"Unit\"", var"c\"Index\"") = begin
                CBinding.funccall(func, var"c\"Unit\"", var"c\"Index\"")
            end
        const clang_getDiagnostic = var"c\"clang_getDiagnostic\""
        export var"c\"clang_getDiagnostic\""
        export clang_getDiagnostic
        var"c\"clang_getDiagnostic\""
        struct Cbinding_clang_getDiagnosticSetFromTU{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXDiagnosticSet\"", CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_getDiagnosticSetFromTU}
        end
        const var"c\"clang_getDiagnosticSetFromTU\"" = Cbinding_clang_getDiagnosticSetFromTU{:clang_getDiagnosticSetFromTU}()
        (func::Cbinding_clang_getDiagnosticSetFromTU)(var"c\"Unit\"") = begin
                CBinding.funccall(func, var"c\"Unit\"")
            end
        const clang_getDiagnosticSetFromTU = var"c\"clang_getDiagnosticSetFromTU\""
        export var"c\"clang_getDiagnosticSetFromTU\""
        export clang_getDiagnosticSetFromTU
        var"c\"clang_getDiagnosticSetFromTU\""
        struct Cbinding_clang_getTranslationUnitSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_getTranslationUnitSpelling}
        end
        const var"c\"clang_getTranslationUnitSpelling\"" = Cbinding_clang_getTranslationUnitSpelling{:clang_getTranslationUnitSpelling}()
        (func::Cbinding_clang_getTranslationUnitSpelling)(var"c\"CTUnit\"") = begin
                CBinding.funccall(func, var"c\"CTUnit\"")
            end
        const clang_getTranslationUnitSpelling = var"c\"clang_getTranslationUnitSpelling\""
        export var"c\"clang_getTranslationUnitSpelling\""
        export clang_getTranslationUnitSpelling
        var"c\"clang_getTranslationUnitSpelling\""
        struct Cbinding_clang_createTranslationUnitFromSourceFile{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXTranslationUnit\"", CBinding.Tuple{var"c\"CXIndex\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cint, CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}}, CBinding.Cuint, CBinding.Cptr{var"c\"struct CXUnsavedFile\""}}, :cdecl}, libpath, :clang_createTranslationUnitFromSourceFile}
        end
        const var"c\"clang_createTranslationUnitFromSourceFile\"" = Cbinding_clang_createTranslationUnitFromSourceFile{:clang_createTranslationUnitFromSourceFile}()
        (func::Cbinding_clang_createTranslationUnitFromSourceFile)(var"c\"CIdx\"", var"c\"source_filename\"", var"c\"num_clang_command_line_args\"", var"c\"clang_command_line_args\"", var"c\"num_unsaved_files\"", var"c\"unsaved_files\"") = begin
                CBinding.funccall(func, var"c\"CIdx\"", var"c\"source_filename\"", var"c\"num_clang_command_line_args\"", var"c\"clang_command_line_args\"", var"c\"num_unsaved_files\"", var"c\"unsaved_files\"")
            end
        const clang_createTranslationUnitFromSourceFile = var"c\"clang_createTranslationUnitFromSourceFile\""
        export var"c\"clang_createTranslationUnitFromSourceFile\""
        export clang_createTranslationUnitFromSourceFile
        var"c\"clang_createTranslationUnitFromSourceFile\""
        struct Cbinding_clang_createTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXTranslationUnit\"", CBinding.Tuple{var"c\"CXIndex\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_createTranslationUnit}
        end
        const var"c\"clang_createTranslationUnit\"" = Cbinding_clang_createTranslationUnit{:clang_createTranslationUnit}()
        (func::Cbinding_clang_createTranslationUnit)(var"c\"CIdx\"", var"c\"ast_filename\"") = begin
                CBinding.funccall(func, var"c\"CIdx\"", var"c\"ast_filename\"")
            end
        const clang_createTranslationUnit = var"c\"clang_createTranslationUnit\""
        export var"c\"clang_createTranslationUnit\""
        export clang_createTranslationUnit
        var"c\"clang_createTranslationUnit\""
        struct Cbinding_clang_createTranslationUnit2{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXIndex\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{var"c\"CXTranslationUnit\""}}, :cdecl}, libpath, :clang_createTranslationUnit2}
        end
        const var"c\"clang_createTranslationUnit2\"" = Cbinding_clang_createTranslationUnit2{:clang_createTranslationUnit2}()
        (func::Cbinding_clang_createTranslationUnit2)(var"c\"CIdx\"", var"c\"ast_filename\"", var"c\"out_TU\"") = begin
                CBinding.funccall(func, var"c\"CIdx\"", var"c\"ast_filename\"", var"c\"out_TU\"")
            end
        const clang_createTranslationUnit2 = var"c\"clang_createTranslationUnit2\""
        export var"c\"clang_createTranslationUnit2\""
        export clang_createTranslationUnit2
        var"c\"clang_createTranslationUnit2\""
        abstract type var"c\"enum CXTranslationUnit_Flags\"" <: Cenum end
        const CXTranslationUnit_Flags = var"c\"enum CXTranslationUnit_Flags\""
        export var"c\"enum CXTranslationUnit_Flags\""
        export CXTranslationUnit_Flags
        var"c\"enum CXTranslationUnit_Flags\""
        primitive type var"(c\"enum CXTranslationUnit_Flags\")" <: var"c\"enum CXTranslationUnit_Flags\"" 32 end
        (::(Type){var"(c\"enum CXTranslationUnit_Flags\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXTranslationUnit_Flags\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXTranslationUnit_Flags\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXTranslationUnit_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_DetailedPreprocessingRecord\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_Incomplete\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_PrecompiledPreamble\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_CacheCompletionResults\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_ForSerialization\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_CXXChainedPCH\""), 0x0000000000000020}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_SkipFunctionBodies\""), 0x0000000000000040}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_IncludeBriefCommentsInCodeCompletion\""), 0x0000000000000080}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_CreatePreambleOnFirstParse\""), 0x0000000000000100}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_KeepGoing\""), 0x0000000000000200}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_SingleFileParse\""), 0x0000000000000400}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_LimitSkipFunctionBodiesToPreamble\""), 0x0000000000000800}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_IncludeAttributedTypes\""), 0x0000000000001000}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_VisitImplicitAttributes\""), 0x0000000000002000}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_IgnoreNonErrorsFromIncludedFiles\""), 0x0000000000004000}, CBinding.Tuple{Symbol("c\"CXTranslationUnit_RetainExcludedConditionalBlocks\""), 0x0000000000008000}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXTranslationUnit_Flags\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXTranslationUnit_Flags\")"}) = begin
                var"(c\"enum CXTranslationUnit_Flags\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXTranslationUnit_Flags\""}) = begin
                var"(c\"enum CXTranslationUnit_Flags\")"
            end
        const var"c\"CXTranslationUnit_None\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000000)
        const var"c\"CXTranslationUnit_DetailedPreprocessingRecord\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000001)
        const var"c\"CXTranslationUnit_Incomplete\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000002)
        const var"c\"CXTranslationUnit_PrecompiledPreamble\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000004)
        const var"c\"CXTranslationUnit_CacheCompletionResults\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000008)
        const var"c\"CXTranslationUnit_ForSerialization\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000010)
        const var"c\"CXTranslationUnit_CXXChainedPCH\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000020)
        const var"c\"CXTranslationUnit_SkipFunctionBodies\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000040)
        const var"c\"CXTranslationUnit_IncludeBriefCommentsInCodeCompletion\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000080)
        const var"c\"CXTranslationUnit_CreatePreambleOnFirstParse\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000100)
        const var"c\"CXTranslationUnit_KeepGoing\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000200)
        const var"c\"CXTranslationUnit_SingleFileParse\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000400)
        const var"c\"CXTranslationUnit_LimitSkipFunctionBodiesToPreamble\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000000800)
        const var"c\"CXTranslationUnit_IncludeAttributedTypes\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000001000)
        const var"c\"CXTranslationUnit_VisitImplicitAttributes\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000002000)
        const var"c\"CXTranslationUnit_IgnoreNonErrorsFromIncludedFiles\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000004000)
        const var"c\"CXTranslationUnit_RetainExcludedConditionalBlocks\"" = var"(c\"enum CXTranslationUnit_Flags\")"(0x0000000000008000)
        const CXTranslationUnit_Flags = var"c\"enum CXTranslationUnit_Flags\""
        const CXTranslationUnit_None = var"c\"CXTranslationUnit_None\""
        const CXTranslationUnit_DetailedPreprocessingRecord = var"c\"CXTranslationUnit_DetailedPreprocessingRecord\""
        const CXTranslationUnit_Incomplete = var"c\"CXTranslationUnit_Incomplete\""
        const CXTranslationUnit_PrecompiledPreamble = var"c\"CXTranslationUnit_PrecompiledPreamble\""
        const CXTranslationUnit_CacheCompletionResults = var"c\"CXTranslationUnit_CacheCompletionResults\""
        const CXTranslationUnit_ForSerialization = var"c\"CXTranslationUnit_ForSerialization\""
        const CXTranslationUnit_CXXChainedPCH = var"c\"CXTranslationUnit_CXXChainedPCH\""
        const CXTranslationUnit_SkipFunctionBodies = var"c\"CXTranslationUnit_SkipFunctionBodies\""
        const CXTranslationUnit_IncludeBriefCommentsInCodeCompletion = var"c\"CXTranslationUnit_IncludeBriefCommentsInCodeCompletion\""
        const CXTranslationUnit_CreatePreambleOnFirstParse = var"c\"CXTranslationUnit_CreatePreambleOnFirstParse\""
        const CXTranslationUnit_KeepGoing = var"c\"CXTranslationUnit_KeepGoing\""
        const CXTranslationUnit_SingleFileParse = var"c\"CXTranslationUnit_SingleFileParse\""
        const CXTranslationUnit_LimitSkipFunctionBodiesToPreamble = var"c\"CXTranslationUnit_LimitSkipFunctionBodiesToPreamble\""
        const CXTranslationUnit_IncludeAttributedTypes = var"c\"CXTranslationUnit_IncludeAttributedTypes\""
        const CXTranslationUnit_VisitImplicitAttributes = var"c\"CXTranslationUnit_VisitImplicitAttributes\""
        const CXTranslationUnit_IgnoreNonErrorsFromIncludedFiles = var"c\"CXTranslationUnit_IgnoreNonErrorsFromIncludedFiles\""
        const CXTranslationUnit_RetainExcludedConditionalBlocks = var"c\"CXTranslationUnit_RetainExcludedConditionalBlocks\""
        export var"c\"enum CXTranslationUnit_Flags\"", var"(c\"enum CXTranslationUnit_Flags\")", var"c\"CXTranslationUnit_None\"", var"c\"CXTranslationUnit_DetailedPreprocessingRecord\"", var"c\"CXTranslationUnit_Incomplete\"", var"c\"CXTranslationUnit_PrecompiledPreamble\"", var"c\"CXTranslationUnit_CacheCompletionResults\"", var"c\"CXTranslationUnit_ForSerialization\"", var"c\"CXTranslationUnit_CXXChainedPCH\"", var"c\"CXTranslationUnit_SkipFunctionBodies\"", var"c\"CXTranslationUnit_IncludeBriefCommentsInCodeCompletion\"", var"c\"CXTranslationUnit_CreatePreambleOnFirstParse\"", var"c\"CXTranslationUnit_KeepGoing\"", var"c\"CXTranslationUnit_SingleFileParse\"", var"c\"CXTranslationUnit_LimitSkipFunctionBodiesToPreamble\"", var"c\"CXTranslationUnit_IncludeAttributedTypes\"", var"c\"CXTranslationUnit_VisitImplicitAttributes\"", var"c\"CXTranslationUnit_IgnoreNonErrorsFromIncludedFiles\"", var"c\"CXTranslationUnit_RetainExcludedConditionalBlocks\""
        export CXTranslationUnit_Flags, CXTranslationUnit_None, CXTranslationUnit_DetailedPreprocessingRecord, CXTranslationUnit_Incomplete, CXTranslationUnit_PrecompiledPreamble, CXTranslationUnit_CacheCompletionResults, CXTranslationUnit_ForSerialization, CXTranslationUnit_CXXChainedPCH, CXTranslationUnit_SkipFunctionBodies, CXTranslationUnit_IncludeBriefCommentsInCodeCompletion, CXTranslationUnit_CreatePreambleOnFirstParse, CXTranslationUnit_KeepGoing, CXTranslationUnit_SingleFileParse, CXTranslationUnit_LimitSkipFunctionBodiesToPreamble, CXTranslationUnit_IncludeAttributedTypes, CXTranslationUnit_VisitImplicitAttributes, CXTranslationUnit_IgnoreNonErrorsFromIncludedFiles, CXTranslationUnit_RetainExcludedConditionalBlocks
        var"c\"enum CXTranslationUnit_Flags\""
        struct Cbinding_clang_defaultEditingTranslationUnitOptions{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{}, :cdecl}, libpath, :clang_defaultEditingTranslationUnitOptions}
        end
        const var"c\"clang_defaultEditingTranslationUnitOptions\"" = Cbinding_clang_defaultEditingTranslationUnitOptions{:clang_defaultEditingTranslationUnitOptions}()
        (func::Cbinding_clang_defaultEditingTranslationUnitOptions)() = begin
                CBinding.funccall(func)
            end
        const clang_defaultEditingTranslationUnitOptions = var"c\"clang_defaultEditingTranslationUnitOptions\""
        export var"c\"clang_defaultEditingTranslationUnitOptions\""
        export clang_defaultEditingTranslationUnitOptions
        var"c\"clang_defaultEditingTranslationUnitOptions\""
        struct Cbinding_clang_parseTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXTranslationUnit\"", CBinding.Tuple{var"c\"CXIndex\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}}, CBinding.Cint, CBinding.Cptr{var"c\"struct CXUnsavedFile\""}, CBinding.Cuint, CBinding.Cuint}, :cdecl}, libpath, :clang_parseTranslationUnit}
        end
        const var"c\"clang_parseTranslationUnit\"" = Cbinding_clang_parseTranslationUnit{:clang_parseTranslationUnit}()
        (func::Cbinding_clang_parseTranslationUnit)(var"c\"CIdx\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"options\"") = begin
                CBinding.funccall(func, var"c\"CIdx\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"options\"")
            end
        const clang_parseTranslationUnit = var"c\"clang_parseTranslationUnit\""
        export var"c\"clang_parseTranslationUnit\""
        export clang_parseTranslationUnit
        var"c\"clang_parseTranslationUnit\""
        struct Cbinding_clang_parseTranslationUnit2{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXIndex\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}}, CBinding.Cint, CBinding.Cptr{var"c\"struct CXUnsavedFile\""}, CBinding.Cuint, CBinding.Cuint, CBinding.Cptr{var"c\"CXTranslationUnit\""}}, :cdecl}, libpath, :clang_parseTranslationUnit2}
        end
        const var"c\"clang_parseTranslationUnit2\"" = Cbinding_clang_parseTranslationUnit2{:clang_parseTranslationUnit2}()
        (func::Cbinding_clang_parseTranslationUnit2)(var"c\"CIdx\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"options\"", var"c\"out_TU\"") = begin
                CBinding.funccall(func, var"c\"CIdx\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"options\"", var"c\"out_TU\"")
            end
        const clang_parseTranslationUnit2 = var"c\"clang_parseTranslationUnit2\""
        export var"c\"clang_parseTranslationUnit2\""
        export clang_parseTranslationUnit2
        var"c\"clang_parseTranslationUnit2\""
        struct Cbinding_clang_parseTranslationUnit2FullArgv{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXIndex\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}}, CBinding.Cint, CBinding.Cptr{var"c\"struct CXUnsavedFile\""}, CBinding.Cuint, CBinding.Cuint, CBinding.Cptr{var"c\"CXTranslationUnit\""}}, :cdecl}, libpath, :clang_parseTranslationUnit2FullArgv}
        end
        const var"c\"clang_parseTranslationUnit2FullArgv\"" = Cbinding_clang_parseTranslationUnit2FullArgv{:clang_parseTranslationUnit2FullArgv}()
        (func::Cbinding_clang_parseTranslationUnit2FullArgv)(var"c\"CIdx\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"options\"", var"c\"out_TU\"") = begin
                CBinding.funccall(func, var"c\"CIdx\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"options\"", var"c\"out_TU\"")
            end
        const clang_parseTranslationUnit2FullArgv = var"c\"clang_parseTranslationUnit2FullArgv\""
        export var"c\"clang_parseTranslationUnit2FullArgv\""
        export clang_parseTranslationUnit2FullArgv
        var"c\"clang_parseTranslationUnit2FullArgv\""
        abstract type var"c\"enum CXSaveTranslationUnit_Flags\"" <: Cenum end
        const CXSaveTranslationUnit_Flags = var"c\"enum CXSaveTranslationUnit_Flags\""
        export var"c\"enum CXSaveTranslationUnit_Flags\""
        export CXSaveTranslationUnit_Flags
        var"c\"enum CXSaveTranslationUnit_Flags\""
        primitive type var"(c\"enum CXSaveTranslationUnit_Flags\")" <: var"c\"enum CXSaveTranslationUnit_Flags\"" 32 end
        (::(Type){var"(c\"enum CXSaveTranslationUnit_Flags\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXSaveTranslationUnit_Flags\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXSaveTranslationUnit_Flags\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXSaveTranslationUnit_None\""), 0x0000000000000000}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXSaveTranslationUnit_Flags\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXSaveTranslationUnit_Flags\")"}) = begin
                var"(c\"enum CXSaveTranslationUnit_Flags\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXSaveTranslationUnit_Flags\""}) = begin
                var"(c\"enum CXSaveTranslationUnit_Flags\")"
            end
        const var"c\"CXSaveTranslationUnit_None\"" = var"(c\"enum CXSaveTranslationUnit_Flags\")"(0x0000000000000000)
        const CXSaveTranslationUnit_Flags = var"c\"enum CXSaveTranslationUnit_Flags\""
        const CXSaveTranslationUnit_None = var"c\"CXSaveTranslationUnit_None\""
        export var"c\"enum CXSaveTranslationUnit_Flags\"", var"(c\"enum CXSaveTranslationUnit_Flags\")", var"c\"CXSaveTranslationUnit_None\""
        export CXSaveTranslationUnit_Flags, CXSaveTranslationUnit_None
        var"c\"enum CXSaveTranslationUnit_Flags\""
        struct Cbinding_clang_defaultSaveOptions{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_defaultSaveOptions}
        end
        const var"c\"clang_defaultSaveOptions\"" = Cbinding_clang_defaultSaveOptions{:clang_defaultSaveOptions}()
        (func::Cbinding_clang_defaultSaveOptions)(var"c\"TU\"") = begin
                CBinding.funccall(func, var"c\"TU\"")
            end
        const clang_defaultSaveOptions = var"c\"clang_defaultSaveOptions\""
        export var"c\"clang_defaultSaveOptions\""
        export clang_defaultSaveOptions
        var"c\"clang_defaultSaveOptions\""
        abstract type var"c\"enum CXSaveError\"" <: Cenum end
        const CXSaveError = var"c\"enum CXSaveError\""
        export var"c\"enum CXSaveError\""
        export CXSaveError
        var"c\"enum CXSaveError\""
        primitive type var"(c\"enum CXSaveError\")" <: var"c\"enum CXSaveError\"" 32 end
        (::(Type){var"(c\"enum CXSaveError\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXSaveError\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXSaveError\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXSaveError_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXSaveError_Unknown\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXSaveError_TranslationErrors\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXSaveError_InvalidTU\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXSaveError\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXSaveError\")"}) = begin
                var"(c\"enum CXSaveError\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXSaveError\""}) = begin
                var"(c\"enum CXSaveError\")"
            end
        const var"c\"CXSaveError_None\"" = var"(c\"enum CXSaveError\")"(0x0000000000000000)
        const var"c\"CXSaveError_Unknown\"" = var"(c\"enum CXSaveError\")"(0x0000000000000001)
        const var"c\"CXSaveError_TranslationErrors\"" = var"(c\"enum CXSaveError\")"(0x0000000000000002)
        const var"c\"CXSaveError_InvalidTU\"" = var"(c\"enum CXSaveError\")"(0x0000000000000003)
        const CXSaveError = var"c\"enum CXSaveError\""
        const CXSaveError_None = var"c\"CXSaveError_None\""
        const CXSaveError_Unknown = var"c\"CXSaveError_Unknown\""
        const CXSaveError_TranslationErrors = var"c\"CXSaveError_TranslationErrors\""
        const CXSaveError_InvalidTU = var"c\"CXSaveError_InvalidTU\""
        export var"c\"enum CXSaveError\"", var"(c\"enum CXSaveError\")", var"c\"CXSaveError_None\"", var"c\"CXSaveError_Unknown\"", var"c\"CXSaveError_TranslationErrors\"", var"c\"CXSaveError_InvalidTU\""
        export CXSaveError, CXSaveError_None, CXSaveError_Unknown, CXSaveError_TranslationErrors, CXSaveError_InvalidTU
        var"c\"enum CXSaveError\""
        struct Cbinding_clang_saveTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cuint}, :cdecl}, libpath, :clang_saveTranslationUnit}
        end
        const var"c\"clang_saveTranslationUnit\"" = Cbinding_clang_saveTranslationUnit{:clang_saveTranslationUnit}()
        (func::Cbinding_clang_saveTranslationUnit)(var"c\"TU\"", var"c\"FileName\"", var"c\"options\"") = begin
                CBinding.funccall(func, var"c\"TU\"", var"c\"FileName\"", var"c\"options\"")
            end
        const clang_saveTranslationUnit = var"c\"clang_saveTranslationUnit\""
        export var"c\"clang_saveTranslationUnit\""
        export clang_saveTranslationUnit
        var"c\"clang_saveTranslationUnit\""
        struct Cbinding_clang_suspendTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_suspendTranslationUnit}
        end
        const var"c\"clang_suspendTranslationUnit\"" = Cbinding_clang_suspendTranslationUnit{:clang_suspendTranslationUnit}()
        (func::Cbinding_clang_suspendTranslationUnit)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_suspendTranslationUnit = var"c\"clang_suspendTranslationUnit\""
        export var"c\"clang_suspendTranslationUnit\""
        export clang_suspendTranslationUnit
        var"c\"clang_suspendTranslationUnit\""
        struct Cbinding_clang_disposeTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_disposeTranslationUnit}
        end
        const var"c\"clang_disposeTranslationUnit\"" = Cbinding_clang_disposeTranslationUnit{:clang_disposeTranslationUnit}()
        (func::Cbinding_clang_disposeTranslationUnit)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_disposeTranslationUnit = var"c\"clang_disposeTranslationUnit\""
        export var"c\"clang_disposeTranslationUnit\""
        export clang_disposeTranslationUnit
        var"c\"clang_disposeTranslationUnit\""
        abstract type var"c\"enum CXReparse_Flags\"" <: Cenum end
        const CXReparse_Flags = var"c\"enum CXReparse_Flags\""
        export var"c\"enum CXReparse_Flags\""
        export CXReparse_Flags
        var"c\"enum CXReparse_Flags\""
        primitive type var"(c\"enum CXReparse_Flags\")" <: var"c\"enum CXReparse_Flags\"" 32 end
        (::(Type){var"(c\"enum CXReparse_Flags\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXReparse_Flags\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXReparse_Flags\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXReparse_None\""), 0x0000000000000000}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXReparse_Flags\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXReparse_Flags\")"}) = begin
                var"(c\"enum CXReparse_Flags\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXReparse_Flags\""}) = begin
                var"(c\"enum CXReparse_Flags\")"
            end
        const var"c\"CXReparse_None\"" = var"(c\"enum CXReparse_Flags\")"(0x0000000000000000)
        const CXReparse_Flags = var"c\"enum CXReparse_Flags\""
        const CXReparse_None = var"c\"CXReparse_None\""
        export var"c\"enum CXReparse_Flags\"", var"(c\"enum CXReparse_Flags\")", var"c\"CXReparse_None\""
        export CXReparse_Flags, CXReparse_None
        var"c\"enum CXReparse_Flags\""
        struct Cbinding_clang_defaultReparseOptions{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_defaultReparseOptions}
        end
        const var"c\"clang_defaultReparseOptions\"" = Cbinding_clang_defaultReparseOptions{:clang_defaultReparseOptions}()
        (func::Cbinding_clang_defaultReparseOptions)(var"c\"TU\"") = begin
                CBinding.funccall(func, var"c\"TU\"")
            end
        const clang_defaultReparseOptions = var"c\"clang_defaultReparseOptions\""
        export var"c\"clang_defaultReparseOptions\""
        export clang_defaultReparseOptions
        var"c\"clang_defaultReparseOptions\""
        struct Cbinding_clang_reparseTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.Cuint, CBinding.Cptr{var"c\"struct CXUnsavedFile\""}, CBinding.Cuint}, :cdecl}, libpath, :clang_reparseTranslationUnit}
        end
        const var"c\"clang_reparseTranslationUnit\"" = Cbinding_clang_reparseTranslationUnit{:clang_reparseTranslationUnit}()
        (func::Cbinding_clang_reparseTranslationUnit)(var"c\"TU\"", var"c\"num_unsaved_files\"", var"c\"unsaved_files\"", var"c\"options\"") = begin
                CBinding.funccall(func, var"c\"TU\"", var"c\"num_unsaved_files\"", var"c\"unsaved_files\"", var"c\"options\"")
            end
        const clang_reparseTranslationUnit = var"c\"clang_reparseTranslationUnit\""
        export var"c\"clang_reparseTranslationUnit\""
        export clang_reparseTranslationUnit
        var"c\"clang_reparseTranslationUnit\""
        abstract type var"c\"enum CXTUResourceUsageKind\"" <: Cenum end
        const CXTUResourceUsageKind = var"c\"enum CXTUResourceUsageKind\""
        export var"c\"enum CXTUResourceUsageKind\""
        export CXTUResourceUsageKind
        var"c\"enum CXTUResourceUsageKind\""
        primitive type var"(c\"enum CXTUResourceUsageKind\")" <: var"c\"enum CXTUResourceUsageKind\"" 32 end
        (::(Type){var"(c\"enum CXTUResourceUsageKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXTUResourceUsageKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXTUResourceUsageKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXTUResourceUsage_AST\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_Identifiers\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_Selectors\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_GlobalCompletionResults\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_SourceManagerContentCache\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_AST_SideTables\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_SourceManager_Membuffer_Malloc\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_SourceManager_Membuffer_MMap\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_ExternalASTSource_Membuffer_MMap\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_Preprocessor\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_PreprocessingRecord\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_SourceManager_DataStructures\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_Preprocessor_HeaderSearch\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_MEMORY_IN_BYTES_END\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_First\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXTUResourceUsage_Last\""), 0x000000000000000e}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXTUResourceUsageKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXTUResourceUsageKind\")"}) = begin
                var"(c\"enum CXTUResourceUsageKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXTUResourceUsageKind\""}) = begin
                var"(c\"enum CXTUResourceUsageKind\")"
            end
        const var"c\"CXTUResourceUsage_AST\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000001)
        const var"c\"CXTUResourceUsage_Identifiers\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000002)
        const var"c\"CXTUResourceUsage_Selectors\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000003)
        const var"c\"CXTUResourceUsage_GlobalCompletionResults\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000004)
        const var"c\"CXTUResourceUsage_SourceManagerContentCache\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000005)
        const var"c\"CXTUResourceUsage_AST_SideTables\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000006)
        const var"c\"CXTUResourceUsage_SourceManager_Membuffer_Malloc\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000007)
        const var"c\"CXTUResourceUsage_SourceManager_Membuffer_MMap\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000008)
        const var"c\"CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000009)
        const var"c\"CXTUResourceUsage_ExternalASTSource_Membuffer_MMap\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x000000000000000a)
        const var"c\"CXTUResourceUsage_Preprocessor\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x000000000000000b)
        const var"c\"CXTUResourceUsage_PreprocessingRecord\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x000000000000000c)
        const var"c\"CXTUResourceUsage_SourceManager_DataStructures\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x000000000000000d)
        const var"c\"CXTUResourceUsage_Preprocessor_HeaderSearch\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x000000000000000e)
        const var"c\"CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000001)
        const var"c\"CXTUResourceUsage_MEMORY_IN_BYTES_END\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x000000000000000e)
        const var"c\"CXTUResourceUsage_First\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x0000000000000001)
        const var"c\"CXTUResourceUsage_Last\"" = var"(c\"enum CXTUResourceUsageKind\")"(0x000000000000000e)
        const CXTUResourceUsageKind = var"c\"enum CXTUResourceUsageKind\""
        const CXTUResourceUsage_AST = var"c\"CXTUResourceUsage_AST\""
        const CXTUResourceUsage_Identifiers = var"c\"CXTUResourceUsage_Identifiers\""
        const CXTUResourceUsage_Selectors = var"c\"CXTUResourceUsage_Selectors\""
        const CXTUResourceUsage_GlobalCompletionResults = var"c\"CXTUResourceUsage_GlobalCompletionResults\""
        const CXTUResourceUsage_SourceManagerContentCache = var"c\"CXTUResourceUsage_SourceManagerContentCache\""
        const CXTUResourceUsage_AST_SideTables = var"c\"CXTUResourceUsage_AST_SideTables\""
        const CXTUResourceUsage_SourceManager_Membuffer_Malloc = var"c\"CXTUResourceUsage_SourceManager_Membuffer_Malloc\""
        const CXTUResourceUsage_SourceManager_Membuffer_MMap = var"c\"CXTUResourceUsage_SourceManager_Membuffer_MMap\""
        const CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc = var"c\"CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc\""
        const CXTUResourceUsage_ExternalASTSource_Membuffer_MMap = var"c\"CXTUResourceUsage_ExternalASTSource_Membuffer_MMap\""
        const CXTUResourceUsage_Preprocessor = var"c\"CXTUResourceUsage_Preprocessor\""
        const CXTUResourceUsage_PreprocessingRecord = var"c\"CXTUResourceUsage_PreprocessingRecord\""
        const CXTUResourceUsage_SourceManager_DataStructures = var"c\"CXTUResourceUsage_SourceManager_DataStructures\""
        const CXTUResourceUsage_Preprocessor_HeaderSearch = var"c\"CXTUResourceUsage_Preprocessor_HeaderSearch\""
        const CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN = var"c\"CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN\""
        const CXTUResourceUsage_MEMORY_IN_BYTES_END = var"c\"CXTUResourceUsage_MEMORY_IN_BYTES_END\""
        const CXTUResourceUsage_First = var"c\"CXTUResourceUsage_First\""
        const CXTUResourceUsage_Last = var"c\"CXTUResourceUsage_Last\""
        export var"c\"enum CXTUResourceUsageKind\"", var"(c\"enum CXTUResourceUsageKind\")", var"c\"CXTUResourceUsage_AST\"", var"c\"CXTUResourceUsage_Identifiers\"", var"c\"CXTUResourceUsage_Selectors\"", var"c\"CXTUResourceUsage_GlobalCompletionResults\"", var"c\"CXTUResourceUsage_SourceManagerContentCache\"", var"c\"CXTUResourceUsage_AST_SideTables\"", var"c\"CXTUResourceUsage_SourceManager_Membuffer_Malloc\"", var"c\"CXTUResourceUsage_SourceManager_Membuffer_MMap\"", var"c\"CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc\"", var"c\"CXTUResourceUsage_ExternalASTSource_Membuffer_MMap\"", var"c\"CXTUResourceUsage_Preprocessor\"", var"c\"CXTUResourceUsage_PreprocessingRecord\"", var"c\"CXTUResourceUsage_SourceManager_DataStructures\"", var"c\"CXTUResourceUsage_Preprocessor_HeaderSearch\"", var"c\"CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN\"", var"c\"CXTUResourceUsage_MEMORY_IN_BYTES_END\"", var"c\"CXTUResourceUsage_First\"", var"c\"CXTUResourceUsage_Last\""
        export CXTUResourceUsageKind, CXTUResourceUsage_AST, CXTUResourceUsage_Identifiers, CXTUResourceUsage_Selectors, CXTUResourceUsage_GlobalCompletionResults, CXTUResourceUsage_SourceManagerContentCache, CXTUResourceUsage_AST_SideTables, CXTUResourceUsage_SourceManager_Membuffer_Malloc, CXTUResourceUsage_SourceManager_Membuffer_MMap, CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc, CXTUResourceUsage_ExternalASTSource_Membuffer_MMap, CXTUResourceUsage_Preprocessor, CXTUResourceUsage_PreprocessingRecord, CXTUResourceUsage_SourceManager_DataStructures, CXTUResourceUsage_Preprocessor_HeaderSearch, CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN, CXTUResourceUsage_MEMORY_IN_BYTES_END, CXTUResourceUsage_First, CXTUResourceUsage_Last
        var"c\"enum CXTUResourceUsageKind\""
        struct Cbinding_clang_getTUResourceUsageName{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Tuple{var"c\"enum CXTUResourceUsageKind\""}, :cdecl}, libpath, :clang_getTUResourceUsageName}
        end
        const var"c\"clang_getTUResourceUsageName\"" = Cbinding_clang_getTUResourceUsageName{:clang_getTUResourceUsageName}()
        (func::Cbinding_clang_getTUResourceUsageName)(var"c\"kind\"") = begin
                CBinding.funccall(func, var"c\"kind\"")
            end
        const clang_getTUResourceUsageName = var"c\"clang_getTUResourceUsageName\""
        export var"c\"clang_getTUResourceUsageName\""
        export clang_getTUResourceUsageName
        var"c\"clang_getTUResourceUsageName\""
        abstract type var"c\"struct CXTUResourceUsageEntry\"" <: Cstruct end
        const CXTUResourceUsageEntry = var"c\"struct CXTUResourceUsageEntry\""
        export var"c\"struct CXTUResourceUsageEntry\""
        export CXTUResourceUsageEntry
        var"c\"struct CXTUResourceUsageEntry\""
        struct var"(c\"struct CXTUResourceUsageEntry\")" <: var"c\"struct CXTUResourceUsageEntry\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"struct CXTUResourceUsageEntry\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"struct CXTUResourceUsageEntry\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:kind, CBinding.Tuple{var"c\"enum CXTUResourceUsageKind\"", CBinding.bitstype(var"c\"enum CXTUResourceUsageKind\""), CBinding.integraltype(var"c\"enum CXTUResourceUsageKind\""), 0, 0, -1}}, CBinding.Tuple{:amount, CBinding.Tuple{CBinding.Culong, CBinding.bitstype(CBinding.Culong), CBinding.integraltype(CBinding.Culong), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"struct CXTUResourceUsageEntry\")"}) = begin
                var"(c\"struct CXTUResourceUsageEntry\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"struct CXTUResourceUsageEntry\""}) = begin
                var"(c\"struct CXTUResourceUsageEntry\")"
            end
        const CXTUResourceUsageEntry = var"c\"struct CXTUResourceUsageEntry\""
        export var"c\"struct CXTUResourceUsageEntry\"", var"(c\"struct CXTUResourceUsageEntry\")"
        export CXTUResourceUsageEntry
        var"c\"struct CXTUResourceUsageEntry\""
        const var"c\"CXTUResourceUsageEntry\"" = var"c\"struct CXTUResourceUsageEntry\""
        const CXTUResourceUsageEntry = var"c\"CXTUResourceUsageEntry\""
        export var"c\"CXTUResourceUsageEntry\""
        export CXTUResourceUsageEntry
        var"c\"CXTUResourceUsageEntry\""
        abstract type var"c\"struct CXTUResourceUsage\"" <: Cstruct end
        const CXTUResourceUsage = var"c\"struct CXTUResourceUsage\""
        export var"c\"struct CXTUResourceUsage\""
        export CXTUResourceUsage
        var"c\"struct CXTUResourceUsage\""
        struct var"(c\"struct CXTUResourceUsage\")" <: var"c\"struct CXTUResourceUsage\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"struct CXTUResourceUsage\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"struct CXTUResourceUsage\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:data, CBinding.Tuple{CBinding.Cptr{CBinding.Cvoid}, CBinding.bitstype(CBinding.Cptr{CBinding.Cvoid}), CBinding.integraltype(CBinding.Cptr{CBinding.Cvoid}), 0, 0, -1}}, CBinding.Tuple{:numEntries, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 8, 0, -1}}, CBinding.Tuple{:entries, CBinding.Tuple{CBinding.Cptr{var"c\"CXTUResourceUsageEntry\""}, CBinding.bitstype(CBinding.Cptr{var"c\"CXTUResourceUsageEntry\""}), CBinding.integraltype(CBinding.Cptr{var"c\"CXTUResourceUsageEntry\""}), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"struct CXTUResourceUsage\")"}) = begin
                var"(c\"struct CXTUResourceUsage\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"struct CXTUResourceUsage\""}) = begin
                var"(c\"struct CXTUResourceUsage\")"
            end
        const CXTUResourceUsage = var"c\"struct CXTUResourceUsage\""
        export var"c\"struct CXTUResourceUsage\"", var"(c\"struct CXTUResourceUsage\")"
        export CXTUResourceUsage
        var"c\"struct CXTUResourceUsage\""
        const var"c\"CXTUResourceUsage\"" = var"c\"struct CXTUResourceUsage\""
        const CXTUResourceUsage = var"c\"CXTUResourceUsage\""
        export var"c\"CXTUResourceUsage\""
        export CXTUResourceUsage
        var"c\"CXTUResourceUsage\""
        struct Cbinding_clang_getCXTUResourceUsage{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXTUResourceUsage\"", CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_getCXTUResourceUsage}
        end
        const var"c\"clang_getCXTUResourceUsage\"" = Cbinding_clang_getCXTUResourceUsage{:clang_getCXTUResourceUsage}()
        (func::Cbinding_clang_getCXTUResourceUsage)(var"c\"TU\"") = begin
                CBinding.funccall(func, var"c\"TU\"")
            end
        const clang_getCXTUResourceUsage = var"c\"clang_getCXTUResourceUsage\""
        export var"c\"clang_getCXTUResourceUsage\""
        export clang_getCXTUResourceUsage
        var"c\"clang_getCXTUResourceUsage\""
        struct Cbinding_clang_disposeCXTUResourceUsage{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXTUResourceUsage\""}, :cdecl}, libpath, :clang_disposeCXTUResourceUsage}
        end
        const var"c\"clang_disposeCXTUResourceUsage\"" = Cbinding_clang_disposeCXTUResourceUsage{:clang_disposeCXTUResourceUsage}()
        (func::Cbinding_clang_disposeCXTUResourceUsage)(var"c\"usage\"") = begin
                CBinding.funccall(func, var"c\"usage\"")
            end
        const clang_disposeCXTUResourceUsage = var"c\"clang_disposeCXTUResourceUsage\""
        export var"c\"clang_disposeCXTUResourceUsage\""
        export clang_disposeCXTUResourceUsage
        var"c\"clang_disposeCXTUResourceUsage\""
        struct Cbinding_clang_getTranslationUnitTargetInfo{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXTargetInfo\"", CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_getTranslationUnitTargetInfo}
        end
        const var"c\"clang_getTranslationUnitTargetInfo\"" = Cbinding_clang_getTranslationUnitTargetInfo{:clang_getTranslationUnitTargetInfo}()
        (func::Cbinding_clang_getTranslationUnitTargetInfo)(var"c\"CTUnit\"") = begin
                CBinding.funccall(func, var"c\"CTUnit\"")
            end
        const clang_getTranslationUnitTargetInfo = var"c\"clang_getTranslationUnitTargetInfo\""
        export var"c\"clang_getTranslationUnitTargetInfo\""
        export clang_getTranslationUnitTargetInfo
        var"c\"clang_getTranslationUnitTargetInfo\""
        struct Cbinding_clang_TargetInfo_dispose{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXTargetInfo\""}, :cdecl}, libpath, :clang_TargetInfo_dispose}
        end
        const var"c\"clang_TargetInfo_dispose\"" = Cbinding_clang_TargetInfo_dispose{:clang_TargetInfo_dispose}()
        (func::Cbinding_clang_TargetInfo_dispose)(var"c\"Info\"") = begin
                CBinding.funccall(func, var"c\"Info\"")
            end
        const clang_TargetInfo_dispose = var"c\"clang_TargetInfo_dispose\""
        export var"c\"clang_TargetInfo_dispose\""
        export clang_TargetInfo_dispose
        var"c\"clang_TargetInfo_dispose\""
        struct Cbinding_clang_TargetInfo_getTriple{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXTargetInfo\""}, :cdecl}, libpath, :clang_TargetInfo_getTriple}
        end
        const var"c\"clang_TargetInfo_getTriple\"" = Cbinding_clang_TargetInfo_getTriple{:clang_TargetInfo_getTriple}()
        (func::Cbinding_clang_TargetInfo_getTriple)(var"c\"Info\"") = begin
                CBinding.funccall(func, var"c\"Info\"")
            end
        const clang_TargetInfo_getTriple = var"c\"clang_TargetInfo_getTriple\""
        export var"c\"clang_TargetInfo_getTriple\""
        export clang_TargetInfo_getTriple
        var"c\"clang_TargetInfo_getTriple\""
        struct Cbinding_clang_TargetInfo_getPointerWidth{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXTargetInfo\""}, :cdecl}, libpath, :clang_TargetInfo_getPointerWidth}
        end
        const var"c\"clang_TargetInfo_getPointerWidth\"" = Cbinding_clang_TargetInfo_getPointerWidth{:clang_TargetInfo_getPointerWidth}()
        (func::Cbinding_clang_TargetInfo_getPointerWidth)(var"c\"Info\"") = begin
                CBinding.funccall(func, var"c\"Info\"")
            end
        const clang_TargetInfo_getPointerWidth = var"c\"clang_TargetInfo_getPointerWidth\""
        export var"c\"clang_TargetInfo_getPointerWidth\""
        export clang_TargetInfo_getPointerWidth
        var"c\"clang_TargetInfo_getPointerWidth\""
        abstract type var"c\"enum CXCursorKind\"" <: Cenum end
        const CXCursorKind = var"c\"enum CXCursorKind\""
        export var"c\"enum CXCursorKind\""
        export CXCursorKind
        var"c\"enum CXCursorKind\""
        primitive type var"(c\"enum CXCursorKind\")" <: var"c\"enum CXCursorKind\"" 32 end
        (::(Type){var"(c\"enum CXCursorKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCursorKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCursorKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXCursor_UnexposedDecl\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCursor_StructDecl\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXCursor_UnionDecl\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXCursor_ClassDecl\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXCursor_EnumDecl\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXCursor_FieldDecl\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXCursor_EnumConstantDecl\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXCursor_FunctionDecl\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXCursor_VarDecl\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXCursor_ParmDecl\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCInterfaceDecl\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCCategoryDecl\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCProtocolDecl\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCPropertyDecl\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCIvarDecl\""), 0x000000000000000f}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCInstanceMethodDecl\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCClassMethodDecl\""), 0x0000000000000011}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCImplementationDecl\""), 0x0000000000000012}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCCategoryImplDecl\""), 0x0000000000000013}, CBinding.Tuple{Symbol("c\"CXCursor_TypedefDecl\""), 0x0000000000000014}, CBinding.Tuple{Symbol("c\"CXCursor_CXXMethod\""), 0x0000000000000015}, CBinding.Tuple{Symbol("c\"CXCursor_Namespace\""), 0x0000000000000016}, CBinding.Tuple{Symbol("c\"CXCursor_LinkageSpec\""), 0x0000000000000017}, CBinding.Tuple{Symbol("c\"CXCursor_Constructor\""), 0x0000000000000018}, CBinding.Tuple{Symbol("c\"CXCursor_Destructor\""), 0x0000000000000019}, CBinding.Tuple{Symbol("c\"CXCursor_ConversionFunction\""), 0x000000000000001a}, CBinding.Tuple{Symbol("c\"CXCursor_TemplateTypeParameter\""), 0x000000000000001b}, CBinding.Tuple{Symbol("c\"CXCursor_NonTypeTemplateParameter\""), 0x000000000000001c}, CBinding.Tuple{Symbol("c\"CXCursor_TemplateTemplateParameter\""), 0x000000000000001d}, CBinding.Tuple{Symbol("c\"CXCursor_FunctionTemplate\""), 0x000000000000001e}, CBinding.Tuple{Symbol("c\"CXCursor_ClassTemplate\""), 0x000000000000001f}, CBinding.Tuple{Symbol("c\"CXCursor_ClassTemplatePartialSpecialization\""), 0x0000000000000020}, CBinding.Tuple{Symbol("c\"CXCursor_NamespaceAlias\""), 0x0000000000000021}, CBinding.Tuple{Symbol("c\"CXCursor_UsingDirective\""), 0x0000000000000022}, CBinding.Tuple{Symbol("c\"CXCursor_UsingDeclaration\""), 0x0000000000000023}, CBinding.Tuple{Symbol("c\"CXCursor_TypeAliasDecl\""), 0x0000000000000024}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCSynthesizeDecl\""), 0x0000000000000025}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCDynamicDecl\""), 0x0000000000000026}, CBinding.Tuple{Symbol("c\"CXCursor_CXXAccessSpecifier\""), 0x0000000000000027}, CBinding.Tuple{Symbol("c\"CXCursor_FirstDecl\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCursor_LastDecl\""), 0x0000000000000027}, CBinding.Tuple{Symbol("c\"CXCursor_FirstRef\""), 0x0000000000000028}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCSuperClassRef\""), 0x0000000000000028}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCProtocolRef\""), 0x0000000000000029}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCClassRef\""), 0x000000000000002a}, CBinding.Tuple{Symbol("c\"CXCursor_TypeRef\""), 0x000000000000002b}, CBinding.Tuple{Symbol("c\"CXCursor_CXXBaseSpecifier\""), 0x000000000000002c}, CBinding.Tuple{Symbol("c\"CXCursor_TemplateRef\""), 0x000000000000002d}, CBinding.Tuple{Symbol("c\"CXCursor_NamespaceRef\""), 0x000000000000002e}, CBinding.Tuple{Symbol("c\"CXCursor_MemberRef\""), 0x000000000000002f}, CBinding.Tuple{Symbol("c\"CXCursor_LabelRef\""), 0x0000000000000030}, CBinding.Tuple{Symbol("c\"CXCursor_OverloadedDeclRef\""), 0x0000000000000031}, CBinding.Tuple{Symbol("c\"CXCursor_VariableRef\""), 0x0000000000000032}, CBinding.Tuple{Symbol("c\"CXCursor_LastRef\""), 0x0000000000000032}, CBinding.Tuple{Symbol("c\"CXCursor_FirstInvalid\""), 0x0000000000000046}, CBinding.Tuple{Symbol("c\"CXCursor_InvalidFile\""), 0x0000000000000046}, CBinding.Tuple{Symbol("c\"CXCursor_NoDeclFound\""), 0x0000000000000047}, CBinding.Tuple{Symbol("c\"CXCursor_NotImplemented\""), 0x0000000000000048}, CBinding.Tuple{Symbol("c\"CXCursor_InvalidCode\""), 0x0000000000000049}, CBinding.Tuple{Symbol("c\"CXCursor_LastInvalid\""), 0x0000000000000049}, CBinding.Tuple{Symbol("c\"CXCursor_FirstExpr\""), 0x0000000000000064}, CBinding.Tuple{Symbol("c\"CXCursor_UnexposedExpr\""), 0x0000000000000064}, CBinding.Tuple{Symbol("c\"CXCursor_DeclRefExpr\""), 0x0000000000000065}, CBinding.Tuple{Symbol("c\"CXCursor_MemberRefExpr\""), 0x0000000000000066}, CBinding.Tuple{Symbol("c\"CXCursor_CallExpr\""), 0x0000000000000067}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCMessageExpr\""), 0x0000000000000068}, CBinding.Tuple{Symbol("c\"CXCursor_BlockExpr\""), 0x0000000000000069}, CBinding.Tuple{Symbol("c\"CXCursor_IntegerLiteral\""), 0x000000000000006a}, CBinding.Tuple{Symbol("c\"CXCursor_FloatingLiteral\""), 0x000000000000006b}, CBinding.Tuple{Symbol("c\"CXCursor_ImaginaryLiteral\""), 0x000000000000006c}, CBinding.Tuple{Symbol("c\"CXCursor_StringLiteral\""), 0x000000000000006d}, CBinding.Tuple{Symbol("c\"CXCursor_CharacterLiteral\""), 0x000000000000006e}, CBinding.Tuple{Symbol("c\"CXCursor_ParenExpr\""), 0x000000000000006f}, CBinding.Tuple{Symbol("c\"CXCursor_UnaryOperator\""), 0x0000000000000070}, CBinding.Tuple{Symbol("c\"CXCursor_ArraySubscriptExpr\""), 0x0000000000000071}, CBinding.Tuple{Symbol("c\"CXCursor_BinaryOperator\""), 0x0000000000000072}, CBinding.Tuple{Symbol("c\"CXCursor_CompoundAssignOperator\""), 0x0000000000000073}, CBinding.Tuple{Symbol("c\"CXCursor_ConditionalOperator\""), 0x0000000000000074}, CBinding.Tuple{Symbol("c\"CXCursor_CStyleCastExpr\""), 0x0000000000000075}, CBinding.Tuple{Symbol("c\"CXCursor_CompoundLiteralExpr\""), 0x0000000000000076}, CBinding.Tuple{Symbol("c\"CXCursor_InitListExpr\""), 0x0000000000000077}, CBinding.Tuple{Symbol("c\"CXCursor_AddrLabelExpr\""), 0x0000000000000078}, CBinding.Tuple{Symbol("c\"CXCursor_StmtExpr\""), 0x0000000000000079}, CBinding.Tuple{Symbol("c\"CXCursor_GenericSelectionExpr\""), 0x000000000000007a}, CBinding.Tuple{Symbol("c\"CXCursor_GNUNullExpr\""), 0x000000000000007b}, CBinding.Tuple{Symbol("c\"CXCursor_CXXStaticCastExpr\""), 0x000000000000007c}, CBinding.Tuple{Symbol("c\"CXCursor_CXXDynamicCastExpr\""), 0x000000000000007d}, CBinding.Tuple{Symbol("c\"CXCursor_CXXReinterpretCastExpr\""), 0x000000000000007e}, CBinding.Tuple{Symbol("c\"CXCursor_CXXConstCastExpr\""), 0x000000000000007f}, CBinding.Tuple{Symbol("c\"CXCursor_CXXFunctionalCastExpr\""), 0x0000000000000080}, CBinding.Tuple{Symbol("c\"CXCursor_CXXTypeidExpr\""), 0x0000000000000081}, CBinding.Tuple{Symbol("c\"CXCursor_CXXBoolLiteralExpr\""), 0x0000000000000082}, CBinding.Tuple{Symbol("c\"CXCursor_CXXNullPtrLiteralExpr\""), 0x0000000000000083}, CBinding.Tuple{Symbol("c\"CXCursor_CXXThisExpr\""), 0x0000000000000084}, CBinding.Tuple{Symbol("c\"CXCursor_CXXThrowExpr\""), 0x0000000000000085}, CBinding.Tuple{Symbol("c\"CXCursor_CXXNewExpr\""), 0x0000000000000086}, CBinding.Tuple{Symbol("c\"CXCursor_CXXDeleteExpr\""), 0x0000000000000087}, CBinding.Tuple{Symbol("c\"CXCursor_UnaryExpr\""), 0x0000000000000088}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCStringLiteral\""), 0x0000000000000089}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCEncodeExpr\""), 0x000000000000008a}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCSelectorExpr\""), 0x000000000000008b}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCProtocolExpr\""), 0x000000000000008c}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCBridgedCastExpr\""), 0x000000000000008d}, CBinding.Tuple{Symbol("c\"CXCursor_PackExpansionExpr\""), 0x000000000000008e}, CBinding.Tuple{Symbol("c\"CXCursor_SizeOfPackExpr\""), 0x000000000000008f}, CBinding.Tuple{Symbol("c\"CXCursor_LambdaExpr\""), 0x0000000000000090}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCBoolLiteralExpr\""), 0x0000000000000091}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCSelfExpr\""), 0x0000000000000092}, CBinding.Tuple{Symbol("c\"CXCursor_OMPArraySectionExpr\""), 0x0000000000000093}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCAvailabilityCheckExpr\""), 0x0000000000000094}, CBinding.Tuple{Symbol("c\"CXCursor_FixedPointLiteral\""), 0x0000000000000095}, CBinding.Tuple{Symbol("c\"CXCursor_OMPArrayShapingExpr\""), 0x0000000000000096}, CBinding.Tuple{Symbol("c\"CXCursor_OMPIteratorExpr\""), 0x0000000000000097}, CBinding.Tuple{Symbol("c\"CXCursor_CXXAddrspaceCastExpr\""), 0x0000000000000098}, CBinding.Tuple{Symbol("c\"CXCursor_ConceptSpecializationExpr\""), 0x0000000000000099}, CBinding.Tuple{Symbol("c\"CXCursor_RequiresExpr\""), 0x000000000000009a}, CBinding.Tuple{Symbol("c\"CXCursor_CXXParenListInitExpr\""), 0x000000000000009b}, CBinding.Tuple{Symbol("c\"CXCursor_LastExpr\""), 0x000000000000009b}, CBinding.Tuple{Symbol("c\"CXCursor_FirstStmt\""), 0x00000000000000c8}, CBinding.Tuple{Symbol("c\"CXCursor_UnexposedStmt\""), 0x00000000000000c8}, CBinding.Tuple{Symbol("c\"CXCursor_LabelStmt\""), 0x00000000000000c9}, CBinding.Tuple{Symbol("c\"CXCursor_CompoundStmt\""), 0x00000000000000ca}, CBinding.Tuple{Symbol("c\"CXCursor_CaseStmt\""), 0x00000000000000cb}, CBinding.Tuple{Symbol("c\"CXCursor_DefaultStmt\""), 0x00000000000000cc}, CBinding.Tuple{Symbol("c\"CXCursor_IfStmt\""), 0x00000000000000cd}, CBinding.Tuple{Symbol("c\"CXCursor_SwitchStmt\""), 0x00000000000000ce}, CBinding.Tuple{Symbol("c\"CXCursor_WhileStmt\""), 0x00000000000000cf}, CBinding.Tuple{Symbol("c\"CXCursor_DoStmt\""), 0x00000000000000d0}, CBinding.Tuple{Symbol("c\"CXCursor_ForStmt\""), 0x00000000000000d1}, CBinding.Tuple{Symbol("c\"CXCursor_GotoStmt\""), 0x00000000000000d2}, CBinding.Tuple{Symbol("c\"CXCursor_IndirectGotoStmt\""), 0x00000000000000d3}, CBinding.Tuple{Symbol("c\"CXCursor_ContinueStmt\""), 0x00000000000000d4}, CBinding.Tuple{Symbol("c\"CXCursor_BreakStmt\""), 0x00000000000000d5}, CBinding.Tuple{Symbol("c\"CXCursor_ReturnStmt\""), 0x00000000000000d6}, CBinding.Tuple{Symbol("c\"CXCursor_GCCAsmStmt\""), 0x00000000000000d7}, CBinding.Tuple{Symbol("c\"CXCursor_AsmStmt\""), 0x00000000000000d7}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCAtTryStmt\""), 0x00000000000000d8}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCAtCatchStmt\""), 0x00000000000000d9}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCAtFinallyStmt\""), 0x00000000000000da}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCAtThrowStmt\""), 0x00000000000000db}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCAtSynchronizedStmt\""), 0x00000000000000dc}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCAutoreleasePoolStmt\""), 0x00000000000000dd}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCForCollectionStmt\""), 0x00000000000000de}, CBinding.Tuple{Symbol("c\"CXCursor_CXXCatchStmt\""), 0x00000000000000df}, CBinding.Tuple{Symbol("c\"CXCursor_CXXTryStmt\""), 0x00000000000000e0}, CBinding.Tuple{Symbol("c\"CXCursor_CXXForRangeStmt\""), 0x00000000000000e1}, CBinding.Tuple{Symbol("c\"CXCursor_SEHTryStmt\""), 0x00000000000000e2}, CBinding.Tuple{Symbol("c\"CXCursor_SEHExceptStmt\""), 0x00000000000000e3}, CBinding.Tuple{Symbol("c\"CXCursor_SEHFinallyStmt\""), 0x00000000000000e4}, CBinding.Tuple{Symbol("c\"CXCursor_MSAsmStmt\""), 0x00000000000000e5}, CBinding.Tuple{Symbol("c\"CXCursor_NullStmt\""), 0x00000000000000e6}, CBinding.Tuple{Symbol("c\"CXCursor_DeclStmt\""), 0x00000000000000e7}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelDirective\""), 0x00000000000000e8}, CBinding.Tuple{Symbol("c\"CXCursor_OMPSimdDirective\""), 0x00000000000000e9}, CBinding.Tuple{Symbol("c\"CXCursor_OMPForDirective\""), 0x00000000000000ea}, CBinding.Tuple{Symbol("c\"CXCursor_OMPSectionsDirective\""), 0x00000000000000eb}, CBinding.Tuple{Symbol("c\"CXCursor_OMPSectionDirective\""), 0x00000000000000ec}, CBinding.Tuple{Symbol("c\"CXCursor_OMPSingleDirective\""), 0x00000000000000ed}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelForDirective\""), 0x00000000000000ee}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelSectionsDirective\""), 0x00000000000000ef}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTaskDirective\""), 0x00000000000000f0}, CBinding.Tuple{Symbol("c\"CXCursor_OMPMasterDirective\""), 0x00000000000000f1}, CBinding.Tuple{Symbol("c\"CXCursor_OMPCriticalDirective\""), 0x00000000000000f2}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTaskyieldDirective\""), 0x00000000000000f3}, CBinding.Tuple{Symbol("c\"CXCursor_OMPBarrierDirective\""), 0x00000000000000f4}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTaskwaitDirective\""), 0x00000000000000f5}, CBinding.Tuple{Symbol("c\"CXCursor_OMPFlushDirective\""), 0x00000000000000f6}, CBinding.Tuple{Symbol("c\"CXCursor_SEHLeaveStmt\""), 0x00000000000000f7}, CBinding.Tuple{Symbol("c\"CXCursor_OMPOrderedDirective\""), 0x00000000000000f8}, CBinding.Tuple{Symbol("c\"CXCursor_OMPAtomicDirective\""), 0x00000000000000f9}, CBinding.Tuple{Symbol("c\"CXCursor_OMPForSimdDirective\""), 0x00000000000000fa}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelForSimdDirective\""), 0x00000000000000fb}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetDirective\""), 0x00000000000000fc}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTeamsDirective\""), 0x00000000000000fd}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTaskgroupDirective\""), 0x00000000000000fe}, CBinding.Tuple{Symbol("c\"CXCursor_OMPCancellationPointDirective\""), 0x00000000000000ff}, CBinding.Tuple{Symbol("c\"CXCursor_OMPCancelDirective\""), 0x0000000000000100}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetDataDirective\""), 0x0000000000000101}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTaskLoopDirective\""), 0x0000000000000102}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTaskLoopSimdDirective\""), 0x0000000000000103}, CBinding.Tuple{Symbol("c\"CXCursor_OMPDistributeDirective\""), 0x0000000000000104}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetEnterDataDirective\""), 0x0000000000000105}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetExitDataDirective\""), 0x0000000000000106}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetParallelDirective\""), 0x0000000000000107}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetParallelForDirective\""), 0x0000000000000108}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetUpdateDirective\""), 0x0000000000000109}, CBinding.Tuple{Symbol("c\"CXCursor_OMPDistributeParallelForDirective\""), 0x000000000000010a}, CBinding.Tuple{Symbol("c\"CXCursor_OMPDistributeParallelForSimdDirective\""), 0x000000000000010b}, CBinding.Tuple{Symbol("c\"CXCursor_OMPDistributeSimdDirective\""), 0x000000000000010c}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetParallelForSimdDirective\""), 0x000000000000010d}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetSimdDirective\""), 0x000000000000010e}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTeamsDistributeDirective\""), 0x000000000000010f}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTeamsDistributeSimdDirective\""), 0x0000000000000110}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTeamsDistributeParallelForSimdDirective\""), 0x0000000000000111}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTeamsDistributeParallelForDirective\""), 0x0000000000000112}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetTeamsDirective\""), 0x0000000000000113}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetTeamsDistributeDirective\""), 0x0000000000000114}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetTeamsDistributeParallelForDirective\""), 0x0000000000000115}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective\""), 0x0000000000000116}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetTeamsDistributeSimdDirective\""), 0x0000000000000117}, CBinding.Tuple{Symbol("c\"CXCursor_BuiltinBitCastExpr\""), 0x0000000000000118}, CBinding.Tuple{Symbol("c\"CXCursor_OMPMasterTaskLoopDirective\""), 0x0000000000000119}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelMasterTaskLoopDirective\""), 0x000000000000011a}, CBinding.Tuple{Symbol("c\"CXCursor_OMPMasterTaskLoopSimdDirective\""), 0x000000000000011b}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelMasterTaskLoopSimdDirective\""), 0x000000000000011c}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelMasterDirective\""), 0x000000000000011d}, CBinding.Tuple{Symbol("c\"CXCursor_OMPDepobjDirective\""), 0x000000000000011e}, CBinding.Tuple{Symbol("c\"CXCursor_OMPScanDirective\""), 0x000000000000011f}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTileDirective\""), 0x0000000000000120}, CBinding.Tuple{Symbol("c\"CXCursor_OMPCanonicalLoop\""), 0x0000000000000121}, CBinding.Tuple{Symbol("c\"CXCursor_OMPInteropDirective\""), 0x0000000000000122}, CBinding.Tuple{Symbol("c\"CXCursor_OMPDispatchDirective\""), 0x0000000000000123}, CBinding.Tuple{Symbol("c\"CXCursor_OMPMaskedDirective\""), 0x0000000000000124}, CBinding.Tuple{Symbol("c\"CXCursor_OMPUnrollDirective\""), 0x0000000000000125}, CBinding.Tuple{Symbol("c\"CXCursor_OMPMetaDirective\""), 0x0000000000000126}, CBinding.Tuple{Symbol("c\"CXCursor_OMPGenericLoopDirective\""), 0x0000000000000127}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTeamsGenericLoopDirective\""), 0x0000000000000128}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetTeamsGenericLoopDirective\""), 0x0000000000000129}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelGenericLoopDirective\""), 0x000000000000012a}, CBinding.Tuple{Symbol("c\"CXCursor_OMPTargetParallelGenericLoopDirective\""), 0x000000000000012b}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelMaskedDirective\""), 0x000000000000012c}, CBinding.Tuple{Symbol("c\"CXCursor_OMPMaskedTaskLoopDirective\""), 0x000000000000012d}, CBinding.Tuple{Symbol("c\"CXCursor_OMPMaskedTaskLoopSimdDirective\""), 0x000000000000012e}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelMaskedTaskLoopDirective\""), 0x000000000000012f}, CBinding.Tuple{Symbol("c\"CXCursor_OMPParallelMaskedTaskLoopSimdDirective\""), 0x0000000000000130}, CBinding.Tuple{Symbol("c\"CXCursor_OMPErrorDirective\""), 0x0000000000000131}, CBinding.Tuple{Symbol("c\"CXCursor_OMPScopeDirective\""), 0x0000000000000132}, CBinding.Tuple{Symbol("c\"CXCursor_LastStmt\""), 0x0000000000000132}, CBinding.Tuple{Symbol("c\"CXCursor_TranslationUnit\""), 0x000000000000015e}, CBinding.Tuple{Symbol("c\"CXCursor_FirstAttr\""), 0x0000000000000190}, CBinding.Tuple{Symbol("c\"CXCursor_UnexposedAttr\""), 0x0000000000000190}, CBinding.Tuple{Symbol("c\"CXCursor_IBActionAttr\""), 0x0000000000000191}, CBinding.Tuple{Symbol("c\"CXCursor_IBOutletAttr\""), 0x0000000000000192}, CBinding.Tuple{Symbol("c\"CXCursor_IBOutletCollectionAttr\""), 0x0000000000000193}, CBinding.Tuple{Symbol("c\"CXCursor_CXXFinalAttr\""), 0x0000000000000194}, CBinding.Tuple{Symbol("c\"CXCursor_CXXOverrideAttr\""), 0x0000000000000195}, CBinding.Tuple{Symbol("c\"CXCursor_AnnotateAttr\""), 0x0000000000000196}, CBinding.Tuple{Symbol("c\"CXCursor_AsmLabelAttr\""), 0x0000000000000197}, CBinding.Tuple{Symbol("c\"CXCursor_PackedAttr\""), 0x0000000000000198}, CBinding.Tuple{Symbol("c\"CXCursor_PureAttr\""), 0x0000000000000199}, CBinding.Tuple{Symbol("c\"CXCursor_ConstAttr\""), 0x000000000000019a}, CBinding.Tuple{Symbol("c\"CXCursor_NoDuplicateAttr\""), 0x000000000000019b}, CBinding.Tuple{Symbol("c\"CXCursor_CUDAConstantAttr\""), 0x000000000000019c}, CBinding.Tuple{Symbol("c\"CXCursor_CUDADeviceAttr\""), 0x000000000000019d}, CBinding.Tuple{Symbol("c\"CXCursor_CUDAGlobalAttr\""), 0x000000000000019e}, CBinding.Tuple{Symbol("c\"CXCursor_CUDAHostAttr\""), 0x000000000000019f}, CBinding.Tuple{Symbol("c\"CXCursor_CUDASharedAttr\""), 0x00000000000001a0}, CBinding.Tuple{Symbol("c\"CXCursor_VisibilityAttr\""), 0x00000000000001a1}, CBinding.Tuple{Symbol("c\"CXCursor_DLLExport\""), 0x00000000000001a2}, CBinding.Tuple{Symbol("c\"CXCursor_DLLImport\""), 0x00000000000001a3}, CBinding.Tuple{Symbol("c\"CXCursor_NSReturnsRetained\""), 0x00000000000001a4}, CBinding.Tuple{Symbol("c\"CXCursor_NSReturnsNotRetained\""), 0x00000000000001a5}, CBinding.Tuple{Symbol("c\"CXCursor_NSReturnsAutoreleased\""), 0x00000000000001a6}, CBinding.Tuple{Symbol("c\"CXCursor_NSConsumesSelf\""), 0x00000000000001a7}, CBinding.Tuple{Symbol("c\"CXCursor_NSConsumed\""), 0x00000000000001a8}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCException\""), 0x00000000000001a9}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCNSObject\""), 0x00000000000001aa}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCIndependentClass\""), 0x00000000000001ab}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCPreciseLifetime\""), 0x00000000000001ac}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCReturnsInnerPointer\""), 0x00000000000001ad}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCRequiresSuper\""), 0x00000000000001ae}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCRootClass\""), 0x00000000000001af}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCSubclassingRestricted\""), 0x00000000000001b0}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCExplicitProtocolImpl\""), 0x00000000000001b1}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCDesignatedInitializer\""), 0x00000000000001b2}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCRuntimeVisible\""), 0x00000000000001b3}, CBinding.Tuple{Symbol("c\"CXCursor_ObjCBoxable\""), 0x00000000000001b4}, CBinding.Tuple{Symbol("c\"CXCursor_FlagEnum\""), 0x00000000000001b5}, CBinding.Tuple{Symbol("c\"CXCursor_ConvergentAttr\""), 0x00000000000001b6}, CBinding.Tuple{Symbol("c\"CXCursor_WarnUnusedAttr\""), 0x00000000000001b7}, CBinding.Tuple{Symbol("c\"CXCursor_WarnUnusedResultAttr\""), 0x00000000000001b8}, CBinding.Tuple{Symbol("c\"CXCursor_AlignedAttr\""), 0x00000000000001b9}, CBinding.Tuple{Symbol("c\"CXCursor_LastAttr\""), 0x00000000000001b9}, CBinding.Tuple{Symbol("c\"CXCursor_PreprocessingDirective\""), 0x00000000000001f4}, CBinding.Tuple{Symbol("c\"CXCursor_MacroDefinition\""), 0x00000000000001f5}, CBinding.Tuple{Symbol("c\"CXCursor_MacroExpansion\""), 0x00000000000001f6}, CBinding.Tuple{Symbol("c\"CXCursor_MacroInstantiation\""), 0x00000000000001f6}, CBinding.Tuple{Symbol("c\"CXCursor_InclusionDirective\""), 0x00000000000001f7}, CBinding.Tuple{Symbol("c\"CXCursor_FirstPreprocessing\""), 0x00000000000001f4}, CBinding.Tuple{Symbol("c\"CXCursor_LastPreprocessing\""), 0x00000000000001f7}, CBinding.Tuple{Symbol("c\"CXCursor_ModuleImportDecl\""), 0x0000000000000258}, CBinding.Tuple{Symbol("c\"CXCursor_TypeAliasTemplateDecl\""), 0x0000000000000259}, CBinding.Tuple{Symbol("c\"CXCursor_StaticAssert\""), 0x000000000000025a}, CBinding.Tuple{Symbol("c\"CXCursor_FriendDecl\""), 0x000000000000025b}, CBinding.Tuple{Symbol("c\"CXCursor_ConceptDecl\""), 0x000000000000025c}, CBinding.Tuple{Symbol("c\"CXCursor_FirstExtraDecl\""), 0x0000000000000258}, CBinding.Tuple{Symbol("c\"CXCursor_LastExtraDecl\""), 0x000000000000025c}, CBinding.Tuple{Symbol("c\"CXCursor_OverloadCandidate\""), 0x00000000000002bc}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCursorKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCursorKind\")"}) = begin
                var"(c\"enum CXCursorKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCursorKind\""}) = begin
                var"(c\"enum CXCursorKind\")"
            end
        const var"c\"CXCursor_UnexposedDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000001)
        const var"c\"CXCursor_StructDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000002)
        const var"c\"CXCursor_UnionDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000003)
        const var"c\"CXCursor_ClassDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000004)
        const var"c\"CXCursor_EnumDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000005)
        const var"c\"CXCursor_FieldDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000006)
        const var"c\"CXCursor_EnumConstantDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000007)
        const var"c\"CXCursor_FunctionDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000008)
        const var"c\"CXCursor_VarDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000009)
        const var"c\"CXCursor_ParmDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000000a)
        const var"c\"CXCursor_ObjCInterfaceDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000000b)
        const var"c\"CXCursor_ObjCCategoryDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000000c)
        const var"c\"CXCursor_ObjCProtocolDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000000d)
        const var"c\"CXCursor_ObjCPropertyDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000000e)
        const var"c\"CXCursor_ObjCIvarDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000000f)
        const var"c\"CXCursor_ObjCInstanceMethodDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000010)
        const var"c\"CXCursor_ObjCClassMethodDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000011)
        const var"c\"CXCursor_ObjCImplementationDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000012)
        const var"c\"CXCursor_ObjCCategoryImplDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000013)
        const var"c\"CXCursor_TypedefDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000014)
        const var"c\"CXCursor_CXXMethod\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000015)
        const var"c\"CXCursor_Namespace\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000016)
        const var"c\"CXCursor_LinkageSpec\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000017)
        const var"c\"CXCursor_Constructor\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000018)
        const var"c\"CXCursor_Destructor\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000019)
        const var"c\"CXCursor_ConversionFunction\"" = var"(c\"enum CXCursorKind\")"(0x000000000000001a)
        const var"c\"CXCursor_TemplateTypeParameter\"" = var"(c\"enum CXCursorKind\")"(0x000000000000001b)
        const var"c\"CXCursor_NonTypeTemplateParameter\"" = var"(c\"enum CXCursorKind\")"(0x000000000000001c)
        const var"c\"CXCursor_TemplateTemplateParameter\"" = var"(c\"enum CXCursorKind\")"(0x000000000000001d)
        const var"c\"CXCursor_FunctionTemplate\"" = var"(c\"enum CXCursorKind\")"(0x000000000000001e)
        const var"c\"CXCursor_ClassTemplate\"" = var"(c\"enum CXCursorKind\")"(0x000000000000001f)
        const var"c\"CXCursor_ClassTemplatePartialSpecialization\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000020)
        const var"c\"CXCursor_NamespaceAlias\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000021)
        const var"c\"CXCursor_UsingDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000022)
        const var"c\"CXCursor_UsingDeclaration\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000023)
        const var"c\"CXCursor_TypeAliasDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000024)
        const var"c\"CXCursor_ObjCSynthesizeDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000025)
        const var"c\"CXCursor_ObjCDynamicDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000026)
        const var"c\"CXCursor_CXXAccessSpecifier\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000027)
        const var"c\"CXCursor_FirstDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000001)
        const var"c\"CXCursor_LastDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000027)
        const var"c\"CXCursor_FirstRef\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000028)
        const var"c\"CXCursor_ObjCSuperClassRef\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000028)
        const var"c\"CXCursor_ObjCProtocolRef\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000029)
        const var"c\"CXCursor_ObjCClassRef\"" = var"(c\"enum CXCursorKind\")"(0x000000000000002a)
        const var"c\"CXCursor_TypeRef\"" = var"(c\"enum CXCursorKind\")"(0x000000000000002b)
        const var"c\"CXCursor_CXXBaseSpecifier\"" = var"(c\"enum CXCursorKind\")"(0x000000000000002c)
        const var"c\"CXCursor_TemplateRef\"" = var"(c\"enum CXCursorKind\")"(0x000000000000002d)
        const var"c\"CXCursor_NamespaceRef\"" = var"(c\"enum CXCursorKind\")"(0x000000000000002e)
        const var"c\"CXCursor_MemberRef\"" = var"(c\"enum CXCursorKind\")"(0x000000000000002f)
        const var"c\"CXCursor_LabelRef\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000030)
        const var"c\"CXCursor_OverloadedDeclRef\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000031)
        const var"c\"CXCursor_VariableRef\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000032)
        const var"c\"CXCursor_LastRef\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000032)
        const var"c\"CXCursor_FirstInvalid\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000046)
        const var"c\"CXCursor_InvalidFile\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000046)
        const var"c\"CXCursor_NoDeclFound\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000047)
        const var"c\"CXCursor_NotImplemented\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000048)
        const var"c\"CXCursor_InvalidCode\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000049)
        const var"c\"CXCursor_LastInvalid\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000049)
        const var"c\"CXCursor_FirstExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000064)
        const var"c\"CXCursor_UnexposedExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000064)
        const var"c\"CXCursor_DeclRefExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000065)
        const var"c\"CXCursor_MemberRefExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000066)
        const var"c\"CXCursor_CallExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000067)
        const var"c\"CXCursor_ObjCMessageExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000068)
        const var"c\"CXCursor_BlockExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000069)
        const var"c\"CXCursor_IntegerLiteral\"" = var"(c\"enum CXCursorKind\")"(0x000000000000006a)
        const var"c\"CXCursor_FloatingLiteral\"" = var"(c\"enum CXCursorKind\")"(0x000000000000006b)
        const var"c\"CXCursor_ImaginaryLiteral\"" = var"(c\"enum CXCursorKind\")"(0x000000000000006c)
        const var"c\"CXCursor_StringLiteral\"" = var"(c\"enum CXCursorKind\")"(0x000000000000006d)
        const var"c\"CXCursor_CharacterLiteral\"" = var"(c\"enum CXCursorKind\")"(0x000000000000006e)
        const var"c\"CXCursor_ParenExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000006f)
        const var"c\"CXCursor_UnaryOperator\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000070)
        const var"c\"CXCursor_ArraySubscriptExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000071)
        const var"c\"CXCursor_BinaryOperator\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000072)
        const var"c\"CXCursor_CompoundAssignOperator\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000073)
        const var"c\"CXCursor_ConditionalOperator\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000074)
        const var"c\"CXCursor_CStyleCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000075)
        const var"c\"CXCursor_CompoundLiteralExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000076)
        const var"c\"CXCursor_InitListExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000077)
        const var"c\"CXCursor_AddrLabelExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000078)
        const var"c\"CXCursor_StmtExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000079)
        const var"c\"CXCursor_GenericSelectionExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000007a)
        const var"c\"CXCursor_GNUNullExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000007b)
        const var"c\"CXCursor_CXXStaticCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000007c)
        const var"c\"CXCursor_CXXDynamicCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000007d)
        const var"c\"CXCursor_CXXReinterpretCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000007e)
        const var"c\"CXCursor_CXXConstCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000007f)
        const var"c\"CXCursor_CXXFunctionalCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000080)
        const var"c\"CXCursor_CXXTypeidExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000081)
        const var"c\"CXCursor_CXXBoolLiteralExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000082)
        const var"c\"CXCursor_CXXNullPtrLiteralExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000083)
        const var"c\"CXCursor_CXXThisExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000084)
        const var"c\"CXCursor_CXXThrowExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000085)
        const var"c\"CXCursor_CXXNewExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000086)
        const var"c\"CXCursor_CXXDeleteExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000087)
        const var"c\"CXCursor_UnaryExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000088)
        const var"c\"CXCursor_ObjCStringLiteral\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000089)
        const var"c\"CXCursor_ObjCEncodeExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000008a)
        const var"c\"CXCursor_ObjCSelectorExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000008b)
        const var"c\"CXCursor_ObjCProtocolExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000008c)
        const var"c\"CXCursor_ObjCBridgedCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000008d)
        const var"c\"CXCursor_PackExpansionExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000008e)
        const var"c\"CXCursor_SizeOfPackExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000008f)
        const var"c\"CXCursor_LambdaExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000090)
        const var"c\"CXCursor_ObjCBoolLiteralExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000091)
        const var"c\"CXCursor_ObjCSelfExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000092)
        const var"c\"CXCursor_OMPArraySectionExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000093)
        const var"c\"CXCursor_ObjCAvailabilityCheckExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000094)
        const var"c\"CXCursor_FixedPointLiteral\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000095)
        const var"c\"CXCursor_OMPArrayShapingExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000096)
        const var"c\"CXCursor_OMPIteratorExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000097)
        const var"c\"CXCursor_CXXAddrspaceCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000098)
        const var"c\"CXCursor_ConceptSpecializationExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000099)
        const var"c\"CXCursor_RequiresExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000009a)
        const var"c\"CXCursor_CXXParenListInitExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000009b)
        const var"c\"CXCursor_LastExpr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000009b)
        const var"c\"CXCursor_FirstStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000c8)
        const var"c\"CXCursor_UnexposedStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000c8)
        const var"c\"CXCursor_LabelStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000c9)
        const var"c\"CXCursor_CompoundStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000ca)
        const var"c\"CXCursor_CaseStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000cb)
        const var"c\"CXCursor_DefaultStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000cc)
        const var"c\"CXCursor_IfStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000cd)
        const var"c\"CXCursor_SwitchStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000ce)
        const var"c\"CXCursor_WhileStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000cf)
        const var"c\"CXCursor_DoStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d0)
        const var"c\"CXCursor_ForStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d1)
        const var"c\"CXCursor_GotoStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d2)
        const var"c\"CXCursor_IndirectGotoStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d3)
        const var"c\"CXCursor_ContinueStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d4)
        const var"c\"CXCursor_BreakStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d5)
        const var"c\"CXCursor_ReturnStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d6)
        const var"c\"CXCursor_GCCAsmStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d7)
        const var"c\"CXCursor_AsmStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d7)
        const var"c\"CXCursor_ObjCAtTryStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d8)
        const var"c\"CXCursor_ObjCAtCatchStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000d9)
        const var"c\"CXCursor_ObjCAtFinallyStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000da)
        const var"c\"CXCursor_ObjCAtThrowStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000db)
        const var"c\"CXCursor_ObjCAtSynchronizedStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000dc)
        const var"c\"CXCursor_ObjCAutoreleasePoolStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000dd)
        const var"c\"CXCursor_ObjCForCollectionStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000de)
        const var"c\"CXCursor_CXXCatchStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000df)
        const var"c\"CXCursor_CXXTryStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e0)
        const var"c\"CXCursor_CXXForRangeStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e1)
        const var"c\"CXCursor_SEHTryStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e2)
        const var"c\"CXCursor_SEHExceptStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e3)
        const var"c\"CXCursor_SEHFinallyStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e4)
        const var"c\"CXCursor_MSAsmStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e5)
        const var"c\"CXCursor_NullStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e6)
        const var"c\"CXCursor_DeclStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e7)
        const var"c\"CXCursor_OMPParallelDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e8)
        const var"c\"CXCursor_OMPSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000e9)
        const var"c\"CXCursor_OMPForDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000ea)
        const var"c\"CXCursor_OMPSectionsDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000eb)
        const var"c\"CXCursor_OMPSectionDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000ec)
        const var"c\"CXCursor_OMPSingleDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000ed)
        const var"c\"CXCursor_OMPParallelForDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000ee)
        const var"c\"CXCursor_OMPParallelSectionsDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000ef)
        const var"c\"CXCursor_OMPTaskDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f0)
        const var"c\"CXCursor_OMPMasterDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f1)
        const var"c\"CXCursor_OMPCriticalDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f2)
        const var"c\"CXCursor_OMPTaskyieldDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f3)
        const var"c\"CXCursor_OMPBarrierDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f4)
        const var"c\"CXCursor_OMPTaskwaitDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f5)
        const var"c\"CXCursor_OMPFlushDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f6)
        const var"c\"CXCursor_SEHLeaveStmt\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f7)
        const var"c\"CXCursor_OMPOrderedDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f8)
        const var"c\"CXCursor_OMPAtomicDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000f9)
        const var"c\"CXCursor_OMPForSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000fa)
        const var"c\"CXCursor_OMPParallelForSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000fb)
        const var"c\"CXCursor_OMPTargetDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000fc)
        const var"c\"CXCursor_OMPTeamsDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000fd)
        const var"c\"CXCursor_OMPTaskgroupDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000fe)
        const var"c\"CXCursor_OMPCancellationPointDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000000ff)
        const var"c\"CXCursor_OMPCancelDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000100)
        const var"c\"CXCursor_OMPTargetDataDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000101)
        const var"c\"CXCursor_OMPTaskLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000102)
        const var"c\"CXCursor_OMPTaskLoopSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000103)
        const var"c\"CXCursor_OMPDistributeDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000104)
        const var"c\"CXCursor_OMPTargetEnterDataDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000105)
        const var"c\"CXCursor_OMPTargetExitDataDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000106)
        const var"c\"CXCursor_OMPTargetParallelDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000107)
        const var"c\"CXCursor_OMPTargetParallelForDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000108)
        const var"c\"CXCursor_OMPTargetUpdateDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000109)
        const var"c\"CXCursor_OMPDistributeParallelForDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000010a)
        const var"c\"CXCursor_OMPDistributeParallelForSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000010b)
        const var"c\"CXCursor_OMPDistributeSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000010c)
        const var"c\"CXCursor_OMPTargetParallelForSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000010d)
        const var"c\"CXCursor_OMPTargetSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000010e)
        const var"c\"CXCursor_OMPTeamsDistributeDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000010f)
        const var"c\"CXCursor_OMPTeamsDistributeSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000110)
        const var"c\"CXCursor_OMPTeamsDistributeParallelForSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000111)
        const var"c\"CXCursor_OMPTeamsDistributeParallelForDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000112)
        const var"c\"CXCursor_OMPTargetTeamsDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000113)
        const var"c\"CXCursor_OMPTargetTeamsDistributeDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000114)
        const var"c\"CXCursor_OMPTargetTeamsDistributeParallelForDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000115)
        const var"c\"CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000116)
        const var"c\"CXCursor_OMPTargetTeamsDistributeSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000117)
        const var"c\"CXCursor_BuiltinBitCastExpr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000118)
        const var"c\"CXCursor_OMPMasterTaskLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000119)
        const var"c\"CXCursor_OMPParallelMasterTaskLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000011a)
        const var"c\"CXCursor_OMPMasterTaskLoopSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000011b)
        const var"c\"CXCursor_OMPParallelMasterTaskLoopSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000011c)
        const var"c\"CXCursor_OMPParallelMasterDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000011d)
        const var"c\"CXCursor_OMPDepobjDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000011e)
        const var"c\"CXCursor_OMPScanDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000011f)
        const var"c\"CXCursor_OMPTileDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000120)
        const var"c\"CXCursor_OMPCanonicalLoop\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000121)
        const var"c\"CXCursor_OMPInteropDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000122)
        const var"c\"CXCursor_OMPDispatchDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000123)
        const var"c\"CXCursor_OMPMaskedDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000124)
        const var"c\"CXCursor_OMPUnrollDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000125)
        const var"c\"CXCursor_OMPMetaDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000126)
        const var"c\"CXCursor_OMPGenericLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000127)
        const var"c\"CXCursor_OMPTeamsGenericLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000128)
        const var"c\"CXCursor_OMPTargetTeamsGenericLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000129)
        const var"c\"CXCursor_OMPParallelGenericLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000012a)
        const var"c\"CXCursor_OMPTargetParallelGenericLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000012b)
        const var"c\"CXCursor_OMPParallelMaskedDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000012c)
        const var"c\"CXCursor_OMPMaskedTaskLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000012d)
        const var"c\"CXCursor_OMPMaskedTaskLoopSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000012e)
        const var"c\"CXCursor_OMPParallelMaskedTaskLoopDirective\"" = var"(c\"enum CXCursorKind\")"(0x000000000000012f)
        const var"c\"CXCursor_OMPParallelMaskedTaskLoopSimdDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000130)
        const var"c\"CXCursor_OMPErrorDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000131)
        const var"c\"CXCursor_OMPScopeDirective\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000132)
        const var"c\"CXCursor_LastStmt\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000132)
        const var"c\"CXCursor_TranslationUnit\"" = var"(c\"enum CXCursorKind\")"(0x000000000000015e)
        const var"c\"CXCursor_FirstAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000190)
        const var"c\"CXCursor_UnexposedAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000190)
        const var"c\"CXCursor_IBActionAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000191)
        const var"c\"CXCursor_IBOutletAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000192)
        const var"c\"CXCursor_IBOutletCollectionAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000193)
        const var"c\"CXCursor_CXXFinalAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000194)
        const var"c\"CXCursor_CXXOverrideAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000195)
        const var"c\"CXCursor_AnnotateAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000196)
        const var"c\"CXCursor_AsmLabelAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000197)
        const var"c\"CXCursor_PackedAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000198)
        const var"c\"CXCursor_PureAttr\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000199)
        const var"c\"CXCursor_ConstAttr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000019a)
        const var"c\"CXCursor_NoDuplicateAttr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000019b)
        const var"c\"CXCursor_CUDAConstantAttr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000019c)
        const var"c\"CXCursor_CUDADeviceAttr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000019d)
        const var"c\"CXCursor_CUDAGlobalAttr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000019e)
        const var"c\"CXCursor_CUDAHostAttr\"" = var"(c\"enum CXCursorKind\")"(0x000000000000019f)
        const var"c\"CXCursor_CUDASharedAttr\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a0)
        const var"c\"CXCursor_VisibilityAttr\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a1)
        const var"c\"CXCursor_DLLExport\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a2)
        const var"c\"CXCursor_DLLImport\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a3)
        const var"c\"CXCursor_NSReturnsRetained\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a4)
        const var"c\"CXCursor_NSReturnsNotRetained\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a5)
        const var"c\"CXCursor_NSReturnsAutoreleased\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a6)
        const var"c\"CXCursor_NSConsumesSelf\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a7)
        const var"c\"CXCursor_NSConsumed\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a8)
        const var"c\"CXCursor_ObjCException\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001a9)
        const var"c\"CXCursor_ObjCNSObject\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001aa)
        const var"c\"CXCursor_ObjCIndependentClass\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001ab)
        const var"c\"CXCursor_ObjCPreciseLifetime\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001ac)
        const var"c\"CXCursor_ObjCReturnsInnerPointer\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001ad)
        const var"c\"CXCursor_ObjCRequiresSuper\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001ae)
        const var"c\"CXCursor_ObjCRootClass\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001af)
        const var"c\"CXCursor_ObjCSubclassingRestricted\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b0)
        const var"c\"CXCursor_ObjCExplicitProtocolImpl\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b1)
        const var"c\"CXCursor_ObjCDesignatedInitializer\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b2)
        const var"c\"CXCursor_ObjCRuntimeVisible\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b3)
        const var"c\"CXCursor_ObjCBoxable\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b4)
        const var"c\"CXCursor_FlagEnum\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b5)
        const var"c\"CXCursor_ConvergentAttr\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b6)
        const var"c\"CXCursor_WarnUnusedAttr\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b7)
        const var"c\"CXCursor_WarnUnusedResultAttr\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b8)
        const var"c\"CXCursor_AlignedAttr\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b9)
        const var"c\"CXCursor_LastAttr\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001b9)
        const var"c\"CXCursor_PreprocessingDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001f4)
        const var"c\"CXCursor_MacroDefinition\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001f5)
        const var"c\"CXCursor_MacroExpansion\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001f6)
        const var"c\"CXCursor_MacroInstantiation\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001f6)
        const var"c\"CXCursor_InclusionDirective\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001f7)
        const var"c\"CXCursor_FirstPreprocessing\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001f4)
        const var"c\"CXCursor_LastPreprocessing\"" = var"(c\"enum CXCursorKind\")"(0x00000000000001f7)
        const var"c\"CXCursor_ModuleImportDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000258)
        const var"c\"CXCursor_TypeAliasTemplateDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000259)
        const var"c\"CXCursor_StaticAssert\"" = var"(c\"enum CXCursorKind\")"(0x000000000000025a)
        const var"c\"CXCursor_FriendDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000025b)
        const var"c\"CXCursor_ConceptDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000025c)
        const var"c\"CXCursor_FirstExtraDecl\"" = var"(c\"enum CXCursorKind\")"(0x0000000000000258)
        const var"c\"CXCursor_LastExtraDecl\"" = var"(c\"enum CXCursorKind\")"(0x000000000000025c)
        const var"c\"CXCursor_OverloadCandidate\"" = var"(c\"enum CXCursorKind\")"(0x00000000000002bc)
        const CXCursorKind = var"c\"enum CXCursorKind\""
        const CXCursor_UnexposedDecl = var"c\"CXCursor_UnexposedDecl\""
        const CXCursor_StructDecl = var"c\"CXCursor_StructDecl\""
        const CXCursor_UnionDecl = var"c\"CXCursor_UnionDecl\""
        const CXCursor_ClassDecl = var"c\"CXCursor_ClassDecl\""
        const CXCursor_EnumDecl = var"c\"CXCursor_EnumDecl\""
        const CXCursor_FieldDecl = var"c\"CXCursor_FieldDecl\""
        const CXCursor_EnumConstantDecl = var"c\"CXCursor_EnumConstantDecl\""
        const CXCursor_FunctionDecl = var"c\"CXCursor_FunctionDecl\""
        const CXCursor_VarDecl = var"c\"CXCursor_VarDecl\""
        const CXCursor_ParmDecl = var"c\"CXCursor_ParmDecl\""
        const CXCursor_ObjCInterfaceDecl = var"c\"CXCursor_ObjCInterfaceDecl\""
        const CXCursor_ObjCCategoryDecl = var"c\"CXCursor_ObjCCategoryDecl\""
        const CXCursor_ObjCProtocolDecl = var"c\"CXCursor_ObjCProtocolDecl\""
        const CXCursor_ObjCPropertyDecl = var"c\"CXCursor_ObjCPropertyDecl\""
        const CXCursor_ObjCIvarDecl = var"c\"CXCursor_ObjCIvarDecl\""
        const CXCursor_ObjCInstanceMethodDecl = var"c\"CXCursor_ObjCInstanceMethodDecl\""
        const CXCursor_ObjCClassMethodDecl = var"c\"CXCursor_ObjCClassMethodDecl\""
        const CXCursor_ObjCImplementationDecl = var"c\"CXCursor_ObjCImplementationDecl\""
        const CXCursor_ObjCCategoryImplDecl = var"c\"CXCursor_ObjCCategoryImplDecl\""
        const CXCursor_TypedefDecl = var"c\"CXCursor_TypedefDecl\""
        const CXCursor_CXXMethod = var"c\"CXCursor_CXXMethod\""
        const CXCursor_Namespace = var"c\"CXCursor_Namespace\""
        const CXCursor_LinkageSpec = var"c\"CXCursor_LinkageSpec\""
        const CXCursor_Constructor = var"c\"CXCursor_Constructor\""
        const CXCursor_Destructor = var"c\"CXCursor_Destructor\""
        const CXCursor_ConversionFunction = var"c\"CXCursor_ConversionFunction\""
        const CXCursor_TemplateTypeParameter = var"c\"CXCursor_TemplateTypeParameter\""
        const CXCursor_NonTypeTemplateParameter = var"c\"CXCursor_NonTypeTemplateParameter\""
        const CXCursor_TemplateTemplateParameter = var"c\"CXCursor_TemplateTemplateParameter\""
        const CXCursor_FunctionTemplate = var"c\"CXCursor_FunctionTemplate\""
        const CXCursor_ClassTemplate = var"c\"CXCursor_ClassTemplate\""
        const CXCursor_ClassTemplatePartialSpecialization = var"c\"CXCursor_ClassTemplatePartialSpecialization\""
        const CXCursor_NamespaceAlias = var"c\"CXCursor_NamespaceAlias\""
        const CXCursor_UsingDirective = var"c\"CXCursor_UsingDirective\""
        const CXCursor_UsingDeclaration = var"c\"CXCursor_UsingDeclaration\""
        const CXCursor_TypeAliasDecl = var"c\"CXCursor_TypeAliasDecl\""
        const CXCursor_ObjCSynthesizeDecl = var"c\"CXCursor_ObjCSynthesizeDecl\""
        const CXCursor_ObjCDynamicDecl = var"c\"CXCursor_ObjCDynamicDecl\""
        const CXCursor_CXXAccessSpecifier = var"c\"CXCursor_CXXAccessSpecifier\""
        const CXCursor_FirstDecl = var"c\"CXCursor_FirstDecl\""
        const CXCursor_LastDecl = var"c\"CXCursor_LastDecl\""
        const CXCursor_FirstRef = var"c\"CXCursor_FirstRef\""
        const CXCursor_ObjCSuperClassRef = var"c\"CXCursor_ObjCSuperClassRef\""
        const CXCursor_ObjCProtocolRef = var"c\"CXCursor_ObjCProtocolRef\""
        const CXCursor_ObjCClassRef = var"c\"CXCursor_ObjCClassRef\""
        const CXCursor_TypeRef = var"c\"CXCursor_TypeRef\""
        const CXCursor_CXXBaseSpecifier = var"c\"CXCursor_CXXBaseSpecifier\""
        const CXCursor_TemplateRef = var"c\"CXCursor_TemplateRef\""
        const CXCursor_NamespaceRef = var"c\"CXCursor_NamespaceRef\""
        const CXCursor_MemberRef = var"c\"CXCursor_MemberRef\""
        const CXCursor_LabelRef = var"c\"CXCursor_LabelRef\""
        const CXCursor_OverloadedDeclRef = var"c\"CXCursor_OverloadedDeclRef\""
        const CXCursor_VariableRef = var"c\"CXCursor_VariableRef\""
        const CXCursor_LastRef = var"c\"CXCursor_LastRef\""
        const CXCursor_FirstInvalid = var"c\"CXCursor_FirstInvalid\""
        const CXCursor_InvalidFile = var"c\"CXCursor_InvalidFile\""
        const CXCursor_NoDeclFound = var"c\"CXCursor_NoDeclFound\""
        const CXCursor_NotImplemented = var"c\"CXCursor_NotImplemented\""
        const CXCursor_InvalidCode = var"c\"CXCursor_InvalidCode\""
        const CXCursor_LastInvalid = var"c\"CXCursor_LastInvalid\""
        const CXCursor_FirstExpr = var"c\"CXCursor_FirstExpr\""
        const CXCursor_UnexposedExpr = var"c\"CXCursor_UnexposedExpr\""
        const CXCursor_DeclRefExpr = var"c\"CXCursor_DeclRefExpr\""
        const CXCursor_MemberRefExpr = var"c\"CXCursor_MemberRefExpr\""
        const CXCursor_CallExpr = var"c\"CXCursor_CallExpr\""
        const CXCursor_ObjCMessageExpr = var"c\"CXCursor_ObjCMessageExpr\""
        const CXCursor_BlockExpr = var"c\"CXCursor_BlockExpr\""
        const CXCursor_IntegerLiteral = var"c\"CXCursor_IntegerLiteral\""
        const CXCursor_FloatingLiteral = var"c\"CXCursor_FloatingLiteral\""
        const CXCursor_ImaginaryLiteral = var"c\"CXCursor_ImaginaryLiteral\""
        const CXCursor_StringLiteral = var"c\"CXCursor_StringLiteral\""
        const CXCursor_CharacterLiteral = var"c\"CXCursor_CharacterLiteral\""
        const CXCursor_ParenExpr = var"c\"CXCursor_ParenExpr\""
        const CXCursor_UnaryOperator = var"c\"CXCursor_UnaryOperator\""
        const CXCursor_ArraySubscriptExpr = var"c\"CXCursor_ArraySubscriptExpr\""
        const CXCursor_BinaryOperator = var"c\"CXCursor_BinaryOperator\""
        const CXCursor_CompoundAssignOperator = var"c\"CXCursor_CompoundAssignOperator\""
        const CXCursor_ConditionalOperator = var"c\"CXCursor_ConditionalOperator\""
        const CXCursor_CStyleCastExpr = var"c\"CXCursor_CStyleCastExpr\""
        const CXCursor_CompoundLiteralExpr = var"c\"CXCursor_CompoundLiteralExpr\""
        const CXCursor_InitListExpr = var"c\"CXCursor_InitListExpr\""
        const CXCursor_AddrLabelExpr = var"c\"CXCursor_AddrLabelExpr\""
        const CXCursor_StmtExpr = var"c\"CXCursor_StmtExpr\""
        const CXCursor_GenericSelectionExpr = var"c\"CXCursor_GenericSelectionExpr\""
        const CXCursor_GNUNullExpr = var"c\"CXCursor_GNUNullExpr\""
        const CXCursor_CXXStaticCastExpr = var"c\"CXCursor_CXXStaticCastExpr\""
        const CXCursor_CXXDynamicCastExpr = var"c\"CXCursor_CXXDynamicCastExpr\""
        const CXCursor_CXXReinterpretCastExpr = var"c\"CXCursor_CXXReinterpretCastExpr\""
        const CXCursor_CXXConstCastExpr = var"c\"CXCursor_CXXConstCastExpr\""
        const CXCursor_CXXFunctionalCastExpr = var"c\"CXCursor_CXXFunctionalCastExpr\""
        const CXCursor_CXXTypeidExpr = var"c\"CXCursor_CXXTypeidExpr\""
        const CXCursor_CXXBoolLiteralExpr = var"c\"CXCursor_CXXBoolLiteralExpr\""
        const CXCursor_CXXNullPtrLiteralExpr = var"c\"CXCursor_CXXNullPtrLiteralExpr\""
        const CXCursor_CXXThisExpr = var"c\"CXCursor_CXXThisExpr\""
        const CXCursor_CXXThrowExpr = var"c\"CXCursor_CXXThrowExpr\""
        const CXCursor_CXXNewExpr = var"c\"CXCursor_CXXNewExpr\""
        const CXCursor_CXXDeleteExpr = var"c\"CXCursor_CXXDeleteExpr\""
        const CXCursor_UnaryExpr = var"c\"CXCursor_UnaryExpr\""
        const CXCursor_ObjCStringLiteral = var"c\"CXCursor_ObjCStringLiteral\""
        const CXCursor_ObjCEncodeExpr = var"c\"CXCursor_ObjCEncodeExpr\""
        const CXCursor_ObjCSelectorExpr = var"c\"CXCursor_ObjCSelectorExpr\""
        const CXCursor_ObjCProtocolExpr = var"c\"CXCursor_ObjCProtocolExpr\""
        const CXCursor_ObjCBridgedCastExpr = var"c\"CXCursor_ObjCBridgedCastExpr\""
        const CXCursor_PackExpansionExpr = var"c\"CXCursor_PackExpansionExpr\""
        const CXCursor_SizeOfPackExpr = var"c\"CXCursor_SizeOfPackExpr\""
        const CXCursor_LambdaExpr = var"c\"CXCursor_LambdaExpr\""
        const CXCursor_ObjCBoolLiteralExpr = var"c\"CXCursor_ObjCBoolLiteralExpr\""
        const CXCursor_ObjCSelfExpr = var"c\"CXCursor_ObjCSelfExpr\""
        const CXCursor_OMPArraySectionExpr = var"c\"CXCursor_OMPArraySectionExpr\""
        const CXCursor_ObjCAvailabilityCheckExpr = var"c\"CXCursor_ObjCAvailabilityCheckExpr\""
        const CXCursor_FixedPointLiteral = var"c\"CXCursor_FixedPointLiteral\""
        const CXCursor_OMPArrayShapingExpr = var"c\"CXCursor_OMPArrayShapingExpr\""
        const CXCursor_OMPIteratorExpr = var"c\"CXCursor_OMPIteratorExpr\""
        const CXCursor_CXXAddrspaceCastExpr = var"c\"CXCursor_CXXAddrspaceCastExpr\""
        const CXCursor_ConceptSpecializationExpr = var"c\"CXCursor_ConceptSpecializationExpr\""
        const CXCursor_RequiresExpr = var"c\"CXCursor_RequiresExpr\""
        const CXCursor_CXXParenListInitExpr = var"c\"CXCursor_CXXParenListInitExpr\""
        const CXCursor_LastExpr = var"c\"CXCursor_LastExpr\""
        const CXCursor_FirstStmt = var"c\"CXCursor_FirstStmt\""
        const CXCursor_UnexposedStmt = var"c\"CXCursor_UnexposedStmt\""
        const CXCursor_LabelStmt = var"c\"CXCursor_LabelStmt\""
        const CXCursor_CompoundStmt = var"c\"CXCursor_CompoundStmt\""
        const CXCursor_CaseStmt = var"c\"CXCursor_CaseStmt\""
        const CXCursor_DefaultStmt = var"c\"CXCursor_DefaultStmt\""
        const CXCursor_IfStmt = var"c\"CXCursor_IfStmt\""
        const CXCursor_SwitchStmt = var"c\"CXCursor_SwitchStmt\""
        const CXCursor_WhileStmt = var"c\"CXCursor_WhileStmt\""
        const CXCursor_DoStmt = var"c\"CXCursor_DoStmt\""
        const CXCursor_ForStmt = var"c\"CXCursor_ForStmt\""
        const CXCursor_GotoStmt = var"c\"CXCursor_GotoStmt\""
        const CXCursor_IndirectGotoStmt = var"c\"CXCursor_IndirectGotoStmt\""
        const CXCursor_ContinueStmt = var"c\"CXCursor_ContinueStmt\""
        const CXCursor_BreakStmt = var"c\"CXCursor_BreakStmt\""
        const CXCursor_ReturnStmt = var"c\"CXCursor_ReturnStmt\""
        const CXCursor_GCCAsmStmt = var"c\"CXCursor_GCCAsmStmt\""
        const CXCursor_AsmStmt = var"c\"CXCursor_AsmStmt\""
        const CXCursor_ObjCAtTryStmt = var"c\"CXCursor_ObjCAtTryStmt\""
        const CXCursor_ObjCAtCatchStmt = var"c\"CXCursor_ObjCAtCatchStmt\""
        const CXCursor_ObjCAtFinallyStmt = var"c\"CXCursor_ObjCAtFinallyStmt\""
        const CXCursor_ObjCAtThrowStmt = var"c\"CXCursor_ObjCAtThrowStmt\""
        const CXCursor_ObjCAtSynchronizedStmt = var"c\"CXCursor_ObjCAtSynchronizedStmt\""
        const CXCursor_ObjCAutoreleasePoolStmt = var"c\"CXCursor_ObjCAutoreleasePoolStmt\""
        const CXCursor_ObjCForCollectionStmt = var"c\"CXCursor_ObjCForCollectionStmt\""
        const CXCursor_CXXCatchStmt = var"c\"CXCursor_CXXCatchStmt\""
        const CXCursor_CXXTryStmt = var"c\"CXCursor_CXXTryStmt\""
        const CXCursor_CXXForRangeStmt = var"c\"CXCursor_CXXForRangeStmt\""
        const CXCursor_SEHTryStmt = var"c\"CXCursor_SEHTryStmt\""
        const CXCursor_SEHExceptStmt = var"c\"CXCursor_SEHExceptStmt\""
        const CXCursor_SEHFinallyStmt = var"c\"CXCursor_SEHFinallyStmt\""
        const CXCursor_MSAsmStmt = var"c\"CXCursor_MSAsmStmt\""
        const CXCursor_NullStmt = var"c\"CXCursor_NullStmt\""
        const CXCursor_DeclStmt = var"c\"CXCursor_DeclStmt\""
        const CXCursor_OMPParallelDirective = var"c\"CXCursor_OMPParallelDirective\""
        const CXCursor_OMPSimdDirective = var"c\"CXCursor_OMPSimdDirective\""
        const CXCursor_OMPForDirective = var"c\"CXCursor_OMPForDirective\""
        const CXCursor_OMPSectionsDirective = var"c\"CXCursor_OMPSectionsDirective\""
        const CXCursor_OMPSectionDirective = var"c\"CXCursor_OMPSectionDirective\""
        const CXCursor_OMPSingleDirective = var"c\"CXCursor_OMPSingleDirective\""
        const CXCursor_OMPParallelForDirective = var"c\"CXCursor_OMPParallelForDirective\""
        const CXCursor_OMPParallelSectionsDirective = var"c\"CXCursor_OMPParallelSectionsDirective\""
        const CXCursor_OMPTaskDirective = var"c\"CXCursor_OMPTaskDirective\""
        const CXCursor_OMPMasterDirective = var"c\"CXCursor_OMPMasterDirective\""
        const CXCursor_OMPCriticalDirective = var"c\"CXCursor_OMPCriticalDirective\""
        const CXCursor_OMPTaskyieldDirective = var"c\"CXCursor_OMPTaskyieldDirective\""
        const CXCursor_OMPBarrierDirective = var"c\"CXCursor_OMPBarrierDirective\""
        const CXCursor_OMPTaskwaitDirective = var"c\"CXCursor_OMPTaskwaitDirective\""
        const CXCursor_OMPFlushDirective = var"c\"CXCursor_OMPFlushDirective\""
        const CXCursor_SEHLeaveStmt = var"c\"CXCursor_SEHLeaveStmt\""
        const CXCursor_OMPOrderedDirective = var"c\"CXCursor_OMPOrderedDirective\""
        const CXCursor_OMPAtomicDirective = var"c\"CXCursor_OMPAtomicDirective\""
        const CXCursor_OMPForSimdDirective = var"c\"CXCursor_OMPForSimdDirective\""
        const CXCursor_OMPParallelForSimdDirective = var"c\"CXCursor_OMPParallelForSimdDirective\""
        const CXCursor_OMPTargetDirective = var"c\"CXCursor_OMPTargetDirective\""
        const CXCursor_OMPTeamsDirective = var"c\"CXCursor_OMPTeamsDirective\""
        const CXCursor_OMPTaskgroupDirective = var"c\"CXCursor_OMPTaskgroupDirective\""
        const CXCursor_OMPCancellationPointDirective = var"c\"CXCursor_OMPCancellationPointDirective\""
        const CXCursor_OMPCancelDirective = var"c\"CXCursor_OMPCancelDirective\""
        const CXCursor_OMPTargetDataDirective = var"c\"CXCursor_OMPTargetDataDirective\""
        const CXCursor_OMPTaskLoopDirective = var"c\"CXCursor_OMPTaskLoopDirective\""
        const CXCursor_OMPTaskLoopSimdDirective = var"c\"CXCursor_OMPTaskLoopSimdDirective\""
        const CXCursor_OMPDistributeDirective = var"c\"CXCursor_OMPDistributeDirective\""
        const CXCursor_OMPTargetEnterDataDirective = var"c\"CXCursor_OMPTargetEnterDataDirective\""
        const CXCursor_OMPTargetExitDataDirective = var"c\"CXCursor_OMPTargetExitDataDirective\""
        const CXCursor_OMPTargetParallelDirective = var"c\"CXCursor_OMPTargetParallelDirective\""
        const CXCursor_OMPTargetParallelForDirective = var"c\"CXCursor_OMPTargetParallelForDirective\""
        const CXCursor_OMPTargetUpdateDirective = var"c\"CXCursor_OMPTargetUpdateDirective\""
        const CXCursor_OMPDistributeParallelForDirective = var"c\"CXCursor_OMPDistributeParallelForDirective\""
        const CXCursor_OMPDistributeParallelForSimdDirective = var"c\"CXCursor_OMPDistributeParallelForSimdDirective\""
        const CXCursor_OMPDistributeSimdDirective = var"c\"CXCursor_OMPDistributeSimdDirective\""
        const CXCursor_OMPTargetParallelForSimdDirective = var"c\"CXCursor_OMPTargetParallelForSimdDirective\""
        const CXCursor_OMPTargetSimdDirective = var"c\"CXCursor_OMPTargetSimdDirective\""
        const CXCursor_OMPTeamsDistributeDirective = var"c\"CXCursor_OMPTeamsDistributeDirective\""
        const CXCursor_OMPTeamsDistributeSimdDirective = var"c\"CXCursor_OMPTeamsDistributeSimdDirective\""
        const CXCursor_OMPTeamsDistributeParallelForSimdDirective = var"c\"CXCursor_OMPTeamsDistributeParallelForSimdDirective\""
        const CXCursor_OMPTeamsDistributeParallelForDirective = var"c\"CXCursor_OMPTeamsDistributeParallelForDirective\""
        const CXCursor_OMPTargetTeamsDirective = var"c\"CXCursor_OMPTargetTeamsDirective\""
        const CXCursor_OMPTargetTeamsDistributeDirective = var"c\"CXCursor_OMPTargetTeamsDistributeDirective\""
        const CXCursor_OMPTargetTeamsDistributeParallelForDirective = var"c\"CXCursor_OMPTargetTeamsDistributeParallelForDirective\""
        const CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective = var"c\"CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective\""
        const CXCursor_OMPTargetTeamsDistributeSimdDirective = var"c\"CXCursor_OMPTargetTeamsDistributeSimdDirective\""
        const CXCursor_BuiltinBitCastExpr = var"c\"CXCursor_BuiltinBitCastExpr\""
        const CXCursor_OMPMasterTaskLoopDirective = var"c\"CXCursor_OMPMasterTaskLoopDirective\""
        const CXCursor_OMPParallelMasterTaskLoopDirective = var"c\"CXCursor_OMPParallelMasterTaskLoopDirective\""
        const CXCursor_OMPMasterTaskLoopSimdDirective = var"c\"CXCursor_OMPMasterTaskLoopSimdDirective\""
        const CXCursor_OMPParallelMasterTaskLoopSimdDirective = var"c\"CXCursor_OMPParallelMasterTaskLoopSimdDirective\""
        const CXCursor_OMPParallelMasterDirective = var"c\"CXCursor_OMPParallelMasterDirective\""
        const CXCursor_OMPDepobjDirective = var"c\"CXCursor_OMPDepobjDirective\""
        const CXCursor_OMPScanDirective = var"c\"CXCursor_OMPScanDirective\""
        const CXCursor_OMPTileDirective = var"c\"CXCursor_OMPTileDirective\""
        const CXCursor_OMPCanonicalLoop = var"c\"CXCursor_OMPCanonicalLoop\""
        const CXCursor_OMPInteropDirective = var"c\"CXCursor_OMPInteropDirective\""
        const CXCursor_OMPDispatchDirective = var"c\"CXCursor_OMPDispatchDirective\""
        const CXCursor_OMPMaskedDirective = var"c\"CXCursor_OMPMaskedDirective\""
        const CXCursor_OMPUnrollDirective = var"c\"CXCursor_OMPUnrollDirective\""
        const CXCursor_OMPMetaDirective = var"c\"CXCursor_OMPMetaDirective\""
        const CXCursor_OMPGenericLoopDirective = var"c\"CXCursor_OMPGenericLoopDirective\""
        const CXCursor_OMPTeamsGenericLoopDirective = var"c\"CXCursor_OMPTeamsGenericLoopDirective\""
        const CXCursor_OMPTargetTeamsGenericLoopDirective = var"c\"CXCursor_OMPTargetTeamsGenericLoopDirective\""
        const CXCursor_OMPParallelGenericLoopDirective = var"c\"CXCursor_OMPParallelGenericLoopDirective\""
        const CXCursor_OMPTargetParallelGenericLoopDirective = var"c\"CXCursor_OMPTargetParallelGenericLoopDirective\""
        const CXCursor_OMPParallelMaskedDirective = var"c\"CXCursor_OMPParallelMaskedDirective\""
        const CXCursor_OMPMaskedTaskLoopDirective = var"c\"CXCursor_OMPMaskedTaskLoopDirective\""
        const CXCursor_OMPMaskedTaskLoopSimdDirective = var"c\"CXCursor_OMPMaskedTaskLoopSimdDirective\""
        const CXCursor_OMPParallelMaskedTaskLoopDirective = var"c\"CXCursor_OMPParallelMaskedTaskLoopDirective\""
        const CXCursor_OMPParallelMaskedTaskLoopSimdDirective = var"c\"CXCursor_OMPParallelMaskedTaskLoopSimdDirective\""
        const CXCursor_OMPErrorDirective = var"c\"CXCursor_OMPErrorDirective\""
        const CXCursor_OMPScopeDirective = var"c\"CXCursor_OMPScopeDirective\""
        const CXCursor_LastStmt = var"c\"CXCursor_LastStmt\""
        const CXCursor_TranslationUnit = var"c\"CXCursor_TranslationUnit\""
        const CXCursor_FirstAttr = var"c\"CXCursor_FirstAttr\""
        const CXCursor_UnexposedAttr = var"c\"CXCursor_UnexposedAttr\""
        const CXCursor_IBActionAttr = var"c\"CXCursor_IBActionAttr\""
        const CXCursor_IBOutletAttr = var"c\"CXCursor_IBOutletAttr\""
        const CXCursor_IBOutletCollectionAttr = var"c\"CXCursor_IBOutletCollectionAttr\""
        const CXCursor_CXXFinalAttr = var"c\"CXCursor_CXXFinalAttr\""
        const CXCursor_CXXOverrideAttr = var"c\"CXCursor_CXXOverrideAttr\""
        const CXCursor_AnnotateAttr = var"c\"CXCursor_AnnotateAttr\""
        const CXCursor_AsmLabelAttr = var"c\"CXCursor_AsmLabelAttr\""
        const CXCursor_PackedAttr = var"c\"CXCursor_PackedAttr\""
        const CXCursor_PureAttr = var"c\"CXCursor_PureAttr\""
        const CXCursor_ConstAttr = var"c\"CXCursor_ConstAttr\""
        const CXCursor_NoDuplicateAttr = var"c\"CXCursor_NoDuplicateAttr\""
        const CXCursor_CUDAConstantAttr = var"c\"CXCursor_CUDAConstantAttr\""
        const CXCursor_CUDADeviceAttr = var"c\"CXCursor_CUDADeviceAttr\""
        const CXCursor_CUDAGlobalAttr = var"c\"CXCursor_CUDAGlobalAttr\""
        const CXCursor_CUDAHostAttr = var"c\"CXCursor_CUDAHostAttr\""
        const CXCursor_CUDASharedAttr = var"c\"CXCursor_CUDASharedAttr\""
        const CXCursor_VisibilityAttr = var"c\"CXCursor_VisibilityAttr\""
        const CXCursor_DLLExport = var"c\"CXCursor_DLLExport\""
        const CXCursor_DLLImport = var"c\"CXCursor_DLLImport\""
        const CXCursor_NSReturnsRetained = var"c\"CXCursor_NSReturnsRetained\""
        const CXCursor_NSReturnsNotRetained = var"c\"CXCursor_NSReturnsNotRetained\""
        const CXCursor_NSReturnsAutoreleased = var"c\"CXCursor_NSReturnsAutoreleased\""
        const CXCursor_NSConsumesSelf = var"c\"CXCursor_NSConsumesSelf\""
        const CXCursor_NSConsumed = var"c\"CXCursor_NSConsumed\""
        const CXCursor_ObjCException = var"c\"CXCursor_ObjCException\""
        const CXCursor_ObjCNSObject = var"c\"CXCursor_ObjCNSObject\""
        const CXCursor_ObjCIndependentClass = var"c\"CXCursor_ObjCIndependentClass\""
        const CXCursor_ObjCPreciseLifetime = var"c\"CXCursor_ObjCPreciseLifetime\""
        const CXCursor_ObjCReturnsInnerPointer = var"c\"CXCursor_ObjCReturnsInnerPointer\""
        const CXCursor_ObjCRequiresSuper = var"c\"CXCursor_ObjCRequiresSuper\""
        const CXCursor_ObjCRootClass = var"c\"CXCursor_ObjCRootClass\""
        const CXCursor_ObjCSubclassingRestricted = var"c\"CXCursor_ObjCSubclassingRestricted\""
        const CXCursor_ObjCExplicitProtocolImpl = var"c\"CXCursor_ObjCExplicitProtocolImpl\""
        const CXCursor_ObjCDesignatedInitializer = var"c\"CXCursor_ObjCDesignatedInitializer\""
        const CXCursor_ObjCRuntimeVisible = var"c\"CXCursor_ObjCRuntimeVisible\""
        const CXCursor_ObjCBoxable = var"c\"CXCursor_ObjCBoxable\""
        const CXCursor_FlagEnum = var"c\"CXCursor_FlagEnum\""
        const CXCursor_ConvergentAttr = var"c\"CXCursor_ConvergentAttr\""
        const CXCursor_WarnUnusedAttr = var"c\"CXCursor_WarnUnusedAttr\""
        const CXCursor_WarnUnusedResultAttr = var"c\"CXCursor_WarnUnusedResultAttr\""
        const CXCursor_AlignedAttr = var"c\"CXCursor_AlignedAttr\""
        const CXCursor_LastAttr = var"c\"CXCursor_LastAttr\""
        const CXCursor_PreprocessingDirective = var"c\"CXCursor_PreprocessingDirective\""
        const CXCursor_MacroDefinition = var"c\"CXCursor_MacroDefinition\""
        const CXCursor_MacroExpansion = var"c\"CXCursor_MacroExpansion\""
        const CXCursor_MacroInstantiation = var"c\"CXCursor_MacroInstantiation\""
        const CXCursor_InclusionDirective = var"c\"CXCursor_InclusionDirective\""
        const CXCursor_FirstPreprocessing = var"c\"CXCursor_FirstPreprocessing\""
        const CXCursor_LastPreprocessing = var"c\"CXCursor_LastPreprocessing\""
        const CXCursor_ModuleImportDecl = var"c\"CXCursor_ModuleImportDecl\""
        const CXCursor_TypeAliasTemplateDecl = var"c\"CXCursor_TypeAliasTemplateDecl\""
        const CXCursor_StaticAssert = var"c\"CXCursor_StaticAssert\""
        const CXCursor_FriendDecl = var"c\"CXCursor_FriendDecl\""
        const CXCursor_ConceptDecl = var"c\"CXCursor_ConceptDecl\""
        const CXCursor_FirstExtraDecl = var"c\"CXCursor_FirstExtraDecl\""
        const CXCursor_LastExtraDecl = var"c\"CXCursor_LastExtraDecl\""
        const CXCursor_OverloadCandidate = var"c\"CXCursor_OverloadCandidate\""
        export var"c\"enum CXCursorKind\"", var"(c\"enum CXCursorKind\")", var"c\"CXCursor_UnexposedDecl\"", var"c\"CXCursor_StructDecl\"", var"c\"CXCursor_UnionDecl\"", var"c\"CXCursor_ClassDecl\"", var"c\"CXCursor_EnumDecl\"", var"c\"CXCursor_FieldDecl\"", var"c\"CXCursor_EnumConstantDecl\"", var"c\"CXCursor_FunctionDecl\"", var"c\"CXCursor_VarDecl\"", var"c\"CXCursor_ParmDecl\"", var"c\"CXCursor_ObjCInterfaceDecl\"", var"c\"CXCursor_ObjCCategoryDecl\"", var"c\"CXCursor_ObjCProtocolDecl\"", var"c\"CXCursor_ObjCPropertyDecl\"", var"c\"CXCursor_ObjCIvarDecl\"", var"c\"CXCursor_ObjCInstanceMethodDecl\"", var"c\"CXCursor_ObjCClassMethodDecl\"", var"c\"CXCursor_ObjCImplementationDecl\"", var"c\"CXCursor_ObjCCategoryImplDecl\"", var"c\"CXCursor_TypedefDecl\"", var"c\"CXCursor_CXXMethod\"", var"c\"CXCursor_Namespace\"", var"c\"CXCursor_LinkageSpec\"", var"c\"CXCursor_Constructor\"", var"c\"CXCursor_Destructor\"", var"c\"CXCursor_ConversionFunction\"", var"c\"CXCursor_TemplateTypeParameter\"", var"c\"CXCursor_NonTypeTemplateParameter\"", var"c\"CXCursor_TemplateTemplateParameter\"", var"c\"CXCursor_FunctionTemplate\"", var"c\"CXCursor_ClassTemplate\"", var"c\"CXCursor_ClassTemplatePartialSpecialization\"", var"c\"CXCursor_NamespaceAlias\"", var"c\"CXCursor_UsingDirective\"", var"c\"CXCursor_UsingDeclaration\"", var"c\"CXCursor_TypeAliasDecl\"", var"c\"CXCursor_ObjCSynthesizeDecl\"", var"c\"CXCursor_ObjCDynamicDecl\"", var"c\"CXCursor_CXXAccessSpecifier\"", var"c\"CXCursor_FirstDecl\"", var"c\"CXCursor_LastDecl\"", var"c\"CXCursor_FirstRef\"", var"c\"CXCursor_ObjCSuperClassRef\"", var"c\"CXCursor_ObjCProtocolRef\"", var"c\"CXCursor_ObjCClassRef\"", var"c\"CXCursor_TypeRef\"", var"c\"CXCursor_CXXBaseSpecifier\"", var"c\"CXCursor_TemplateRef\"", var"c\"CXCursor_NamespaceRef\"", var"c\"CXCursor_MemberRef\"", var"c\"CXCursor_LabelRef\"", var"c\"CXCursor_OverloadedDeclRef\"", var"c\"CXCursor_VariableRef\"", var"c\"CXCursor_LastRef\"", var"c\"CXCursor_FirstInvalid\"", var"c\"CXCursor_InvalidFile\"", var"c\"CXCursor_NoDeclFound\"", var"c\"CXCursor_NotImplemented\"", var"c\"CXCursor_InvalidCode\"", var"c\"CXCursor_LastInvalid\"", var"c\"CXCursor_FirstExpr\"", var"c\"CXCursor_UnexposedExpr\"", var"c\"CXCursor_DeclRefExpr\"", var"c\"CXCursor_MemberRefExpr\"", var"c\"CXCursor_CallExpr\"", var"c\"CXCursor_ObjCMessageExpr\"", var"c\"CXCursor_BlockExpr\"", var"c\"CXCursor_IntegerLiteral\"", var"c\"CXCursor_FloatingLiteral\"", var"c\"CXCursor_ImaginaryLiteral\"", var"c\"CXCursor_StringLiteral\"", var"c\"CXCursor_CharacterLiteral\"", var"c\"CXCursor_ParenExpr\"", var"c\"CXCursor_UnaryOperator\"", var"c\"CXCursor_ArraySubscriptExpr\"", var"c\"CXCursor_BinaryOperator\"", var"c\"CXCursor_CompoundAssignOperator\"", var"c\"CXCursor_ConditionalOperator\"", var"c\"CXCursor_CStyleCastExpr\"", var"c\"CXCursor_CompoundLiteralExpr\"", var"c\"CXCursor_InitListExpr\"", var"c\"CXCursor_AddrLabelExpr\"", var"c\"CXCursor_StmtExpr\"", var"c\"CXCursor_GenericSelectionExpr\"", var"c\"CXCursor_GNUNullExpr\"", var"c\"CXCursor_CXXStaticCastExpr\"", var"c\"CXCursor_CXXDynamicCastExpr\"", var"c\"CXCursor_CXXReinterpretCastExpr\"", var"c\"CXCursor_CXXConstCastExpr\"", var"c\"CXCursor_CXXFunctionalCastExpr\"", var"c\"CXCursor_CXXTypeidExpr\"", var"c\"CXCursor_CXXBoolLiteralExpr\"", var"c\"CXCursor_CXXNullPtrLiteralExpr\"", var"c\"CXCursor_CXXThisExpr\"", var"c\"CXCursor_CXXThrowExpr\"", var"c\"CXCursor_CXXNewExpr\"", var"c\"CXCursor_CXXDeleteExpr\"", var"c\"CXCursor_UnaryExpr\"", var"c\"CXCursor_ObjCStringLiteral\"", var"c\"CXCursor_ObjCEncodeExpr\"", var"c\"CXCursor_ObjCSelectorExpr\"", var"c\"CXCursor_ObjCProtocolExpr\"", var"c\"CXCursor_ObjCBridgedCastExpr\"", var"c\"CXCursor_PackExpansionExpr\"", var"c\"CXCursor_SizeOfPackExpr\"", var"c\"CXCursor_LambdaExpr\"", var"c\"CXCursor_ObjCBoolLiteralExpr\"", var"c\"CXCursor_ObjCSelfExpr\"", var"c\"CXCursor_OMPArraySectionExpr\"", var"c\"CXCursor_ObjCAvailabilityCheckExpr\"", var"c\"CXCursor_FixedPointLiteral\"", var"c\"CXCursor_OMPArrayShapingExpr\"", var"c\"CXCursor_OMPIteratorExpr\"", var"c\"CXCursor_CXXAddrspaceCastExpr\"", var"c\"CXCursor_ConceptSpecializationExpr\"", var"c\"CXCursor_RequiresExpr\"", var"c\"CXCursor_CXXParenListInitExpr\"", var"c\"CXCursor_LastExpr\"", var"c\"CXCursor_FirstStmt\"", var"c\"CXCursor_UnexposedStmt\"", var"c\"CXCursor_LabelStmt\"", var"c\"CXCursor_CompoundStmt\"", var"c\"CXCursor_CaseStmt\"", var"c\"CXCursor_DefaultStmt\"", var"c\"CXCursor_IfStmt\"", var"c\"CXCursor_SwitchStmt\"", var"c\"CXCursor_WhileStmt\"", var"c\"CXCursor_DoStmt\"", var"c\"CXCursor_ForStmt\"", var"c\"CXCursor_GotoStmt\"", var"c\"CXCursor_IndirectGotoStmt\"", var"c\"CXCursor_ContinueStmt\"", var"c\"CXCursor_BreakStmt\"", var"c\"CXCursor_ReturnStmt\"", var"c\"CXCursor_GCCAsmStmt\"", var"c\"CXCursor_AsmStmt\"", var"c\"CXCursor_ObjCAtTryStmt\"", var"c\"CXCursor_ObjCAtCatchStmt\"", var"c\"CXCursor_ObjCAtFinallyStmt\"", var"c\"CXCursor_ObjCAtThrowStmt\"", var"c\"CXCursor_ObjCAtSynchronizedStmt\"", var"c\"CXCursor_ObjCAutoreleasePoolStmt\"", var"c\"CXCursor_ObjCForCollectionStmt\"", var"c\"CXCursor_CXXCatchStmt\"", var"c\"CXCursor_CXXTryStmt\"", var"c\"CXCursor_CXXForRangeStmt\"", var"c\"CXCursor_SEHTryStmt\"", var"c\"CXCursor_SEHExceptStmt\"", var"c\"CXCursor_SEHFinallyStmt\"", var"c\"CXCursor_MSAsmStmt\"", var"c\"CXCursor_NullStmt\"", var"c\"CXCursor_DeclStmt\"", var"c\"CXCursor_OMPParallelDirective\"", var"c\"CXCursor_OMPSimdDirective\"", var"c\"CXCursor_OMPForDirective\"", var"c\"CXCursor_OMPSectionsDirective\"", var"c\"CXCursor_OMPSectionDirective\"", var"c\"CXCursor_OMPSingleDirective\"", var"c\"CXCursor_OMPParallelForDirective\"", var"c\"CXCursor_OMPParallelSectionsDirective\"", var"c\"CXCursor_OMPTaskDirective\"", var"c\"CXCursor_OMPMasterDirective\"", var"c\"CXCursor_OMPCriticalDirective\"", var"c\"CXCursor_OMPTaskyieldDirective\"", var"c\"CXCursor_OMPBarrierDirective\"", var"c\"CXCursor_OMPTaskwaitDirective\"", var"c\"CXCursor_OMPFlushDirective\"", var"c\"CXCursor_SEHLeaveStmt\"", var"c\"CXCursor_OMPOrderedDirective\"", var"c\"CXCursor_OMPAtomicDirective\"", var"c\"CXCursor_OMPForSimdDirective\"", var"c\"CXCursor_OMPParallelForSimdDirective\"", var"c\"CXCursor_OMPTargetDirective\"", var"c\"CXCursor_OMPTeamsDirective\"", var"c\"CXCursor_OMPTaskgroupDirective\"", var"c\"CXCursor_OMPCancellationPointDirective\"", var"c\"CXCursor_OMPCancelDirective\"", var"c\"CXCursor_OMPTargetDataDirective\"", var"c\"CXCursor_OMPTaskLoopDirective\"", var"c\"CXCursor_OMPTaskLoopSimdDirective\"", var"c\"CXCursor_OMPDistributeDirective\"", var"c\"CXCursor_OMPTargetEnterDataDirective\"", var"c\"CXCursor_OMPTargetExitDataDirective\"", var"c\"CXCursor_OMPTargetParallelDirective\"", var"c\"CXCursor_OMPTargetParallelForDirective\"", var"c\"CXCursor_OMPTargetUpdateDirective\"", var"c\"CXCursor_OMPDistributeParallelForDirective\"", var"c\"CXCursor_OMPDistributeParallelForSimdDirective\"", var"c\"CXCursor_OMPDistributeSimdDirective\"", var"c\"CXCursor_OMPTargetParallelForSimdDirective\"", var"c\"CXCursor_OMPTargetSimdDirective\"", var"c\"CXCursor_OMPTeamsDistributeDirective\"", var"c\"CXCursor_OMPTeamsDistributeSimdDirective\"", var"c\"CXCursor_OMPTeamsDistributeParallelForSimdDirective\"", var"c\"CXCursor_OMPTeamsDistributeParallelForDirective\"", var"c\"CXCursor_OMPTargetTeamsDirective\"", var"c\"CXCursor_OMPTargetTeamsDistributeDirective\"", var"c\"CXCursor_OMPTargetTeamsDistributeParallelForDirective\"", var"c\"CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective\"", var"c\"CXCursor_OMPTargetTeamsDistributeSimdDirective\"", var"c\"CXCursor_BuiltinBitCastExpr\"", var"c\"CXCursor_OMPMasterTaskLoopDirective\"", var"c\"CXCursor_OMPParallelMasterTaskLoopDirective\"", var"c\"CXCursor_OMPMasterTaskLoopSimdDirective\"", var"c\"CXCursor_OMPParallelMasterTaskLoopSimdDirective\"", var"c\"CXCursor_OMPParallelMasterDirective\"", var"c\"CXCursor_OMPDepobjDirective\"", var"c\"CXCursor_OMPScanDirective\"", var"c\"CXCursor_OMPTileDirective\"", var"c\"CXCursor_OMPCanonicalLoop\"", var"c\"CXCursor_OMPInteropDirective\"", var"c\"CXCursor_OMPDispatchDirective\"", var"c\"CXCursor_OMPMaskedDirective\"", var"c\"CXCursor_OMPUnrollDirective\"", var"c\"CXCursor_OMPMetaDirective\"", var"c\"CXCursor_OMPGenericLoopDirective\"", var"c\"CXCursor_OMPTeamsGenericLoopDirective\"", var"c\"CXCursor_OMPTargetTeamsGenericLoopDirective\"", var"c\"CXCursor_OMPParallelGenericLoopDirective\"", var"c\"CXCursor_OMPTargetParallelGenericLoopDirective\"", var"c\"CXCursor_OMPParallelMaskedDirective\"", var"c\"CXCursor_OMPMaskedTaskLoopDirective\"", var"c\"CXCursor_OMPMaskedTaskLoopSimdDirective\"", var"c\"CXCursor_OMPParallelMaskedTaskLoopDirective\"", var"c\"CXCursor_OMPParallelMaskedTaskLoopSimdDirective\"", var"c\"CXCursor_OMPErrorDirective\"", var"c\"CXCursor_OMPScopeDirective\"", var"c\"CXCursor_LastStmt\"", var"c\"CXCursor_TranslationUnit\"", var"c\"CXCursor_FirstAttr\"", var"c\"CXCursor_UnexposedAttr\"", var"c\"CXCursor_IBActionAttr\"", var"c\"CXCursor_IBOutletAttr\"", var"c\"CXCursor_IBOutletCollectionAttr\"", var"c\"CXCursor_CXXFinalAttr\"", var"c\"CXCursor_CXXOverrideAttr\"", var"c\"CXCursor_AnnotateAttr\"", var"c\"CXCursor_AsmLabelAttr\"", var"c\"CXCursor_PackedAttr\"", var"c\"CXCursor_PureAttr\"", var"c\"CXCursor_ConstAttr\"", var"c\"CXCursor_NoDuplicateAttr\"", var"c\"CXCursor_CUDAConstantAttr\"", var"c\"CXCursor_CUDADeviceAttr\"", var"c\"CXCursor_CUDAGlobalAttr\"", var"c\"CXCursor_CUDAHostAttr\"", var"c\"CXCursor_CUDASharedAttr\"", var"c\"CXCursor_VisibilityAttr\"", var"c\"CXCursor_DLLExport\"", var"c\"CXCursor_DLLImport\"", var"c\"CXCursor_NSReturnsRetained\"", var"c\"CXCursor_NSReturnsNotRetained\"", var"c\"CXCursor_NSReturnsAutoreleased\"", var"c\"CXCursor_NSConsumesSelf\"", var"c\"CXCursor_NSConsumed\"", var"c\"CXCursor_ObjCException\"", var"c\"CXCursor_ObjCNSObject\"", var"c\"CXCursor_ObjCIndependentClass\"", var"c\"CXCursor_ObjCPreciseLifetime\"", var"c\"CXCursor_ObjCReturnsInnerPointer\"", var"c\"CXCursor_ObjCRequiresSuper\"", var"c\"CXCursor_ObjCRootClass\"", var"c\"CXCursor_ObjCSubclassingRestricted\"", var"c\"CXCursor_ObjCExplicitProtocolImpl\"", var"c\"CXCursor_ObjCDesignatedInitializer\"", var"c\"CXCursor_ObjCRuntimeVisible\"", var"c\"CXCursor_ObjCBoxable\"", var"c\"CXCursor_FlagEnum\"", var"c\"CXCursor_ConvergentAttr\"", var"c\"CXCursor_WarnUnusedAttr\"", var"c\"CXCursor_WarnUnusedResultAttr\"", var"c\"CXCursor_AlignedAttr\"", var"c\"CXCursor_LastAttr\"", var"c\"CXCursor_PreprocessingDirective\"", var"c\"CXCursor_MacroDefinition\"", var"c\"CXCursor_MacroExpansion\"", var"c\"CXCursor_MacroInstantiation\"", var"c\"CXCursor_InclusionDirective\"", var"c\"CXCursor_FirstPreprocessing\"", var"c\"CXCursor_LastPreprocessing\"", var"c\"CXCursor_ModuleImportDecl\"", var"c\"CXCursor_TypeAliasTemplateDecl\"", var"c\"CXCursor_StaticAssert\"", var"c\"CXCursor_FriendDecl\"", var"c\"CXCursor_ConceptDecl\"", var"c\"CXCursor_FirstExtraDecl\"", var"c\"CXCursor_LastExtraDecl\"", var"c\"CXCursor_OverloadCandidate\""
        export CXCursorKind, CXCursor_UnexposedDecl, CXCursor_StructDecl, CXCursor_UnionDecl, CXCursor_ClassDecl, CXCursor_EnumDecl, CXCursor_FieldDecl, CXCursor_EnumConstantDecl, CXCursor_FunctionDecl, CXCursor_VarDecl, CXCursor_ParmDecl, CXCursor_ObjCInterfaceDecl, CXCursor_ObjCCategoryDecl, CXCursor_ObjCProtocolDecl, CXCursor_ObjCPropertyDecl, CXCursor_ObjCIvarDecl, CXCursor_ObjCInstanceMethodDecl, CXCursor_ObjCClassMethodDecl, CXCursor_ObjCImplementationDecl, CXCursor_ObjCCategoryImplDecl, CXCursor_TypedefDecl, CXCursor_CXXMethod, CXCursor_Namespace, CXCursor_LinkageSpec, CXCursor_Constructor, CXCursor_Destructor, CXCursor_ConversionFunction, CXCursor_TemplateTypeParameter, CXCursor_NonTypeTemplateParameter, CXCursor_TemplateTemplateParameter, CXCursor_FunctionTemplate, CXCursor_ClassTemplate, CXCursor_ClassTemplatePartialSpecialization, CXCursor_NamespaceAlias, CXCursor_UsingDirective, CXCursor_UsingDeclaration, CXCursor_TypeAliasDecl, CXCursor_ObjCSynthesizeDecl, CXCursor_ObjCDynamicDecl, CXCursor_CXXAccessSpecifier, CXCursor_FirstDecl, CXCursor_LastDecl, CXCursor_FirstRef, CXCursor_ObjCSuperClassRef, CXCursor_ObjCProtocolRef, CXCursor_ObjCClassRef, CXCursor_TypeRef, CXCursor_CXXBaseSpecifier, CXCursor_TemplateRef, CXCursor_NamespaceRef, CXCursor_MemberRef, CXCursor_LabelRef, CXCursor_OverloadedDeclRef, CXCursor_VariableRef, CXCursor_LastRef, CXCursor_FirstInvalid, CXCursor_InvalidFile, CXCursor_NoDeclFound, CXCursor_NotImplemented, CXCursor_InvalidCode, CXCursor_LastInvalid, CXCursor_FirstExpr, CXCursor_UnexposedExpr, CXCursor_DeclRefExpr, CXCursor_MemberRefExpr, CXCursor_CallExpr, CXCursor_ObjCMessageExpr, CXCursor_BlockExpr, CXCursor_IntegerLiteral, CXCursor_FloatingLiteral, CXCursor_ImaginaryLiteral, CXCursor_StringLiteral, CXCursor_CharacterLiteral, CXCursor_ParenExpr, CXCursor_UnaryOperator, CXCursor_ArraySubscriptExpr, CXCursor_BinaryOperator, CXCursor_CompoundAssignOperator, CXCursor_ConditionalOperator, CXCursor_CStyleCastExpr, CXCursor_CompoundLiteralExpr, CXCursor_InitListExpr, CXCursor_AddrLabelExpr, CXCursor_StmtExpr, CXCursor_GenericSelectionExpr, CXCursor_GNUNullExpr, CXCursor_CXXStaticCastExpr, CXCursor_CXXDynamicCastExpr, CXCursor_CXXReinterpretCastExpr, CXCursor_CXXConstCastExpr, CXCursor_CXXFunctionalCastExpr, CXCursor_CXXTypeidExpr, CXCursor_CXXBoolLiteralExpr, CXCursor_CXXNullPtrLiteralExpr, CXCursor_CXXThisExpr, CXCursor_CXXThrowExpr, CXCursor_CXXNewExpr, CXCursor_CXXDeleteExpr, CXCursor_UnaryExpr, CXCursor_ObjCStringLiteral, CXCursor_ObjCEncodeExpr, CXCursor_ObjCSelectorExpr, CXCursor_ObjCProtocolExpr, CXCursor_ObjCBridgedCastExpr, CXCursor_PackExpansionExpr, CXCursor_SizeOfPackExpr, CXCursor_LambdaExpr, CXCursor_ObjCBoolLiteralExpr, CXCursor_ObjCSelfExpr, CXCursor_OMPArraySectionExpr, CXCursor_ObjCAvailabilityCheckExpr, CXCursor_FixedPointLiteral, CXCursor_OMPArrayShapingExpr, CXCursor_OMPIteratorExpr, CXCursor_CXXAddrspaceCastExpr, CXCursor_ConceptSpecializationExpr, CXCursor_RequiresExpr, CXCursor_CXXParenListInitExpr, CXCursor_LastExpr, CXCursor_FirstStmt, CXCursor_UnexposedStmt, CXCursor_LabelStmt, CXCursor_CompoundStmt, CXCursor_CaseStmt, CXCursor_DefaultStmt, CXCursor_IfStmt, CXCursor_SwitchStmt, CXCursor_WhileStmt, CXCursor_DoStmt, CXCursor_ForStmt, CXCursor_GotoStmt, CXCursor_IndirectGotoStmt, CXCursor_ContinueStmt, CXCursor_BreakStmt, CXCursor_ReturnStmt, CXCursor_GCCAsmStmt, CXCursor_AsmStmt, CXCursor_ObjCAtTryStmt, CXCursor_ObjCAtCatchStmt, CXCursor_ObjCAtFinallyStmt, CXCursor_ObjCAtThrowStmt, CXCursor_ObjCAtSynchronizedStmt, CXCursor_ObjCAutoreleasePoolStmt, CXCursor_ObjCForCollectionStmt, CXCursor_CXXCatchStmt, CXCursor_CXXTryStmt, CXCursor_CXXForRangeStmt, CXCursor_SEHTryStmt, CXCursor_SEHExceptStmt, CXCursor_SEHFinallyStmt, CXCursor_MSAsmStmt, CXCursor_NullStmt, CXCursor_DeclStmt, CXCursor_OMPParallelDirective, CXCursor_OMPSimdDirective, CXCursor_OMPForDirective, CXCursor_OMPSectionsDirective, CXCursor_OMPSectionDirective, CXCursor_OMPSingleDirective, CXCursor_OMPParallelForDirective, CXCursor_OMPParallelSectionsDirective, CXCursor_OMPTaskDirective, CXCursor_OMPMasterDirective, CXCursor_OMPCriticalDirective, CXCursor_OMPTaskyieldDirective, CXCursor_OMPBarrierDirective, CXCursor_OMPTaskwaitDirective, CXCursor_OMPFlushDirective, CXCursor_SEHLeaveStmt, CXCursor_OMPOrderedDirective, CXCursor_OMPAtomicDirective, CXCursor_OMPForSimdDirective, CXCursor_OMPParallelForSimdDirective, CXCursor_OMPTargetDirective, CXCursor_OMPTeamsDirective, CXCursor_OMPTaskgroupDirective, CXCursor_OMPCancellationPointDirective, CXCursor_OMPCancelDirective, CXCursor_OMPTargetDataDirective, CXCursor_OMPTaskLoopDirective, CXCursor_OMPTaskLoopSimdDirective, CXCursor_OMPDistributeDirective, CXCursor_OMPTargetEnterDataDirective, CXCursor_OMPTargetExitDataDirective, CXCursor_OMPTargetParallelDirective, CXCursor_OMPTargetParallelForDirective, CXCursor_OMPTargetUpdateDirective, CXCursor_OMPDistributeParallelForDirective, CXCursor_OMPDistributeParallelForSimdDirective, CXCursor_OMPDistributeSimdDirective, CXCursor_OMPTargetParallelForSimdDirective, CXCursor_OMPTargetSimdDirective, CXCursor_OMPTeamsDistributeDirective, CXCursor_OMPTeamsDistributeSimdDirective, CXCursor_OMPTeamsDistributeParallelForSimdDirective, CXCursor_OMPTeamsDistributeParallelForDirective, CXCursor_OMPTargetTeamsDirective, CXCursor_OMPTargetTeamsDistributeDirective, CXCursor_OMPTargetTeamsDistributeParallelForDirective, CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective, CXCursor_OMPTargetTeamsDistributeSimdDirective, CXCursor_BuiltinBitCastExpr, CXCursor_OMPMasterTaskLoopDirective, CXCursor_OMPParallelMasterTaskLoopDirective, CXCursor_OMPMasterTaskLoopSimdDirective, CXCursor_OMPParallelMasterTaskLoopSimdDirective, CXCursor_OMPParallelMasterDirective, CXCursor_OMPDepobjDirective, CXCursor_OMPScanDirective, CXCursor_OMPTileDirective, CXCursor_OMPCanonicalLoop, CXCursor_OMPInteropDirective, CXCursor_OMPDispatchDirective, CXCursor_OMPMaskedDirective, CXCursor_OMPUnrollDirective, CXCursor_OMPMetaDirective, CXCursor_OMPGenericLoopDirective, CXCursor_OMPTeamsGenericLoopDirective, CXCursor_OMPTargetTeamsGenericLoopDirective, CXCursor_OMPParallelGenericLoopDirective, CXCursor_OMPTargetParallelGenericLoopDirective, CXCursor_OMPParallelMaskedDirective, CXCursor_OMPMaskedTaskLoopDirective, CXCursor_OMPMaskedTaskLoopSimdDirective, CXCursor_OMPParallelMaskedTaskLoopDirective, CXCursor_OMPParallelMaskedTaskLoopSimdDirective, CXCursor_OMPErrorDirective, CXCursor_OMPScopeDirective, CXCursor_LastStmt, CXCursor_TranslationUnit, CXCursor_FirstAttr, CXCursor_UnexposedAttr, CXCursor_IBActionAttr, CXCursor_IBOutletAttr, CXCursor_IBOutletCollectionAttr, CXCursor_CXXFinalAttr, CXCursor_CXXOverrideAttr, CXCursor_AnnotateAttr, CXCursor_AsmLabelAttr, CXCursor_PackedAttr, CXCursor_PureAttr, CXCursor_ConstAttr, CXCursor_NoDuplicateAttr, CXCursor_CUDAConstantAttr, CXCursor_CUDADeviceAttr, CXCursor_CUDAGlobalAttr, CXCursor_CUDAHostAttr, CXCursor_CUDASharedAttr, CXCursor_VisibilityAttr, CXCursor_DLLExport, CXCursor_DLLImport, CXCursor_NSReturnsRetained, CXCursor_NSReturnsNotRetained, CXCursor_NSReturnsAutoreleased, CXCursor_NSConsumesSelf, CXCursor_NSConsumed, CXCursor_ObjCException, CXCursor_ObjCNSObject, CXCursor_ObjCIndependentClass, CXCursor_ObjCPreciseLifetime, CXCursor_ObjCReturnsInnerPointer, CXCursor_ObjCRequiresSuper, CXCursor_ObjCRootClass, CXCursor_ObjCSubclassingRestricted, CXCursor_ObjCExplicitProtocolImpl, CXCursor_ObjCDesignatedInitializer, CXCursor_ObjCRuntimeVisible, CXCursor_ObjCBoxable, CXCursor_FlagEnum, CXCursor_ConvergentAttr, CXCursor_WarnUnusedAttr, CXCursor_WarnUnusedResultAttr, CXCursor_AlignedAttr, CXCursor_LastAttr, CXCursor_PreprocessingDirective, CXCursor_MacroDefinition, CXCursor_MacroExpansion, CXCursor_MacroInstantiation, CXCursor_InclusionDirective, CXCursor_FirstPreprocessing, CXCursor_LastPreprocessing, CXCursor_ModuleImportDecl, CXCursor_TypeAliasTemplateDecl, CXCursor_StaticAssert, CXCursor_FriendDecl, CXCursor_ConceptDecl, CXCursor_FirstExtraDecl, CXCursor_LastExtraDecl, CXCursor_OverloadCandidate
        var"c\"enum CXCursorKind\""
        abstract type var"c\"CXCursor\"" <: Cstruct end
        const CXCursor = var"c\"CXCursor\""
        export var"c\"CXCursor\""
        export CXCursor
        var"c\"CXCursor\""
        struct var"(c\"CXCursor\")" <: var"c\"CXCursor\""
            mem::CBinding.NTuple{32, CBinding.UInt8}
            var"(c\"CXCursor\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{32, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXCursor\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:kind, CBinding.Tuple{var"c\"enum CXCursorKind\"", CBinding.bitstype(var"c\"enum CXCursorKind\""), CBinding.integraltype(var"c\"enum CXCursorKind\""), 0, 0, -1}}, CBinding.Tuple{:xdata, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 4, 0, -1}}, CBinding.Tuple{:data, CBinding.Tuple{CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 3}, CBinding.bitstype(CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 3}), CBinding.integraltype(CBinding.Carray{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, 3}), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXCursor\")"}) = begin
                var"(c\"CXCursor\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXCursor\""}) = begin
                var"(c\"CXCursor\")"
            end
        const CXCursor = var"c\"CXCursor\""
        export var"c\"CXCursor\"", var"(c\"CXCursor\")"
        export CXCursor
        var"c\"CXCursor\""
        struct Cbinding_clang_getNullCursor{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{}, :cdecl}, libpath, :clang_getNullCursor}
        end
        const var"c\"clang_getNullCursor\"" = Cbinding_clang_getNullCursor{:clang_getNullCursor}()
        (func::Cbinding_clang_getNullCursor)() = begin
                CBinding.funccall(func)
            end
        const clang_getNullCursor = var"c\"clang_getNullCursor\""
        export var"c\"clang_getNullCursor\""
        export clang_getNullCursor
        var"c\"clang_getNullCursor\""
        struct Cbinding_clang_getTranslationUnitCursor{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_getTranslationUnitCursor}
        end
        const var"c\"clang_getTranslationUnitCursor\"" = Cbinding_clang_getTranslationUnitCursor{:clang_getTranslationUnitCursor}()
        (func::Cbinding_clang_getTranslationUnitCursor)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getTranslationUnitCursor = var"c\"clang_getTranslationUnitCursor\""
        export var"c\"clang_getTranslationUnitCursor\""
        export clang_getTranslationUnitCursor
        var"c\"clang_getTranslationUnitCursor\""
        struct Cbinding_clang_equalCursors{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\"", var"c\"CXCursor\""}, :cdecl}, libpath, :clang_equalCursors}
        end
        const var"c\"clang_equalCursors\"" = Cbinding_clang_equalCursors{:clang_equalCursors}()
        (func::Cbinding_clang_equalCursors)(arg1, arg2) = begin
                CBinding.funccall(func, arg1, arg2)
            end
        const clang_equalCursors = var"c\"clang_equalCursors\""
        export var"c\"clang_equalCursors\""
        export clang_equalCursors
        var"c\"clang_equalCursors\""
        struct Cbinding_clang_Cursor_isNull{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isNull}
        end
        const var"c\"clang_Cursor_isNull\"" = Cbinding_clang_Cursor_isNull{:clang_Cursor_isNull}()
        (func::Cbinding_clang_Cursor_isNull)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_Cursor_isNull = var"c\"clang_Cursor_isNull\""
        export var"c\"clang_Cursor_isNull\""
        export clang_Cursor_isNull
        var"c\"clang_Cursor_isNull\""
        struct Cbinding_clang_hashCursor{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_hashCursor}
        end
        const var"c\"clang_hashCursor\"" = Cbinding_clang_hashCursor{:clang_hashCursor}()
        (func::Cbinding_clang_hashCursor)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_hashCursor = var"c\"clang_hashCursor\""
        export var"c\"clang_hashCursor\""
        export clang_hashCursor
        var"c\"clang_hashCursor\""
        struct Cbinding_clang_getCursorKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXCursorKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorKind}
        end
        const var"c\"clang_getCursorKind\"" = Cbinding_clang_getCursorKind{:clang_getCursorKind}()
        (func::Cbinding_clang_getCursorKind)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorKind = var"c\"clang_getCursorKind\""
        export var"c\"clang_getCursorKind\""
        export clang_getCursorKind
        var"c\"clang_getCursorKind\""
        struct Cbinding_clang_isDeclaration{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isDeclaration}
        end
        const var"c\"clang_isDeclaration\"" = Cbinding_clang_isDeclaration{:clang_isDeclaration}()
        (func::Cbinding_clang_isDeclaration)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isDeclaration = var"c\"clang_isDeclaration\""
        export var"c\"clang_isDeclaration\""
        export clang_isDeclaration
        var"c\"clang_isDeclaration\""
        struct Cbinding_clang_isInvalidDeclaration{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_isInvalidDeclaration}
        end
        const var"c\"clang_isInvalidDeclaration\"" = Cbinding_clang_isInvalidDeclaration{:clang_isInvalidDeclaration}()
        (func::Cbinding_clang_isInvalidDeclaration)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isInvalidDeclaration = var"c\"clang_isInvalidDeclaration\""
        export var"c\"clang_isInvalidDeclaration\""
        export clang_isInvalidDeclaration
        var"c\"clang_isInvalidDeclaration\""
        struct Cbinding_clang_isReference{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isReference}
        end
        const var"c\"clang_isReference\"" = Cbinding_clang_isReference{:clang_isReference}()
        (func::Cbinding_clang_isReference)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isReference = var"c\"clang_isReference\""
        export var"c\"clang_isReference\""
        export clang_isReference
        var"c\"clang_isReference\""
        struct Cbinding_clang_isExpression{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isExpression}
        end
        const var"c\"clang_isExpression\"" = Cbinding_clang_isExpression{:clang_isExpression}()
        (func::Cbinding_clang_isExpression)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isExpression = var"c\"clang_isExpression\""
        export var"c\"clang_isExpression\""
        export clang_isExpression
        var"c\"clang_isExpression\""
        struct Cbinding_clang_isStatement{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isStatement}
        end
        const var"c\"clang_isStatement\"" = Cbinding_clang_isStatement{:clang_isStatement}()
        (func::Cbinding_clang_isStatement)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isStatement = var"c\"clang_isStatement\""
        export var"c\"clang_isStatement\""
        export clang_isStatement
        var"c\"clang_isStatement\""
        struct Cbinding_clang_isAttribute{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isAttribute}
        end
        const var"c\"clang_isAttribute\"" = Cbinding_clang_isAttribute{:clang_isAttribute}()
        (func::Cbinding_clang_isAttribute)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isAttribute = var"c\"clang_isAttribute\""
        export var"c\"clang_isAttribute\""
        export clang_isAttribute
        var"c\"clang_isAttribute\""
        struct Cbinding_clang_Cursor_hasAttrs{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_hasAttrs}
        end
        const var"c\"clang_Cursor_hasAttrs\"" = Cbinding_clang_Cursor_hasAttrs{:clang_Cursor_hasAttrs}()
        (func::Cbinding_clang_Cursor_hasAttrs)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_hasAttrs = var"c\"clang_Cursor_hasAttrs\""
        export var"c\"clang_Cursor_hasAttrs\""
        export clang_Cursor_hasAttrs
        var"c\"clang_Cursor_hasAttrs\""
        struct Cbinding_clang_isInvalid{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isInvalid}
        end
        const var"c\"clang_isInvalid\"" = Cbinding_clang_isInvalid{:clang_isInvalid}()
        (func::Cbinding_clang_isInvalid)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isInvalid = var"c\"clang_isInvalid\""
        export var"c\"clang_isInvalid\""
        export clang_isInvalid
        var"c\"clang_isInvalid\""
        struct Cbinding_clang_isTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isTranslationUnit}
        end
        const var"c\"clang_isTranslationUnit\"" = Cbinding_clang_isTranslationUnit{:clang_isTranslationUnit}()
        (func::Cbinding_clang_isTranslationUnit)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isTranslationUnit = var"c\"clang_isTranslationUnit\""
        export var"c\"clang_isTranslationUnit\""
        export clang_isTranslationUnit
        var"c\"clang_isTranslationUnit\""
        struct Cbinding_clang_isPreprocessing{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isPreprocessing}
        end
        const var"c\"clang_isPreprocessing\"" = Cbinding_clang_isPreprocessing{:clang_isPreprocessing}()
        (func::Cbinding_clang_isPreprocessing)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isPreprocessing = var"c\"clang_isPreprocessing\""
        export var"c\"clang_isPreprocessing\""
        export clang_isPreprocessing
        var"c\"clang_isPreprocessing\""
        struct Cbinding_clang_isUnexposed{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_isUnexposed}
        end
        const var"c\"clang_isUnexposed\"" = Cbinding_clang_isUnexposed{:clang_isUnexposed}()
        (func::Cbinding_clang_isUnexposed)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isUnexposed = var"c\"clang_isUnexposed\""
        export var"c\"clang_isUnexposed\""
        export clang_isUnexposed
        var"c\"clang_isUnexposed\""
        abstract type var"c\"enum CXLinkageKind\"" <: Cenum end
        const CXLinkageKind = var"c\"enum CXLinkageKind\""
        export var"c\"enum CXLinkageKind\""
        export CXLinkageKind
        var"c\"enum CXLinkageKind\""
        primitive type var"(c\"enum CXLinkageKind\")" <: var"c\"enum CXLinkageKind\"" 32 end
        (::(Type){var"(c\"enum CXLinkageKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXLinkageKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXLinkageKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXLinkage_Invalid\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXLinkage_NoLinkage\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXLinkage_Internal\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXLinkage_UniqueExternal\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXLinkage_External\""), 0x0000000000000004}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXLinkageKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXLinkageKind\")"}) = begin
                var"(c\"enum CXLinkageKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXLinkageKind\""}) = begin
                var"(c\"enum CXLinkageKind\")"
            end
        const var"c\"CXLinkage_Invalid\"" = var"(c\"enum CXLinkageKind\")"(0x0000000000000000)
        const var"c\"CXLinkage_NoLinkage\"" = var"(c\"enum CXLinkageKind\")"(0x0000000000000001)
        const var"c\"CXLinkage_Internal\"" = var"(c\"enum CXLinkageKind\")"(0x0000000000000002)
        const var"c\"CXLinkage_UniqueExternal\"" = var"(c\"enum CXLinkageKind\")"(0x0000000000000003)
        const var"c\"CXLinkage_External\"" = var"(c\"enum CXLinkageKind\")"(0x0000000000000004)
        const CXLinkageKind = var"c\"enum CXLinkageKind\""
        const CXLinkage_Invalid = var"c\"CXLinkage_Invalid\""
        const CXLinkage_NoLinkage = var"c\"CXLinkage_NoLinkage\""
        const CXLinkage_Internal = var"c\"CXLinkage_Internal\""
        const CXLinkage_UniqueExternal = var"c\"CXLinkage_UniqueExternal\""
        const CXLinkage_External = var"c\"CXLinkage_External\""
        export var"c\"enum CXLinkageKind\"", var"(c\"enum CXLinkageKind\")", var"c\"CXLinkage_Invalid\"", var"c\"CXLinkage_NoLinkage\"", var"c\"CXLinkage_Internal\"", var"c\"CXLinkage_UniqueExternal\"", var"c\"CXLinkage_External\""
        export CXLinkageKind, CXLinkage_Invalid, CXLinkage_NoLinkage, CXLinkage_Internal, CXLinkage_UniqueExternal, CXLinkage_External
        var"c\"enum CXLinkageKind\""
        struct Cbinding_clang_getCursorLinkage{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXLinkageKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorLinkage}
        end
        const var"c\"clang_getCursorLinkage\"" = Cbinding_clang_getCursorLinkage{:clang_getCursorLinkage}()
        (func::Cbinding_clang_getCursorLinkage)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorLinkage = var"c\"clang_getCursorLinkage\""
        export var"c\"clang_getCursorLinkage\""
        export clang_getCursorLinkage
        var"c\"clang_getCursorLinkage\""
        abstract type var"c\"enum CXVisibilityKind\"" <: Cenum end
        const CXVisibilityKind = var"c\"enum CXVisibilityKind\""
        export var"c\"enum CXVisibilityKind\""
        export CXVisibilityKind
        var"c\"enum CXVisibilityKind\""
        primitive type var"(c\"enum CXVisibilityKind\")" <: var"c\"enum CXVisibilityKind\"" 32 end
        (::(Type){var"(c\"enum CXVisibilityKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXVisibilityKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXVisibilityKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXVisibility_Invalid\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXVisibility_Hidden\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXVisibility_Protected\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXVisibility_Default\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXVisibilityKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXVisibilityKind\")"}) = begin
                var"(c\"enum CXVisibilityKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXVisibilityKind\""}) = begin
                var"(c\"enum CXVisibilityKind\")"
            end
        const var"c\"CXVisibility_Invalid\"" = var"(c\"enum CXVisibilityKind\")"(0x0000000000000000)
        const var"c\"CXVisibility_Hidden\"" = var"(c\"enum CXVisibilityKind\")"(0x0000000000000001)
        const var"c\"CXVisibility_Protected\"" = var"(c\"enum CXVisibilityKind\")"(0x0000000000000002)
        const var"c\"CXVisibility_Default\"" = var"(c\"enum CXVisibilityKind\")"(0x0000000000000003)
        const CXVisibilityKind = var"c\"enum CXVisibilityKind\""
        const CXVisibility_Invalid = var"c\"CXVisibility_Invalid\""
        const CXVisibility_Hidden = var"c\"CXVisibility_Hidden\""
        const CXVisibility_Protected = var"c\"CXVisibility_Protected\""
        const CXVisibility_Default = var"c\"CXVisibility_Default\""
        export var"c\"enum CXVisibilityKind\"", var"(c\"enum CXVisibilityKind\")", var"c\"CXVisibility_Invalid\"", var"c\"CXVisibility_Hidden\"", var"c\"CXVisibility_Protected\"", var"c\"CXVisibility_Default\""
        export CXVisibilityKind, CXVisibility_Invalid, CXVisibility_Hidden, CXVisibility_Protected, CXVisibility_Default
        var"c\"enum CXVisibilityKind\""
        struct Cbinding_clang_getCursorVisibility{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXVisibilityKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorVisibility}
        end
        const var"c\"clang_getCursorVisibility\"" = Cbinding_clang_getCursorVisibility{:clang_getCursorVisibility}()
        (func::Cbinding_clang_getCursorVisibility)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorVisibility = var"c\"clang_getCursorVisibility\""
        export var"c\"clang_getCursorVisibility\""
        export clang_getCursorVisibility
        var"c\"clang_getCursorVisibility\""
        struct Cbinding_clang_getCursorAvailability{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXAvailabilityKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorAvailability}
        end
        const var"c\"clang_getCursorAvailability\"" = Cbinding_clang_getCursorAvailability{:clang_getCursorAvailability}()
        (func::Cbinding_clang_getCursorAvailability)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorAvailability = var"c\"clang_getCursorAvailability\""
        export var"c\"clang_getCursorAvailability\""
        export clang_getCursorAvailability
        var"c\"clang_getCursorAvailability\""
        abstract type var"c\"struct CXPlatformAvailability\"" <: Cstruct end
        const CXPlatformAvailability = var"c\"struct CXPlatformAvailability\""
        export var"c\"struct CXPlatformAvailability\""
        export CXPlatformAvailability
        var"c\"struct CXPlatformAvailability\""
        struct var"(c\"struct CXPlatformAvailability\")" <: var"c\"struct CXPlatformAvailability\""
            mem::CBinding.NTuple{72, CBinding.UInt8}
            var"(c\"struct CXPlatformAvailability\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{72, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"struct CXPlatformAvailability\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:Platform, CBinding.Tuple{var"c\"CXString\"", CBinding.bitstype(var"c\"CXString\""), CBinding.integraltype(var"c\"CXString\""), 0, 0, -1}}, CBinding.Tuple{:Introduced, CBinding.Tuple{var"c\"CXVersion\"", CBinding.bitstype(var"c\"CXVersion\""), CBinding.integraltype(var"c\"CXVersion\""), 16, 0, -1}}, CBinding.Tuple{:Deprecated, CBinding.Tuple{var"c\"CXVersion\"", CBinding.bitstype(var"c\"CXVersion\""), CBinding.integraltype(var"c\"CXVersion\""), 28, 0, -1}}, CBinding.Tuple{:Obsoleted, CBinding.Tuple{var"c\"CXVersion\"", CBinding.bitstype(var"c\"CXVersion\""), CBinding.integraltype(var"c\"CXVersion\""), 40, 0, -1}}, CBinding.Tuple{:Unavailable, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 52, 0, -1}}, CBinding.Tuple{:Message, CBinding.Tuple{var"c\"CXString\"", CBinding.bitstype(var"c\"CXString\""), CBinding.integraltype(var"c\"CXString\""), 56, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"struct CXPlatformAvailability\")"}) = begin
                var"(c\"struct CXPlatformAvailability\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"struct CXPlatformAvailability\""}) = begin
                var"(c\"struct CXPlatformAvailability\")"
            end
        const CXPlatformAvailability = var"c\"struct CXPlatformAvailability\""
        export var"c\"struct CXPlatformAvailability\"", var"(c\"struct CXPlatformAvailability\")"
        export CXPlatformAvailability
        var"c\"struct CXPlatformAvailability\""
        const var"c\"CXPlatformAvailability\"" = var"c\"struct CXPlatformAvailability\""
        const CXPlatformAvailability = var"c\"CXPlatformAvailability\""
        export var"c\"CXPlatformAvailability\""
        export CXPlatformAvailability
        var"c\"CXPlatformAvailability\""
        struct Cbinding_clang_getCursorPlatformAvailability{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cptr{CBinding.Cint}, CBinding.Cptr{var"c\"CXString\""}, CBinding.Cptr{CBinding.Cint}, CBinding.Cptr{var"c\"CXString\""}, CBinding.Cptr{var"c\"CXPlatformAvailability\""}, CBinding.Cint}, :cdecl}, libpath, :clang_getCursorPlatformAvailability}
        end
        const var"c\"clang_getCursorPlatformAvailability\"" = Cbinding_clang_getCursorPlatformAvailability{:clang_getCursorPlatformAvailability}()
        (func::Cbinding_clang_getCursorPlatformAvailability)(var"c\"cursor\"", var"c\"always_deprecated\"", var"c\"deprecated_message\"", var"c\"always_unavailable\"", var"c\"unavailable_message\"", var"c\"availability\"", var"c\"availability_size\"") = begin
                CBinding.funccall(func, var"c\"cursor\"", var"c\"always_deprecated\"", var"c\"deprecated_message\"", var"c\"always_unavailable\"", var"c\"unavailable_message\"", var"c\"availability\"", var"c\"availability_size\"")
            end
        const clang_getCursorPlatformAvailability = var"c\"clang_getCursorPlatformAvailability\""
        export var"c\"clang_getCursorPlatformAvailability\""
        export clang_getCursorPlatformAvailability
        var"c\"clang_getCursorPlatformAvailability\""
        struct Cbinding_clang_disposeCXPlatformAvailability{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{var"c\"CXPlatformAvailability\""}}, :cdecl}, libpath, :clang_disposeCXPlatformAvailability}
        end
        const var"c\"clang_disposeCXPlatformAvailability\"" = Cbinding_clang_disposeCXPlatformAvailability{:clang_disposeCXPlatformAvailability}()
        (func::Cbinding_clang_disposeCXPlatformAvailability)(var"c\"availability\"") = begin
                CBinding.funccall(func, var"c\"availability\"")
            end
        const clang_disposeCXPlatformAvailability = var"c\"clang_disposeCXPlatformAvailability\""
        export var"c\"clang_disposeCXPlatformAvailability\""
        export clang_disposeCXPlatformAvailability
        var"c\"clang_disposeCXPlatformAvailability\""
        struct Cbinding_clang_Cursor_getVarDeclInitializer{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getVarDeclInitializer}
        end
        const var"c\"clang_Cursor_getVarDeclInitializer\"" = Cbinding_clang_Cursor_getVarDeclInitializer{:clang_Cursor_getVarDeclInitializer}()
        (func::Cbinding_clang_Cursor_getVarDeclInitializer)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_Cursor_getVarDeclInitializer = var"c\"clang_Cursor_getVarDeclInitializer\""
        export var"c\"clang_Cursor_getVarDeclInitializer\""
        export clang_Cursor_getVarDeclInitializer
        var"c\"clang_Cursor_getVarDeclInitializer\""
        struct Cbinding_clang_Cursor_hasVarDeclGlobalStorage{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_hasVarDeclGlobalStorage}
        end
        const var"c\"clang_Cursor_hasVarDeclGlobalStorage\"" = Cbinding_clang_Cursor_hasVarDeclGlobalStorage{:clang_Cursor_hasVarDeclGlobalStorage}()
        (func::Cbinding_clang_Cursor_hasVarDeclGlobalStorage)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_Cursor_hasVarDeclGlobalStorage = var"c\"clang_Cursor_hasVarDeclGlobalStorage\""
        export var"c\"clang_Cursor_hasVarDeclGlobalStorage\""
        export clang_Cursor_hasVarDeclGlobalStorage
        var"c\"clang_Cursor_hasVarDeclGlobalStorage\""
        struct Cbinding_clang_Cursor_hasVarDeclExternalStorage{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_hasVarDeclExternalStorage}
        end
        const var"c\"clang_Cursor_hasVarDeclExternalStorage\"" = Cbinding_clang_Cursor_hasVarDeclExternalStorage{:clang_Cursor_hasVarDeclExternalStorage}()
        (func::Cbinding_clang_Cursor_hasVarDeclExternalStorage)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_Cursor_hasVarDeclExternalStorage = var"c\"clang_Cursor_hasVarDeclExternalStorage\""
        export var"c\"clang_Cursor_hasVarDeclExternalStorage\""
        export clang_Cursor_hasVarDeclExternalStorage
        var"c\"clang_Cursor_hasVarDeclExternalStorage\""
        abstract type var"c\"enum CXLanguageKind\"" <: Cenum end
        const CXLanguageKind = var"c\"enum CXLanguageKind\""
        export var"c\"enum CXLanguageKind\""
        export CXLanguageKind
        var"c\"enum CXLanguageKind\""
        primitive type var"(c\"enum CXLanguageKind\")" <: var"c\"enum CXLanguageKind\"" 32 end
        (::(Type){var"(c\"enum CXLanguageKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXLanguageKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXLanguageKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXLanguage_Invalid\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXLanguage_C\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXLanguage_ObjC\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXLanguage_CPlusPlus\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXLanguageKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXLanguageKind\")"}) = begin
                var"(c\"enum CXLanguageKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXLanguageKind\""}) = begin
                var"(c\"enum CXLanguageKind\")"
            end
        const var"c\"CXLanguage_Invalid\"" = var"(c\"enum CXLanguageKind\")"(0x0000000000000000)
        const var"c\"CXLanguage_C\"" = var"(c\"enum CXLanguageKind\")"(0x0000000000000001)
        const var"c\"CXLanguage_ObjC\"" = var"(c\"enum CXLanguageKind\")"(0x0000000000000002)
        const var"c\"CXLanguage_CPlusPlus\"" = var"(c\"enum CXLanguageKind\")"(0x0000000000000003)
        const CXLanguageKind = var"c\"enum CXLanguageKind\""
        const CXLanguage_Invalid = var"c\"CXLanguage_Invalid\""
        const CXLanguage_C = var"c\"CXLanguage_C\""
        const CXLanguage_ObjC = var"c\"CXLanguage_ObjC\""
        const CXLanguage_CPlusPlus = var"c\"CXLanguage_CPlusPlus\""
        export var"c\"enum CXLanguageKind\"", var"(c\"enum CXLanguageKind\")", var"c\"CXLanguage_Invalid\"", var"c\"CXLanguage_C\"", var"c\"CXLanguage_ObjC\"", var"c\"CXLanguage_CPlusPlus\""
        export CXLanguageKind, CXLanguage_Invalid, CXLanguage_C, CXLanguage_ObjC, CXLanguage_CPlusPlus
        var"c\"enum CXLanguageKind\""
        struct Cbinding_clang_getCursorLanguage{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXLanguageKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorLanguage}
        end
        const var"c\"clang_getCursorLanguage\"" = Cbinding_clang_getCursorLanguage{:clang_getCursorLanguage}()
        (func::Cbinding_clang_getCursorLanguage)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorLanguage = var"c\"clang_getCursorLanguage\""
        export var"c\"clang_getCursorLanguage\""
        export clang_getCursorLanguage
        var"c\"clang_getCursorLanguage\""
        abstract type var"c\"enum CXTLSKind\"" <: Cenum end
        const CXTLSKind = var"c\"enum CXTLSKind\""
        export var"c\"enum CXTLSKind\""
        export CXTLSKind
        var"c\"enum CXTLSKind\""
        primitive type var"(c\"enum CXTLSKind\")" <: var"c\"enum CXTLSKind\"" 32 end
        (::(Type){var"(c\"enum CXTLSKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXTLSKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXTLSKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXTLS_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXTLS_Dynamic\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXTLS_Static\""), 0x0000000000000002}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXTLSKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXTLSKind\")"}) = begin
                var"(c\"enum CXTLSKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXTLSKind\""}) = begin
                var"(c\"enum CXTLSKind\")"
            end
        const var"c\"CXTLS_None\"" = var"(c\"enum CXTLSKind\")"(0x0000000000000000)
        const var"c\"CXTLS_Dynamic\"" = var"(c\"enum CXTLSKind\")"(0x0000000000000001)
        const var"c\"CXTLS_Static\"" = var"(c\"enum CXTLSKind\")"(0x0000000000000002)
        const CXTLSKind = var"c\"enum CXTLSKind\""
        const CXTLS_None = var"c\"CXTLS_None\""
        const CXTLS_Dynamic = var"c\"CXTLS_Dynamic\""
        const CXTLS_Static = var"c\"CXTLS_Static\""
        export var"c\"enum CXTLSKind\"", var"(c\"enum CXTLSKind\")", var"c\"CXTLS_None\"", var"c\"CXTLS_Dynamic\"", var"c\"CXTLS_Static\""
        export CXTLSKind, CXTLS_None, CXTLS_Dynamic, CXTLS_Static
        var"c\"enum CXTLSKind\""
        struct Cbinding_clang_getCursorTLSKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXTLSKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorTLSKind}
        end
        const var"c\"clang_getCursorTLSKind\"" = Cbinding_clang_getCursorTLSKind{:clang_getCursorTLSKind}()
        (func::Cbinding_clang_getCursorTLSKind)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorTLSKind = var"c\"clang_getCursorTLSKind\""
        export var"c\"clang_getCursorTLSKind\""
        export clang_getCursorTLSKind
        var"c\"clang_getCursorTLSKind\""
        struct Cbinding_clang_Cursor_getTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXTranslationUnit\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getTranslationUnit}
        end
        const var"c\"clang_Cursor_getTranslationUnit\"" = Cbinding_clang_Cursor_getTranslationUnit{:clang_Cursor_getTranslationUnit}()
        (func::Cbinding_clang_Cursor_getTranslationUnit)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_Cursor_getTranslationUnit = var"c\"clang_Cursor_getTranslationUnit\""
        export var"c\"clang_Cursor_getTranslationUnit\""
        export clang_Cursor_getTranslationUnit
        var"c\"clang_Cursor_getTranslationUnit\""
        abstract type var"c\"struct CXCursorSetImpl\"" <: Cstruct end
        const CXCursorSetImpl = var"c\"struct CXCursorSetImpl\""
        export var"c\"struct CXCursorSetImpl\""
        export CXCursorSetImpl
        var"c\"struct CXCursorSetImpl\""
        const var"c\"CXCursorSet\"" = CBinding.Cptr{var"c\"struct CXCursorSetImpl\""}
        const CXCursorSet = var"c\"CXCursorSet\""
        export var"c\"CXCursorSet\""
        export CXCursorSet
        var"c\"CXCursorSet\""
        struct Cbinding_clang_createCXCursorSet{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursorSet\"", CBinding.Tuple{}, :cdecl}, libpath, :clang_createCXCursorSet}
        end
        const var"c\"clang_createCXCursorSet\"" = Cbinding_clang_createCXCursorSet{:clang_createCXCursorSet}()
        (func::Cbinding_clang_createCXCursorSet)() = begin
                CBinding.funccall(func)
            end
        const clang_createCXCursorSet = var"c\"clang_createCXCursorSet\""
        export var"c\"clang_createCXCursorSet\""
        export clang_createCXCursorSet
        var"c\"clang_createCXCursorSet\""
        struct Cbinding_clang_disposeCXCursorSet{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXCursorSet\""}, :cdecl}, libpath, :clang_disposeCXCursorSet}
        end
        const var"c\"clang_disposeCXCursorSet\"" = Cbinding_clang_disposeCXCursorSet{:clang_disposeCXCursorSet}()
        (func::Cbinding_clang_disposeCXCursorSet)(var"c\"cset\"") = begin
                CBinding.funccall(func, var"c\"cset\"")
            end
        const clang_disposeCXCursorSet = var"c\"clang_disposeCXCursorSet\""
        export var"c\"clang_disposeCXCursorSet\""
        export clang_disposeCXCursorSet
        var"c\"clang_disposeCXCursorSet\""
        struct Cbinding_clang_CXCursorSet_contains{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursorSet\"", var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXCursorSet_contains}
        end
        const var"c\"clang_CXCursorSet_contains\"" = Cbinding_clang_CXCursorSet_contains{:clang_CXCursorSet_contains}()
        (func::Cbinding_clang_CXCursorSet_contains)(var"c\"cset\"", var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cset\"", var"c\"cursor\"")
            end
        const clang_CXCursorSet_contains = var"c\"clang_CXCursorSet_contains\""
        export var"c\"clang_CXCursorSet_contains\""
        export clang_CXCursorSet_contains
        var"c\"clang_CXCursorSet_contains\""
        struct Cbinding_clang_CXCursorSet_insert{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursorSet\"", var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXCursorSet_insert}
        end
        const var"c\"clang_CXCursorSet_insert\"" = Cbinding_clang_CXCursorSet_insert{:clang_CXCursorSet_insert}()
        (func::Cbinding_clang_CXCursorSet_insert)(var"c\"cset\"", var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cset\"", var"c\"cursor\"")
            end
        const clang_CXCursorSet_insert = var"c\"clang_CXCursorSet_insert\""
        export var"c\"clang_CXCursorSet_insert\""
        export clang_CXCursorSet_insert
        var"c\"clang_CXCursorSet_insert\""
        struct Cbinding_clang_getCursorSemanticParent{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorSemanticParent}
        end
        const var"c\"clang_getCursorSemanticParent\"" = Cbinding_clang_getCursorSemanticParent{:clang_getCursorSemanticParent}()
        (func::Cbinding_clang_getCursorSemanticParent)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorSemanticParent = var"c\"clang_getCursorSemanticParent\""
        export var"c\"clang_getCursorSemanticParent\""
        export clang_getCursorSemanticParent
        var"c\"clang_getCursorSemanticParent\""
        struct Cbinding_clang_getCursorLexicalParent{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorLexicalParent}
        end
        const var"c\"clang_getCursorLexicalParent\"" = Cbinding_clang_getCursorLexicalParent{:clang_getCursorLexicalParent}()
        (func::Cbinding_clang_getCursorLexicalParent)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorLexicalParent = var"c\"clang_getCursorLexicalParent\""
        export var"c\"clang_getCursorLexicalParent\""
        export clang_getCursorLexicalParent
        var"c\"clang_getCursorLexicalParent\""
        struct Cbinding_clang_getOverriddenCursors{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cptr{CBinding.Cptr{var"c\"CXCursor\""}}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_getOverriddenCursors}
        end
        const var"c\"clang_getOverriddenCursors\"" = Cbinding_clang_getOverriddenCursors{:clang_getOverriddenCursors}()
        (func::Cbinding_clang_getOverriddenCursors)(var"c\"cursor\"", var"c\"overridden\"", var"c\"num_overridden\"") = begin
                CBinding.funccall(func, var"c\"cursor\"", var"c\"overridden\"", var"c\"num_overridden\"")
            end
        const clang_getOverriddenCursors = var"c\"clang_getOverriddenCursors\""
        export var"c\"clang_getOverriddenCursors\""
        export clang_getOverriddenCursors
        var"c\"clang_getOverriddenCursors\""
        struct Cbinding_clang_disposeOverriddenCursors{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{var"c\"CXCursor\""}}, :cdecl}, libpath, :clang_disposeOverriddenCursors}
        end
        const var"c\"clang_disposeOverriddenCursors\"" = Cbinding_clang_disposeOverriddenCursors{:clang_disposeOverriddenCursors}()
        (func::Cbinding_clang_disposeOverriddenCursors)(var"c\"overridden\"") = begin
                CBinding.funccall(func, var"c\"overridden\"")
            end
        const clang_disposeOverriddenCursors = var"c\"clang_disposeOverriddenCursors\""
        export var"c\"clang_disposeOverriddenCursors\""
        export clang_disposeOverriddenCursors
        var"c\"clang_disposeOverriddenCursors\""
        struct Cbinding_clang_getIncludedFile{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXFile\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getIncludedFile}
        end
        const var"c\"clang_getIncludedFile\"" = Cbinding_clang_getIncludedFile{:clang_getIncludedFile}()
        (func::Cbinding_clang_getIncludedFile)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getIncludedFile = var"c\"clang_getIncludedFile\""
        export var"c\"clang_getIncludedFile\""
        export clang_getIncludedFile
        var"c\"clang_getIncludedFile\""
        struct Cbinding_clang_getCursor{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXSourceLocation\""}, :cdecl}, libpath, :clang_getCursor}
        end
        const var"c\"clang_getCursor\"" = Cbinding_clang_getCursor{:clang_getCursor}()
        (func::Cbinding_clang_getCursor)(arg1, arg2) = begin
                CBinding.funccall(func, arg1, arg2)
            end
        const clang_getCursor = var"c\"clang_getCursor\""
        export var"c\"clang_getCursor\""
        export clang_getCursor
        var"c\"clang_getCursor\""
        struct Cbinding_clang_getCursorLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorLocation}
        end
        const var"c\"clang_getCursorLocation\"" = Cbinding_clang_getCursorLocation{:clang_getCursorLocation}()
        (func::Cbinding_clang_getCursorLocation)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorLocation = var"c\"clang_getCursorLocation\""
        export var"c\"clang_getCursorLocation\""
        export clang_getCursorLocation
        var"c\"clang_getCursorLocation\""
        struct Cbinding_clang_getCursorExtent{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceRange\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorExtent}
        end
        const var"c\"clang_getCursorExtent\"" = Cbinding_clang_getCursorExtent{:clang_getCursorExtent}()
        (func::Cbinding_clang_getCursorExtent)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorExtent = var"c\"clang_getCursorExtent\""
        export var"c\"clang_getCursorExtent\""
        export clang_getCursorExtent
        var"c\"clang_getCursorExtent\""
        abstract type var"c\"enum CXTypeKind\"" <: Cenum end
        const CXTypeKind = var"c\"enum CXTypeKind\""
        export var"c\"enum CXTypeKind\""
        export CXTypeKind
        var"c\"enum CXTypeKind\""
        primitive type var"(c\"enum CXTypeKind\")" <: var"c\"enum CXTypeKind\"" 32 end
        (::(Type){var"(c\"enum CXTypeKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXTypeKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXTypeKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXType_Invalid\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXType_Unexposed\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXType_Void\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXType_Bool\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXType_Char_U\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXType_UChar\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXType_Char16\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXType_Char32\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXType_UShort\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXType_UInt\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXType_ULong\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXType_ULongLong\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXType_UInt128\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXType_Char_S\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXType_SChar\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXType_WChar\""), 0x000000000000000f}, CBinding.Tuple{Symbol("c\"CXType_Short\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXType_Int\""), 0x0000000000000011}, CBinding.Tuple{Symbol("c\"CXType_Long\""), 0x0000000000000012}, CBinding.Tuple{Symbol("c\"CXType_LongLong\""), 0x0000000000000013}, CBinding.Tuple{Symbol("c\"CXType_Int128\""), 0x0000000000000014}, CBinding.Tuple{Symbol("c\"CXType_Float\""), 0x0000000000000015}, CBinding.Tuple{Symbol("c\"CXType_Double\""), 0x0000000000000016}, CBinding.Tuple{Symbol("c\"CXType_LongDouble\""), 0x0000000000000017}, CBinding.Tuple{Symbol("c\"CXType_NullPtr\""), 0x0000000000000018}, CBinding.Tuple{Symbol("c\"CXType_Overload\""), 0x0000000000000019}, CBinding.Tuple{Symbol("c\"CXType_Dependent\""), 0x000000000000001a}, CBinding.Tuple{Symbol("c\"CXType_ObjCId\""), 0x000000000000001b}, CBinding.Tuple{Symbol("c\"CXType_ObjCClass\""), 0x000000000000001c}, CBinding.Tuple{Symbol("c\"CXType_ObjCSel\""), 0x000000000000001d}, CBinding.Tuple{Symbol("c\"CXType_Float128\""), 0x000000000000001e}, CBinding.Tuple{Symbol("c\"CXType_Half\""), 0x000000000000001f}, CBinding.Tuple{Symbol("c\"CXType_Float16\""), 0x0000000000000020}, CBinding.Tuple{Symbol("c\"CXType_ShortAccum\""), 0x0000000000000021}, CBinding.Tuple{Symbol("c\"CXType_Accum\""), 0x0000000000000022}, CBinding.Tuple{Symbol("c\"CXType_LongAccum\""), 0x0000000000000023}, CBinding.Tuple{Symbol("c\"CXType_UShortAccum\""), 0x0000000000000024}, CBinding.Tuple{Symbol("c\"CXType_UAccum\""), 0x0000000000000025}, CBinding.Tuple{Symbol("c\"CXType_ULongAccum\""), 0x0000000000000026}, CBinding.Tuple{Symbol("c\"CXType_BFloat16\""), 0x0000000000000027}, CBinding.Tuple{Symbol("c\"CXType_Ibm128\""), 0x0000000000000028}, CBinding.Tuple{Symbol("c\"CXType_FirstBuiltin\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXType_LastBuiltin\""), 0x0000000000000028}, CBinding.Tuple{Symbol("c\"CXType_Complex\""), 0x0000000000000064}, CBinding.Tuple{Symbol("c\"CXType_Pointer\""), 0x0000000000000065}, CBinding.Tuple{Symbol("c\"CXType_BlockPointer\""), 0x0000000000000066}, CBinding.Tuple{Symbol("c\"CXType_LValueReference\""), 0x0000000000000067}, CBinding.Tuple{Symbol("c\"CXType_RValueReference\""), 0x0000000000000068}, CBinding.Tuple{Symbol("c\"CXType_Record\""), 0x0000000000000069}, CBinding.Tuple{Symbol("c\"CXType_Enum\""), 0x000000000000006a}, CBinding.Tuple{Symbol("c\"CXType_Typedef\""), 0x000000000000006b}, CBinding.Tuple{Symbol("c\"CXType_ObjCInterface\""), 0x000000000000006c}, CBinding.Tuple{Symbol("c\"CXType_ObjCObjectPointer\""), 0x000000000000006d}, CBinding.Tuple{Symbol("c\"CXType_FunctionNoProto\""), 0x000000000000006e}, CBinding.Tuple{Symbol("c\"CXType_FunctionProto\""), 0x000000000000006f}, CBinding.Tuple{Symbol("c\"CXType_ConstantArray\""), 0x0000000000000070}, CBinding.Tuple{Symbol("c\"CXType_Vector\""), 0x0000000000000071}, CBinding.Tuple{Symbol("c\"CXType_IncompleteArray\""), 0x0000000000000072}, CBinding.Tuple{Symbol("c\"CXType_VariableArray\""), 0x0000000000000073}, CBinding.Tuple{Symbol("c\"CXType_DependentSizedArray\""), 0x0000000000000074}, CBinding.Tuple{Symbol("c\"CXType_MemberPointer\""), 0x0000000000000075}, CBinding.Tuple{Symbol("c\"CXType_Auto\""), 0x0000000000000076}, CBinding.Tuple{Symbol("c\"CXType_Elaborated\""), 0x0000000000000077}, CBinding.Tuple{Symbol("c\"CXType_Pipe\""), 0x0000000000000078}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dRO\""), 0x0000000000000079}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dArrayRO\""), 0x000000000000007a}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dBufferRO\""), 0x000000000000007b}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dRO\""), 0x000000000000007c}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayRO\""), 0x000000000000007d}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dDepthRO\""), 0x000000000000007e}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayDepthRO\""), 0x000000000000007f}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dMSAARO\""), 0x0000000000000080}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayMSAARO\""), 0x0000000000000081}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dMSAADepthRO\""), 0x0000000000000082}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayMSAADepthRO\""), 0x0000000000000083}, CBinding.Tuple{Symbol("c\"CXType_OCLImage3dRO\""), 0x0000000000000084}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dWO\""), 0x0000000000000085}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dArrayWO\""), 0x0000000000000086}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dBufferWO\""), 0x0000000000000087}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dWO\""), 0x0000000000000088}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayWO\""), 0x0000000000000089}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dDepthWO\""), 0x000000000000008a}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayDepthWO\""), 0x000000000000008b}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dMSAAWO\""), 0x000000000000008c}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayMSAAWO\""), 0x000000000000008d}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dMSAADepthWO\""), 0x000000000000008e}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayMSAADepthWO\""), 0x000000000000008f}, CBinding.Tuple{Symbol("c\"CXType_OCLImage3dWO\""), 0x0000000000000090}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dRW\""), 0x0000000000000091}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dArrayRW\""), 0x0000000000000092}, CBinding.Tuple{Symbol("c\"CXType_OCLImage1dBufferRW\""), 0x0000000000000093}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dRW\""), 0x0000000000000094}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayRW\""), 0x0000000000000095}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dDepthRW\""), 0x0000000000000096}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayDepthRW\""), 0x0000000000000097}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dMSAARW\""), 0x0000000000000098}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayMSAARW\""), 0x0000000000000099}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dMSAADepthRW\""), 0x000000000000009a}, CBinding.Tuple{Symbol("c\"CXType_OCLImage2dArrayMSAADepthRW\""), 0x000000000000009b}, CBinding.Tuple{Symbol("c\"CXType_OCLImage3dRW\""), 0x000000000000009c}, CBinding.Tuple{Symbol("c\"CXType_OCLSampler\""), 0x000000000000009d}, CBinding.Tuple{Symbol("c\"CXType_OCLEvent\""), 0x000000000000009e}, CBinding.Tuple{Symbol("c\"CXType_OCLQueue\""), 0x000000000000009f}, CBinding.Tuple{Symbol("c\"CXType_OCLReserveID\""), 0x00000000000000a0}, CBinding.Tuple{Symbol("c\"CXType_ObjCObject\""), 0x00000000000000a1}, CBinding.Tuple{Symbol("c\"CXType_ObjCTypeParam\""), 0x00000000000000a2}, CBinding.Tuple{Symbol("c\"CXType_Attributed\""), 0x00000000000000a3}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCMcePayload\""), 0x00000000000000a4}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImePayload\""), 0x00000000000000a5}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCRefPayload\""), 0x00000000000000a6}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCSicPayload\""), 0x00000000000000a7}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCMceResult\""), 0x00000000000000a8}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeResult\""), 0x00000000000000a9}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCRefResult\""), 0x00000000000000aa}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCSicResult\""), 0x00000000000000ab}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeResultSingleReferenceStreamout\""), 0x00000000000000ac}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeResultDualReferenceStreamout\""), 0x00000000000000ad}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeSingleReferenceStreamin\""), 0x00000000000000ae}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeDualReferenceStreamin\""), 0x00000000000000af}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout\""), 0x00000000000000ac}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout\""), 0x00000000000000ad}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeSingleRefStreamin\""), 0x00000000000000ae}, CBinding.Tuple{Symbol("c\"CXType_OCLIntelSubgroupAVCImeDualRefStreamin\""), 0x00000000000000af}, CBinding.Tuple{Symbol("c\"CXType_ExtVector\""), 0x00000000000000b0}, CBinding.Tuple{Symbol("c\"CXType_Atomic\""), 0x00000000000000b1}, CBinding.Tuple{Symbol("c\"CXType_BTFTagAttributed\""), 0x00000000000000b2}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXTypeKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXTypeKind\")"}) = begin
                var"(c\"enum CXTypeKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXTypeKind\""}) = begin
                var"(c\"enum CXTypeKind\")"
            end
        const var"c\"CXType_Invalid\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000000)
        const var"c\"CXType_Unexposed\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000001)
        const var"c\"CXType_Void\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000002)
        const var"c\"CXType_Bool\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000003)
        const var"c\"CXType_Char_U\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000004)
        const var"c\"CXType_UChar\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000005)
        const var"c\"CXType_Char16\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000006)
        const var"c\"CXType_Char32\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000007)
        const var"c\"CXType_UShort\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000008)
        const var"c\"CXType_UInt\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000009)
        const var"c\"CXType_ULong\"" = var"(c\"enum CXTypeKind\")"(0x000000000000000a)
        const var"c\"CXType_ULongLong\"" = var"(c\"enum CXTypeKind\")"(0x000000000000000b)
        const var"c\"CXType_UInt128\"" = var"(c\"enum CXTypeKind\")"(0x000000000000000c)
        const var"c\"CXType_Char_S\"" = var"(c\"enum CXTypeKind\")"(0x000000000000000d)
        const var"c\"CXType_SChar\"" = var"(c\"enum CXTypeKind\")"(0x000000000000000e)
        const var"c\"CXType_WChar\"" = var"(c\"enum CXTypeKind\")"(0x000000000000000f)
        const var"c\"CXType_Short\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000010)
        const var"c\"CXType_Int\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000011)
        const var"c\"CXType_Long\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000012)
        const var"c\"CXType_LongLong\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000013)
        const var"c\"CXType_Int128\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000014)
        const var"c\"CXType_Float\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000015)
        const var"c\"CXType_Double\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000016)
        const var"c\"CXType_LongDouble\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000017)
        const var"c\"CXType_NullPtr\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000018)
        const var"c\"CXType_Overload\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000019)
        const var"c\"CXType_Dependent\"" = var"(c\"enum CXTypeKind\")"(0x000000000000001a)
        const var"c\"CXType_ObjCId\"" = var"(c\"enum CXTypeKind\")"(0x000000000000001b)
        const var"c\"CXType_ObjCClass\"" = var"(c\"enum CXTypeKind\")"(0x000000000000001c)
        const var"c\"CXType_ObjCSel\"" = var"(c\"enum CXTypeKind\")"(0x000000000000001d)
        const var"c\"CXType_Float128\"" = var"(c\"enum CXTypeKind\")"(0x000000000000001e)
        const var"c\"CXType_Half\"" = var"(c\"enum CXTypeKind\")"(0x000000000000001f)
        const var"c\"CXType_Float16\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000020)
        const var"c\"CXType_ShortAccum\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000021)
        const var"c\"CXType_Accum\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000022)
        const var"c\"CXType_LongAccum\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000023)
        const var"c\"CXType_UShortAccum\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000024)
        const var"c\"CXType_UAccum\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000025)
        const var"c\"CXType_ULongAccum\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000026)
        const var"c\"CXType_BFloat16\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000027)
        const var"c\"CXType_Ibm128\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000028)
        const var"c\"CXType_FirstBuiltin\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000002)
        const var"c\"CXType_LastBuiltin\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000028)
        const var"c\"CXType_Complex\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000064)
        const var"c\"CXType_Pointer\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000065)
        const var"c\"CXType_BlockPointer\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000066)
        const var"c\"CXType_LValueReference\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000067)
        const var"c\"CXType_RValueReference\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000068)
        const var"c\"CXType_Record\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000069)
        const var"c\"CXType_Enum\"" = var"(c\"enum CXTypeKind\")"(0x000000000000006a)
        const var"c\"CXType_Typedef\"" = var"(c\"enum CXTypeKind\")"(0x000000000000006b)
        const var"c\"CXType_ObjCInterface\"" = var"(c\"enum CXTypeKind\")"(0x000000000000006c)
        const var"c\"CXType_ObjCObjectPointer\"" = var"(c\"enum CXTypeKind\")"(0x000000000000006d)
        const var"c\"CXType_FunctionNoProto\"" = var"(c\"enum CXTypeKind\")"(0x000000000000006e)
        const var"c\"CXType_FunctionProto\"" = var"(c\"enum CXTypeKind\")"(0x000000000000006f)
        const var"c\"CXType_ConstantArray\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000070)
        const var"c\"CXType_Vector\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000071)
        const var"c\"CXType_IncompleteArray\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000072)
        const var"c\"CXType_VariableArray\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000073)
        const var"c\"CXType_DependentSizedArray\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000074)
        const var"c\"CXType_MemberPointer\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000075)
        const var"c\"CXType_Auto\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000076)
        const var"c\"CXType_Elaborated\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000077)
        const var"c\"CXType_Pipe\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000078)
        const var"c\"CXType_OCLImage1dRO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000079)
        const var"c\"CXType_OCLImage1dArrayRO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000007a)
        const var"c\"CXType_OCLImage1dBufferRO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000007b)
        const var"c\"CXType_OCLImage2dRO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000007c)
        const var"c\"CXType_OCLImage2dArrayRO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000007d)
        const var"c\"CXType_OCLImage2dDepthRO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000007e)
        const var"c\"CXType_OCLImage2dArrayDepthRO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000007f)
        const var"c\"CXType_OCLImage2dMSAARO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000080)
        const var"c\"CXType_OCLImage2dArrayMSAARO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000081)
        const var"c\"CXType_OCLImage2dMSAADepthRO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000082)
        const var"c\"CXType_OCLImage2dArrayMSAADepthRO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000083)
        const var"c\"CXType_OCLImage3dRO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000084)
        const var"c\"CXType_OCLImage1dWO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000085)
        const var"c\"CXType_OCLImage1dArrayWO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000086)
        const var"c\"CXType_OCLImage1dBufferWO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000087)
        const var"c\"CXType_OCLImage2dWO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000088)
        const var"c\"CXType_OCLImage2dArrayWO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000089)
        const var"c\"CXType_OCLImage2dDepthWO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000008a)
        const var"c\"CXType_OCLImage2dArrayDepthWO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000008b)
        const var"c\"CXType_OCLImage2dMSAAWO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000008c)
        const var"c\"CXType_OCLImage2dArrayMSAAWO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000008d)
        const var"c\"CXType_OCLImage2dMSAADepthWO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000008e)
        const var"c\"CXType_OCLImage2dArrayMSAADepthWO\"" = var"(c\"enum CXTypeKind\")"(0x000000000000008f)
        const var"c\"CXType_OCLImage3dWO\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000090)
        const var"c\"CXType_OCLImage1dRW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000091)
        const var"c\"CXType_OCLImage1dArrayRW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000092)
        const var"c\"CXType_OCLImage1dBufferRW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000093)
        const var"c\"CXType_OCLImage2dRW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000094)
        const var"c\"CXType_OCLImage2dArrayRW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000095)
        const var"c\"CXType_OCLImage2dDepthRW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000096)
        const var"c\"CXType_OCLImage2dArrayDepthRW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000097)
        const var"c\"CXType_OCLImage2dMSAARW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000098)
        const var"c\"CXType_OCLImage2dArrayMSAARW\"" = var"(c\"enum CXTypeKind\")"(0x0000000000000099)
        const var"c\"CXType_OCLImage2dMSAADepthRW\"" = var"(c\"enum CXTypeKind\")"(0x000000000000009a)
        const var"c\"CXType_OCLImage2dArrayMSAADepthRW\"" = var"(c\"enum CXTypeKind\")"(0x000000000000009b)
        const var"c\"CXType_OCLImage3dRW\"" = var"(c\"enum CXTypeKind\")"(0x000000000000009c)
        const var"c\"CXType_OCLSampler\"" = var"(c\"enum CXTypeKind\")"(0x000000000000009d)
        const var"c\"CXType_OCLEvent\"" = var"(c\"enum CXTypeKind\")"(0x000000000000009e)
        const var"c\"CXType_OCLQueue\"" = var"(c\"enum CXTypeKind\")"(0x000000000000009f)
        const var"c\"CXType_OCLReserveID\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a0)
        const var"c\"CXType_ObjCObject\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a1)
        const var"c\"CXType_ObjCTypeParam\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a2)
        const var"c\"CXType_Attributed\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a3)
        const var"c\"CXType_OCLIntelSubgroupAVCMcePayload\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a4)
        const var"c\"CXType_OCLIntelSubgroupAVCImePayload\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a5)
        const var"c\"CXType_OCLIntelSubgroupAVCRefPayload\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a6)
        const var"c\"CXType_OCLIntelSubgroupAVCSicPayload\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a7)
        const var"c\"CXType_OCLIntelSubgroupAVCMceResult\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a8)
        const var"c\"CXType_OCLIntelSubgroupAVCImeResult\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000a9)
        const var"c\"CXType_OCLIntelSubgroupAVCRefResult\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000aa)
        const var"c\"CXType_OCLIntelSubgroupAVCSicResult\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000ab)
        const var"c\"CXType_OCLIntelSubgroupAVCImeResultSingleReferenceStreamout\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000ac)
        const var"c\"CXType_OCLIntelSubgroupAVCImeResultDualReferenceStreamout\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000ad)
        const var"c\"CXType_OCLIntelSubgroupAVCImeSingleReferenceStreamin\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000ae)
        const var"c\"CXType_OCLIntelSubgroupAVCImeDualReferenceStreamin\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000af)
        const var"c\"CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000ac)
        const var"c\"CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000ad)
        const var"c\"CXType_OCLIntelSubgroupAVCImeSingleRefStreamin\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000ae)
        const var"c\"CXType_OCLIntelSubgroupAVCImeDualRefStreamin\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000af)
        const var"c\"CXType_ExtVector\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000b0)
        const var"c\"CXType_Atomic\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000b1)
        const var"c\"CXType_BTFTagAttributed\"" = var"(c\"enum CXTypeKind\")"(0x00000000000000b2)
        const CXTypeKind = var"c\"enum CXTypeKind\""
        const CXType_Invalid = var"c\"CXType_Invalid\""
        const CXType_Unexposed = var"c\"CXType_Unexposed\""
        const CXType_Void = var"c\"CXType_Void\""
        const CXType_Bool = var"c\"CXType_Bool\""
        const CXType_Char_U = var"c\"CXType_Char_U\""
        const CXType_UChar = var"c\"CXType_UChar\""
        const CXType_Char16 = var"c\"CXType_Char16\""
        const CXType_Char32 = var"c\"CXType_Char32\""
        const CXType_UShort = var"c\"CXType_UShort\""
        const CXType_UInt = var"c\"CXType_UInt\""
        const CXType_ULong = var"c\"CXType_ULong\""
        const CXType_ULongLong = var"c\"CXType_ULongLong\""
        const CXType_UInt128 = var"c\"CXType_UInt128\""
        const CXType_Char_S = var"c\"CXType_Char_S\""
        const CXType_SChar = var"c\"CXType_SChar\""
        const CXType_WChar = var"c\"CXType_WChar\""
        const CXType_Short = var"c\"CXType_Short\""
        const CXType_Int = var"c\"CXType_Int\""
        const CXType_Long = var"c\"CXType_Long\""
        const CXType_LongLong = var"c\"CXType_LongLong\""
        const CXType_Int128 = var"c\"CXType_Int128\""
        const CXType_Float = var"c\"CXType_Float\""
        const CXType_Double = var"c\"CXType_Double\""
        const CXType_LongDouble = var"c\"CXType_LongDouble\""
        const CXType_NullPtr = var"c\"CXType_NullPtr\""
        const CXType_Overload = var"c\"CXType_Overload\""
        const CXType_Dependent = var"c\"CXType_Dependent\""
        const CXType_ObjCId = var"c\"CXType_ObjCId\""
        const CXType_ObjCClass = var"c\"CXType_ObjCClass\""
        const CXType_ObjCSel = var"c\"CXType_ObjCSel\""
        const CXType_Float128 = var"c\"CXType_Float128\""
        const CXType_Half = var"c\"CXType_Half\""
        const CXType_Float16 = var"c\"CXType_Float16\""
        const CXType_ShortAccum = var"c\"CXType_ShortAccum\""
        const CXType_Accum = var"c\"CXType_Accum\""
        const CXType_LongAccum = var"c\"CXType_LongAccum\""
        const CXType_UShortAccum = var"c\"CXType_UShortAccum\""
        const CXType_UAccum = var"c\"CXType_UAccum\""
        const CXType_ULongAccum = var"c\"CXType_ULongAccum\""
        const CXType_BFloat16 = var"c\"CXType_BFloat16\""
        const CXType_Ibm128 = var"c\"CXType_Ibm128\""
        const CXType_FirstBuiltin = var"c\"CXType_FirstBuiltin\""
        const CXType_LastBuiltin = var"c\"CXType_LastBuiltin\""
        const CXType_Complex = var"c\"CXType_Complex\""
        const CXType_Pointer = var"c\"CXType_Pointer\""
        const CXType_BlockPointer = var"c\"CXType_BlockPointer\""
        const CXType_LValueReference = var"c\"CXType_LValueReference\""
        const CXType_RValueReference = var"c\"CXType_RValueReference\""
        const CXType_Record = var"c\"CXType_Record\""
        const CXType_Enum = var"c\"CXType_Enum\""
        const CXType_Typedef = var"c\"CXType_Typedef\""
        const CXType_ObjCInterface = var"c\"CXType_ObjCInterface\""
        const CXType_ObjCObjectPointer = var"c\"CXType_ObjCObjectPointer\""
        const CXType_FunctionNoProto = var"c\"CXType_FunctionNoProto\""
        const CXType_FunctionProto = var"c\"CXType_FunctionProto\""
        const CXType_ConstantArray = var"c\"CXType_ConstantArray\""
        const CXType_Vector = var"c\"CXType_Vector\""
        const CXType_IncompleteArray = var"c\"CXType_IncompleteArray\""
        const CXType_VariableArray = var"c\"CXType_VariableArray\""
        const CXType_DependentSizedArray = var"c\"CXType_DependentSizedArray\""
        const CXType_MemberPointer = var"c\"CXType_MemberPointer\""
        const CXType_Auto = var"c\"CXType_Auto\""
        const CXType_Elaborated = var"c\"CXType_Elaborated\""
        const CXType_Pipe = var"c\"CXType_Pipe\""
        const CXType_OCLImage1dRO = var"c\"CXType_OCLImage1dRO\""
        const CXType_OCLImage1dArrayRO = var"c\"CXType_OCLImage1dArrayRO\""
        const CXType_OCLImage1dBufferRO = var"c\"CXType_OCLImage1dBufferRO\""
        const CXType_OCLImage2dRO = var"c\"CXType_OCLImage2dRO\""
        const CXType_OCLImage2dArrayRO = var"c\"CXType_OCLImage2dArrayRO\""
        const CXType_OCLImage2dDepthRO = var"c\"CXType_OCLImage2dDepthRO\""
        const CXType_OCLImage2dArrayDepthRO = var"c\"CXType_OCLImage2dArrayDepthRO\""
        const CXType_OCLImage2dMSAARO = var"c\"CXType_OCLImage2dMSAARO\""
        const CXType_OCLImage2dArrayMSAARO = var"c\"CXType_OCLImage2dArrayMSAARO\""
        const CXType_OCLImage2dMSAADepthRO = var"c\"CXType_OCLImage2dMSAADepthRO\""
        const CXType_OCLImage2dArrayMSAADepthRO = var"c\"CXType_OCLImage2dArrayMSAADepthRO\""
        const CXType_OCLImage3dRO = var"c\"CXType_OCLImage3dRO\""
        const CXType_OCLImage1dWO = var"c\"CXType_OCLImage1dWO\""
        const CXType_OCLImage1dArrayWO = var"c\"CXType_OCLImage1dArrayWO\""
        const CXType_OCLImage1dBufferWO = var"c\"CXType_OCLImage1dBufferWO\""
        const CXType_OCLImage2dWO = var"c\"CXType_OCLImage2dWO\""
        const CXType_OCLImage2dArrayWO = var"c\"CXType_OCLImage2dArrayWO\""
        const CXType_OCLImage2dDepthWO = var"c\"CXType_OCLImage2dDepthWO\""
        const CXType_OCLImage2dArrayDepthWO = var"c\"CXType_OCLImage2dArrayDepthWO\""
        const CXType_OCLImage2dMSAAWO = var"c\"CXType_OCLImage2dMSAAWO\""
        const CXType_OCLImage2dArrayMSAAWO = var"c\"CXType_OCLImage2dArrayMSAAWO\""
        const CXType_OCLImage2dMSAADepthWO = var"c\"CXType_OCLImage2dMSAADepthWO\""
        const CXType_OCLImage2dArrayMSAADepthWO = var"c\"CXType_OCLImage2dArrayMSAADepthWO\""
        const CXType_OCLImage3dWO = var"c\"CXType_OCLImage3dWO\""
        const CXType_OCLImage1dRW = var"c\"CXType_OCLImage1dRW\""
        const CXType_OCLImage1dArrayRW = var"c\"CXType_OCLImage1dArrayRW\""
        const CXType_OCLImage1dBufferRW = var"c\"CXType_OCLImage1dBufferRW\""
        const CXType_OCLImage2dRW = var"c\"CXType_OCLImage2dRW\""
        const CXType_OCLImage2dArrayRW = var"c\"CXType_OCLImage2dArrayRW\""
        const CXType_OCLImage2dDepthRW = var"c\"CXType_OCLImage2dDepthRW\""
        const CXType_OCLImage2dArrayDepthRW = var"c\"CXType_OCLImage2dArrayDepthRW\""
        const CXType_OCLImage2dMSAARW = var"c\"CXType_OCLImage2dMSAARW\""
        const CXType_OCLImage2dArrayMSAARW = var"c\"CXType_OCLImage2dArrayMSAARW\""
        const CXType_OCLImage2dMSAADepthRW = var"c\"CXType_OCLImage2dMSAADepthRW\""
        const CXType_OCLImage2dArrayMSAADepthRW = var"c\"CXType_OCLImage2dArrayMSAADepthRW\""
        const CXType_OCLImage3dRW = var"c\"CXType_OCLImage3dRW\""
        const CXType_OCLSampler = var"c\"CXType_OCLSampler\""
        const CXType_OCLEvent = var"c\"CXType_OCLEvent\""
        const CXType_OCLQueue = var"c\"CXType_OCLQueue\""
        const CXType_OCLReserveID = var"c\"CXType_OCLReserveID\""
        const CXType_ObjCObject = var"c\"CXType_ObjCObject\""
        const CXType_ObjCTypeParam = var"c\"CXType_ObjCTypeParam\""
        const CXType_Attributed = var"c\"CXType_Attributed\""
        const CXType_OCLIntelSubgroupAVCMcePayload = var"c\"CXType_OCLIntelSubgroupAVCMcePayload\""
        const CXType_OCLIntelSubgroupAVCImePayload = var"c\"CXType_OCLIntelSubgroupAVCImePayload\""
        const CXType_OCLIntelSubgroupAVCRefPayload = var"c\"CXType_OCLIntelSubgroupAVCRefPayload\""
        const CXType_OCLIntelSubgroupAVCSicPayload = var"c\"CXType_OCLIntelSubgroupAVCSicPayload\""
        const CXType_OCLIntelSubgroupAVCMceResult = var"c\"CXType_OCLIntelSubgroupAVCMceResult\""
        const CXType_OCLIntelSubgroupAVCImeResult = var"c\"CXType_OCLIntelSubgroupAVCImeResult\""
        const CXType_OCLIntelSubgroupAVCRefResult = var"c\"CXType_OCLIntelSubgroupAVCRefResult\""
        const CXType_OCLIntelSubgroupAVCSicResult = var"c\"CXType_OCLIntelSubgroupAVCSicResult\""
        const CXType_OCLIntelSubgroupAVCImeResultSingleReferenceStreamout = var"c\"CXType_OCLIntelSubgroupAVCImeResultSingleReferenceStreamout\""
        const CXType_OCLIntelSubgroupAVCImeResultDualReferenceStreamout = var"c\"CXType_OCLIntelSubgroupAVCImeResultDualReferenceStreamout\""
        const CXType_OCLIntelSubgroupAVCImeSingleReferenceStreamin = var"c\"CXType_OCLIntelSubgroupAVCImeSingleReferenceStreamin\""
        const CXType_OCLIntelSubgroupAVCImeDualReferenceStreamin = var"c\"CXType_OCLIntelSubgroupAVCImeDualReferenceStreamin\""
        const CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout = var"c\"CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout\""
        const CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout = var"c\"CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout\""
        const CXType_OCLIntelSubgroupAVCImeSingleRefStreamin = var"c\"CXType_OCLIntelSubgroupAVCImeSingleRefStreamin\""
        const CXType_OCLIntelSubgroupAVCImeDualRefStreamin = var"c\"CXType_OCLIntelSubgroupAVCImeDualRefStreamin\""
        const CXType_ExtVector = var"c\"CXType_ExtVector\""
        const CXType_Atomic = var"c\"CXType_Atomic\""
        const CXType_BTFTagAttributed = var"c\"CXType_BTFTagAttributed\""
        export var"c\"enum CXTypeKind\"", var"(c\"enum CXTypeKind\")", var"c\"CXType_Invalid\"", var"c\"CXType_Unexposed\"", var"c\"CXType_Void\"", var"c\"CXType_Bool\"", var"c\"CXType_Char_U\"", var"c\"CXType_UChar\"", var"c\"CXType_Char16\"", var"c\"CXType_Char32\"", var"c\"CXType_UShort\"", var"c\"CXType_UInt\"", var"c\"CXType_ULong\"", var"c\"CXType_ULongLong\"", var"c\"CXType_UInt128\"", var"c\"CXType_Char_S\"", var"c\"CXType_SChar\"", var"c\"CXType_WChar\"", var"c\"CXType_Short\"", var"c\"CXType_Int\"", var"c\"CXType_Long\"", var"c\"CXType_LongLong\"", var"c\"CXType_Int128\"", var"c\"CXType_Float\"", var"c\"CXType_Double\"", var"c\"CXType_LongDouble\"", var"c\"CXType_NullPtr\"", var"c\"CXType_Overload\"", var"c\"CXType_Dependent\"", var"c\"CXType_ObjCId\"", var"c\"CXType_ObjCClass\"", var"c\"CXType_ObjCSel\"", var"c\"CXType_Float128\"", var"c\"CXType_Half\"", var"c\"CXType_Float16\"", var"c\"CXType_ShortAccum\"", var"c\"CXType_Accum\"", var"c\"CXType_LongAccum\"", var"c\"CXType_UShortAccum\"", var"c\"CXType_UAccum\"", var"c\"CXType_ULongAccum\"", var"c\"CXType_BFloat16\"", var"c\"CXType_Ibm128\"", var"c\"CXType_FirstBuiltin\"", var"c\"CXType_LastBuiltin\"", var"c\"CXType_Complex\"", var"c\"CXType_Pointer\"", var"c\"CXType_BlockPointer\"", var"c\"CXType_LValueReference\"", var"c\"CXType_RValueReference\"", var"c\"CXType_Record\"", var"c\"CXType_Enum\"", var"c\"CXType_Typedef\"", var"c\"CXType_ObjCInterface\"", var"c\"CXType_ObjCObjectPointer\"", var"c\"CXType_FunctionNoProto\"", var"c\"CXType_FunctionProto\"", var"c\"CXType_ConstantArray\"", var"c\"CXType_Vector\"", var"c\"CXType_IncompleteArray\"", var"c\"CXType_VariableArray\"", var"c\"CXType_DependentSizedArray\"", var"c\"CXType_MemberPointer\"", var"c\"CXType_Auto\"", var"c\"CXType_Elaborated\"", var"c\"CXType_Pipe\"", var"c\"CXType_OCLImage1dRO\"", var"c\"CXType_OCLImage1dArrayRO\"", var"c\"CXType_OCLImage1dBufferRO\"", var"c\"CXType_OCLImage2dRO\"", var"c\"CXType_OCLImage2dArrayRO\"", var"c\"CXType_OCLImage2dDepthRO\"", var"c\"CXType_OCLImage2dArrayDepthRO\"", var"c\"CXType_OCLImage2dMSAARO\"", var"c\"CXType_OCLImage2dArrayMSAARO\"", var"c\"CXType_OCLImage2dMSAADepthRO\"", var"c\"CXType_OCLImage2dArrayMSAADepthRO\"", var"c\"CXType_OCLImage3dRO\"", var"c\"CXType_OCLImage1dWO\"", var"c\"CXType_OCLImage1dArrayWO\"", var"c\"CXType_OCLImage1dBufferWO\"", var"c\"CXType_OCLImage2dWO\"", var"c\"CXType_OCLImage2dArrayWO\"", var"c\"CXType_OCLImage2dDepthWO\"", var"c\"CXType_OCLImage2dArrayDepthWO\"", var"c\"CXType_OCLImage2dMSAAWO\"", var"c\"CXType_OCLImage2dArrayMSAAWO\"", var"c\"CXType_OCLImage2dMSAADepthWO\"", var"c\"CXType_OCLImage2dArrayMSAADepthWO\"", var"c\"CXType_OCLImage3dWO\"", var"c\"CXType_OCLImage1dRW\"", var"c\"CXType_OCLImage1dArrayRW\"", var"c\"CXType_OCLImage1dBufferRW\"", var"c\"CXType_OCLImage2dRW\"", var"c\"CXType_OCLImage2dArrayRW\"", var"c\"CXType_OCLImage2dDepthRW\"", var"c\"CXType_OCLImage2dArrayDepthRW\"", var"c\"CXType_OCLImage2dMSAARW\"", var"c\"CXType_OCLImage2dArrayMSAARW\"", var"c\"CXType_OCLImage2dMSAADepthRW\"", var"c\"CXType_OCLImage2dArrayMSAADepthRW\"", var"c\"CXType_OCLImage3dRW\"", var"c\"CXType_OCLSampler\"", var"c\"CXType_OCLEvent\"", var"c\"CXType_OCLQueue\"", var"c\"CXType_OCLReserveID\"", var"c\"CXType_ObjCObject\"", var"c\"CXType_ObjCTypeParam\"", var"c\"CXType_Attributed\"", var"c\"CXType_OCLIntelSubgroupAVCMcePayload\"", var"c\"CXType_OCLIntelSubgroupAVCImePayload\"", var"c\"CXType_OCLIntelSubgroupAVCRefPayload\"", var"c\"CXType_OCLIntelSubgroupAVCSicPayload\"", var"c\"CXType_OCLIntelSubgroupAVCMceResult\"", var"c\"CXType_OCLIntelSubgroupAVCImeResult\"", var"c\"CXType_OCLIntelSubgroupAVCRefResult\"", var"c\"CXType_OCLIntelSubgroupAVCSicResult\"", var"c\"CXType_OCLIntelSubgroupAVCImeResultSingleReferenceStreamout\"", var"c\"CXType_OCLIntelSubgroupAVCImeResultDualReferenceStreamout\"", var"c\"CXType_OCLIntelSubgroupAVCImeSingleReferenceStreamin\"", var"c\"CXType_OCLIntelSubgroupAVCImeDualReferenceStreamin\"", var"c\"CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout\"", var"c\"CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout\"", var"c\"CXType_OCLIntelSubgroupAVCImeSingleRefStreamin\"", var"c\"CXType_OCLIntelSubgroupAVCImeDualRefStreamin\"", var"c\"CXType_ExtVector\"", var"c\"CXType_Atomic\"", var"c\"CXType_BTFTagAttributed\""
        export CXTypeKind, CXType_Invalid, CXType_Unexposed, CXType_Void, CXType_Bool, CXType_Char_U, CXType_UChar, CXType_Char16, CXType_Char32, CXType_UShort, CXType_UInt, CXType_ULong, CXType_ULongLong, CXType_UInt128, CXType_Char_S, CXType_SChar, CXType_WChar, CXType_Short, CXType_Int, CXType_Long, CXType_LongLong, CXType_Int128, CXType_Float, CXType_Double, CXType_LongDouble, CXType_NullPtr, CXType_Overload, CXType_Dependent, CXType_ObjCId, CXType_ObjCClass, CXType_ObjCSel, CXType_Float128, CXType_Half, CXType_Float16, CXType_ShortAccum, CXType_Accum, CXType_LongAccum, CXType_UShortAccum, CXType_UAccum, CXType_ULongAccum, CXType_BFloat16, CXType_Ibm128, CXType_FirstBuiltin, CXType_LastBuiltin, CXType_Complex, CXType_Pointer, CXType_BlockPointer, CXType_LValueReference, CXType_RValueReference, CXType_Record, CXType_Enum, CXType_Typedef, CXType_ObjCInterface, CXType_ObjCObjectPointer, CXType_FunctionNoProto, CXType_FunctionProto, CXType_ConstantArray, CXType_Vector, CXType_IncompleteArray, CXType_VariableArray, CXType_DependentSizedArray, CXType_MemberPointer, CXType_Auto, CXType_Elaborated, CXType_Pipe, CXType_OCLImage1dRO, CXType_OCLImage1dArrayRO, CXType_OCLImage1dBufferRO, CXType_OCLImage2dRO, CXType_OCLImage2dArrayRO, CXType_OCLImage2dDepthRO, CXType_OCLImage2dArrayDepthRO, CXType_OCLImage2dMSAARO, CXType_OCLImage2dArrayMSAARO, CXType_OCLImage2dMSAADepthRO, CXType_OCLImage2dArrayMSAADepthRO, CXType_OCLImage3dRO, CXType_OCLImage1dWO, CXType_OCLImage1dArrayWO, CXType_OCLImage1dBufferWO, CXType_OCLImage2dWO, CXType_OCLImage2dArrayWO, CXType_OCLImage2dDepthWO, CXType_OCLImage2dArrayDepthWO, CXType_OCLImage2dMSAAWO, CXType_OCLImage2dArrayMSAAWO, CXType_OCLImage2dMSAADepthWO, CXType_OCLImage2dArrayMSAADepthWO, CXType_OCLImage3dWO, CXType_OCLImage1dRW, CXType_OCLImage1dArrayRW, CXType_OCLImage1dBufferRW, CXType_OCLImage2dRW, CXType_OCLImage2dArrayRW, CXType_OCLImage2dDepthRW, CXType_OCLImage2dArrayDepthRW, CXType_OCLImage2dMSAARW, CXType_OCLImage2dArrayMSAARW, CXType_OCLImage2dMSAADepthRW, CXType_OCLImage2dArrayMSAADepthRW, CXType_OCLImage3dRW, CXType_OCLSampler, CXType_OCLEvent, CXType_OCLQueue, CXType_OCLReserveID, CXType_ObjCObject, CXType_ObjCTypeParam, CXType_Attributed, CXType_OCLIntelSubgroupAVCMcePayload, CXType_OCLIntelSubgroupAVCImePayload, CXType_OCLIntelSubgroupAVCRefPayload, CXType_OCLIntelSubgroupAVCSicPayload, CXType_OCLIntelSubgroupAVCMceResult, CXType_OCLIntelSubgroupAVCImeResult, CXType_OCLIntelSubgroupAVCRefResult, CXType_OCLIntelSubgroupAVCSicResult, CXType_OCLIntelSubgroupAVCImeResultSingleReferenceStreamout, CXType_OCLIntelSubgroupAVCImeResultDualReferenceStreamout, CXType_OCLIntelSubgroupAVCImeSingleReferenceStreamin, CXType_OCLIntelSubgroupAVCImeDualReferenceStreamin, CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout, CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout, CXType_OCLIntelSubgroupAVCImeSingleRefStreamin, CXType_OCLIntelSubgroupAVCImeDualRefStreamin, CXType_ExtVector, CXType_Atomic, CXType_BTFTagAttributed
        var"c\"enum CXTypeKind\""
        abstract type var"c\"enum CXCallingConv\"" <: Cenum end
        const CXCallingConv = var"c\"enum CXCallingConv\""
        export var"c\"enum CXCallingConv\""
        export CXCallingConv
        var"c\"enum CXCallingConv\""
        primitive type var"(c\"enum CXCallingConv\")" <: var"c\"enum CXCallingConv\"" 32 end
        (::(Type){var"(c\"enum CXCallingConv\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCallingConv\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCallingConv\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXCallingConv_Default\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXCallingConv_C\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCallingConv_X86StdCall\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXCallingConv_X86FastCall\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXCallingConv_X86ThisCall\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXCallingConv_X86Pascal\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXCallingConv_AAPCS\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXCallingConv_AAPCS_VFP\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXCallingConv_X86RegCall\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXCallingConv_IntelOclBicc\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXCallingConv_Win64\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXCallingConv_X86_64Win64\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXCallingConv_X86_64SysV\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXCallingConv_X86VectorCall\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXCallingConv_Swift\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXCallingConv_PreserveMost\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXCallingConv_PreserveAll\""), 0x000000000000000f}, CBinding.Tuple{Symbol("c\"CXCallingConv_AArch64VectorCall\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXCallingConv_SwiftAsync\""), 0x0000000000000011}, CBinding.Tuple{Symbol("c\"CXCallingConv_AArch64SVEPCS\""), 0x0000000000000012}, CBinding.Tuple{Symbol("c\"CXCallingConv_M68kRTD\""), 0x0000000000000013}, CBinding.Tuple{Symbol("c\"CXCallingConv_Invalid\""), 0x0000000000000064}, CBinding.Tuple{Symbol("c\"CXCallingConv_Unexposed\""), 0x00000000000000c8}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCallingConv\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCallingConv\")"}) = begin
                var"(c\"enum CXCallingConv\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCallingConv\""}) = begin
                var"(c\"enum CXCallingConv\")"
            end
        const var"c\"CXCallingConv_Default\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000000)
        const var"c\"CXCallingConv_C\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000001)
        const var"c\"CXCallingConv_X86StdCall\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000002)
        const var"c\"CXCallingConv_X86FastCall\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000003)
        const var"c\"CXCallingConv_X86ThisCall\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000004)
        const var"c\"CXCallingConv_X86Pascal\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000005)
        const var"c\"CXCallingConv_AAPCS\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000006)
        const var"c\"CXCallingConv_AAPCS_VFP\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000007)
        const var"c\"CXCallingConv_X86RegCall\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000008)
        const var"c\"CXCallingConv_IntelOclBicc\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000009)
        const var"c\"CXCallingConv_Win64\"" = var"(c\"enum CXCallingConv\")"(0x000000000000000a)
        const var"c\"CXCallingConv_X86_64Win64\"" = var"(c\"enum CXCallingConv\")"(0x000000000000000a)
        const var"c\"CXCallingConv_X86_64SysV\"" = var"(c\"enum CXCallingConv\")"(0x000000000000000b)
        const var"c\"CXCallingConv_X86VectorCall\"" = var"(c\"enum CXCallingConv\")"(0x000000000000000c)
        const var"c\"CXCallingConv_Swift\"" = var"(c\"enum CXCallingConv\")"(0x000000000000000d)
        const var"c\"CXCallingConv_PreserveMost\"" = var"(c\"enum CXCallingConv\")"(0x000000000000000e)
        const var"c\"CXCallingConv_PreserveAll\"" = var"(c\"enum CXCallingConv\")"(0x000000000000000f)
        const var"c\"CXCallingConv_AArch64VectorCall\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000010)
        const var"c\"CXCallingConv_SwiftAsync\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000011)
        const var"c\"CXCallingConv_AArch64SVEPCS\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000012)
        const var"c\"CXCallingConv_M68kRTD\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000013)
        const var"c\"CXCallingConv_Invalid\"" = var"(c\"enum CXCallingConv\")"(0x0000000000000064)
        const var"c\"CXCallingConv_Unexposed\"" = var"(c\"enum CXCallingConv\")"(0x00000000000000c8)
        const CXCallingConv = var"c\"enum CXCallingConv\""
        const CXCallingConv_Default = var"c\"CXCallingConv_Default\""
        const CXCallingConv_C = var"c\"CXCallingConv_C\""
        const CXCallingConv_X86StdCall = var"c\"CXCallingConv_X86StdCall\""
        const CXCallingConv_X86FastCall = var"c\"CXCallingConv_X86FastCall\""
        const CXCallingConv_X86ThisCall = var"c\"CXCallingConv_X86ThisCall\""
        const CXCallingConv_X86Pascal = var"c\"CXCallingConv_X86Pascal\""
        const CXCallingConv_AAPCS = var"c\"CXCallingConv_AAPCS\""
        const CXCallingConv_AAPCS_VFP = var"c\"CXCallingConv_AAPCS_VFP\""
        const CXCallingConv_X86RegCall = var"c\"CXCallingConv_X86RegCall\""
        const CXCallingConv_IntelOclBicc = var"c\"CXCallingConv_IntelOclBicc\""
        const CXCallingConv_Win64 = var"c\"CXCallingConv_Win64\""
        const CXCallingConv_X86_64Win64 = var"c\"CXCallingConv_X86_64Win64\""
        const CXCallingConv_X86_64SysV = var"c\"CXCallingConv_X86_64SysV\""
        const CXCallingConv_X86VectorCall = var"c\"CXCallingConv_X86VectorCall\""
        const CXCallingConv_Swift = var"c\"CXCallingConv_Swift\""
        const CXCallingConv_PreserveMost = var"c\"CXCallingConv_PreserveMost\""
        const CXCallingConv_PreserveAll = var"c\"CXCallingConv_PreserveAll\""
        const CXCallingConv_AArch64VectorCall = var"c\"CXCallingConv_AArch64VectorCall\""
        const CXCallingConv_SwiftAsync = var"c\"CXCallingConv_SwiftAsync\""
        const CXCallingConv_AArch64SVEPCS = var"c\"CXCallingConv_AArch64SVEPCS\""
        const CXCallingConv_M68kRTD = var"c\"CXCallingConv_M68kRTD\""
        const CXCallingConv_Invalid = var"c\"CXCallingConv_Invalid\""
        const CXCallingConv_Unexposed = var"c\"CXCallingConv_Unexposed\""
        export var"c\"enum CXCallingConv\"", var"(c\"enum CXCallingConv\")", var"c\"CXCallingConv_Default\"", var"c\"CXCallingConv_C\"", var"c\"CXCallingConv_X86StdCall\"", var"c\"CXCallingConv_X86FastCall\"", var"c\"CXCallingConv_X86ThisCall\"", var"c\"CXCallingConv_X86Pascal\"", var"c\"CXCallingConv_AAPCS\"", var"c\"CXCallingConv_AAPCS_VFP\"", var"c\"CXCallingConv_X86RegCall\"", var"c\"CXCallingConv_IntelOclBicc\"", var"c\"CXCallingConv_Win64\"", var"c\"CXCallingConv_X86_64Win64\"", var"c\"CXCallingConv_X86_64SysV\"", var"c\"CXCallingConv_X86VectorCall\"", var"c\"CXCallingConv_Swift\"", var"c\"CXCallingConv_PreserveMost\"", var"c\"CXCallingConv_PreserveAll\"", var"c\"CXCallingConv_AArch64VectorCall\"", var"c\"CXCallingConv_SwiftAsync\"", var"c\"CXCallingConv_AArch64SVEPCS\"", var"c\"CXCallingConv_M68kRTD\"", var"c\"CXCallingConv_Invalid\"", var"c\"CXCallingConv_Unexposed\""
        export CXCallingConv, CXCallingConv_Default, CXCallingConv_C, CXCallingConv_X86StdCall, CXCallingConv_X86FastCall, CXCallingConv_X86ThisCall, CXCallingConv_X86Pascal, CXCallingConv_AAPCS, CXCallingConv_AAPCS_VFP, CXCallingConv_X86RegCall, CXCallingConv_IntelOclBicc, CXCallingConv_Win64, CXCallingConv_X86_64Win64, CXCallingConv_X86_64SysV, CXCallingConv_X86VectorCall, CXCallingConv_Swift, CXCallingConv_PreserveMost, CXCallingConv_PreserveAll, CXCallingConv_AArch64VectorCall, CXCallingConv_SwiftAsync, CXCallingConv_AArch64SVEPCS, CXCallingConv_M68kRTD, CXCallingConv_Invalid, CXCallingConv_Unexposed
        var"c\"enum CXCallingConv\""
        abstract type var"c\"CXType\"" <: Cstruct end
        const CXType = var"c\"CXType\""
        export var"c\"CXType\""
        export CXType
        var"c\"CXType\""
        struct var"(c\"CXType\")" <: var"c\"CXType\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXType\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXType\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:kind, CBinding.Tuple{var"c\"enum CXTypeKind\"", CBinding.bitstype(var"c\"enum CXTypeKind\""), CBinding.integraltype(var"c\"enum CXTypeKind\""), 0, 0, -1}}, CBinding.Tuple{:data, CBinding.Tuple{CBinding.Carray{CBinding.Cptr{CBinding.Cvoid}, 2}, CBinding.bitstype(CBinding.Carray{CBinding.Cptr{CBinding.Cvoid}, 2}), CBinding.integraltype(CBinding.Carray{CBinding.Cptr{CBinding.Cvoid}, 2}), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXType\")"}) = begin
                var"(c\"CXType\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXType\""}) = begin
                var"(c\"CXType\")"
            end
        const CXType = var"c\"CXType\""
        export var"c\"CXType\"", var"(c\"CXType\")"
        export CXType
        var"c\"CXType\""
        struct Cbinding_clang_getCursorType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorType}
        end
        const var"c\"clang_getCursorType\"" = Cbinding_clang_getCursorType{:clang_getCursorType}()
        (func::Cbinding_clang_getCursorType)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getCursorType = var"c\"clang_getCursorType\""
        export var"c\"clang_getCursorType\""
        export clang_getCursorType
        var"c\"clang_getCursorType\""
        struct Cbinding_clang_getTypeSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getTypeSpelling}
        end
        const var"c\"clang_getTypeSpelling\"" = Cbinding_clang_getTypeSpelling{:clang_getTypeSpelling}()
        (func::Cbinding_clang_getTypeSpelling)(var"c\"CT\"") = begin
                CBinding.funccall(func, var"c\"CT\"")
            end
        const clang_getTypeSpelling = var"c\"clang_getTypeSpelling\""
        export var"c\"clang_getTypeSpelling\""
        export clang_getTypeSpelling
        var"c\"clang_getTypeSpelling\""
        struct Cbinding_clang_getTypedefDeclUnderlyingType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getTypedefDeclUnderlyingType}
        end
        const var"c\"clang_getTypedefDeclUnderlyingType\"" = Cbinding_clang_getTypedefDeclUnderlyingType{:clang_getTypedefDeclUnderlyingType}()
        (func::Cbinding_clang_getTypedefDeclUnderlyingType)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getTypedefDeclUnderlyingType = var"c\"clang_getTypedefDeclUnderlyingType\""
        export var"c\"clang_getTypedefDeclUnderlyingType\""
        export clang_getTypedefDeclUnderlyingType
        var"c\"clang_getTypedefDeclUnderlyingType\""
        struct Cbinding_clang_getEnumDeclIntegerType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getEnumDeclIntegerType}
        end
        const var"c\"clang_getEnumDeclIntegerType\"" = Cbinding_clang_getEnumDeclIntegerType{:clang_getEnumDeclIntegerType}()
        (func::Cbinding_clang_getEnumDeclIntegerType)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getEnumDeclIntegerType = var"c\"clang_getEnumDeclIntegerType\""
        export var"c\"clang_getEnumDeclIntegerType\""
        export clang_getEnumDeclIntegerType
        var"c\"clang_getEnumDeclIntegerType\""
        struct Cbinding_clang_getEnumConstantDeclValue{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getEnumConstantDeclValue}
        end
        const var"c\"clang_getEnumConstantDeclValue\"" = Cbinding_clang_getEnumConstantDeclValue{:clang_getEnumConstantDeclValue}()
        (func::Cbinding_clang_getEnumConstantDeclValue)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getEnumConstantDeclValue = var"c\"clang_getEnumConstantDeclValue\""
        export var"c\"clang_getEnumConstantDeclValue\""
        export clang_getEnumConstantDeclValue
        var"c\"clang_getEnumConstantDeclValue\""
        struct Cbinding_clang_getEnumConstantDeclUnsignedValue{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Culonglong, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getEnumConstantDeclUnsignedValue}
        end
        const var"c\"clang_getEnumConstantDeclUnsignedValue\"" = Cbinding_clang_getEnumConstantDeclUnsignedValue{:clang_getEnumConstantDeclUnsignedValue}()
        (func::Cbinding_clang_getEnumConstantDeclUnsignedValue)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getEnumConstantDeclUnsignedValue = var"c\"clang_getEnumConstantDeclUnsignedValue\""
        export var"c\"clang_getEnumConstantDeclUnsignedValue\""
        export clang_getEnumConstantDeclUnsignedValue
        var"c\"clang_getEnumConstantDeclUnsignedValue\""
        struct Cbinding_clang_Cursor_isBitField{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isBitField}
        end
        const var"c\"clang_Cursor_isBitField\"" = Cbinding_clang_Cursor_isBitField{:clang_Cursor_isBitField}()
        (func::Cbinding_clang_Cursor_isBitField)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isBitField = var"c\"clang_Cursor_isBitField\""
        export var"c\"clang_Cursor_isBitField\""
        export clang_Cursor_isBitField
        var"c\"clang_Cursor_isBitField\""
        struct Cbinding_clang_getFieldDeclBitWidth{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getFieldDeclBitWidth}
        end
        const var"c\"clang_getFieldDeclBitWidth\"" = Cbinding_clang_getFieldDeclBitWidth{:clang_getFieldDeclBitWidth}()
        (func::Cbinding_clang_getFieldDeclBitWidth)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getFieldDeclBitWidth = var"c\"clang_getFieldDeclBitWidth\""
        export var"c\"clang_getFieldDeclBitWidth\""
        export clang_getFieldDeclBitWidth
        var"c\"clang_getFieldDeclBitWidth\""
        struct Cbinding_clang_Cursor_getNumArguments{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getNumArguments}
        end
        const var"c\"clang_Cursor_getNumArguments\"" = Cbinding_clang_Cursor_getNumArguments{:clang_Cursor_getNumArguments}()
        (func::Cbinding_clang_Cursor_getNumArguments)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getNumArguments = var"c\"clang_Cursor_getNumArguments\""
        export var"c\"clang_Cursor_getNumArguments\""
        export clang_Cursor_getNumArguments
        var"c\"clang_Cursor_getNumArguments\""
        struct Cbinding_clang_Cursor_getArgument{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Cursor_getArgument}
        end
        const var"c\"clang_Cursor_getArgument\"" = Cbinding_clang_Cursor_getArgument{:clang_Cursor_getArgument}()
        (func::Cbinding_clang_Cursor_getArgument)(var"c\"C\"", var"c\"i\"") = begin
                CBinding.funccall(func, var"c\"C\"", var"c\"i\"")
            end
        const clang_Cursor_getArgument = var"c\"clang_Cursor_getArgument\""
        export var"c\"clang_Cursor_getArgument\""
        export clang_Cursor_getArgument
        var"c\"clang_Cursor_getArgument\""
        abstract type var"c\"enum CXTemplateArgumentKind\"" <: Cenum end
        const CXTemplateArgumentKind = var"c\"enum CXTemplateArgumentKind\""
        export var"c\"enum CXTemplateArgumentKind\""
        export CXTemplateArgumentKind
        var"c\"enum CXTemplateArgumentKind\""
        primitive type var"(c\"enum CXTemplateArgumentKind\")" <: var"c\"enum CXTemplateArgumentKind\"" 32 end
        (::(Type){var"(c\"enum CXTemplateArgumentKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXTemplateArgumentKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXTemplateArgumentKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_Null\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_Type\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_Declaration\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_NullPtr\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_Integral\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_Template\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_TemplateExpansion\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_Expression\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_Pack\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXTemplateArgumentKind_Invalid\""), 0x0000000000000009}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXTemplateArgumentKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXTemplateArgumentKind\")"}) = begin
                var"(c\"enum CXTemplateArgumentKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXTemplateArgumentKind\""}) = begin
                var"(c\"enum CXTemplateArgumentKind\")"
            end
        const var"c\"CXTemplateArgumentKind_Null\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000000)
        const var"c\"CXTemplateArgumentKind_Type\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000001)
        const var"c\"CXTemplateArgumentKind_Declaration\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000002)
        const var"c\"CXTemplateArgumentKind_NullPtr\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000003)
        const var"c\"CXTemplateArgumentKind_Integral\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000004)
        const var"c\"CXTemplateArgumentKind_Template\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000005)
        const var"c\"CXTemplateArgumentKind_TemplateExpansion\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000006)
        const var"c\"CXTemplateArgumentKind_Expression\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000007)
        const var"c\"CXTemplateArgumentKind_Pack\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000008)
        const var"c\"CXTemplateArgumentKind_Invalid\"" = var"(c\"enum CXTemplateArgumentKind\")"(0x0000000000000009)
        const CXTemplateArgumentKind = var"c\"enum CXTemplateArgumentKind\""
        const CXTemplateArgumentKind_Null = var"c\"CXTemplateArgumentKind_Null\""
        const CXTemplateArgumentKind_Type = var"c\"CXTemplateArgumentKind_Type\""
        const CXTemplateArgumentKind_Declaration = var"c\"CXTemplateArgumentKind_Declaration\""
        const CXTemplateArgumentKind_NullPtr = var"c\"CXTemplateArgumentKind_NullPtr\""
        const CXTemplateArgumentKind_Integral = var"c\"CXTemplateArgumentKind_Integral\""
        const CXTemplateArgumentKind_Template = var"c\"CXTemplateArgumentKind_Template\""
        const CXTemplateArgumentKind_TemplateExpansion = var"c\"CXTemplateArgumentKind_TemplateExpansion\""
        const CXTemplateArgumentKind_Expression = var"c\"CXTemplateArgumentKind_Expression\""
        const CXTemplateArgumentKind_Pack = var"c\"CXTemplateArgumentKind_Pack\""
        const CXTemplateArgumentKind_Invalid = var"c\"CXTemplateArgumentKind_Invalid\""
        export var"c\"enum CXTemplateArgumentKind\"", var"(c\"enum CXTemplateArgumentKind\")", var"c\"CXTemplateArgumentKind_Null\"", var"c\"CXTemplateArgumentKind_Type\"", var"c\"CXTemplateArgumentKind_Declaration\"", var"c\"CXTemplateArgumentKind_NullPtr\"", var"c\"CXTemplateArgumentKind_Integral\"", var"c\"CXTemplateArgumentKind_Template\"", var"c\"CXTemplateArgumentKind_TemplateExpansion\"", var"c\"CXTemplateArgumentKind_Expression\"", var"c\"CXTemplateArgumentKind_Pack\"", var"c\"CXTemplateArgumentKind_Invalid\""
        export CXTemplateArgumentKind, CXTemplateArgumentKind_Null, CXTemplateArgumentKind_Type, CXTemplateArgumentKind_Declaration, CXTemplateArgumentKind_NullPtr, CXTemplateArgumentKind_Integral, CXTemplateArgumentKind_Template, CXTemplateArgumentKind_TemplateExpansion, CXTemplateArgumentKind_Expression, CXTemplateArgumentKind_Pack, CXTemplateArgumentKind_Invalid
        var"c\"enum CXTemplateArgumentKind\""
        struct Cbinding_clang_Cursor_getNumTemplateArguments{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getNumTemplateArguments}
        end
        const var"c\"clang_Cursor_getNumTemplateArguments\"" = Cbinding_clang_Cursor_getNumTemplateArguments{:clang_Cursor_getNumTemplateArguments}()
        (func::Cbinding_clang_Cursor_getNumTemplateArguments)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getNumTemplateArguments = var"c\"clang_Cursor_getNumTemplateArguments\""
        export var"c\"clang_Cursor_getNumTemplateArguments\""
        export clang_Cursor_getNumTemplateArguments
        var"c\"clang_Cursor_getNumTemplateArguments\""
        struct Cbinding_clang_Cursor_getTemplateArgumentKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXTemplateArgumentKind\"", CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Cursor_getTemplateArgumentKind}
        end
        const var"c\"clang_Cursor_getTemplateArgumentKind\"" = Cbinding_clang_Cursor_getTemplateArgumentKind{:clang_Cursor_getTemplateArgumentKind}()
        (func::Cbinding_clang_Cursor_getTemplateArgumentKind)(var"c\"C\"", var"c\"I\"") = begin
                CBinding.funccall(func, var"c\"C\"", var"c\"I\"")
            end
        const clang_Cursor_getTemplateArgumentKind = var"c\"clang_Cursor_getTemplateArgumentKind\""
        export var"c\"clang_Cursor_getTemplateArgumentKind\""
        export clang_Cursor_getTemplateArgumentKind
        var"c\"clang_Cursor_getTemplateArgumentKind\""
        struct Cbinding_clang_Cursor_getTemplateArgumentType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Cursor_getTemplateArgumentType}
        end
        const var"c\"clang_Cursor_getTemplateArgumentType\"" = Cbinding_clang_Cursor_getTemplateArgumentType{:clang_Cursor_getTemplateArgumentType}()
        (func::Cbinding_clang_Cursor_getTemplateArgumentType)(var"c\"C\"", var"c\"I\"") = begin
                CBinding.funccall(func, var"c\"C\"", var"c\"I\"")
            end
        const clang_Cursor_getTemplateArgumentType = var"c\"clang_Cursor_getTemplateArgumentType\""
        export var"c\"clang_Cursor_getTemplateArgumentType\""
        export clang_Cursor_getTemplateArgumentType
        var"c\"clang_Cursor_getTemplateArgumentType\""
        struct Cbinding_clang_Cursor_getTemplateArgumentValue{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Cursor_getTemplateArgumentValue}
        end
        const var"c\"clang_Cursor_getTemplateArgumentValue\"" = Cbinding_clang_Cursor_getTemplateArgumentValue{:clang_Cursor_getTemplateArgumentValue}()
        (func::Cbinding_clang_Cursor_getTemplateArgumentValue)(var"c\"C\"", var"c\"I\"") = begin
                CBinding.funccall(func, var"c\"C\"", var"c\"I\"")
            end
        const clang_Cursor_getTemplateArgumentValue = var"c\"clang_Cursor_getTemplateArgumentValue\""
        export var"c\"clang_Cursor_getTemplateArgumentValue\""
        export clang_Cursor_getTemplateArgumentValue
        var"c\"clang_Cursor_getTemplateArgumentValue\""
        struct Cbinding_clang_Cursor_getTemplateArgumentUnsignedValue{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Culonglong, CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Cursor_getTemplateArgumentUnsignedValue}
        end
        const var"c\"clang_Cursor_getTemplateArgumentUnsignedValue\"" = Cbinding_clang_Cursor_getTemplateArgumentUnsignedValue{:clang_Cursor_getTemplateArgumentUnsignedValue}()
        (func::Cbinding_clang_Cursor_getTemplateArgumentUnsignedValue)(var"c\"C\"", var"c\"I\"") = begin
                CBinding.funccall(func, var"c\"C\"", var"c\"I\"")
            end
        const clang_Cursor_getTemplateArgumentUnsignedValue = var"c\"clang_Cursor_getTemplateArgumentUnsignedValue\""
        export var"c\"clang_Cursor_getTemplateArgumentUnsignedValue\""
        export clang_Cursor_getTemplateArgumentUnsignedValue
        var"c\"clang_Cursor_getTemplateArgumentUnsignedValue\""
        struct Cbinding_clang_equalTypes{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\"", var"c\"CXType\""}, :cdecl}, libpath, :clang_equalTypes}
        end
        const var"c\"clang_equalTypes\"" = Cbinding_clang_equalTypes{:clang_equalTypes}()
        (func::Cbinding_clang_equalTypes)(var"c\"A\"", var"c\"B\"") = begin
                CBinding.funccall(func, var"c\"A\"", var"c\"B\"")
            end
        const clang_equalTypes = var"c\"clang_equalTypes\""
        export var"c\"clang_equalTypes\""
        export clang_equalTypes
        var"c\"clang_equalTypes\""
        struct Cbinding_clang_getCanonicalType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getCanonicalType}
        end
        const var"c\"clang_getCanonicalType\"" = Cbinding_clang_getCanonicalType{:clang_getCanonicalType}()
        (func::Cbinding_clang_getCanonicalType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getCanonicalType = var"c\"clang_getCanonicalType\""
        export var"c\"clang_getCanonicalType\""
        export clang_getCanonicalType
        var"c\"clang_getCanonicalType\""
        struct Cbinding_clang_isConstQualifiedType{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_isConstQualifiedType}
        end
        const var"c\"clang_isConstQualifiedType\"" = Cbinding_clang_isConstQualifiedType{:clang_isConstQualifiedType}()
        (func::Cbinding_clang_isConstQualifiedType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_isConstQualifiedType = var"c\"clang_isConstQualifiedType\""
        export var"c\"clang_isConstQualifiedType\""
        export clang_isConstQualifiedType
        var"c\"clang_isConstQualifiedType\""
        struct Cbinding_clang_Cursor_isMacroFunctionLike{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isMacroFunctionLike}
        end
        const var"c\"clang_Cursor_isMacroFunctionLike\"" = Cbinding_clang_Cursor_isMacroFunctionLike{:clang_Cursor_isMacroFunctionLike}()
        (func::Cbinding_clang_Cursor_isMacroFunctionLike)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isMacroFunctionLike = var"c\"clang_Cursor_isMacroFunctionLike\""
        export var"c\"clang_Cursor_isMacroFunctionLike\""
        export clang_Cursor_isMacroFunctionLike
        var"c\"clang_Cursor_isMacroFunctionLike\""
        struct Cbinding_clang_Cursor_isMacroBuiltin{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isMacroBuiltin}
        end
        const var"c\"clang_Cursor_isMacroBuiltin\"" = Cbinding_clang_Cursor_isMacroBuiltin{:clang_Cursor_isMacroBuiltin}()
        (func::Cbinding_clang_Cursor_isMacroBuiltin)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isMacroBuiltin = var"c\"clang_Cursor_isMacroBuiltin\""
        export var"c\"clang_Cursor_isMacroBuiltin\""
        export clang_Cursor_isMacroBuiltin
        var"c\"clang_Cursor_isMacroBuiltin\""
        struct Cbinding_clang_Cursor_isFunctionInlined{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isFunctionInlined}
        end
        const var"c\"clang_Cursor_isFunctionInlined\"" = Cbinding_clang_Cursor_isFunctionInlined{:clang_Cursor_isFunctionInlined}()
        (func::Cbinding_clang_Cursor_isFunctionInlined)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isFunctionInlined = var"c\"clang_Cursor_isFunctionInlined\""
        export var"c\"clang_Cursor_isFunctionInlined\""
        export clang_Cursor_isFunctionInlined
        var"c\"clang_Cursor_isFunctionInlined\""
        struct Cbinding_clang_isVolatileQualifiedType{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_isVolatileQualifiedType}
        end
        const var"c\"clang_isVolatileQualifiedType\"" = Cbinding_clang_isVolatileQualifiedType{:clang_isVolatileQualifiedType}()
        (func::Cbinding_clang_isVolatileQualifiedType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_isVolatileQualifiedType = var"c\"clang_isVolatileQualifiedType\""
        export var"c\"clang_isVolatileQualifiedType\""
        export clang_isVolatileQualifiedType
        var"c\"clang_isVolatileQualifiedType\""
        struct Cbinding_clang_isRestrictQualifiedType{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_isRestrictQualifiedType}
        end
        const var"c\"clang_isRestrictQualifiedType\"" = Cbinding_clang_isRestrictQualifiedType{:clang_isRestrictQualifiedType}()
        (func::Cbinding_clang_isRestrictQualifiedType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_isRestrictQualifiedType = var"c\"clang_isRestrictQualifiedType\""
        export var"c\"clang_isRestrictQualifiedType\""
        export clang_isRestrictQualifiedType
        var"c\"clang_isRestrictQualifiedType\""
        struct Cbinding_clang_getAddressSpace{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getAddressSpace}
        end
        const var"c\"clang_getAddressSpace\"" = Cbinding_clang_getAddressSpace{:clang_getAddressSpace}()
        (func::Cbinding_clang_getAddressSpace)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getAddressSpace = var"c\"clang_getAddressSpace\""
        export var"c\"clang_getAddressSpace\""
        export clang_getAddressSpace
        var"c\"clang_getAddressSpace\""
        struct Cbinding_clang_getTypedefName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getTypedefName}
        end
        const var"c\"clang_getTypedefName\"" = Cbinding_clang_getTypedefName{:clang_getTypedefName}()
        (func::Cbinding_clang_getTypedefName)(var"c\"CT\"") = begin
                CBinding.funccall(func, var"c\"CT\"")
            end
        const clang_getTypedefName = var"c\"clang_getTypedefName\""
        export var"c\"clang_getTypedefName\""
        export clang_getTypedefName
        var"c\"clang_getTypedefName\""
        struct Cbinding_clang_getPointeeType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getPointeeType}
        end
        const var"c\"clang_getPointeeType\"" = Cbinding_clang_getPointeeType{:clang_getPointeeType}()
        (func::Cbinding_clang_getPointeeType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getPointeeType = var"c\"clang_getPointeeType\""
        export var"c\"clang_getPointeeType\""
        export clang_getPointeeType
        var"c\"clang_getPointeeType\""
        struct Cbinding_clang_getUnqualifiedType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getUnqualifiedType}
        end
        const var"c\"clang_getUnqualifiedType\"" = Cbinding_clang_getUnqualifiedType{:clang_getUnqualifiedType}()
        (func::Cbinding_clang_getUnqualifiedType)(var"c\"CT\"") = begin
                CBinding.funccall(func, var"c\"CT\"")
            end
        const clang_getUnqualifiedType = var"c\"clang_getUnqualifiedType\""
        export var"c\"clang_getUnqualifiedType\""
        export clang_getUnqualifiedType
        var"c\"clang_getUnqualifiedType\""
        struct Cbinding_clang_getNonReferenceType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getNonReferenceType}
        end
        const var"c\"clang_getNonReferenceType\"" = Cbinding_clang_getNonReferenceType{:clang_getNonReferenceType}()
        (func::Cbinding_clang_getNonReferenceType)(var"c\"CT\"") = begin
                CBinding.funccall(func, var"c\"CT\"")
            end
        const clang_getNonReferenceType = var"c\"clang_getNonReferenceType\""
        export var"c\"clang_getNonReferenceType\""
        export clang_getNonReferenceType
        var"c\"clang_getNonReferenceType\""
        struct Cbinding_clang_getTypeDeclaration{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getTypeDeclaration}
        end
        const var"c\"clang_getTypeDeclaration\"" = Cbinding_clang_getTypeDeclaration{:clang_getTypeDeclaration}()
        (func::Cbinding_clang_getTypeDeclaration)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getTypeDeclaration = var"c\"clang_getTypeDeclaration\""
        export var"c\"clang_getTypeDeclaration\""
        export clang_getTypeDeclaration
        var"c\"clang_getTypeDeclaration\""
        struct Cbinding_clang_getDeclObjCTypeEncoding{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getDeclObjCTypeEncoding}
        end
        const var"c\"clang_getDeclObjCTypeEncoding\"" = Cbinding_clang_getDeclObjCTypeEncoding{:clang_getDeclObjCTypeEncoding}()
        (func::Cbinding_clang_getDeclObjCTypeEncoding)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getDeclObjCTypeEncoding = var"c\"clang_getDeclObjCTypeEncoding\""
        export var"c\"clang_getDeclObjCTypeEncoding\""
        export clang_getDeclObjCTypeEncoding
        var"c\"clang_getDeclObjCTypeEncoding\""
        struct Cbinding_clang_Type_getObjCEncoding{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getObjCEncoding}
        end
        const var"c\"clang_Type_getObjCEncoding\"" = Cbinding_clang_Type_getObjCEncoding{:clang_Type_getObjCEncoding}()
        (func::Cbinding_clang_Type_getObjCEncoding)(var"c\"type\"") = begin
                CBinding.funccall(func, var"c\"type\"")
            end
        const clang_Type_getObjCEncoding = var"c\"clang_Type_getObjCEncoding\""
        export var"c\"clang_Type_getObjCEncoding\""
        export clang_Type_getObjCEncoding
        var"c\"clang_Type_getObjCEncoding\""
        struct Cbinding_clang_getTypeKindSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"enum CXTypeKind\""}, :cdecl}, libpath, :clang_getTypeKindSpelling}
        end
        const var"c\"clang_getTypeKindSpelling\"" = Cbinding_clang_getTypeKindSpelling{:clang_getTypeKindSpelling}()
        (func::Cbinding_clang_getTypeKindSpelling)(var"c\"K\"") = begin
                CBinding.funccall(func, var"c\"K\"")
            end
        const clang_getTypeKindSpelling = var"c\"clang_getTypeKindSpelling\""
        export var"c\"clang_getTypeKindSpelling\""
        export clang_getTypeKindSpelling
        var"c\"clang_getTypeKindSpelling\""
        struct Cbinding_clang_getFunctionTypeCallingConv{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXCallingConv\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getFunctionTypeCallingConv}
        end
        const var"c\"clang_getFunctionTypeCallingConv\"" = Cbinding_clang_getFunctionTypeCallingConv{:clang_getFunctionTypeCallingConv}()
        (func::Cbinding_clang_getFunctionTypeCallingConv)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getFunctionTypeCallingConv = var"c\"clang_getFunctionTypeCallingConv\""
        export var"c\"clang_getFunctionTypeCallingConv\""
        export clang_getFunctionTypeCallingConv
        var"c\"clang_getFunctionTypeCallingConv\""
        struct Cbinding_clang_getResultType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getResultType}
        end
        const var"c\"clang_getResultType\"" = Cbinding_clang_getResultType{:clang_getResultType}()
        (func::Cbinding_clang_getResultType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getResultType = var"c\"clang_getResultType\""
        export var"c\"clang_getResultType\""
        export clang_getResultType
        var"c\"clang_getResultType\""
        struct Cbinding_clang_getExceptionSpecificationType{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getExceptionSpecificationType}
        end
        const var"c\"clang_getExceptionSpecificationType\"" = Cbinding_clang_getExceptionSpecificationType{:clang_getExceptionSpecificationType}()
        (func::Cbinding_clang_getExceptionSpecificationType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getExceptionSpecificationType = var"c\"clang_getExceptionSpecificationType\""
        export var"c\"clang_getExceptionSpecificationType\""
        export clang_getExceptionSpecificationType
        var"c\"clang_getExceptionSpecificationType\""
        struct Cbinding_clang_getNumArgTypes{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getNumArgTypes}
        end
        const var"c\"clang_getNumArgTypes\"" = Cbinding_clang_getNumArgTypes{:clang_getNumArgTypes}()
        (func::Cbinding_clang_getNumArgTypes)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getNumArgTypes = var"c\"clang_getNumArgTypes\""
        export var"c\"clang_getNumArgTypes\""
        export clang_getNumArgTypes
        var"c\"clang_getNumArgTypes\""
        struct Cbinding_clang_getArgType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getArgType}
        end
        const var"c\"clang_getArgType\"" = Cbinding_clang_getArgType{:clang_getArgType}()
        (func::Cbinding_clang_getArgType)(var"c\"T\"", var"c\"i\"") = begin
                CBinding.funccall(func, var"c\"T\"", var"c\"i\"")
            end
        const clang_getArgType = var"c\"clang_getArgType\""
        export var"c\"clang_getArgType\""
        export clang_getArgType
        var"c\"clang_getArgType\""
        struct Cbinding_clang_Type_getObjCObjectBaseType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getObjCObjectBaseType}
        end
        const var"c\"clang_Type_getObjCObjectBaseType\"" = Cbinding_clang_Type_getObjCObjectBaseType{:clang_Type_getObjCObjectBaseType}()
        (func::Cbinding_clang_Type_getObjCObjectBaseType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getObjCObjectBaseType = var"c\"clang_Type_getObjCObjectBaseType\""
        export var"c\"clang_Type_getObjCObjectBaseType\""
        export clang_Type_getObjCObjectBaseType
        var"c\"clang_Type_getObjCObjectBaseType\""
        struct Cbinding_clang_Type_getNumObjCProtocolRefs{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getNumObjCProtocolRefs}
        end
        const var"c\"clang_Type_getNumObjCProtocolRefs\"" = Cbinding_clang_Type_getNumObjCProtocolRefs{:clang_Type_getNumObjCProtocolRefs}()
        (func::Cbinding_clang_Type_getNumObjCProtocolRefs)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getNumObjCProtocolRefs = var"c\"clang_Type_getNumObjCProtocolRefs\""
        export var"c\"clang_Type_getNumObjCProtocolRefs\""
        export clang_Type_getNumObjCProtocolRefs
        var"c\"clang_Type_getNumObjCProtocolRefs\""
        struct Cbinding_clang_Type_getObjCProtocolDecl{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXType\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Type_getObjCProtocolDecl}
        end
        const var"c\"clang_Type_getObjCProtocolDecl\"" = Cbinding_clang_Type_getObjCProtocolDecl{:clang_Type_getObjCProtocolDecl}()
        (func::Cbinding_clang_Type_getObjCProtocolDecl)(var"c\"T\"", var"c\"i\"") = begin
                CBinding.funccall(func, var"c\"T\"", var"c\"i\"")
            end
        const clang_Type_getObjCProtocolDecl = var"c\"clang_Type_getObjCProtocolDecl\""
        export var"c\"clang_Type_getObjCProtocolDecl\""
        export clang_Type_getObjCProtocolDecl
        var"c\"clang_Type_getObjCProtocolDecl\""
        struct Cbinding_clang_Type_getNumObjCTypeArgs{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getNumObjCTypeArgs}
        end
        const var"c\"clang_Type_getNumObjCTypeArgs\"" = Cbinding_clang_Type_getNumObjCTypeArgs{:clang_Type_getNumObjCTypeArgs}()
        (func::Cbinding_clang_Type_getNumObjCTypeArgs)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getNumObjCTypeArgs = var"c\"clang_Type_getNumObjCTypeArgs\""
        export var"c\"clang_Type_getNumObjCTypeArgs\""
        export clang_Type_getNumObjCTypeArgs
        var"c\"clang_Type_getNumObjCTypeArgs\""
        struct Cbinding_clang_Type_getObjCTypeArg{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Type_getObjCTypeArg}
        end
        const var"c\"clang_Type_getObjCTypeArg\"" = Cbinding_clang_Type_getObjCTypeArg{:clang_Type_getObjCTypeArg}()
        (func::Cbinding_clang_Type_getObjCTypeArg)(var"c\"T\"", var"c\"i\"") = begin
                CBinding.funccall(func, var"c\"T\"", var"c\"i\"")
            end
        const clang_Type_getObjCTypeArg = var"c\"clang_Type_getObjCTypeArg\""
        export var"c\"clang_Type_getObjCTypeArg\""
        export clang_Type_getObjCTypeArg
        var"c\"clang_Type_getObjCTypeArg\""
        struct Cbinding_clang_isFunctionTypeVariadic{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_isFunctionTypeVariadic}
        end
        const var"c\"clang_isFunctionTypeVariadic\"" = Cbinding_clang_isFunctionTypeVariadic{:clang_isFunctionTypeVariadic}()
        (func::Cbinding_clang_isFunctionTypeVariadic)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_isFunctionTypeVariadic = var"c\"clang_isFunctionTypeVariadic\""
        export var"c\"clang_isFunctionTypeVariadic\""
        export clang_isFunctionTypeVariadic
        var"c\"clang_isFunctionTypeVariadic\""
        struct Cbinding_clang_getCursorResultType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorResultType}
        end
        const var"c\"clang_getCursorResultType\"" = Cbinding_clang_getCursorResultType{:clang_getCursorResultType}()
        (func::Cbinding_clang_getCursorResultType)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getCursorResultType = var"c\"clang_getCursorResultType\""
        export var"c\"clang_getCursorResultType\""
        export clang_getCursorResultType
        var"c\"clang_getCursorResultType\""
        struct Cbinding_clang_getCursorExceptionSpecificationType{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorExceptionSpecificationType}
        end
        const var"c\"clang_getCursorExceptionSpecificationType\"" = Cbinding_clang_getCursorExceptionSpecificationType{:clang_getCursorExceptionSpecificationType}()
        (func::Cbinding_clang_getCursorExceptionSpecificationType)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getCursorExceptionSpecificationType = var"c\"clang_getCursorExceptionSpecificationType\""
        export var"c\"clang_getCursorExceptionSpecificationType\""
        export clang_getCursorExceptionSpecificationType
        var"c\"clang_getCursorExceptionSpecificationType\""
        struct Cbinding_clang_isPODType{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_isPODType}
        end
        const var"c\"clang_isPODType\"" = Cbinding_clang_isPODType{:clang_isPODType}()
        (func::Cbinding_clang_isPODType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_isPODType = var"c\"clang_isPODType\""
        export var"c\"clang_isPODType\""
        export clang_isPODType
        var"c\"clang_isPODType\""
        struct Cbinding_clang_getElementType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getElementType}
        end
        const var"c\"clang_getElementType\"" = Cbinding_clang_getElementType{:clang_getElementType}()
        (func::Cbinding_clang_getElementType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getElementType = var"c\"clang_getElementType\""
        export var"c\"clang_getElementType\""
        export clang_getElementType
        var"c\"clang_getElementType\""
        struct Cbinding_clang_getNumElements{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getNumElements}
        end
        const var"c\"clang_getNumElements\"" = Cbinding_clang_getNumElements{:clang_getNumElements}()
        (func::Cbinding_clang_getNumElements)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getNumElements = var"c\"clang_getNumElements\""
        export var"c\"clang_getNumElements\""
        export clang_getNumElements
        var"c\"clang_getNumElements\""
        struct Cbinding_clang_getArrayElementType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getArrayElementType}
        end
        const var"c\"clang_getArrayElementType\"" = Cbinding_clang_getArrayElementType{:clang_getArrayElementType}()
        (func::Cbinding_clang_getArrayElementType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getArrayElementType = var"c\"clang_getArrayElementType\""
        export var"c\"clang_getArrayElementType\""
        export clang_getArrayElementType
        var"c\"clang_getArrayElementType\""
        struct Cbinding_clang_getArraySize{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_getArraySize}
        end
        const var"c\"clang_getArraySize\"" = Cbinding_clang_getArraySize{:clang_getArraySize}()
        (func::Cbinding_clang_getArraySize)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_getArraySize = var"c\"clang_getArraySize\""
        export var"c\"clang_getArraySize\""
        export clang_getArraySize
        var"c\"clang_getArraySize\""
        struct Cbinding_clang_Type_getNamedType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getNamedType}
        end
        const var"c\"clang_Type_getNamedType\"" = Cbinding_clang_Type_getNamedType{:clang_Type_getNamedType}()
        (func::Cbinding_clang_Type_getNamedType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getNamedType = var"c\"clang_Type_getNamedType\""
        export var"c\"clang_Type_getNamedType\""
        export clang_Type_getNamedType
        var"c\"clang_Type_getNamedType\""
        struct Cbinding_clang_Type_isTransparentTagTypedef{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_isTransparentTagTypedef}
        end
        const var"c\"clang_Type_isTransparentTagTypedef\"" = Cbinding_clang_Type_isTransparentTagTypedef{:clang_Type_isTransparentTagTypedef}()
        (func::Cbinding_clang_Type_isTransparentTagTypedef)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_isTransparentTagTypedef = var"c\"clang_Type_isTransparentTagTypedef\""
        export var"c\"clang_Type_isTransparentTagTypedef\""
        export clang_Type_isTransparentTagTypedef
        var"c\"clang_Type_isTransparentTagTypedef\""
        abstract type var"c\"enum CXTypeNullabilityKind\"" <: Cenum end
        const CXTypeNullabilityKind = var"c\"enum CXTypeNullabilityKind\""
        export var"c\"enum CXTypeNullabilityKind\""
        export CXTypeNullabilityKind
        var"c\"enum CXTypeNullabilityKind\""
        primitive type var"(c\"enum CXTypeNullabilityKind\")" <: var"c\"enum CXTypeNullabilityKind\"" 32 end
        (::(Type){var"(c\"enum CXTypeNullabilityKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXTypeNullabilityKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXTypeNullabilityKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXTypeNullability_NonNull\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXTypeNullability_Nullable\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXTypeNullability_Unspecified\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXTypeNullability_Invalid\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXTypeNullability_NullableResult\""), 0x0000000000000004}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXTypeNullabilityKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXTypeNullabilityKind\")"}) = begin
                var"(c\"enum CXTypeNullabilityKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXTypeNullabilityKind\""}) = begin
                var"(c\"enum CXTypeNullabilityKind\")"
            end
        const var"c\"CXTypeNullability_NonNull\"" = var"(c\"enum CXTypeNullabilityKind\")"(0x0000000000000000)
        const var"c\"CXTypeNullability_Nullable\"" = var"(c\"enum CXTypeNullabilityKind\")"(0x0000000000000001)
        const var"c\"CXTypeNullability_Unspecified\"" = var"(c\"enum CXTypeNullabilityKind\")"(0x0000000000000002)
        const var"c\"CXTypeNullability_Invalid\"" = var"(c\"enum CXTypeNullabilityKind\")"(0x0000000000000003)
        const var"c\"CXTypeNullability_NullableResult\"" = var"(c\"enum CXTypeNullabilityKind\")"(0x0000000000000004)
        const CXTypeNullabilityKind = var"c\"enum CXTypeNullabilityKind\""
        const CXTypeNullability_NonNull = var"c\"CXTypeNullability_NonNull\""
        const CXTypeNullability_Nullable = var"c\"CXTypeNullability_Nullable\""
        const CXTypeNullability_Unspecified = var"c\"CXTypeNullability_Unspecified\""
        const CXTypeNullability_Invalid = var"c\"CXTypeNullability_Invalid\""
        const CXTypeNullability_NullableResult = var"c\"CXTypeNullability_NullableResult\""
        export var"c\"enum CXTypeNullabilityKind\"", var"(c\"enum CXTypeNullabilityKind\")", var"c\"CXTypeNullability_NonNull\"", var"c\"CXTypeNullability_Nullable\"", var"c\"CXTypeNullability_Unspecified\"", var"c\"CXTypeNullability_Invalid\"", var"c\"CXTypeNullability_NullableResult\""
        export CXTypeNullabilityKind, CXTypeNullability_NonNull, CXTypeNullability_Nullable, CXTypeNullability_Unspecified, CXTypeNullability_Invalid, CXTypeNullability_NullableResult
        var"c\"enum CXTypeNullabilityKind\""
        struct Cbinding_clang_Type_getNullability{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXTypeNullabilityKind\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getNullability}
        end
        const var"c\"clang_Type_getNullability\"" = Cbinding_clang_Type_getNullability{:clang_Type_getNullability}()
        (func::Cbinding_clang_Type_getNullability)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getNullability = var"c\"clang_Type_getNullability\""
        export var"c\"clang_Type_getNullability\""
        export clang_Type_getNullability
        var"c\"clang_Type_getNullability\""
        abstract type var"c\"enum CXTypeLayoutError\"" <: Cenum end
        const CXTypeLayoutError = var"c\"enum CXTypeLayoutError\""
        export var"c\"enum CXTypeLayoutError\""
        export CXTypeLayoutError
        var"c\"enum CXTypeLayoutError\""
        primitive type var"(c\"enum CXTypeLayoutError\")" <: var"c\"enum CXTypeLayoutError\"" 32 end
        (::(Type){var"(c\"enum CXTypeLayoutError\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXTypeLayoutError\")", CBinding.convert(CBinding.Cint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXTypeLayoutError\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXTypeLayoutError_Invalid\""), -1}, CBinding.Tuple{Symbol("c\"CXTypeLayoutError_Incomplete\""), -2}, CBinding.Tuple{Symbol("c\"CXTypeLayoutError_Dependent\""), -3}, CBinding.Tuple{Symbol("c\"CXTypeLayoutError_NotConstantSize\""), -4}, CBinding.Tuple{Symbol("c\"CXTypeLayoutError_InvalidFieldName\""), -5}, CBinding.Tuple{Symbol("c\"CXTypeLayoutError_Undeduced\""), -6}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXTypeLayoutError\")"}) = begin
                CBinding.Cint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXTypeLayoutError\")"}) = begin
                var"(c\"enum CXTypeLayoutError\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXTypeLayoutError\""}) = begin
                var"(c\"enum CXTypeLayoutError\")"
            end
        const var"c\"CXTypeLayoutError_Invalid\"" = var"(c\"enum CXTypeLayoutError\")"(-1)
        const var"c\"CXTypeLayoutError_Incomplete\"" = var"(c\"enum CXTypeLayoutError\")"(-2)
        const var"c\"CXTypeLayoutError_Dependent\"" = var"(c\"enum CXTypeLayoutError\")"(-3)
        const var"c\"CXTypeLayoutError_NotConstantSize\"" = var"(c\"enum CXTypeLayoutError\")"(-4)
        const var"c\"CXTypeLayoutError_InvalidFieldName\"" = var"(c\"enum CXTypeLayoutError\")"(-5)
        const var"c\"CXTypeLayoutError_Undeduced\"" = var"(c\"enum CXTypeLayoutError\")"(-6)
        const CXTypeLayoutError = var"c\"enum CXTypeLayoutError\""
        const CXTypeLayoutError_Invalid = var"c\"CXTypeLayoutError_Invalid\""
        const CXTypeLayoutError_Incomplete = var"c\"CXTypeLayoutError_Incomplete\""
        const CXTypeLayoutError_Dependent = var"c\"CXTypeLayoutError_Dependent\""
        const CXTypeLayoutError_NotConstantSize = var"c\"CXTypeLayoutError_NotConstantSize\""
        const CXTypeLayoutError_InvalidFieldName = var"c\"CXTypeLayoutError_InvalidFieldName\""
        const CXTypeLayoutError_Undeduced = var"c\"CXTypeLayoutError_Undeduced\""
        export var"c\"enum CXTypeLayoutError\"", var"(c\"enum CXTypeLayoutError\")", var"c\"CXTypeLayoutError_Invalid\"", var"c\"CXTypeLayoutError_Incomplete\"", var"c\"CXTypeLayoutError_Dependent\"", var"c\"CXTypeLayoutError_NotConstantSize\"", var"c\"CXTypeLayoutError_InvalidFieldName\"", var"c\"CXTypeLayoutError_Undeduced\""
        export CXTypeLayoutError, CXTypeLayoutError_Invalid, CXTypeLayoutError_Incomplete, CXTypeLayoutError_Dependent, CXTypeLayoutError_NotConstantSize, CXTypeLayoutError_InvalidFieldName, CXTypeLayoutError_Undeduced
        var"c\"enum CXTypeLayoutError\""
        struct Cbinding_clang_Type_getAlignOf{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getAlignOf}
        end
        const var"c\"clang_Type_getAlignOf\"" = Cbinding_clang_Type_getAlignOf{:clang_Type_getAlignOf}()
        (func::Cbinding_clang_Type_getAlignOf)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getAlignOf = var"c\"clang_Type_getAlignOf\""
        export var"c\"clang_Type_getAlignOf\""
        export clang_Type_getAlignOf
        var"c\"clang_Type_getAlignOf\""
        struct Cbinding_clang_Type_getClassType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getClassType}
        end
        const var"c\"clang_Type_getClassType\"" = Cbinding_clang_Type_getClassType{:clang_Type_getClassType}()
        (func::Cbinding_clang_Type_getClassType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getClassType = var"c\"clang_Type_getClassType\""
        export var"c\"clang_Type_getClassType\""
        export clang_Type_getClassType
        var"c\"clang_Type_getClassType\""
        struct Cbinding_clang_Type_getSizeOf{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getSizeOf}
        end
        const var"c\"clang_Type_getSizeOf\"" = Cbinding_clang_Type_getSizeOf{:clang_Type_getSizeOf}()
        (func::Cbinding_clang_Type_getSizeOf)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getSizeOf = var"c\"clang_Type_getSizeOf\""
        export var"c\"clang_Type_getSizeOf\""
        export clang_Type_getSizeOf
        var"c\"clang_Type_getSizeOf\""
        struct Cbinding_clang_Type_getOffsetOf{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXType\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_Type_getOffsetOf}
        end
        const var"c\"clang_Type_getOffsetOf\"" = Cbinding_clang_Type_getOffsetOf{:clang_Type_getOffsetOf}()
        (func::Cbinding_clang_Type_getOffsetOf)(var"c\"T\"", var"c\"S\"") = begin
                CBinding.funccall(func, var"c\"T\"", var"c\"S\"")
            end
        const clang_Type_getOffsetOf = var"c\"clang_Type_getOffsetOf\""
        export var"c\"clang_Type_getOffsetOf\""
        export clang_Type_getOffsetOf
        var"c\"clang_Type_getOffsetOf\""
        struct Cbinding_clang_Type_getModifiedType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getModifiedType}
        end
        const var"c\"clang_Type_getModifiedType\"" = Cbinding_clang_Type_getModifiedType{:clang_Type_getModifiedType}()
        (func::Cbinding_clang_Type_getModifiedType)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getModifiedType = var"c\"clang_Type_getModifiedType\""
        export var"c\"clang_Type_getModifiedType\""
        export clang_Type_getModifiedType
        var"c\"clang_Type_getModifiedType\""
        struct Cbinding_clang_Type_getValueType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getValueType}
        end
        const var"c\"clang_Type_getValueType\"" = Cbinding_clang_Type_getValueType{:clang_Type_getValueType}()
        (func::Cbinding_clang_Type_getValueType)(var"c\"CT\"") = begin
                CBinding.funccall(func, var"c\"CT\"")
            end
        const clang_Type_getValueType = var"c\"clang_Type_getValueType\""
        export var"c\"clang_Type_getValueType\""
        export clang_Type_getValueType
        var"c\"clang_Type_getValueType\""
        struct Cbinding_clang_Cursor_getOffsetOfField{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getOffsetOfField}
        end
        const var"c\"clang_Cursor_getOffsetOfField\"" = Cbinding_clang_Cursor_getOffsetOfField{:clang_Cursor_getOffsetOfField}()
        (func::Cbinding_clang_Cursor_getOffsetOfField)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getOffsetOfField = var"c\"clang_Cursor_getOffsetOfField\""
        export var"c\"clang_Cursor_getOffsetOfField\""
        export clang_Cursor_getOffsetOfField
        var"c\"clang_Cursor_getOffsetOfField\""
        struct Cbinding_clang_Cursor_isAnonymous{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isAnonymous}
        end
        const var"c\"clang_Cursor_isAnonymous\"" = Cbinding_clang_Cursor_isAnonymous{:clang_Cursor_isAnonymous}()
        (func::Cbinding_clang_Cursor_isAnonymous)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isAnonymous = var"c\"clang_Cursor_isAnonymous\""
        export var"c\"clang_Cursor_isAnonymous\""
        export clang_Cursor_isAnonymous
        var"c\"clang_Cursor_isAnonymous\""
        struct Cbinding_clang_Cursor_isAnonymousRecordDecl{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isAnonymousRecordDecl}
        end
        const var"c\"clang_Cursor_isAnonymousRecordDecl\"" = Cbinding_clang_Cursor_isAnonymousRecordDecl{:clang_Cursor_isAnonymousRecordDecl}()
        (func::Cbinding_clang_Cursor_isAnonymousRecordDecl)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isAnonymousRecordDecl = var"c\"clang_Cursor_isAnonymousRecordDecl\""
        export var"c\"clang_Cursor_isAnonymousRecordDecl\""
        export clang_Cursor_isAnonymousRecordDecl
        var"c\"clang_Cursor_isAnonymousRecordDecl\""
        struct Cbinding_clang_Cursor_isInlineNamespace{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isInlineNamespace}
        end
        const var"c\"clang_Cursor_isInlineNamespace\"" = Cbinding_clang_Cursor_isInlineNamespace{:clang_Cursor_isInlineNamespace}()
        (func::Cbinding_clang_Cursor_isInlineNamespace)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isInlineNamespace = var"c\"clang_Cursor_isInlineNamespace\""
        export var"c\"clang_Cursor_isInlineNamespace\""
        export clang_Cursor_isInlineNamespace
        var"c\"clang_Cursor_isInlineNamespace\""
        abstract type var"c\"enum CXRefQualifierKind\"" <: Cenum end
        const CXRefQualifierKind = var"c\"enum CXRefQualifierKind\""
        export var"c\"enum CXRefQualifierKind\""
        export CXRefQualifierKind
        var"c\"enum CXRefQualifierKind\""
        primitive type var"(c\"enum CXRefQualifierKind\")" <: var"c\"enum CXRefQualifierKind\"" 32 end
        (::(Type){var"(c\"enum CXRefQualifierKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXRefQualifierKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXRefQualifierKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXRefQualifier_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXRefQualifier_LValue\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXRefQualifier_RValue\""), 0x0000000000000002}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXRefQualifierKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXRefQualifierKind\")"}) = begin
                var"(c\"enum CXRefQualifierKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXRefQualifierKind\""}) = begin
                var"(c\"enum CXRefQualifierKind\")"
            end
        const var"c\"CXRefQualifier_None\"" = var"(c\"enum CXRefQualifierKind\")"(0x0000000000000000)
        const var"c\"CXRefQualifier_LValue\"" = var"(c\"enum CXRefQualifierKind\")"(0x0000000000000001)
        const var"c\"CXRefQualifier_RValue\"" = var"(c\"enum CXRefQualifierKind\")"(0x0000000000000002)
        const CXRefQualifierKind = var"c\"enum CXRefQualifierKind\""
        const CXRefQualifier_None = var"c\"CXRefQualifier_None\""
        const CXRefQualifier_LValue = var"c\"CXRefQualifier_LValue\""
        const CXRefQualifier_RValue = var"c\"CXRefQualifier_RValue\""
        export var"c\"enum CXRefQualifierKind\"", var"(c\"enum CXRefQualifierKind\")", var"c\"CXRefQualifier_None\"", var"c\"CXRefQualifier_LValue\"", var"c\"CXRefQualifier_RValue\""
        export CXRefQualifierKind, CXRefQualifier_None, CXRefQualifier_LValue, CXRefQualifier_RValue
        var"c\"enum CXRefQualifierKind\""
        struct Cbinding_clang_Type_getNumTemplateArguments{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getNumTemplateArguments}
        end
        const var"c\"clang_Type_getNumTemplateArguments\"" = Cbinding_clang_Type_getNumTemplateArguments{:clang_Type_getNumTemplateArguments}()
        (func::Cbinding_clang_Type_getNumTemplateArguments)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getNumTemplateArguments = var"c\"clang_Type_getNumTemplateArguments\""
        export var"c\"clang_Type_getNumTemplateArguments\""
        export clang_Type_getNumTemplateArguments
        var"c\"clang_Type_getNumTemplateArguments\""
        struct Cbinding_clang_Type_getTemplateArgumentAsType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXType\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Type_getTemplateArgumentAsType}
        end
        const var"c\"clang_Type_getTemplateArgumentAsType\"" = Cbinding_clang_Type_getTemplateArgumentAsType{:clang_Type_getTemplateArgumentAsType}()
        (func::Cbinding_clang_Type_getTemplateArgumentAsType)(var"c\"T\"", var"c\"i\"") = begin
                CBinding.funccall(func, var"c\"T\"", var"c\"i\"")
            end
        const clang_Type_getTemplateArgumentAsType = var"c\"clang_Type_getTemplateArgumentAsType\""
        export var"c\"clang_Type_getTemplateArgumentAsType\""
        export clang_Type_getTemplateArgumentAsType
        var"c\"clang_Type_getTemplateArgumentAsType\""
        struct Cbinding_clang_Type_getCXXRefQualifier{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXRefQualifierKind\"", CBinding.Tuple{var"c\"CXType\""}, :cdecl}, libpath, :clang_Type_getCXXRefQualifier}
        end
        const var"c\"clang_Type_getCXXRefQualifier\"" = Cbinding_clang_Type_getCXXRefQualifier{:clang_Type_getCXXRefQualifier}()
        (func::Cbinding_clang_Type_getCXXRefQualifier)(var"c\"T\"") = begin
                CBinding.funccall(func, var"c\"T\"")
            end
        const clang_Type_getCXXRefQualifier = var"c\"clang_Type_getCXXRefQualifier\""
        export var"c\"clang_Type_getCXXRefQualifier\""
        export clang_Type_getCXXRefQualifier
        var"c\"clang_Type_getCXXRefQualifier\""
        struct Cbinding_clang_isVirtualBase{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_isVirtualBase}
        end
        const var"c\"clang_isVirtualBase\"" = Cbinding_clang_isVirtualBase{:clang_isVirtualBase}()
        (func::Cbinding_clang_isVirtualBase)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isVirtualBase = var"c\"clang_isVirtualBase\""
        export var"c\"clang_isVirtualBase\""
        export clang_isVirtualBase
        var"c\"clang_isVirtualBase\""
        abstract type var"c\"enum CX_CXXAccessSpecifier\"" <: Cenum end
        const CX_CXXAccessSpecifier = var"c\"enum CX_CXXAccessSpecifier\""
        export var"c\"enum CX_CXXAccessSpecifier\""
        export CX_CXXAccessSpecifier
        var"c\"enum CX_CXXAccessSpecifier\""
        primitive type var"(c\"enum CX_CXXAccessSpecifier\")" <: var"c\"enum CX_CXXAccessSpecifier\"" 32 end
        (::(Type){var"(c\"enum CX_CXXAccessSpecifier\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CX_CXXAccessSpecifier\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CX_CXXAccessSpecifier\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CX_CXXInvalidAccessSpecifier\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CX_CXXPublic\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CX_CXXProtected\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CX_CXXPrivate\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CX_CXXAccessSpecifier\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CX_CXXAccessSpecifier\")"}) = begin
                var"(c\"enum CX_CXXAccessSpecifier\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CX_CXXAccessSpecifier\""}) = begin
                var"(c\"enum CX_CXXAccessSpecifier\")"
            end
        const var"c\"CX_CXXInvalidAccessSpecifier\"" = var"(c\"enum CX_CXXAccessSpecifier\")"(0x0000000000000000)
        const var"c\"CX_CXXPublic\"" = var"(c\"enum CX_CXXAccessSpecifier\")"(0x0000000000000001)
        const var"c\"CX_CXXProtected\"" = var"(c\"enum CX_CXXAccessSpecifier\")"(0x0000000000000002)
        const var"c\"CX_CXXPrivate\"" = var"(c\"enum CX_CXXAccessSpecifier\")"(0x0000000000000003)
        const CX_CXXAccessSpecifier = var"c\"enum CX_CXXAccessSpecifier\""
        const CX_CXXInvalidAccessSpecifier = var"c\"CX_CXXInvalidAccessSpecifier\""
        const CX_CXXPublic = var"c\"CX_CXXPublic\""
        const CX_CXXProtected = var"c\"CX_CXXProtected\""
        const CX_CXXPrivate = var"c\"CX_CXXPrivate\""
        export var"c\"enum CX_CXXAccessSpecifier\"", var"(c\"enum CX_CXXAccessSpecifier\")", var"c\"CX_CXXInvalidAccessSpecifier\"", var"c\"CX_CXXPublic\"", var"c\"CX_CXXProtected\"", var"c\"CX_CXXPrivate\""
        export CX_CXXAccessSpecifier, CX_CXXInvalidAccessSpecifier, CX_CXXPublic, CX_CXXProtected, CX_CXXPrivate
        var"c\"enum CX_CXXAccessSpecifier\""
        struct Cbinding_clang_getCXXAccessSpecifier{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CX_CXXAccessSpecifier\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCXXAccessSpecifier}
        end
        const var"c\"clang_getCXXAccessSpecifier\"" = Cbinding_clang_getCXXAccessSpecifier{:clang_getCXXAccessSpecifier}()
        (func::Cbinding_clang_getCXXAccessSpecifier)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCXXAccessSpecifier = var"c\"clang_getCXXAccessSpecifier\""
        export var"c\"clang_getCXXAccessSpecifier\""
        export clang_getCXXAccessSpecifier
        var"c\"clang_getCXXAccessSpecifier\""
        abstract type var"c\"enum CX_StorageClass\"" <: Cenum end
        const CX_StorageClass = var"c\"enum CX_StorageClass\""
        export var"c\"enum CX_StorageClass\""
        export CX_StorageClass
        var"c\"enum CX_StorageClass\""
        primitive type var"(c\"enum CX_StorageClass\")" <: var"c\"enum CX_StorageClass\"" 32 end
        (::(Type){var"(c\"enum CX_StorageClass\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CX_StorageClass\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CX_StorageClass\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CX_SC_Invalid\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CX_SC_None\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CX_SC_Extern\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CX_SC_Static\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CX_SC_PrivateExtern\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CX_SC_OpenCLWorkGroupLocal\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CX_SC_Auto\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CX_SC_Register\""), 0x0000000000000007}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CX_StorageClass\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CX_StorageClass\")"}) = begin
                var"(c\"enum CX_StorageClass\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CX_StorageClass\""}) = begin
                var"(c\"enum CX_StorageClass\")"
            end
        const var"c\"CX_SC_Invalid\"" = var"(c\"enum CX_StorageClass\")"(0x0000000000000000)
        const var"c\"CX_SC_None\"" = var"(c\"enum CX_StorageClass\")"(0x0000000000000001)
        const var"c\"CX_SC_Extern\"" = var"(c\"enum CX_StorageClass\")"(0x0000000000000002)
        const var"c\"CX_SC_Static\"" = var"(c\"enum CX_StorageClass\")"(0x0000000000000003)
        const var"c\"CX_SC_PrivateExtern\"" = var"(c\"enum CX_StorageClass\")"(0x0000000000000004)
        const var"c\"CX_SC_OpenCLWorkGroupLocal\"" = var"(c\"enum CX_StorageClass\")"(0x0000000000000005)
        const var"c\"CX_SC_Auto\"" = var"(c\"enum CX_StorageClass\")"(0x0000000000000006)
        const var"c\"CX_SC_Register\"" = var"(c\"enum CX_StorageClass\")"(0x0000000000000007)
        const CX_StorageClass = var"c\"enum CX_StorageClass\""
        const CX_SC_Invalid = var"c\"CX_SC_Invalid\""
        const CX_SC_None = var"c\"CX_SC_None\""
        const CX_SC_Extern = var"c\"CX_SC_Extern\""
        const CX_SC_Static = var"c\"CX_SC_Static\""
        const CX_SC_PrivateExtern = var"c\"CX_SC_PrivateExtern\""
        const CX_SC_OpenCLWorkGroupLocal = var"c\"CX_SC_OpenCLWorkGroupLocal\""
        const CX_SC_Auto = var"c\"CX_SC_Auto\""
        const CX_SC_Register = var"c\"CX_SC_Register\""
        export var"c\"enum CX_StorageClass\"", var"(c\"enum CX_StorageClass\")", var"c\"CX_SC_Invalid\"", var"c\"CX_SC_None\"", var"c\"CX_SC_Extern\"", var"c\"CX_SC_Static\"", var"c\"CX_SC_PrivateExtern\"", var"c\"CX_SC_OpenCLWorkGroupLocal\"", var"c\"CX_SC_Auto\"", var"c\"CX_SC_Register\""
        export CX_StorageClass, CX_SC_Invalid, CX_SC_None, CX_SC_Extern, CX_SC_Static, CX_SC_PrivateExtern, CX_SC_OpenCLWorkGroupLocal, CX_SC_Auto, CX_SC_Register
        var"c\"enum CX_StorageClass\""
        struct Cbinding_clang_Cursor_getStorageClass{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CX_StorageClass\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getStorageClass}
        end
        const var"c\"clang_Cursor_getStorageClass\"" = Cbinding_clang_Cursor_getStorageClass{:clang_Cursor_getStorageClass}()
        (func::Cbinding_clang_Cursor_getStorageClass)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_Cursor_getStorageClass = var"c\"clang_Cursor_getStorageClass\""
        export var"c\"clang_Cursor_getStorageClass\""
        export clang_Cursor_getStorageClass
        var"c\"clang_Cursor_getStorageClass\""
        struct Cbinding_clang_getNumOverloadedDecls{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getNumOverloadedDecls}
        end
        const var"c\"clang_getNumOverloadedDecls\"" = Cbinding_clang_getNumOverloadedDecls{:clang_getNumOverloadedDecls}()
        (func::Cbinding_clang_getNumOverloadedDecls)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getNumOverloadedDecls = var"c\"clang_getNumOverloadedDecls\""
        export var"c\"clang_getNumOverloadedDecls\""
        export clang_getNumOverloadedDecls
        var"c\"clang_getNumOverloadedDecls\""
        struct Cbinding_clang_getOverloadedDecl{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getOverloadedDecl}
        end
        const var"c\"clang_getOverloadedDecl\"" = Cbinding_clang_getOverloadedDecl{:clang_getOverloadedDecl}()
        (func::Cbinding_clang_getOverloadedDecl)(var"c\"cursor\"", var"c\"index\"") = begin
                CBinding.funccall(func, var"c\"cursor\"", var"c\"index\"")
            end
        const clang_getOverloadedDecl = var"c\"clang_getOverloadedDecl\""
        export var"c\"clang_getOverloadedDecl\""
        export clang_getOverloadedDecl
        var"c\"clang_getOverloadedDecl\""
        struct Cbinding_clang_getIBOutletCollectionType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getIBOutletCollectionType}
        end
        const var"c\"clang_getIBOutletCollectionType\"" = Cbinding_clang_getIBOutletCollectionType{:clang_getIBOutletCollectionType}()
        (func::Cbinding_clang_getIBOutletCollectionType)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getIBOutletCollectionType = var"c\"clang_getIBOutletCollectionType\""
        export var"c\"clang_getIBOutletCollectionType\""
        export clang_getIBOutletCollectionType
        var"c\"clang_getIBOutletCollectionType\""
        abstract type var"c\"enum CXChildVisitResult\"" <: Cenum end
        const CXChildVisitResult = var"c\"enum CXChildVisitResult\""
        export var"c\"enum CXChildVisitResult\""
        export CXChildVisitResult
        var"c\"enum CXChildVisitResult\""
        primitive type var"(c\"enum CXChildVisitResult\")" <: var"c\"enum CXChildVisitResult\"" 32 end
        (::(Type){var"(c\"enum CXChildVisitResult\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXChildVisitResult\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXChildVisitResult\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXChildVisit_Break\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXChildVisit_Continue\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXChildVisit_Recurse\""), 0x0000000000000002}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXChildVisitResult\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXChildVisitResult\")"}) = begin
                var"(c\"enum CXChildVisitResult\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXChildVisitResult\""}) = begin
                var"(c\"enum CXChildVisitResult\")"
            end
        const var"c\"CXChildVisit_Break\"" = var"(c\"enum CXChildVisitResult\")"(0x0000000000000000)
        const var"c\"CXChildVisit_Continue\"" = var"(c\"enum CXChildVisitResult\")"(0x0000000000000001)
        const var"c\"CXChildVisit_Recurse\"" = var"(c\"enum CXChildVisitResult\")"(0x0000000000000002)
        const CXChildVisitResult = var"c\"enum CXChildVisitResult\""
        const CXChildVisit_Break = var"c\"CXChildVisit_Break\""
        const CXChildVisit_Continue = var"c\"CXChildVisit_Continue\""
        const CXChildVisit_Recurse = var"c\"CXChildVisit_Recurse\""
        export var"c\"enum CXChildVisitResult\"", var"(c\"enum CXChildVisitResult\")", var"c\"CXChildVisit_Break\"", var"c\"CXChildVisit_Continue\"", var"c\"CXChildVisit_Recurse\""
        export CXChildVisitResult, CXChildVisit_Break, CXChildVisit_Continue, CXChildVisit_Recurse
        var"c\"enum CXChildVisitResult\""
        const var"c\"CXCursorVisitor\"" = CBinding.Cptr{CBinding.Cfunction{var"c\"enum CXChildVisitResult\"", CBinding.Tuple{var"c\"CXCursor\"", var"c\"CXCursor\"", var"c\"CXClientData\""}, :cdecl}}
        const CXCursorVisitor = var"c\"CXCursorVisitor\""
        export var"c\"CXCursorVisitor\""
        export CXCursorVisitor
        var"c\"CXCursorVisitor\""
        struct Cbinding_clang_visitChildren{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\"", var"c\"CXCursorVisitor\"", var"c\"CXClientData\""}, :cdecl}, libpath, :clang_visitChildren}
        end
        const var"c\"clang_visitChildren\"" = Cbinding_clang_visitChildren{:clang_visitChildren}()
        (func::Cbinding_clang_visitChildren)(var"c\"parent\"", var"c\"visitor\"", var"c\"client_data\"") = begin
                CBinding.funccall(func, var"c\"parent\"", var"c\"visitor\"", var"c\"client_data\"")
            end
        const clang_visitChildren = var"c\"clang_visitChildren\""
        export var"c\"clang_visitChildren\""
        export clang_visitChildren
        var"c\"clang_visitChildren\""
        abstract type var"c\"struct _CXChildVisitResult\"" <: Cstruct end
        const _CXChildVisitResult = var"c\"struct _CXChildVisitResult\""
        export var"c\"struct _CXChildVisitResult\""
        export _CXChildVisitResult
        var"c\"struct _CXChildVisitResult\""
        const var"c\"CXCursorVisitorBlock\"" = CBinding.Cptr{var"c\"struct _CXChildVisitResult\""}
        const CXCursorVisitorBlock = var"c\"CXCursorVisitorBlock\""
        export var"c\"CXCursorVisitorBlock\""
        export CXCursorVisitorBlock
        var"c\"CXCursorVisitorBlock\""
        struct Cbinding_clang_visitChildrenWithBlock{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\"", var"c\"CXCursorVisitorBlock\""}, :cdecl}, libpath, :clang_visitChildrenWithBlock}
        end
        const var"c\"clang_visitChildrenWithBlock\"" = Cbinding_clang_visitChildrenWithBlock{:clang_visitChildrenWithBlock}()
        (func::Cbinding_clang_visitChildrenWithBlock)(var"c\"parent\"", var"c\"block\"") = begin
                CBinding.funccall(func, var"c\"parent\"", var"c\"block\"")
            end
        const clang_visitChildrenWithBlock = var"c\"clang_visitChildrenWithBlock\""
        export var"c\"clang_visitChildrenWithBlock\""
        export clang_visitChildrenWithBlock
        var"c\"clang_visitChildrenWithBlock\""
        struct Cbinding_clang_getCursorUSR{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorUSR}
        end
        const var"c\"clang_getCursorUSR\"" = Cbinding_clang_getCursorUSR{:clang_getCursorUSR}()
        (func::Cbinding_clang_getCursorUSR)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorUSR = var"c\"clang_getCursorUSR\""
        export var"c\"clang_getCursorUSR\""
        export clang_getCursorUSR
        var"c\"clang_getCursorUSR\""
        struct Cbinding_clang_constructUSR_ObjCClass{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_constructUSR_ObjCClass}
        end
        const var"c\"clang_constructUSR_ObjCClass\"" = Cbinding_clang_constructUSR_ObjCClass{:clang_constructUSR_ObjCClass}()
        (func::Cbinding_clang_constructUSR_ObjCClass)(var"c\"class_name\"") = begin
                CBinding.funccall(func, var"c\"class_name\"")
            end
        const clang_constructUSR_ObjCClass = var"c\"clang_constructUSR_ObjCClass\""
        export var"c\"clang_constructUSR_ObjCClass\""
        export clang_constructUSR_ObjCClass
        var"c\"clang_constructUSR_ObjCClass\""
        struct Cbinding_clang_constructUSR_ObjCCategory{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_constructUSR_ObjCCategory}
        end
        const var"c\"clang_constructUSR_ObjCCategory\"" = Cbinding_clang_constructUSR_ObjCCategory{:clang_constructUSR_ObjCCategory}()
        (func::Cbinding_clang_constructUSR_ObjCCategory)(var"c\"class_name\"", var"c\"category_name\"") = begin
                CBinding.funccall(func, var"c\"class_name\"", var"c\"category_name\"")
            end
        const clang_constructUSR_ObjCCategory = var"c\"clang_constructUSR_ObjCCategory\""
        export var"c\"clang_constructUSR_ObjCCategory\""
        export clang_constructUSR_ObjCCategory
        var"c\"clang_constructUSR_ObjCCategory\""
        struct Cbinding_clang_constructUSR_ObjCProtocol{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_constructUSR_ObjCProtocol}
        end
        const var"c\"clang_constructUSR_ObjCProtocol\"" = Cbinding_clang_constructUSR_ObjCProtocol{:clang_constructUSR_ObjCProtocol}()
        (func::Cbinding_clang_constructUSR_ObjCProtocol)(var"c\"protocol_name\"") = begin
                CBinding.funccall(func, var"c\"protocol_name\"")
            end
        const clang_constructUSR_ObjCProtocol = var"c\"clang_constructUSR_ObjCProtocol\""
        export var"c\"clang_constructUSR_ObjCProtocol\""
        export clang_constructUSR_ObjCProtocol
        var"c\"clang_constructUSR_ObjCProtocol\""
        struct Cbinding_clang_constructUSR_ObjCIvar{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, var"c\"CXString\""}, :cdecl}, libpath, :clang_constructUSR_ObjCIvar}
        end
        const var"c\"clang_constructUSR_ObjCIvar\"" = Cbinding_clang_constructUSR_ObjCIvar{:clang_constructUSR_ObjCIvar}()
        (func::Cbinding_clang_constructUSR_ObjCIvar)(var"c\"name\"", var"c\"classUSR\"") = begin
                CBinding.funccall(func, var"c\"name\"", var"c\"classUSR\"")
            end
        const clang_constructUSR_ObjCIvar = var"c\"clang_constructUSR_ObjCIvar\""
        export var"c\"clang_constructUSR_ObjCIvar\""
        export clang_constructUSR_ObjCIvar
        var"c\"clang_constructUSR_ObjCIvar\""
        struct Cbinding_clang_constructUSR_ObjCMethod{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cuint, var"c\"CXString\""}, :cdecl}, libpath, :clang_constructUSR_ObjCMethod}
        end
        const var"c\"clang_constructUSR_ObjCMethod\"" = Cbinding_clang_constructUSR_ObjCMethod{:clang_constructUSR_ObjCMethod}()
        (func::Cbinding_clang_constructUSR_ObjCMethod)(var"c\"name\"", var"c\"isInstanceMethod\"", var"c\"classUSR\"") = begin
                CBinding.funccall(func, var"c\"name\"", var"c\"isInstanceMethod\"", var"c\"classUSR\"")
            end
        const clang_constructUSR_ObjCMethod = var"c\"clang_constructUSR_ObjCMethod\""
        export var"c\"clang_constructUSR_ObjCMethod\""
        export clang_constructUSR_ObjCMethod
        var"c\"clang_constructUSR_ObjCMethod\""
        struct Cbinding_clang_constructUSR_ObjCProperty{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, var"c\"CXString\""}, :cdecl}, libpath, :clang_constructUSR_ObjCProperty}
        end
        const var"c\"clang_constructUSR_ObjCProperty\"" = Cbinding_clang_constructUSR_ObjCProperty{:clang_constructUSR_ObjCProperty}()
        (func::Cbinding_clang_constructUSR_ObjCProperty)(var"c\"property\"", var"c\"classUSR\"") = begin
                CBinding.funccall(func, var"c\"property\"", var"c\"classUSR\"")
            end
        const clang_constructUSR_ObjCProperty = var"c\"clang_constructUSR_ObjCProperty\""
        export var"c\"clang_constructUSR_ObjCProperty\""
        export clang_constructUSR_ObjCProperty
        var"c\"clang_constructUSR_ObjCProperty\""
        struct Cbinding_clang_getCursorSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorSpelling}
        end
        const var"c\"clang_getCursorSpelling\"" = Cbinding_clang_getCursorSpelling{:clang_getCursorSpelling}()
        (func::Cbinding_clang_getCursorSpelling)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorSpelling = var"c\"clang_getCursorSpelling\""
        export var"c\"clang_getCursorSpelling\""
        export clang_getCursorSpelling
        var"c\"clang_getCursorSpelling\""
        struct Cbinding_clang_Cursor_getSpellingNameRange{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceRange\"", CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint, CBinding.Cuint}, :cdecl}, libpath, :clang_Cursor_getSpellingNameRange}
        end
        const var"c\"clang_Cursor_getSpellingNameRange\"" = Cbinding_clang_Cursor_getSpellingNameRange{:clang_Cursor_getSpellingNameRange}()
        (func::Cbinding_clang_Cursor_getSpellingNameRange)(arg1, var"c\"pieceIndex\"", var"c\"options\"") = begin
                CBinding.funccall(func, arg1, var"c\"pieceIndex\"", var"c\"options\"")
            end
        const clang_Cursor_getSpellingNameRange = var"c\"clang_Cursor_getSpellingNameRange\""
        export var"c\"clang_Cursor_getSpellingNameRange\""
        export clang_Cursor_getSpellingNameRange
        var"c\"clang_Cursor_getSpellingNameRange\""
        const var"c\"CXPrintingPolicy\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXPrintingPolicy = var"c\"CXPrintingPolicy\""
        export var"c\"CXPrintingPolicy\""
        export CXPrintingPolicy
        var"c\"CXPrintingPolicy\""
        abstract type var"c\"enum CXPrintingPolicyProperty\"" <: Cenum end
        const CXPrintingPolicyProperty = var"c\"enum CXPrintingPolicyProperty\""
        export var"c\"enum CXPrintingPolicyProperty\""
        export CXPrintingPolicyProperty
        var"c\"enum CXPrintingPolicyProperty\""
        primitive type var"(c\"enum CXPrintingPolicyProperty\")" <: var"c\"enum CXPrintingPolicyProperty\"" 32 end
        (::(Type){var"(c\"enum CXPrintingPolicyProperty\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXPrintingPolicyProperty\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXPrintingPolicyProperty\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXPrintingPolicy_Indentation\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressSpecifiers\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressTagKeyword\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_IncludeTagDefinition\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressScope\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressUnwrittenScope\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressInitializers\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_ConstantArraySizeAsWritten\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_AnonymousTagLocations\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressStrongLifetime\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressLifetimeQualifiers\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_Bool\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_Restrict\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_Alignof\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_UnderscoreAlignof\""), 0x000000000000000f}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_UseVoidForZeroParams\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_TerseOutput\""), 0x0000000000000011}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_PolishForDeclaration\""), 0x0000000000000012}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_Half\""), 0x0000000000000013}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_MSWChar\""), 0x0000000000000014}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_IncludeNewlines\""), 0x0000000000000015}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_MSVCFormatting\""), 0x0000000000000016}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_ConstantsAsWritten\""), 0x0000000000000017}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_SuppressImplicitBase\""), 0x0000000000000018}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_FullyQualifiedName\""), 0x0000000000000019}, CBinding.Tuple{Symbol("c\"CXPrintingPolicy_LastProperty\""), 0x0000000000000019}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXPrintingPolicyProperty\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXPrintingPolicyProperty\")"}) = begin
                var"(c\"enum CXPrintingPolicyProperty\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXPrintingPolicyProperty\""}) = begin
                var"(c\"enum CXPrintingPolicyProperty\")"
            end
        const var"c\"CXPrintingPolicy_Indentation\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000000)
        const var"c\"CXPrintingPolicy_SuppressSpecifiers\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000001)
        const var"c\"CXPrintingPolicy_SuppressTagKeyword\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000002)
        const var"c\"CXPrintingPolicy_IncludeTagDefinition\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000003)
        const var"c\"CXPrintingPolicy_SuppressScope\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000004)
        const var"c\"CXPrintingPolicy_SuppressUnwrittenScope\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000005)
        const var"c\"CXPrintingPolicy_SuppressInitializers\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000006)
        const var"c\"CXPrintingPolicy_ConstantArraySizeAsWritten\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000007)
        const var"c\"CXPrintingPolicy_AnonymousTagLocations\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000008)
        const var"c\"CXPrintingPolicy_SuppressStrongLifetime\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000009)
        const var"c\"CXPrintingPolicy_SuppressLifetimeQualifiers\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x000000000000000a)
        const var"c\"CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x000000000000000b)
        const var"c\"CXPrintingPolicy_Bool\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x000000000000000c)
        const var"c\"CXPrintingPolicy_Restrict\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x000000000000000d)
        const var"c\"CXPrintingPolicy_Alignof\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x000000000000000e)
        const var"c\"CXPrintingPolicy_UnderscoreAlignof\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x000000000000000f)
        const var"c\"CXPrintingPolicy_UseVoidForZeroParams\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000010)
        const var"c\"CXPrintingPolicy_TerseOutput\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000011)
        const var"c\"CXPrintingPolicy_PolishForDeclaration\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000012)
        const var"c\"CXPrintingPolicy_Half\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000013)
        const var"c\"CXPrintingPolicy_MSWChar\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000014)
        const var"c\"CXPrintingPolicy_IncludeNewlines\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000015)
        const var"c\"CXPrintingPolicy_MSVCFormatting\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000016)
        const var"c\"CXPrintingPolicy_ConstantsAsWritten\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000017)
        const var"c\"CXPrintingPolicy_SuppressImplicitBase\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000018)
        const var"c\"CXPrintingPolicy_FullyQualifiedName\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000019)
        const var"c\"CXPrintingPolicy_LastProperty\"" = var"(c\"enum CXPrintingPolicyProperty\")"(0x0000000000000019)
        const CXPrintingPolicyProperty = var"c\"enum CXPrintingPolicyProperty\""
        const CXPrintingPolicy_Indentation = var"c\"CXPrintingPolicy_Indentation\""
        const CXPrintingPolicy_SuppressSpecifiers = var"c\"CXPrintingPolicy_SuppressSpecifiers\""
        const CXPrintingPolicy_SuppressTagKeyword = var"c\"CXPrintingPolicy_SuppressTagKeyword\""
        const CXPrintingPolicy_IncludeTagDefinition = var"c\"CXPrintingPolicy_IncludeTagDefinition\""
        const CXPrintingPolicy_SuppressScope = var"c\"CXPrintingPolicy_SuppressScope\""
        const CXPrintingPolicy_SuppressUnwrittenScope = var"c\"CXPrintingPolicy_SuppressUnwrittenScope\""
        const CXPrintingPolicy_SuppressInitializers = var"c\"CXPrintingPolicy_SuppressInitializers\""
        const CXPrintingPolicy_ConstantArraySizeAsWritten = var"c\"CXPrintingPolicy_ConstantArraySizeAsWritten\""
        const CXPrintingPolicy_AnonymousTagLocations = var"c\"CXPrintingPolicy_AnonymousTagLocations\""
        const CXPrintingPolicy_SuppressStrongLifetime = var"c\"CXPrintingPolicy_SuppressStrongLifetime\""
        const CXPrintingPolicy_SuppressLifetimeQualifiers = var"c\"CXPrintingPolicy_SuppressLifetimeQualifiers\""
        const CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors = var"c\"CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors\""
        const CXPrintingPolicy_Bool = var"c\"CXPrintingPolicy_Bool\""
        const CXPrintingPolicy_Restrict = var"c\"CXPrintingPolicy_Restrict\""
        const CXPrintingPolicy_Alignof = var"c\"CXPrintingPolicy_Alignof\""
        const CXPrintingPolicy_UnderscoreAlignof = var"c\"CXPrintingPolicy_UnderscoreAlignof\""
        const CXPrintingPolicy_UseVoidForZeroParams = var"c\"CXPrintingPolicy_UseVoidForZeroParams\""
        const CXPrintingPolicy_TerseOutput = var"c\"CXPrintingPolicy_TerseOutput\""
        const CXPrintingPolicy_PolishForDeclaration = var"c\"CXPrintingPolicy_PolishForDeclaration\""
        const CXPrintingPolicy_Half = var"c\"CXPrintingPolicy_Half\""
        const CXPrintingPolicy_MSWChar = var"c\"CXPrintingPolicy_MSWChar\""
        const CXPrintingPolicy_IncludeNewlines = var"c\"CXPrintingPolicy_IncludeNewlines\""
        const CXPrintingPolicy_MSVCFormatting = var"c\"CXPrintingPolicy_MSVCFormatting\""
        const CXPrintingPolicy_ConstantsAsWritten = var"c\"CXPrintingPolicy_ConstantsAsWritten\""
        const CXPrintingPolicy_SuppressImplicitBase = var"c\"CXPrintingPolicy_SuppressImplicitBase\""
        const CXPrintingPolicy_FullyQualifiedName = var"c\"CXPrintingPolicy_FullyQualifiedName\""
        const CXPrintingPolicy_LastProperty = var"c\"CXPrintingPolicy_LastProperty\""
        export var"c\"enum CXPrintingPolicyProperty\"", var"(c\"enum CXPrintingPolicyProperty\")", var"c\"CXPrintingPolicy_Indentation\"", var"c\"CXPrintingPolicy_SuppressSpecifiers\"", var"c\"CXPrintingPolicy_SuppressTagKeyword\"", var"c\"CXPrintingPolicy_IncludeTagDefinition\"", var"c\"CXPrintingPolicy_SuppressScope\"", var"c\"CXPrintingPolicy_SuppressUnwrittenScope\"", var"c\"CXPrintingPolicy_SuppressInitializers\"", var"c\"CXPrintingPolicy_ConstantArraySizeAsWritten\"", var"c\"CXPrintingPolicy_AnonymousTagLocations\"", var"c\"CXPrintingPolicy_SuppressStrongLifetime\"", var"c\"CXPrintingPolicy_SuppressLifetimeQualifiers\"", var"c\"CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors\"", var"c\"CXPrintingPolicy_Bool\"", var"c\"CXPrintingPolicy_Restrict\"", var"c\"CXPrintingPolicy_Alignof\"", var"c\"CXPrintingPolicy_UnderscoreAlignof\"", var"c\"CXPrintingPolicy_UseVoidForZeroParams\"", var"c\"CXPrintingPolicy_TerseOutput\"", var"c\"CXPrintingPolicy_PolishForDeclaration\"", var"c\"CXPrintingPolicy_Half\"", var"c\"CXPrintingPolicy_MSWChar\"", var"c\"CXPrintingPolicy_IncludeNewlines\"", var"c\"CXPrintingPolicy_MSVCFormatting\"", var"c\"CXPrintingPolicy_ConstantsAsWritten\"", var"c\"CXPrintingPolicy_SuppressImplicitBase\"", var"c\"CXPrintingPolicy_FullyQualifiedName\"", var"c\"CXPrintingPolicy_LastProperty\""
        export CXPrintingPolicyProperty, CXPrintingPolicy_Indentation, CXPrintingPolicy_SuppressSpecifiers, CXPrintingPolicy_SuppressTagKeyword, CXPrintingPolicy_IncludeTagDefinition, CXPrintingPolicy_SuppressScope, CXPrintingPolicy_SuppressUnwrittenScope, CXPrintingPolicy_SuppressInitializers, CXPrintingPolicy_ConstantArraySizeAsWritten, CXPrintingPolicy_AnonymousTagLocations, CXPrintingPolicy_SuppressStrongLifetime, CXPrintingPolicy_SuppressLifetimeQualifiers, CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors, CXPrintingPolicy_Bool, CXPrintingPolicy_Restrict, CXPrintingPolicy_Alignof, CXPrintingPolicy_UnderscoreAlignof, CXPrintingPolicy_UseVoidForZeroParams, CXPrintingPolicy_TerseOutput, CXPrintingPolicy_PolishForDeclaration, CXPrintingPolicy_Half, CXPrintingPolicy_MSWChar, CXPrintingPolicy_IncludeNewlines, CXPrintingPolicy_MSVCFormatting, CXPrintingPolicy_ConstantsAsWritten, CXPrintingPolicy_SuppressImplicitBase, CXPrintingPolicy_FullyQualifiedName, CXPrintingPolicy_LastProperty
        var"c\"enum CXPrintingPolicyProperty\""
        struct Cbinding_clang_PrintingPolicy_getProperty{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXPrintingPolicy\"", var"c\"enum CXPrintingPolicyProperty\""}, :cdecl}, libpath, :clang_PrintingPolicy_getProperty}
        end
        const var"c\"clang_PrintingPolicy_getProperty\"" = Cbinding_clang_PrintingPolicy_getProperty{:clang_PrintingPolicy_getProperty}()
        (func::Cbinding_clang_PrintingPolicy_getProperty)(var"c\"Policy\"", var"c\"Property\"") = begin
                CBinding.funccall(func, var"c\"Policy\"", var"c\"Property\"")
            end
        const clang_PrintingPolicy_getProperty = var"c\"clang_PrintingPolicy_getProperty\""
        export var"c\"clang_PrintingPolicy_getProperty\""
        export clang_PrintingPolicy_getProperty
        var"c\"clang_PrintingPolicy_getProperty\""
        struct Cbinding_clang_PrintingPolicy_setProperty{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXPrintingPolicy\"", var"c\"enum CXPrintingPolicyProperty\"", CBinding.Cuint}, :cdecl}, libpath, :clang_PrintingPolicy_setProperty}
        end
        const var"c\"clang_PrintingPolicy_setProperty\"" = Cbinding_clang_PrintingPolicy_setProperty{:clang_PrintingPolicy_setProperty}()
        (func::Cbinding_clang_PrintingPolicy_setProperty)(var"c\"Policy\"", var"c\"Property\"", var"c\"Value\"") = begin
                CBinding.funccall(func, var"c\"Policy\"", var"c\"Property\"", var"c\"Value\"")
            end
        const clang_PrintingPolicy_setProperty = var"c\"clang_PrintingPolicy_setProperty\""
        export var"c\"clang_PrintingPolicy_setProperty\""
        export clang_PrintingPolicy_setProperty
        var"c\"clang_PrintingPolicy_setProperty\""
        struct Cbinding_clang_getCursorPrintingPolicy{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXPrintingPolicy\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorPrintingPolicy}
        end
        const var"c\"clang_getCursorPrintingPolicy\"" = Cbinding_clang_getCursorPrintingPolicy{:clang_getCursorPrintingPolicy}()
        (func::Cbinding_clang_getCursorPrintingPolicy)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorPrintingPolicy = var"c\"clang_getCursorPrintingPolicy\""
        export var"c\"clang_getCursorPrintingPolicy\""
        export clang_getCursorPrintingPolicy
        var"c\"clang_getCursorPrintingPolicy\""
        struct Cbinding_clang_PrintingPolicy_dispose{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXPrintingPolicy\""}, :cdecl}, libpath, :clang_PrintingPolicy_dispose}
        end
        const var"c\"clang_PrintingPolicy_dispose\"" = Cbinding_clang_PrintingPolicy_dispose{:clang_PrintingPolicy_dispose}()
        (func::Cbinding_clang_PrintingPolicy_dispose)(var"c\"Policy\"") = begin
                CBinding.funccall(func, var"c\"Policy\"")
            end
        const clang_PrintingPolicy_dispose = var"c\"clang_PrintingPolicy_dispose\""
        export var"c\"clang_PrintingPolicy_dispose\""
        export clang_PrintingPolicy_dispose
        var"c\"clang_PrintingPolicy_dispose\""
        struct Cbinding_clang_getCursorPrettyPrinted{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\"", var"c\"CXPrintingPolicy\""}, :cdecl}, libpath, :clang_getCursorPrettyPrinted}
        end
        const var"c\"clang_getCursorPrettyPrinted\"" = Cbinding_clang_getCursorPrettyPrinted{:clang_getCursorPrettyPrinted}()
        (func::Cbinding_clang_getCursorPrettyPrinted)(var"c\"Cursor\"", var"c\"Policy\"") = begin
                CBinding.funccall(func, var"c\"Cursor\"", var"c\"Policy\"")
            end
        const clang_getCursorPrettyPrinted = var"c\"clang_getCursorPrettyPrinted\""
        export var"c\"clang_getCursorPrettyPrinted\""
        export clang_getCursorPrettyPrinted
        var"c\"clang_getCursorPrettyPrinted\""
        struct Cbinding_clang_getCursorDisplayName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorDisplayName}
        end
        const var"c\"clang_getCursorDisplayName\"" = Cbinding_clang_getCursorDisplayName{:clang_getCursorDisplayName}()
        (func::Cbinding_clang_getCursorDisplayName)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorDisplayName = var"c\"clang_getCursorDisplayName\""
        export var"c\"clang_getCursorDisplayName\""
        export clang_getCursorDisplayName
        var"c\"clang_getCursorDisplayName\""
        struct Cbinding_clang_getCursorReferenced{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorReferenced}
        end
        const var"c\"clang_getCursorReferenced\"" = Cbinding_clang_getCursorReferenced{:clang_getCursorReferenced}()
        (func::Cbinding_clang_getCursorReferenced)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorReferenced = var"c\"clang_getCursorReferenced\""
        export var"c\"clang_getCursorReferenced\""
        export clang_getCursorReferenced
        var"c\"clang_getCursorReferenced\""
        struct Cbinding_clang_getCursorDefinition{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorDefinition}
        end
        const var"c\"clang_getCursorDefinition\"" = Cbinding_clang_getCursorDefinition{:clang_getCursorDefinition}()
        (func::Cbinding_clang_getCursorDefinition)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCursorDefinition = var"c\"clang_getCursorDefinition\""
        export var"c\"clang_getCursorDefinition\""
        export clang_getCursorDefinition
        var"c\"clang_getCursorDefinition\""
        struct Cbinding_clang_isCursorDefinition{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_isCursorDefinition}
        end
        const var"c\"clang_isCursorDefinition\"" = Cbinding_clang_isCursorDefinition{:clang_isCursorDefinition}()
        (func::Cbinding_clang_isCursorDefinition)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_isCursorDefinition = var"c\"clang_isCursorDefinition\""
        export var"c\"clang_isCursorDefinition\""
        export clang_isCursorDefinition
        var"c\"clang_isCursorDefinition\""
        struct Cbinding_clang_getCanonicalCursor{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCanonicalCursor}
        end
        const var"c\"clang_getCanonicalCursor\"" = Cbinding_clang_getCanonicalCursor{:clang_getCanonicalCursor}()
        (func::Cbinding_clang_getCanonicalCursor)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getCanonicalCursor = var"c\"clang_getCanonicalCursor\""
        export var"c\"clang_getCanonicalCursor\""
        export clang_getCanonicalCursor
        var"c\"clang_getCanonicalCursor\""
        struct Cbinding_clang_Cursor_getObjCSelectorIndex{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getObjCSelectorIndex}
        end
        const var"c\"clang_Cursor_getObjCSelectorIndex\"" = Cbinding_clang_Cursor_getObjCSelectorIndex{:clang_Cursor_getObjCSelectorIndex}()
        (func::Cbinding_clang_Cursor_getObjCSelectorIndex)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_Cursor_getObjCSelectorIndex = var"c\"clang_Cursor_getObjCSelectorIndex\""
        export var"c\"clang_Cursor_getObjCSelectorIndex\""
        export clang_Cursor_getObjCSelectorIndex
        var"c\"clang_Cursor_getObjCSelectorIndex\""
        struct Cbinding_clang_Cursor_isDynamicCall{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isDynamicCall}
        end
        const var"c\"clang_Cursor_isDynamicCall\"" = Cbinding_clang_Cursor_isDynamicCall{:clang_Cursor_isDynamicCall}()
        (func::Cbinding_clang_Cursor_isDynamicCall)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isDynamicCall = var"c\"clang_Cursor_isDynamicCall\""
        export var"c\"clang_Cursor_isDynamicCall\""
        export clang_Cursor_isDynamicCall
        var"c\"clang_Cursor_isDynamicCall\""
        struct Cbinding_clang_Cursor_getReceiverType{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXType\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getReceiverType}
        end
        const var"c\"clang_Cursor_getReceiverType\"" = Cbinding_clang_Cursor_getReceiverType{:clang_Cursor_getReceiverType}()
        (func::Cbinding_clang_Cursor_getReceiverType)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getReceiverType = var"c\"clang_Cursor_getReceiverType\""
        export var"c\"clang_Cursor_getReceiverType\""
        export clang_Cursor_getReceiverType
        var"c\"clang_Cursor_getReceiverType\""
        abstract type var"c\"CXObjCPropertyAttrKind\"" <: Cenum end
        const CXObjCPropertyAttrKind = var"c\"CXObjCPropertyAttrKind\""
        export var"c\"CXObjCPropertyAttrKind\""
        export CXObjCPropertyAttrKind
        var"c\"CXObjCPropertyAttrKind\""
        primitive type var"(c\"CXObjCPropertyAttrKind\")" <: var"c\"CXObjCPropertyAttrKind\"" 32 end
        (::(Type){var"(c\"CXObjCPropertyAttrKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXObjCPropertyAttrKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXObjCPropertyAttrKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_noattr\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_readonly\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_getter\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_assign\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_readwrite\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_retain\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_copy\""), 0x0000000000000020}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_nonatomic\""), 0x0000000000000040}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_setter\""), 0x0000000000000080}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_atomic\""), 0x0000000000000100}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_weak\""), 0x0000000000000200}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_strong\""), 0x0000000000000400}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_unsafe_unretained\""), 0x0000000000000800}, CBinding.Tuple{Symbol("c\"CXObjCPropertyAttr_class\""), 0x0000000000001000}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXObjCPropertyAttrKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXObjCPropertyAttrKind\")"}) = begin
                var"(c\"CXObjCPropertyAttrKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXObjCPropertyAttrKind\""}) = begin
                var"(c\"CXObjCPropertyAttrKind\")"
            end
        const var"c\"CXObjCPropertyAttr_noattr\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000000)
        const var"c\"CXObjCPropertyAttr_readonly\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000001)
        const var"c\"CXObjCPropertyAttr_getter\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000002)
        const var"c\"CXObjCPropertyAttr_assign\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000004)
        const var"c\"CXObjCPropertyAttr_readwrite\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000008)
        const var"c\"CXObjCPropertyAttr_retain\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000010)
        const var"c\"CXObjCPropertyAttr_copy\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000020)
        const var"c\"CXObjCPropertyAttr_nonatomic\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000040)
        const var"c\"CXObjCPropertyAttr_setter\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000080)
        const var"c\"CXObjCPropertyAttr_atomic\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000100)
        const var"c\"CXObjCPropertyAttr_weak\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000200)
        const var"c\"CXObjCPropertyAttr_strong\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000400)
        const var"c\"CXObjCPropertyAttr_unsafe_unretained\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000000800)
        const var"c\"CXObjCPropertyAttr_class\"" = var"(c\"CXObjCPropertyAttrKind\")"(0x0000000000001000)
        const CXObjCPropertyAttrKind = var"c\"CXObjCPropertyAttrKind\""
        const CXObjCPropertyAttr_noattr = var"c\"CXObjCPropertyAttr_noattr\""
        const CXObjCPropertyAttr_readonly = var"c\"CXObjCPropertyAttr_readonly\""
        const CXObjCPropertyAttr_getter = var"c\"CXObjCPropertyAttr_getter\""
        const CXObjCPropertyAttr_assign = var"c\"CXObjCPropertyAttr_assign\""
        const CXObjCPropertyAttr_readwrite = var"c\"CXObjCPropertyAttr_readwrite\""
        const CXObjCPropertyAttr_retain = var"c\"CXObjCPropertyAttr_retain\""
        const CXObjCPropertyAttr_copy = var"c\"CXObjCPropertyAttr_copy\""
        const CXObjCPropertyAttr_nonatomic = var"c\"CXObjCPropertyAttr_nonatomic\""
        const CXObjCPropertyAttr_setter = var"c\"CXObjCPropertyAttr_setter\""
        const CXObjCPropertyAttr_atomic = var"c\"CXObjCPropertyAttr_atomic\""
        const CXObjCPropertyAttr_weak = var"c\"CXObjCPropertyAttr_weak\""
        const CXObjCPropertyAttr_strong = var"c\"CXObjCPropertyAttr_strong\""
        const CXObjCPropertyAttr_unsafe_unretained = var"c\"CXObjCPropertyAttr_unsafe_unretained\""
        const CXObjCPropertyAttr_class = var"c\"CXObjCPropertyAttr_class\""
        export var"c\"CXObjCPropertyAttrKind\"", var"(c\"CXObjCPropertyAttrKind\")", var"c\"CXObjCPropertyAttr_noattr\"", var"c\"CXObjCPropertyAttr_readonly\"", var"c\"CXObjCPropertyAttr_getter\"", var"c\"CXObjCPropertyAttr_assign\"", var"c\"CXObjCPropertyAttr_readwrite\"", var"c\"CXObjCPropertyAttr_retain\"", var"c\"CXObjCPropertyAttr_copy\"", var"c\"CXObjCPropertyAttr_nonatomic\"", var"c\"CXObjCPropertyAttr_setter\"", var"c\"CXObjCPropertyAttr_atomic\"", var"c\"CXObjCPropertyAttr_weak\"", var"c\"CXObjCPropertyAttr_strong\"", var"c\"CXObjCPropertyAttr_unsafe_unretained\"", var"c\"CXObjCPropertyAttr_class\""
        export CXObjCPropertyAttrKind, CXObjCPropertyAttr_noattr, CXObjCPropertyAttr_readonly, CXObjCPropertyAttr_getter, CXObjCPropertyAttr_assign, CXObjCPropertyAttr_readwrite, CXObjCPropertyAttr_retain, CXObjCPropertyAttr_copy, CXObjCPropertyAttr_nonatomic, CXObjCPropertyAttr_setter, CXObjCPropertyAttr_atomic, CXObjCPropertyAttr_weak, CXObjCPropertyAttr_strong, CXObjCPropertyAttr_unsafe_unretained, CXObjCPropertyAttr_class
        var"c\"CXObjCPropertyAttrKind\""
        struct Cbinding_clang_Cursor_getObjCPropertyAttributes{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Cursor_getObjCPropertyAttributes}
        end
        const var"c\"clang_Cursor_getObjCPropertyAttributes\"" = Cbinding_clang_Cursor_getObjCPropertyAttributes{:clang_Cursor_getObjCPropertyAttributes}()
        (func::Cbinding_clang_Cursor_getObjCPropertyAttributes)(var"c\"C\"", var"c\"reserved\"") = begin
                CBinding.funccall(func, var"c\"C\"", var"c\"reserved\"")
            end
        const clang_Cursor_getObjCPropertyAttributes = var"c\"clang_Cursor_getObjCPropertyAttributes\""
        export var"c\"clang_Cursor_getObjCPropertyAttributes\""
        export clang_Cursor_getObjCPropertyAttributes
        var"c\"clang_Cursor_getObjCPropertyAttributes\""
        struct Cbinding_clang_Cursor_getObjCPropertyGetterName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getObjCPropertyGetterName}
        end
        const var"c\"clang_Cursor_getObjCPropertyGetterName\"" = Cbinding_clang_Cursor_getObjCPropertyGetterName{:clang_Cursor_getObjCPropertyGetterName}()
        (func::Cbinding_clang_Cursor_getObjCPropertyGetterName)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getObjCPropertyGetterName = var"c\"clang_Cursor_getObjCPropertyGetterName\""
        export var"c\"clang_Cursor_getObjCPropertyGetterName\""
        export clang_Cursor_getObjCPropertyGetterName
        var"c\"clang_Cursor_getObjCPropertyGetterName\""
        struct Cbinding_clang_Cursor_getObjCPropertySetterName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getObjCPropertySetterName}
        end
        const var"c\"clang_Cursor_getObjCPropertySetterName\"" = Cbinding_clang_Cursor_getObjCPropertySetterName{:clang_Cursor_getObjCPropertySetterName}()
        (func::Cbinding_clang_Cursor_getObjCPropertySetterName)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getObjCPropertySetterName = var"c\"clang_Cursor_getObjCPropertySetterName\""
        export var"c\"clang_Cursor_getObjCPropertySetterName\""
        export clang_Cursor_getObjCPropertySetterName
        var"c\"clang_Cursor_getObjCPropertySetterName\""
        abstract type var"c\"CXObjCDeclQualifierKind\"" <: Cenum end
        const CXObjCDeclQualifierKind = var"c\"CXObjCDeclQualifierKind\""
        export var"c\"CXObjCDeclQualifierKind\""
        export CXObjCDeclQualifierKind
        var"c\"CXObjCDeclQualifierKind\""
        primitive type var"(c\"CXObjCDeclQualifierKind\")" <: var"c\"CXObjCDeclQualifierKind\"" 32 end
        (::(Type){var"(c\"CXObjCDeclQualifierKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXObjCDeclQualifierKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXObjCDeclQualifierKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXObjCDeclQualifier_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXObjCDeclQualifier_In\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXObjCDeclQualifier_Inout\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXObjCDeclQualifier_Out\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXObjCDeclQualifier_Bycopy\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXObjCDeclQualifier_Byref\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXObjCDeclQualifier_Oneway\""), 0x0000000000000020}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXObjCDeclQualifierKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXObjCDeclQualifierKind\")"}) = begin
                var"(c\"CXObjCDeclQualifierKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXObjCDeclQualifierKind\""}) = begin
                var"(c\"CXObjCDeclQualifierKind\")"
            end
        const var"c\"CXObjCDeclQualifier_None\"" = var"(c\"CXObjCDeclQualifierKind\")"(0x0000000000000000)
        const var"c\"CXObjCDeclQualifier_In\"" = var"(c\"CXObjCDeclQualifierKind\")"(0x0000000000000001)
        const var"c\"CXObjCDeclQualifier_Inout\"" = var"(c\"CXObjCDeclQualifierKind\")"(0x0000000000000002)
        const var"c\"CXObjCDeclQualifier_Out\"" = var"(c\"CXObjCDeclQualifierKind\")"(0x0000000000000004)
        const var"c\"CXObjCDeclQualifier_Bycopy\"" = var"(c\"CXObjCDeclQualifierKind\")"(0x0000000000000008)
        const var"c\"CXObjCDeclQualifier_Byref\"" = var"(c\"CXObjCDeclQualifierKind\")"(0x0000000000000010)
        const var"c\"CXObjCDeclQualifier_Oneway\"" = var"(c\"CXObjCDeclQualifierKind\")"(0x0000000000000020)
        const CXObjCDeclQualifierKind = var"c\"CXObjCDeclQualifierKind\""
        const CXObjCDeclQualifier_None = var"c\"CXObjCDeclQualifier_None\""
        const CXObjCDeclQualifier_In = var"c\"CXObjCDeclQualifier_In\""
        const CXObjCDeclQualifier_Inout = var"c\"CXObjCDeclQualifier_Inout\""
        const CXObjCDeclQualifier_Out = var"c\"CXObjCDeclQualifier_Out\""
        const CXObjCDeclQualifier_Bycopy = var"c\"CXObjCDeclQualifier_Bycopy\""
        const CXObjCDeclQualifier_Byref = var"c\"CXObjCDeclQualifier_Byref\""
        const CXObjCDeclQualifier_Oneway = var"c\"CXObjCDeclQualifier_Oneway\""
        export var"c\"CXObjCDeclQualifierKind\"", var"(c\"CXObjCDeclQualifierKind\")", var"c\"CXObjCDeclQualifier_None\"", var"c\"CXObjCDeclQualifier_In\"", var"c\"CXObjCDeclQualifier_Inout\"", var"c\"CXObjCDeclQualifier_Out\"", var"c\"CXObjCDeclQualifier_Bycopy\"", var"c\"CXObjCDeclQualifier_Byref\"", var"c\"CXObjCDeclQualifier_Oneway\""
        export CXObjCDeclQualifierKind, CXObjCDeclQualifier_None, CXObjCDeclQualifier_In, CXObjCDeclQualifier_Inout, CXObjCDeclQualifier_Out, CXObjCDeclQualifier_Bycopy, CXObjCDeclQualifier_Byref, CXObjCDeclQualifier_Oneway
        var"c\"CXObjCDeclQualifierKind\""
        struct Cbinding_clang_Cursor_getObjCDeclQualifiers{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getObjCDeclQualifiers}
        end
        const var"c\"clang_Cursor_getObjCDeclQualifiers\"" = Cbinding_clang_Cursor_getObjCDeclQualifiers{:clang_Cursor_getObjCDeclQualifiers}()
        (func::Cbinding_clang_Cursor_getObjCDeclQualifiers)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getObjCDeclQualifiers = var"c\"clang_Cursor_getObjCDeclQualifiers\""
        export var"c\"clang_Cursor_getObjCDeclQualifiers\""
        export clang_Cursor_getObjCDeclQualifiers
        var"c\"clang_Cursor_getObjCDeclQualifiers\""
        struct Cbinding_clang_Cursor_isObjCOptional{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isObjCOptional}
        end
        const var"c\"clang_Cursor_isObjCOptional\"" = Cbinding_clang_Cursor_isObjCOptional{:clang_Cursor_isObjCOptional}()
        (func::Cbinding_clang_Cursor_isObjCOptional)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isObjCOptional = var"c\"clang_Cursor_isObjCOptional\""
        export var"c\"clang_Cursor_isObjCOptional\""
        export clang_Cursor_isObjCOptional
        var"c\"clang_Cursor_isObjCOptional\""
        struct Cbinding_clang_Cursor_isVariadic{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_isVariadic}
        end
        const var"c\"clang_Cursor_isVariadic\"" = Cbinding_clang_Cursor_isVariadic{:clang_Cursor_isVariadic}()
        (func::Cbinding_clang_Cursor_isVariadic)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_isVariadic = var"c\"clang_Cursor_isVariadic\""
        export var"c\"clang_Cursor_isVariadic\""
        export clang_Cursor_isVariadic
        var"c\"clang_Cursor_isVariadic\""
        struct Cbinding_clang_Cursor_isExternalSymbol{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cptr{var"c\"CXString\""}, CBinding.Cptr{var"c\"CXString\""}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_Cursor_isExternalSymbol}
        end
        const var"c\"clang_Cursor_isExternalSymbol\"" = Cbinding_clang_Cursor_isExternalSymbol{:clang_Cursor_isExternalSymbol}()
        (func::Cbinding_clang_Cursor_isExternalSymbol)(var"c\"C\"", var"c\"language\"", var"c\"definedIn\"", var"c\"isGenerated\"") = begin
                CBinding.funccall(func, var"c\"C\"", var"c\"language\"", var"c\"definedIn\"", var"c\"isGenerated\"")
            end
        const clang_Cursor_isExternalSymbol = var"c\"clang_Cursor_isExternalSymbol\""
        export var"c\"clang_Cursor_isExternalSymbol\""
        export clang_Cursor_isExternalSymbol
        var"c\"clang_Cursor_isExternalSymbol\""
        struct Cbinding_clang_Cursor_getCommentRange{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceRange\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getCommentRange}
        end
        const var"c\"clang_Cursor_getCommentRange\"" = Cbinding_clang_Cursor_getCommentRange{:clang_Cursor_getCommentRange}()
        (func::Cbinding_clang_Cursor_getCommentRange)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getCommentRange = var"c\"clang_Cursor_getCommentRange\""
        export var"c\"clang_Cursor_getCommentRange\""
        export clang_Cursor_getCommentRange
        var"c\"clang_Cursor_getCommentRange\""
        struct Cbinding_clang_Cursor_getRawCommentText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getRawCommentText}
        end
        const var"c\"clang_Cursor_getRawCommentText\"" = Cbinding_clang_Cursor_getRawCommentText{:clang_Cursor_getRawCommentText}()
        (func::Cbinding_clang_Cursor_getRawCommentText)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getRawCommentText = var"c\"clang_Cursor_getRawCommentText\""
        export var"c\"clang_Cursor_getRawCommentText\""
        export clang_Cursor_getRawCommentText
        var"c\"clang_Cursor_getRawCommentText\""
        struct Cbinding_clang_Cursor_getBriefCommentText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getBriefCommentText}
        end
        const var"c\"clang_Cursor_getBriefCommentText\"" = Cbinding_clang_Cursor_getBriefCommentText{:clang_Cursor_getBriefCommentText}()
        (func::Cbinding_clang_Cursor_getBriefCommentText)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getBriefCommentText = var"c\"clang_Cursor_getBriefCommentText\""
        export var"c\"clang_Cursor_getBriefCommentText\""
        export clang_Cursor_getBriefCommentText
        var"c\"clang_Cursor_getBriefCommentText\""
        struct Cbinding_clang_Cursor_getMangling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getMangling}
        end
        const var"c\"clang_Cursor_getMangling\"" = Cbinding_clang_Cursor_getMangling{:clang_Cursor_getMangling}()
        (func::Cbinding_clang_Cursor_getMangling)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_Cursor_getMangling = var"c\"clang_Cursor_getMangling\""
        export var"c\"clang_Cursor_getMangling\""
        export clang_Cursor_getMangling
        var"c\"clang_Cursor_getMangling\""
        struct Cbinding_clang_Cursor_getCXXManglings{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{var"c\"CXStringSet\""}, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getCXXManglings}
        end
        const var"c\"clang_Cursor_getCXXManglings\"" = Cbinding_clang_Cursor_getCXXManglings{:clang_Cursor_getCXXManglings}()
        (func::Cbinding_clang_Cursor_getCXXManglings)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_Cursor_getCXXManglings = var"c\"clang_Cursor_getCXXManglings\""
        export var"c\"clang_Cursor_getCXXManglings\""
        export clang_Cursor_getCXXManglings
        var"c\"clang_Cursor_getCXXManglings\""
        struct Cbinding_clang_Cursor_getObjCManglings{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{var"c\"CXStringSet\""}, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getObjCManglings}
        end
        const var"c\"clang_Cursor_getObjCManglings\"" = Cbinding_clang_Cursor_getObjCManglings{:clang_Cursor_getObjCManglings}()
        (func::Cbinding_clang_Cursor_getObjCManglings)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_Cursor_getObjCManglings = var"c\"clang_Cursor_getObjCManglings\""
        export var"c\"clang_Cursor_getObjCManglings\""
        export clang_Cursor_getObjCManglings
        var"c\"clang_Cursor_getObjCManglings\""
        const var"c\"CXModule\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXModule = var"c\"CXModule\""
        export var"c\"CXModule\""
        export CXModule
        var"c\"CXModule\""
        struct Cbinding_clang_Cursor_getModule{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXModule\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getModule}
        end
        const var"c\"clang_Cursor_getModule\"" = Cbinding_clang_Cursor_getModule{:clang_Cursor_getModule}()
        (func::Cbinding_clang_Cursor_getModule)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getModule = var"c\"clang_Cursor_getModule\""
        export var"c\"clang_Cursor_getModule\""
        export clang_Cursor_getModule
        var"c\"clang_Cursor_getModule\""
        struct Cbinding_clang_getModuleForFile{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXModule\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXFile\""}, :cdecl}, libpath, :clang_getModuleForFile}
        end
        const var"c\"clang_getModuleForFile\"" = Cbinding_clang_getModuleForFile{:clang_getModuleForFile}()
        (func::Cbinding_clang_getModuleForFile)(arg1, arg2) = begin
                CBinding.funccall(func, arg1, arg2)
            end
        const clang_getModuleForFile = var"c\"clang_getModuleForFile\""
        export var"c\"clang_getModuleForFile\""
        export clang_getModuleForFile
        var"c\"clang_getModuleForFile\""
        struct Cbinding_clang_Module_getASTFile{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXFile\"", CBinding.Tuple{var"c\"CXModule\""}, :cdecl}, libpath, :clang_Module_getASTFile}
        end
        const var"c\"clang_Module_getASTFile\"" = Cbinding_clang_Module_getASTFile{:clang_Module_getASTFile}()
        (func::Cbinding_clang_Module_getASTFile)(var"c\"Module\"") = begin
                CBinding.funccall(func, var"c\"Module\"")
            end
        const clang_Module_getASTFile = var"c\"clang_Module_getASTFile\""
        export var"c\"clang_Module_getASTFile\""
        export clang_Module_getASTFile
        var"c\"clang_Module_getASTFile\""
        struct Cbinding_clang_Module_getParent{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXModule\"", CBinding.Tuple{var"c\"CXModule\""}, :cdecl}, libpath, :clang_Module_getParent}
        end
        const var"c\"clang_Module_getParent\"" = Cbinding_clang_Module_getParent{:clang_Module_getParent}()
        (func::Cbinding_clang_Module_getParent)(var"c\"Module\"") = begin
                CBinding.funccall(func, var"c\"Module\"")
            end
        const clang_Module_getParent = var"c\"clang_Module_getParent\""
        export var"c\"clang_Module_getParent\""
        export clang_Module_getParent
        var"c\"clang_Module_getParent\""
        struct Cbinding_clang_Module_getName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXModule\""}, :cdecl}, libpath, :clang_Module_getName}
        end
        const var"c\"clang_Module_getName\"" = Cbinding_clang_Module_getName{:clang_Module_getName}()
        (func::Cbinding_clang_Module_getName)(var"c\"Module\"") = begin
                CBinding.funccall(func, var"c\"Module\"")
            end
        const clang_Module_getName = var"c\"clang_Module_getName\""
        export var"c\"clang_Module_getName\""
        export clang_Module_getName
        var"c\"clang_Module_getName\""
        struct Cbinding_clang_Module_getFullName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXModule\""}, :cdecl}, libpath, :clang_Module_getFullName}
        end
        const var"c\"clang_Module_getFullName\"" = Cbinding_clang_Module_getFullName{:clang_Module_getFullName}()
        (func::Cbinding_clang_Module_getFullName)(var"c\"Module\"") = begin
                CBinding.funccall(func, var"c\"Module\"")
            end
        const clang_Module_getFullName = var"c\"clang_Module_getFullName\""
        export var"c\"clang_Module_getFullName\""
        export clang_Module_getFullName
        var"c\"clang_Module_getFullName\""
        struct Cbinding_clang_Module_isSystem{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXModule\""}, :cdecl}, libpath, :clang_Module_isSystem}
        end
        const var"c\"clang_Module_isSystem\"" = Cbinding_clang_Module_isSystem{:clang_Module_isSystem}()
        (func::Cbinding_clang_Module_isSystem)(var"c\"Module\"") = begin
                CBinding.funccall(func, var"c\"Module\"")
            end
        const clang_Module_isSystem = var"c\"clang_Module_isSystem\""
        export var"c\"clang_Module_isSystem\""
        export clang_Module_isSystem
        var"c\"clang_Module_isSystem\""
        struct Cbinding_clang_Module_getNumTopLevelHeaders{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXModule\""}, :cdecl}, libpath, :clang_Module_getNumTopLevelHeaders}
        end
        const var"c\"clang_Module_getNumTopLevelHeaders\"" = Cbinding_clang_Module_getNumTopLevelHeaders{:clang_Module_getNumTopLevelHeaders}()
        (func::Cbinding_clang_Module_getNumTopLevelHeaders)(arg1, var"c\"Module\"") = begin
                CBinding.funccall(func, arg1, var"c\"Module\"")
            end
        const clang_Module_getNumTopLevelHeaders = var"c\"clang_Module_getNumTopLevelHeaders\""
        export var"c\"clang_Module_getNumTopLevelHeaders\""
        export clang_Module_getNumTopLevelHeaders
        var"c\"clang_Module_getNumTopLevelHeaders\""
        struct Cbinding_clang_Module_getTopLevelHeader{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXFile\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXModule\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Module_getTopLevelHeader}
        end
        const var"c\"clang_Module_getTopLevelHeader\"" = Cbinding_clang_Module_getTopLevelHeader{:clang_Module_getTopLevelHeader}()
        (func::Cbinding_clang_Module_getTopLevelHeader)(arg1, var"c\"Module\"", var"c\"Index\"") = begin
                CBinding.funccall(func, arg1, var"c\"Module\"", var"c\"Index\"")
            end
        const clang_Module_getTopLevelHeader = var"c\"clang_Module_getTopLevelHeader\""
        export var"c\"clang_Module_getTopLevelHeader\""
        export clang_Module_getTopLevelHeader
        var"c\"clang_Module_getTopLevelHeader\""
        struct Cbinding_clang_CXXConstructor_isConvertingConstructor{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXConstructor_isConvertingConstructor}
        end
        const var"c\"clang_CXXConstructor_isConvertingConstructor\"" = Cbinding_clang_CXXConstructor_isConvertingConstructor{:clang_CXXConstructor_isConvertingConstructor}()
        (func::Cbinding_clang_CXXConstructor_isConvertingConstructor)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXConstructor_isConvertingConstructor = var"c\"clang_CXXConstructor_isConvertingConstructor\""
        export var"c\"clang_CXXConstructor_isConvertingConstructor\""
        export clang_CXXConstructor_isConvertingConstructor
        var"c\"clang_CXXConstructor_isConvertingConstructor\""
        struct Cbinding_clang_CXXConstructor_isCopyConstructor{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXConstructor_isCopyConstructor}
        end
        const var"c\"clang_CXXConstructor_isCopyConstructor\"" = Cbinding_clang_CXXConstructor_isCopyConstructor{:clang_CXXConstructor_isCopyConstructor}()
        (func::Cbinding_clang_CXXConstructor_isCopyConstructor)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXConstructor_isCopyConstructor = var"c\"clang_CXXConstructor_isCopyConstructor\""
        export var"c\"clang_CXXConstructor_isCopyConstructor\""
        export clang_CXXConstructor_isCopyConstructor
        var"c\"clang_CXXConstructor_isCopyConstructor\""
        struct Cbinding_clang_CXXConstructor_isDefaultConstructor{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXConstructor_isDefaultConstructor}
        end
        const var"c\"clang_CXXConstructor_isDefaultConstructor\"" = Cbinding_clang_CXXConstructor_isDefaultConstructor{:clang_CXXConstructor_isDefaultConstructor}()
        (func::Cbinding_clang_CXXConstructor_isDefaultConstructor)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXConstructor_isDefaultConstructor = var"c\"clang_CXXConstructor_isDefaultConstructor\""
        export var"c\"clang_CXXConstructor_isDefaultConstructor\""
        export clang_CXXConstructor_isDefaultConstructor
        var"c\"clang_CXXConstructor_isDefaultConstructor\""
        struct Cbinding_clang_CXXConstructor_isMoveConstructor{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXConstructor_isMoveConstructor}
        end
        const var"c\"clang_CXXConstructor_isMoveConstructor\"" = Cbinding_clang_CXXConstructor_isMoveConstructor{:clang_CXXConstructor_isMoveConstructor}()
        (func::Cbinding_clang_CXXConstructor_isMoveConstructor)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXConstructor_isMoveConstructor = var"c\"clang_CXXConstructor_isMoveConstructor\""
        export var"c\"clang_CXXConstructor_isMoveConstructor\""
        export clang_CXXConstructor_isMoveConstructor
        var"c\"clang_CXXConstructor_isMoveConstructor\""
        struct Cbinding_clang_CXXField_isMutable{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXField_isMutable}
        end
        const var"c\"clang_CXXField_isMutable\"" = Cbinding_clang_CXXField_isMutable{:clang_CXXField_isMutable}()
        (func::Cbinding_clang_CXXField_isMutable)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXField_isMutable = var"c\"clang_CXXField_isMutable\""
        export var"c\"clang_CXXField_isMutable\""
        export clang_CXXField_isMutable
        var"c\"clang_CXXField_isMutable\""
        struct Cbinding_clang_CXXMethod_isDefaulted{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isDefaulted}
        end
        const var"c\"clang_CXXMethod_isDefaulted\"" = Cbinding_clang_CXXMethod_isDefaulted{:clang_CXXMethod_isDefaulted}()
        (func::Cbinding_clang_CXXMethod_isDefaulted)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isDefaulted = var"c\"clang_CXXMethod_isDefaulted\""
        export var"c\"clang_CXXMethod_isDefaulted\""
        export clang_CXXMethod_isDefaulted
        var"c\"clang_CXXMethod_isDefaulted\""
        struct Cbinding_clang_CXXMethod_isDeleted{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isDeleted}
        end
        const var"c\"clang_CXXMethod_isDeleted\"" = Cbinding_clang_CXXMethod_isDeleted{:clang_CXXMethod_isDeleted}()
        (func::Cbinding_clang_CXXMethod_isDeleted)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isDeleted = var"c\"clang_CXXMethod_isDeleted\""
        export var"c\"clang_CXXMethod_isDeleted\""
        export clang_CXXMethod_isDeleted
        var"c\"clang_CXXMethod_isDeleted\""
        struct Cbinding_clang_CXXMethod_isPureVirtual{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isPureVirtual}
        end
        const var"c\"clang_CXXMethod_isPureVirtual\"" = Cbinding_clang_CXXMethod_isPureVirtual{:clang_CXXMethod_isPureVirtual}()
        (func::Cbinding_clang_CXXMethod_isPureVirtual)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isPureVirtual = var"c\"clang_CXXMethod_isPureVirtual\""
        export var"c\"clang_CXXMethod_isPureVirtual\""
        export clang_CXXMethod_isPureVirtual
        var"c\"clang_CXXMethod_isPureVirtual\""
        struct Cbinding_clang_CXXMethod_isStatic{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isStatic}
        end
        const var"c\"clang_CXXMethod_isStatic\"" = Cbinding_clang_CXXMethod_isStatic{:clang_CXXMethod_isStatic}()
        (func::Cbinding_clang_CXXMethod_isStatic)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isStatic = var"c\"clang_CXXMethod_isStatic\""
        export var"c\"clang_CXXMethod_isStatic\""
        export clang_CXXMethod_isStatic
        var"c\"clang_CXXMethod_isStatic\""
        struct Cbinding_clang_CXXMethod_isVirtual{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isVirtual}
        end
        const var"c\"clang_CXXMethod_isVirtual\"" = Cbinding_clang_CXXMethod_isVirtual{:clang_CXXMethod_isVirtual}()
        (func::Cbinding_clang_CXXMethod_isVirtual)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isVirtual = var"c\"clang_CXXMethod_isVirtual\""
        export var"c\"clang_CXXMethod_isVirtual\""
        export clang_CXXMethod_isVirtual
        var"c\"clang_CXXMethod_isVirtual\""
        struct Cbinding_clang_CXXMethod_isCopyAssignmentOperator{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isCopyAssignmentOperator}
        end
        const var"c\"clang_CXXMethod_isCopyAssignmentOperator\"" = Cbinding_clang_CXXMethod_isCopyAssignmentOperator{:clang_CXXMethod_isCopyAssignmentOperator}()
        (func::Cbinding_clang_CXXMethod_isCopyAssignmentOperator)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isCopyAssignmentOperator = var"c\"clang_CXXMethod_isCopyAssignmentOperator\""
        export var"c\"clang_CXXMethod_isCopyAssignmentOperator\""
        export clang_CXXMethod_isCopyAssignmentOperator
        var"c\"clang_CXXMethod_isCopyAssignmentOperator\""
        struct Cbinding_clang_CXXMethod_isMoveAssignmentOperator{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isMoveAssignmentOperator}
        end
        const var"c\"clang_CXXMethod_isMoveAssignmentOperator\"" = Cbinding_clang_CXXMethod_isMoveAssignmentOperator{:clang_CXXMethod_isMoveAssignmentOperator}()
        (func::Cbinding_clang_CXXMethod_isMoveAssignmentOperator)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isMoveAssignmentOperator = var"c\"clang_CXXMethod_isMoveAssignmentOperator\""
        export var"c\"clang_CXXMethod_isMoveAssignmentOperator\""
        export clang_CXXMethod_isMoveAssignmentOperator
        var"c\"clang_CXXMethod_isMoveAssignmentOperator\""
        struct Cbinding_clang_CXXMethod_isExplicit{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isExplicit}
        end
        const var"c\"clang_CXXMethod_isExplicit\"" = Cbinding_clang_CXXMethod_isExplicit{:clang_CXXMethod_isExplicit}()
        (func::Cbinding_clang_CXXMethod_isExplicit)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isExplicit = var"c\"clang_CXXMethod_isExplicit\""
        export var"c\"clang_CXXMethod_isExplicit\""
        export clang_CXXMethod_isExplicit
        var"c\"clang_CXXMethod_isExplicit\""
        struct Cbinding_clang_CXXRecord_isAbstract{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXRecord_isAbstract}
        end
        const var"c\"clang_CXXRecord_isAbstract\"" = Cbinding_clang_CXXRecord_isAbstract{:clang_CXXRecord_isAbstract}()
        (func::Cbinding_clang_CXXRecord_isAbstract)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXRecord_isAbstract = var"c\"clang_CXXRecord_isAbstract\""
        export var"c\"clang_CXXRecord_isAbstract\""
        export clang_CXXRecord_isAbstract
        var"c\"clang_CXXRecord_isAbstract\""
        struct Cbinding_clang_EnumDecl_isScoped{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_EnumDecl_isScoped}
        end
        const var"c\"clang_EnumDecl_isScoped\"" = Cbinding_clang_EnumDecl_isScoped{:clang_EnumDecl_isScoped}()
        (func::Cbinding_clang_EnumDecl_isScoped)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_EnumDecl_isScoped = var"c\"clang_EnumDecl_isScoped\""
        export var"c\"clang_EnumDecl_isScoped\""
        export clang_EnumDecl_isScoped
        var"c\"clang_EnumDecl_isScoped\""
        struct Cbinding_clang_CXXMethod_isConst{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_CXXMethod_isConst}
        end
        const var"c\"clang_CXXMethod_isConst\"" = Cbinding_clang_CXXMethod_isConst{:clang_CXXMethod_isConst}()
        (func::Cbinding_clang_CXXMethod_isConst)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_CXXMethod_isConst = var"c\"clang_CXXMethod_isConst\""
        export var"c\"clang_CXXMethod_isConst\""
        export clang_CXXMethod_isConst
        var"c\"clang_CXXMethod_isConst\""
        struct Cbinding_clang_getTemplateCursorKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXCursorKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getTemplateCursorKind}
        end
        const var"c\"clang_getTemplateCursorKind\"" = Cbinding_clang_getTemplateCursorKind{:clang_getTemplateCursorKind}()
        (func::Cbinding_clang_getTemplateCursorKind)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getTemplateCursorKind = var"c\"clang_getTemplateCursorKind\""
        export var"c\"clang_getTemplateCursorKind\""
        export clang_getTemplateCursorKind
        var"c\"clang_getTemplateCursorKind\""
        struct Cbinding_clang_getSpecializedCursorTemplate{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCursor\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getSpecializedCursorTemplate}
        end
        const var"c\"clang_getSpecializedCursorTemplate\"" = Cbinding_clang_getSpecializedCursorTemplate{:clang_getSpecializedCursorTemplate}()
        (func::Cbinding_clang_getSpecializedCursorTemplate)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_getSpecializedCursorTemplate = var"c\"clang_getSpecializedCursorTemplate\""
        export var"c\"clang_getSpecializedCursorTemplate\""
        export clang_getSpecializedCursorTemplate
        var"c\"clang_getSpecializedCursorTemplate\""
        struct Cbinding_clang_getCursorReferenceNameRange{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceRange\"", CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cuint, CBinding.Cuint}, :cdecl}, libpath, :clang_getCursorReferenceNameRange}
        end
        const var"c\"clang_getCursorReferenceNameRange\"" = Cbinding_clang_getCursorReferenceNameRange{:clang_getCursorReferenceNameRange}()
        (func::Cbinding_clang_getCursorReferenceNameRange)(var"c\"C\"", var"c\"NameFlags\"", var"c\"PieceIndex\"") = begin
                CBinding.funccall(func, var"c\"C\"", var"c\"NameFlags\"", var"c\"PieceIndex\"")
            end
        const clang_getCursorReferenceNameRange = var"c\"clang_getCursorReferenceNameRange\""
        export var"c\"clang_getCursorReferenceNameRange\""
        export clang_getCursorReferenceNameRange
        var"c\"clang_getCursorReferenceNameRange\""
        abstract type var"c\"enum CXNameRefFlags\"" <: Cenum end
        const CXNameRefFlags = var"c\"enum CXNameRefFlags\""
        export var"c\"enum CXNameRefFlags\""
        export CXNameRefFlags
        var"c\"enum CXNameRefFlags\""
        primitive type var"(c\"enum CXNameRefFlags\")" <: var"c\"enum CXNameRefFlags\"" 32 end
        (::(Type){var"(c\"enum CXNameRefFlags\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXNameRefFlags\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXNameRefFlags\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXNameRange_WantQualifier\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXNameRange_WantTemplateArgs\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXNameRange_WantSinglePiece\""), 0x0000000000000004}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXNameRefFlags\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXNameRefFlags\")"}) = begin
                var"(c\"enum CXNameRefFlags\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXNameRefFlags\""}) = begin
                var"(c\"enum CXNameRefFlags\")"
            end
        const var"c\"CXNameRange_WantQualifier\"" = var"(c\"enum CXNameRefFlags\")"(0x0000000000000001)
        const var"c\"CXNameRange_WantTemplateArgs\"" = var"(c\"enum CXNameRefFlags\")"(0x0000000000000002)
        const var"c\"CXNameRange_WantSinglePiece\"" = var"(c\"enum CXNameRefFlags\")"(0x0000000000000004)
        const CXNameRefFlags = var"c\"enum CXNameRefFlags\""
        const CXNameRange_WantQualifier = var"c\"CXNameRange_WantQualifier\""
        const CXNameRange_WantTemplateArgs = var"c\"CXNameRange_WantTemplateArgs\""
        const CXNameRange_WantSinglePiece = var"c\"CXNameRange_WantSinglePiece\""
        export var"c\"enum CXNameRefFlags\"", var"(c\"enum CXNameRefFlags\")", var"c\"CXNameRange_WantQualifier\"", var"c\"CXNameRange_WantTemplateArgs\"", var"c\"CXNameRange_WantSinglePiece\""
        export CXNameRefFlags, CXNameRange_WantQualifier, CXNameRange_WantTemplateArgs, CXNameRange_WantSinglePiece
        var"c\"enum CXNameRefFlags\""
        abstract type var"c\"enum CXTokenKind\"" <: Cenum end
        const CXTokenKind = var"c\"enum CXTokenKind\""
        export var"c\"enum CXTokenKind\""
        export CXTokenKind
        var"c\"enum CXTokenKind\""
        primitive type var"(c\"enum CXTokenKind\")" <: var"c\"enum CXTokenKind\"" 32 end
        (::(Type){var"(c\"enum CXTokenKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXTokenKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXTokenKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXToken_Punctuation\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXToken_Keyword\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXToken_Identifier\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXToken_Literal\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXToken_Comment\""), 0x0000000000000004}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXTokenKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXTokenKind\")"}) = begin
                var"(c\"enum CXTokenKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXTokenKind\""}) = begin
                var"(c\"enum CXTokenKind\")"
            end
        const var"c\"CXToken_Punctuation\"" = var"(c\"enum CXTokenKind\")"(0x0000000000000000)
        const var"c\"CXToken_Keyword\"" = var"(c\"enum CXTokenKind\")"(0x0000000000000001)
        const var"c\"CXToken_Identifier\"" = var"(c\"enum CXTokenKind\")"(0x0000000000000002)
        const var"c\"CXToken_Literal\"" = var"(c\"enum CXTokenKind\")"(0x0000000000000003)
        const var"c\"CXToken_Comment\"" = var"(c\"enum CXTokenKind\")"(0x0000000000000004)
        const CXTokenKind = var"c\"enum CXTokenKind\""
        const CXToken_Punctuation = var"c\"CXToken_Punctuation\""
        const CXToken_Keyword = var"c\"CXToken_Keyword\""
        const CXToken_Identifier = var"c\"CXToken_Identifier\""
        const CXToken_Literal = var"c\"CXToken_Literal\""
        const CXToken_Comment = var"c\"CXToken_Comment\""
        export var"c\"enum CXTokenKind\"", var"(c\"enum CXTokenKind\")", var"c\"CXToken_Punctuation\"", var"c\"CXToken_Keyword\"", var"c\"CXToken_Identifier\"", var"c\"CXToken_Literal\"", var"c\"CXToken_Comment\""
        export CXTokenKind, CXToken_Punctuation, CXToken_Keyword, CXToken_Identifier, CXToken_Literal, CXToken_Comment
        var"c\"enum CXTokenKind\""
        const var"c\"CXTokenKind\"" = var"c\"enum CXTokenKind\""
        const CXTokenKind = var"c\"CXTokenKind\""
        export var"c\"CXTokenKind\""
        export CXTokenKind
        var"c\"CXTokenKind\""
        abstract type var"c\"CXToken\"" <: Cstruct end
        const CXToken = var"c\"CXToken\""
        export var"c\"CXToken\""
        export CXToken
        var"c\"CXToken\""
        struct var"(c\"CXToken\")" <: var"c\"CXToken\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXToken\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXToken\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:int_data, CBinding.Tuple{CBinding.Carray{CBinding.Cuint, 4}, CBinding.bitstype(CBinding.Carray{CBinding.Cuint, 4}), CBinding.integraltype(CBinding.Carray{CBinding.Cuint, 4}), 0, 0, -1}}, CBinding.Tuple{:ptr_data, CBinding.Tuple{CBinding.Cptr{CBinding.Cvoid}, CBinding.bitstype(CBinding.Cptr{CBinding.Cvoid}), CBinding.integraltype(CBinding.Cptr{CBinding.Cvoid}), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXToken\")"}) = begin
                var"(c\"CXToken\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXToken\""}) = begin
                var"(c\"CXToken\")"
            end
        const CXToken = var"c\"CXToken\""
        export var"c\"CXToken\"", var"(c\"CXToken\")"
        export CXToken
        var"c\"CXToken\""
        struct Cbinding_clang_getToken{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{var"c\"CXToken\""}, CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXSourceLocation\""}, :cdecl}, libpath, :clang_getToken}
        end
        const var"c\"clang_getToken\"" = Cbinding_clang_getToken{:clang_getToken}()
        (func::Cbinding_clang_getToken)(var"c\"TU\"", var"c\"Location\"") = begin
                CBinding.funccall(func, var"c\"TU\"", var"c\"Location\"")
            end
        const clang_getToken = var"c\"clang_getToken\""
        export var"c\"clang_getToken\""
        export clang_getToken
        var"c\"clang_getToken\""
        struct Cbinding_clang_getTokenKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXTokenKind\"", CBinding.Tuple{var"c\"CXToken\""}, :cdecl}, libpath, :clang_getTokenKind}
        end
        const var"c\"clang_getTokenKind\"" = Cbinding_clang_getTokenKind{:clang_getTokenKind}()
        (func::Cbinding_clang_getTokenKind)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_getTokenKind = var"c\"clang_getTokenKind\""
        export var"c\"clang_getTokenKind\""
        export clang_getTokenKind
        var"c\"clang_getTokenKind\""
        struct Cbinding_clang_getTokenSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXToken\""}, :cdecl}, libpath, :clang_getTokenSpelling}
        end
        const var"c\"clang_getTokenSpelling\"" = Cbinding_clang_getTokenSpelling{:clang_getTokenSpelling}()
        (func::Cbinding_clang_getTokenSpelling)(arg1, arg2) = begin
                CBinding.funccall(func, arg1, arg2)
            end
        const clang_getTokenSpelling = var"c\"clang_getTokenSpelling\""
        export var"c\"clang_getTokenSpelling\""
        export clang_getTokenSpelling
        var"c\"clang_getTokenSpelling\""
        struct Cbinding_clang_getTokenLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXToken\""}, :cdecl}, libpath, :clang_getTokenLocation}
        end
        const var"c\"clang_getTokenLocation\"" = Cbinding_clang_getTokenLocation{:clang_getTokenLocation}()
        (func::Cbinding_clang_getTokenLocation)(arg1, arg2) = begin
                CBinding.funccall(func, arg1, arg2)
            end
        const clang_getTokenLocation = var"c\"clang_getTokenLocation\""
        export var"c\"clang_getTokenLocation\""
        export clang_getTokenLocation
        var"c\"clang_getTokenLocation\""
        struct Cbinding_clang_getTokenExtent{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceRange\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXToken\""}, :cdecl}, libpath, :clang_getTokenExtent}
        end
        const var"c\"clang_getTokenExtent\"" = Cbinding_clang_getTokenExtent{:clang_getTokenExtent}()
        (func::Cbinding_clang_getTokenExtent)(arg1, arg2) = begin
                CBinding.funccall(func, arg1, arg2)
            end
        const clang_getTokenExtent = var"c\"clang_getTokenExtent\""
        export var"c\"clang_getTokenExtent\""
        export clang_getTokenExtent
        var"c\"clang_getTokenExtent\""
        struct Cbinding_clang_tokenize{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXSourceRange\"", CBinding.Cptr{CBinding.Cptr{var"c\"CXToken\""}}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_tokenize}
        end
        const var"c\"clang_tokenize\"" = Cbinding_clang_tokenize{:clang_tokenize}()
        (func::Cbinding_clang_tokenize)(var"c\"TU\"", var"c\"Range\"", var"c\"Tokens\"", var"c\"NumTokens\"") = begin
                CBinding.funccall(func, var"c\"TU\"", var"c\"Range\"", var"c\"Tokens\"", var"c\"NumTokens\"")
            end
        const clang_tokenize = var"c\"clang_tokenize\""
        export var"c\"clang_tokenize\""
        export clang_tokenize
        var"c\"clang_tokenize\""
        struct Cbinding_clang_annotateTokens{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.Cptr{var"c\"CXToken\""}, CBinding.Cuint, CBinding.Cptr{var"c\"CXCursor\""}}, :cdecl}, libpath, :clang_annotateTokens}
        end
        const var"c\"clang_annotateTokens\"" = Cbinding_clang_annotateTokens{:clang_annotateTokens}()
        (func::Cbinding_clang_annotateTokens)(var"c\"TU\"", var"c\"Tokens\"", var"c\"NumTokens\"", var"c\"Cursors\"") = begin
                CBinding.funccall(func, var"c\"TU\"", var"c\"Tokens\"", var"c\"NumTokens\"", var"c\"Cursors\"")
            end
        const clang_annotateTokens = var"c\"clang_annotateTokens\""
        export var"c\"clang_annotateTokens\""
        export clang_annotateTokens
        var"c\"clang_annotateTokens\""
        struct Cbinding_clang_disposeTokens{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.Cptr{var"c\"CXToken\""}, CBinding.Cuint}, :cdecl}, libpath, :clang_disposeTokens}
        end
        const var"c\"clang_disposeTokens\"" = Cbinding_clang_disposeTokens{:clang_disposeTokens}()
        (func::Cbinding_clang_disposeTokens)(var"c\"TU\"", var"c\"Tokens\"", var"c\"NumTokens\"") = begin
                CBinding.funccall(func, var"c\"TU\"", var"c\"Tokens\"", var"c\"NumTokens\"")
            end
        const clang_disposeTokens = var"c\"clang_disposeTokens\""
        export var"c\"clang_disposeTokens\""
        export clang_disposeTokens
        var"c\"clang_disposeTokens\""
        struct Cbinding_clang_getCursorKindSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"enum CXCursorKind\""}, :cdecl}, libpath, :clang_getCursorKindSpelling}
        end
        const var"c\"clang_getCursorKindSpelling\"" = Cbinding_clang_getCursorKindSpelling{:clang_getCursorKindSpelling}()
        (func::Cbinding_clang_getCursorKindSpelling)(var"c\"Kind\"") = begin
                CBinding.funccall(func, var"c\"Kind\"")
            end
        const clang_getCursorKindSpelling = var"c\"clang_getCursorKindSpelling\""
        export var"c\"clang_getCursorKindSpelling\""
        export clang_getCursorKindSpelling
        var"c\"clang_getCursorKindSpelling\""
        struct Cbinding_clang_getDefinitionSpellingAndExtent{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXCursor\"", CBinding.Cptr{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, CBinding.Cptr{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_getDefinitionSpellingAndExtent}
        end
        const var"c\"clang_getDefinitionSpellingAndExtent\"" = Cbinding_clang_getDefinitionSpellingAndExtent{:clang_getDefinitionSpellingAndExtent}()
        (func::Cbinding_clang_getDefinitionSpellingAndExtent)(arg1, var"c\"startBuf\"", var"c\"endBuf\"", var"c\"startLine\"", var"c\"startColumn\"", var"c\"endLine\"", var"c\"endColumn\"") = begin
                CBinding.funccall(func, arg1, var"c\"startBuf\"", var"c\"endBuf\"", var"c\"startLine\"", var"c\"startColumn\"", var"c\"endLine\"", var"c\"endColumn\"")
            end
        const clang_getDefinitionSpellingAndExtent = var"c\"clang_getDefinitionSpellingAndExtent\""
        export var"c\"clang_getDefinitionSpellingAndExtent\""
        export clang_getDefinitionSpellingAndExtent
        var"c\"clang_getDefinitionSpellingAndExtent\""
        struct Cbinding_clang_enableStackTraces{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{}, :cdecl}, libpath, :clang_enableStackTraces}
        end
        const var"c\"clang_enableStackTraces\"" = Cbinding_clang_enableStackTraces{:clang_enableStackTraces}()
        (func::Cbinding_clang_enableStackTraces)() = begin
                CBinding.funccall(func)
            end
        const clang_enableStackTraces = var"c\"clang_enableStackTraces\""
        export var"c\"clang_enableStackTraces\""
        export clang_enableStackTraces
        var"c\"clang_enableStackTraces\""
        struct Cbinding_clang_executeOnThread{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}, CBinding.Cptr{CBinding.Cvoid}, CBinding.Cuint}, :cdecl}, libpath, :clang_executeOnThread}
        end
        const var"c\"clang_executeOnThread\"" = Cbinding_clang_executeOnThread{:clang_executeOnThread}()
        (func::Cbinding_clang_executeOnThread)(var"c\"fn\"", var"c\"user_data\"", var"c\"stack_size\"") = begin
                CBinding.funccall(func, var"c\"fn\"", var"c\"user_data\"", var"c\"stack_size\"")
            end
        const clang_executeOnThread = var"c\"clang_executeOnThread\""
        export var"c\"clang_executeOnThread\""
        export clang_executeOnThread
        var"c\"clang_executeOnThread\""
        const var"c\"CXCompletionString\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXCompletionString = var"c\"CXCompletionString\""
        export var"c\"CXCompletionString\""
        export CXCompletionString
        var"c\"CXCompletionString\""
        abstract type var"c\"CXCompletionResult\"" <: Cstruct end
        const CXCompletionResult = var"c\"CXCompletionResult\""
        export var"c\"CXCompletionResult\""
        export CXCompletionResult
        var"c\"CXCompletionResult\""
        struct var"(c\"CXCompletionResult\")" <: var"c\"CXCompletionResult\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"CXCompletionResult\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXCompletionResult\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:CursorKind, CBinding.Tuple{var"c\"enum CXCursorKind\"", CBinding.bitstype(var"c\"enum CXCursorKind\""), CBinding.integraltype(var"c\"enum CXCursorKind\""), 0, 0, -1}}, CBinding.Tuple{:CompletionString, CBinding.Tuple{var"c\"CXCompletionString\"", CBinding.bitstype(var"c\"CXCompletionString\""), CBinding.integraltype(var"c\"CXCompletionString\""), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXCompletionResult\")"}) = begin
                var"(c\"CXCompletionResult\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXCompletionResult\""}) = begin
                var"(c\"CXCompletionResult\")"
            end
        const CXCompletionResult = var"c\"CXCompletionResult\""
        export var"c\"CXCompletionResult\"", var"(c\"CXCompletionResult\")"
        export CXCompletionResult
        var"c\"CXCompletionResult\""
        abstract type var"c\"enum CXCompletionChunkKind\"" <: Cenum end
        const CXCompletionChunkKind = var"c\"enum CXCompletionChunkKind\""
        export var"c\"enum CXCompletionChunkKind\""
        export CXCompletionChunkKind
        var"c\"enum CXCompletionChunkKind\""
        primitive type var"(c\"enum CXCompletionChunkKind\")" <: var"c\"enum CXCompletionChunkKind\"" 32 end
        (::(Type){var"(c\"enum CXCompletionChunkKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCompletionChunkKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCompletionChunkKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXCompletionChunk_Optional\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_TypedText\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_Text\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_Placeholder\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_Informative\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_CurrentParameter\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_LeftParen\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_RightParen\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_LeftBracket\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_RightBracket\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_LeftBrace\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_RightBrace\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_LeftAngle\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_RightAngle\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_Comma\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_ResultType\""), 0x000000000000000f}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_Colon\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_SemiColon\""), 0x0000000000000011}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_Equal\""), 0x0000000000000012}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_HorizontalSpace\""), 0x0000000000000013}, CBinding.Tuple{Symbol("c\"CXCompletionChunk_VerticalSpace\""), 0x0000000000000014}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCompletionChunkKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCompletionChunkKind\")"}) = begin
                var"(c\"enum CXCompletionChunkKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCompletionChunkKind\""}) = begin
                var"(c\"enum CXCompletionChunkKind\")"
            end
        const var"c\"CXCompletionChunk_Optional\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000000)
        const var"c\"CXCompletionChunk_TypedText\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000001)
        const var"c\"CXCompletionChunk_Text\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000002)
        const var"c\"CXCompletionChunk_Placeholder\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000003)
        const var"c\"CXCompletionChunk_Informative\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000004)
        const var"c\"CXCompletionChunk_CurrentParameter\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000005)
        const var"c\"CXCompletionChunk_LeftParen\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000006)
        const var"c\"CXCompletionChunk_RightParen\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000007)
        const var"c\"CXCompletionChunk_LeftBracket\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000008)
        const var"c\"CXCompletionChunk_RightBracket\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000009)
        const var"c\"CXCompletionChunk_LeftBrace\"" = var"(c\"enum CXCompletionChunkKind\")"(0x000000000000000a)
        const var"c\"CXCompletionChunk_RightBrace\"" = var"(c\"enum CXCompletionChunkKind\")"(0x000000000000000b)
        const var"c\"CXCompletionChunk_LeftAngle\"" = var"(c\"enum CXCompletionChunkKind\")"(0x000000000000000c)
        const var"c\"CXCompletionChunk_RightAngle\"" = var"(c\"enum CXCompletionChunkKind\")"(0x000000000000000d)
        const var"c\"CXCompletionChunk_Comma\"" = var"(c\"enum CXCompletionChunkKind\")"(0x000000000000000e)
        const var"c\"CXCompletionChunk_ResultType\"" = var"(c\"enum CXCompletionChunkKind\")"(0x000000000000000f)
        const var"c\"CXCompletionChunk_Colon\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000010)
        const var"c\"CXCompletionChunk_SemiColon\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000011)
        const var"c\"CXCompletionChunk_Equal\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000012)
        const var"c\"CXCompletionChunk_HorizontalSpace\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000013)
        const var"c\"CXCompletionChunk_VerticalSpace\"" = var"(c\"enum CXCompletionChunkKind\")"(0x0000000000000014)
        const CXCompletionChunkKind = var"c\"enum CXCompletionChunkKind\""
        const CXCompletionChunk_Optional = var"c\"CXCompletionChunk_Optional\""
        const CXCompletionChunk_TypedText = var"c\"CXCompletionChunk_TypedText\""
        const CXCompletionChunk_Text = var"c\"CXCompletionChunk_Text\""
        const CXCompletionChunk_Placeholder = var"c\"CXCompletionChunk_Placeholder\""
        const CXCompletionChunk_Informative = var"c\"CXCompletionChunk_Informative\""
        const CXCompletionChunk_CurrentParameter = var"c\"CXCompletionChunk_CurrentParameter\""
        const CXCompletionChunk_LeftParen = var"c\"CXCompletionChunk_LeftParen\""
        const CXCompletionChunk_RightParen = var"c\"CXCompletionChunk_RightParen\""
        const CXCompletionChunk_LeftBracket = var"c\"CXCompletionChunk_LeftBracket\""
        const CXCompletionChunk_RightBracket = var"c\"CXCompletionChunk_RightBracket\""
        const CXCompletionChunk_LeftBrace = var"c\"CXCompletionChunk_LeftBrace\""
        const CXCompletionChunk_RightBrace = var"c\"CXCompletionChunk_RightBrace\""
        const CXCompletionChunk_LeftAngle = var"c\"CXCompletionChunk_LeftAngle\""
        const CXCompletionChunk_RightAngle = var"c\"CXCompletionChunk_RightAngle\""
        const CXCompletionChunk_Comma = var"c\"CXCompletionChunk_Comma\""
        const CXCompletionChunk_ResultType = var"c\"CXCompletionChunk_ResultType\""
        const CXCompletionChunk_Colon = var"c\"CXCompletionChunk_Colon\""
        const CXCompletionChunk_SemiColon = var"c\"CXCompletionChunk_SemiColon\""
        const CXCompletionChunk_Equal = var"c\"CXCompletionChunk_Equal\""
        const CXCompletionChunk_HorizontalSpace = var"c\"CXCompletionChunk_HorizontalSpace\""
        const CXCompletionChunk_VerticalSpace = var"c\"CXCompletionChunk_VerticalSpace\""
        export var"c\"enum CXCompletionChunkKind\"", var"(c\"enum CXCompletionChunkKind\")", var"c\"CXCompletionChunk_Optional\"", var"c\"CXCompletionChunk_TypedText\"", var"c\"CXCompletionChunk_Text\"", var"c\"CXCompletionChunk_Placeholder\"", var"c\"CXCompletionChunk_Informative\"", var"c\"CXCompletionChunk_CurrentParameter\"", var"c\"CXCompletionChunk_LeftParen\"", var"c\"CXCompletionChunk_RightParen\"", var"c\"CXCompletionChunk_LeftBracket\"", var"c\"CXCompletionChunk_RightBracket\"", var"c\"CXCompletionChunk_LeftBrace\"", var"c\"CXCompletionChunk_RightBrace\"", var"c\"CXCompletionChunk_LeftAngle\"", var"c\"CXCompletionChunk_RightAngle\"", var"c\"CXCompletionChunk_Comma\"", var"c\"CXCompletionChunk_ResultType\"", var"c\"CXCompletionChunk_Colon\"", var"c\"CXCompletionChunk_SemiColon\"", var"c\"CXCompletionChunk_Equal\"", var"c\"CXCompletionChunk_HorizontalSpace\"", var"c\"CXCompletionChunk_VerticalSpace\""
        export CXCompletionChunkKind, CXCompletionChunk_Optional, CXCompletionChunk_TypedText, CXCompletionChunk_Text, CXCompletionChunk_Placeholder, CXCompletionChunk_Informative, CXCompletionChunk_CurrentParameter, CXCompletionChunk_LeftParen, CXCompletionChunk_RightParen, CXCompletionChunk_LeftBracket, CXCompletionChunk_RightBracket, CXCompletionChunk_LeftBrace, CXCompletionChunk_RightBrace, CXCompletionChunk_LeftAngle, CXCompletionChunk_RightAngle, CXCompletionChunk_Comma, CXCompletionChunk_ResultType, CXCompletionChunk_Colon, CXCompletionChunk_SemiColon, CXCompletionChunk_Equal, CXCompletionChunk_HorizontalSpace, CXCompletionChunk_VerticalSpace
        var"c\"enum CXCompletionChunkKind\""
        struct Cbinding_clang_getCompletionChunkKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXCompletionChunkKind\"", CBinding.Tuple{var"c\"CXCompletionString\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getCompletionChunkKind}
        end
        const var"c\"clang_getCompletionChunkKind\"" = Cbinding_clang_getCompletionChunkKind{:clang_getCompletionChunkKind}()
        (func::Cbinding_clang_getCompletionChunkKind)(var"c\"completion_string\"", var"c\"chunk_number\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"", var"c\"chunk_number\"")
            end
        const clang_getCompletionChunkKind = var"c\"clang_getCompletionChunkKind\""
        export var"c\"clang_getCompletionChunkKind\""
        export clang_getCompletionChunkKind
        var"c\"clang_getCompletionChunkKind\""
        struct Cbinding_clang_getCompletionChunkText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCompletionString\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getCompletionChunkText}
        end
        const var"c\"clang_getCompletionChunkText\"" = Cbinding_clang_getCompletionChunkText{:clang_getCompletionChunkText}()
        (func::Cbinding_clang_getCompletionChunkText)(var"c\"completion_string\"", var"c\"chunk_number\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"", var"c\"chunk_number\"")
            end
        const clang_getCompletionChunkText = var"c\"clang_getCompletionChunkText\""
        export var"c\"clang_getCompletionChunkText\""
        export clang_getCompletionChunkText
        var"c\"clang_getCompletionChunkText\""
        struct Cbinding_clang_getCompletionChunkCompletionString{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCompletionString\"", CBinding.Tuple{var"c\"CXCompletionString\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getCompletionChunkCompletionString}
        end
        const var"c\"clang_getCompletionChunkCompletionString\"" = Cbinding_clang_getCompletionChunkCompletionString{:clang_getCompletionChunkCompletionString}()
        (func::Cbinding_clang_getCompletionChunkCompletionString)(var"c\"completion_string\"", var"c\"chunk_number\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"", var"c\"chunk_number\"")
            end
        const clang_getCompletionChunkCompletionString = var"c\"clang_getCompletionChunkCompletionString\""
        export var"c\"clang_getCompletionChunkCompletionString\""
        export clang_getCompletionChunkCompletionString
        var"c\"clang_getCompletionChunkCompletionString\""
        struct Cbinding_clang_getNumCompletionChunks{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCompletionString\""}, :cdecl}, libpath, :clang_getNumCompletionChunks}
        end
        const var"c\"clang_getNumCompletionChunks\"" = Cbinding_clang_getNumCompletionChunks{:clang_getNumCompletionChunks}()
        (func::Cbinding_clang_getNumCompletionChunks)(var"c\"completion_string\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"")
            end
        const clang_getNumCompletionChunks = var"c\"clang_getNumCompletionChunks\""
        export var"c\"clang_getNumCompletionChunks\""
        export clang_getNumCompletionChunks
        var"c\"clang_getNumCompletionChunks\""
        struct Cbinding_clang_getCompletionPriority{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCompletionString\""}, :cdecl}, libpath, :clang_getCompletionPriority}
        end
        const var"c\"clang_getCompletionPriority\"" = Cbinding_clang_getCompletionPriority{:clang_getCompletionPriority}()
        (func::Cbinding_clang_getCompletionPriority)(var"c\"completion_string\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"")
            end
        const clang_getCompletionPriority = var"c\"clang_getCompletionPriority\""
        export var"c\"clang_getCompletionPriority\""
        export clang_getCompletionPriority
        var"c\"clang_getCompletionPriority\""
        struct Cbinding_clang_getCompletionAvailability{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXAvailabilityKind\"", CBinding.Tuple{var"c\"CXCompletionString\""}, :cdecl}, libpath, :clang_getCompletionAvailability}
        end
        const var"c\"clang_getCompletionAvailability\"" = Cbinding_clang_getCompletionAvailability{:clang_getCompletionAvailability}()
        (func::Cbinding_clang_getCompletionAvailability)(var"c\"completion_string\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"")
            end
        const clang_getCompletionAvailability = var"c\"clang_getCompletionAvailability\""
        export var"c\"clang_getCompletionAvailability\""
        export clang_getCompletionAvailability
        var"c\"clang_getCompletionAvailability\""
        struct Cbinding_clang_getCompletionNumAnnotations{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXCompletionString\""}, :cdecl}, libpath, :clang_getCompletionNumAnnotations}
        end
        const var"c\"clang_getCompletionNumAnnotations\"" = Cbinding_clang_getCompletionNumAnnotations{:clang_getCompletionNumAnnotations}()
        (func::Cbinding_clang_getCompletionNumAnnotations)(var"c\"completion_string\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"")
            end
        const clang_getCompletionNumAnnotations = var"c\"clang_getCompletionNumAnnotations\""
        export var"c\"clang_getCompletionNumAnnotations\""
        export clang_getCompletionNumAnnotations
        var"c\"clang_getCompletionNumAnnotations\""
        struct Cbinding_clang_getCompletionAnnotation{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCompletionString\"", CBinding.Cuint}, :cdecl}, libpath, :clang_getCompletionAnnotation}
        end
        const var"c\"clang_getCompletionAnnotation\"" = Cbinding_clang_getCompletionAnnotation{:clang_getCompletionAnnotation}()
        (func::Cbinding_clang_getCompletionAnnotation)(var"c\"completion_string\"", var"c\"annotation_number\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"", var"c\"annotation_number\"")
            end
        const clang_getCompletionAnnotation = var"c\"clang_getCompletionAnnotation\""
        export var"c\"clang_getCompletionAnnotation\""
        export clang_getCompletionAnnotation
        var"c\"clang_getCompletionAnnotation\""
        struct Cbinding_clang_getCompletionParent{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCompletionString\"", CBinding.Cptr{var"c\"enum CXCursorKind\""}}, :cdecl}, libpath, :clang_getCompletionParent}
        end
        const var"c\"clang_getCompletionParent\"" = Cbinding_clang_getCompletionParent{:clang_getCompletionParent}()
        (func::Cbinding_clang_getCompletionParent)(var"c\"completion_string\"", var"c\"kind\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"", var"c\"kind\"")
            end
        const clang_getCompletionParent = var"c\"clang_getCompletionParent\""
        export var"c\"clang_getCompletionParent\""
        export clang_getCompletionParent
        var"c\"clang_getCompletionParent\""
        struct Cbinding_clang_getCompletionBriefComment{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCompletionString\""}, :cdecl}, libpath, :clang_getCompletionBriefComment}
        end
        const var"c\"clang_getCompletionBriefComment\"" = Cbinding_clang_getCompletionBriefComment{:clang_getCompletionBriefComment}()
        (func::Cbinding_clang_getCompletionBriefComment)(var"c\"completion_string\"") = begin
                CBinding.funccall(func, var"c\"completion_string\"")
            end
        const clang_getCompletionBriefComment = var"c\"clang_getCompletionBriefComment\""
        export var"c\"clang_getCompletionBriefComment\""
        export clang_getCompletionBriefComment
        var"c\"clang_getCompletionBriefComment\""
        struct Cbinding_clang_getCursorCompletionString{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXCompletionString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorCompletionString}
        end
        const var"c\"clang_getCursorCompletionString\"" = Cbinding_clang_getCursorCompletionString{:clang_getCursorCompletionString}()
        (func::Cbinding_clang_getCursorCompletionString)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorCompletionString = var"c\"clang_getCursorCompletionString\""
        export var"c\"clang_getCursorCompletionString\""
        export clang_getCursorCompletionString
        var"c\"clang_getCursorCompletionString\""
        abstract type var"c\"CXCodeCompleteResults\"" <: Cstruct end
        const CXCodeCompleteResults = var"c\"CXCodeCompleteResults\""
        export var"c\"CXCodeCompleteResults\""
        export CXCodeCompleteResults
        var"c\"CXCodeCompleteResults\""
        struct var"(c\"CXCodeCompleteResults\")" <: var"c\"CXCodeCompleteResults\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"CXCodeCompleteResults\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXCodeCompleteResults\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:Results, CBinding.Tuple{CBinding.Cptr{var"c\"CXCompletionResult\""}, CBinding.bitstype(CBinding.Cptr{var"c\"CXCompletionResult\""}), CBinding.integraltype(CBinding.Cptr{var"c\"CXCompletionResult\""}), 0, 0, -1}}, CBinding.Tuple{:NumResults, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXCodeCompleteResults\")"}) = begin
                var"(c\"CXCodeCompleteResults\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXCodeCompleteResults\""}) = begin
                var"(c\"CXCodeCompleteResults\")"
            end
        const CXCodeCompleteResults = var"c\"CXCodeCompleteResults\""
        export var"c\"CXCodeCompleteResults\"", var"(c\"CXCodeCompleteResults\")"
        export CXCodeCompleteResults
        var"c\"CXCodeCompleteResults\""
        struct Cbinding_clang_getCompletionNumFixIts{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}, CBinding.Cuint}, :cdecl}, libpath, :clang_getCompletionNumFixIts}
        end
        const var"c\"clang_getCompletionNumFixIts\"" = Cbinding_clang_getCompletionNumFixIts{:clang_getCompletionNumFixIts}()
        (func::Cbinding_clang_getCompletionNumFixIts)(var"c\"results\"", var"c\"completion_index\"") = begin
                CBinding.funccall(func, var"c\"results\"", var"c\"completion_index\"")
            end
        const clang_getCompletionNumFixIts = var"c\"clang_getCompletionNumFixIts\""
        export var"c\"clang_getCompletionNumFixIts\""
        export clang_getCompletionNumFixIts
        var"c\"clang_getCompletionNumFixIts\""
        struct Cbinding_clang_getCompletionFixIt{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}, CBinding.Cuint, CBinding.Cuint, CBinding.Cptr{var"c\"CXSourceRange\""}}, :cdecl}, libpath, :clang_getCompletionFixIt}
        end
        const var"c\"clang_getCompletionFixIt\"" = Cbinding_clang_getCompletionFixIt{:clang_getCompletionFixIt}()
        (func::Cbinding_clang_getCompletionFixIt)(var"c\"results\"", var"c\"completion_index\"", var"c\"fixit_index\"", var"c\"replacement_range\"") = begin
                CBinding.funccall(func, var"c\"results\"", var"c\"completion_index\"", var"c\"fixit_index\"", var"c\"replacement_range\"")
            end
        const clang_getCompletionFixIt = var"c\"clang_getCompletionFixIt\""
        export var"c\"clang_getCompletionFixIt\""
        export clang_getCompletionFixIt
        var"c\"clang_getCompletionFixIt\""
        abstract type var"c\"enum CXCodeComplete_Flags\"" <: Cenum end
        const CXCodeComplete_Flags = var"c\"enum CXCodeComplete_Flags\""
        export var"c\"enum CXCodeComplete_Flags\""
        export CXCodeComplete_Flags
        var"c\"enum CXCodeComplete_Flags\""
        primitive type var"(c\"enum CXCodeComplete_Flags\")" <: var"c\"enum CXCodeComplete_Flags\"" 32 end
        (::(Type){var"(c\"enum CXCodeComplete_Flags\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCodeComplete_Flags\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCodeComplete_Flags\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXCodeComplete_IncludeMacros\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCodeComplete_IncludeCodePatterns\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXCodeComplete_IncludeBriefComments\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXCodeComplete_SkipPreamble\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXCodeComplete_IncludeCompletionsWithFixIts\""), 0x0000000000000010}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCodeComplete_Flags\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCodeComplete_Flags\")"}) = begin
                var"(c\"enum CXCodeComplete_Flags\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCodeComplete_Flags\""}) = begin
                var"(c\"enum CXCodeComplete_Flags\")"
            end
        const var"c\"CXCodeComplete_IncludeMacros\"" = var"(c\"enum CXCodeComplete_Flags\")"(0x0000000000000001)
        const var"c\"CXCodeComplete_IncludeCodePatterns\"" = var"(c\"enum CXCodeComplete_Flags\")"(0x0000000000000002)
        const var"c\"CXCodeComplete_IncludeBriefComments\"" = var"(c\"enum CXCodeComplete_Flags\")"(0x0000000000000004)
        const var"c\"CXCodeComplete_SkipPreamble\"" = var"(c\"enum CXCodeComplete_Flags\")"(0x0000000000000008)
        const var"c\"CXCodeComplete_IncludeCompletionsWithFixIts\"" = var"(c\"enum CXCodeComplete_Flags\")"(0x0000000000000010)
        const CXCodeComplete_Flags = var"c\"enum CXCodeComplete_Flags\""
        const CXCodeComplete_IncludeMacros = var"c\"CXCodeComplete_IncludeMacros\""
        const CXCodeComplete_IncludeCodePatterns = var"c\"CXCodeComplete_IncludeCodePatterns\""
        const CXCodeComplete_IncludeBriefComments = var"c\"CXCodeComplete_IncludeBriefComments\""
        const CXCodeComplete_SkipPreamble = var"c\"CXCodeComplete_SkipPreamble\""
        const CXCodeComplete_IncludeCompletionsWithFixIts = var"c\"CXCodeComplete_IncludeCompletionsWithFixIts\""
        export var"c\"enum CXCodeComplete_Flags\"", var"(c\"enum CXCodeComplete_Flags\")", var"c\"CXCodeComplete_IncludeMacros\"", var"c\"CXCodeComplete_IncludeCodePatterns\"", var"c\"CXCodeComplete_IncludeBriefComments\"", var"c\"CXCodeComplete_SkipPreamble\"", var"c\"CXCodeComplete_IncludeCompletionsWithFixIts\""
        export CXCodeComplete_Flags, CXCodeComplete_IncludeMacros, CXCodeComplete_IncludeCodePatterns, CXCodeComplete_IncludeBriefComments, CXCodeComplete_SkipPreamble, CXCodeComplete_IncludeCompletionsWithFixIts
        var"c\"enum CXCodeComplete_Flags\""
        abstract type var"c\"enum CXCompletionContext\"" <: Cenum end
        const CXCompletionContext = var"c\"enum CXCompletionContext\""
        export var"c\"enum CXCompletionContext\""
        export CXCompletionContext
        var"c\"enum CXCompletionContext\""
        primitive type var"(c\"enum CXCompletionContext\")" <: var"c\"enum CXCompletionContext\"" 32 end
        (::(Type){var"(c\"enum CXCompletionContext\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCompletionContext\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCompletionContext\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXCompletionContext_Unexposed\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_AnyType\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCompletionContext_AnyValue\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCObjectValue\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCSelectorValue\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXCompletionContext_CXXClassTypeValue\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXCompletionContext_DotMemberAccess\""), 0x0000000000000020}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ArrowMemberAccess\""), 0x0000000000000040}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCPropertyAccess\""), 0x0000000000000080}, CBinding.Tuple{Symbol("c\"CXCompletionContext_EnumTag\""), 0x0000000000000100}, CBinding.Tuple{Symbol("c\"CXCompletionContext_UnionTag\""), 0x0000000000000200}, CBinding.Tuple{Symbol("c\"CXCompletionContext_StructTag\""), 0x0000000000000400}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ClassTag\""), 0x0000000000000800}, CBinding.Tuple{Symbol("c\"CXCompletionContext_Namespace\""), 0x0000000000001000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_NestedNameSpecifier\""), 0x0000000000002000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCInterface\""), 0x0000000000004000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCProtocol\""), 0x0000000000008000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCCategory\""), 0x0000000000010000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCInstanceMessage\""), 0x0000000000020000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCClassMessage\""), 0x0000000000040000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_ObjCSelectorName\""), 0x0000000000080000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_MacroName\""), 0x0000000000100000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_NaturalLanguage\""), 0x0000000000200000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_IncludedFile\""), 0x0000000000400000}, CBinding.Tuple{Symbol("c\"CXCompletionContext_Unknown\""), 0x00000000007fffff}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCompletionContext\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCompletionContext\")"}) = begin
                var"(c\"enum CXCompletionContext\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCompletionContext\""}) = begin
                var"(c\"enum CXCompletionContext\")"
            end
        const var"c\"CXCompletionContext_Unexposed\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000000)
        const var"c\"CXCompletionContext_AnyType\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000001)
        const var"c\"CXCompletionContext_AnyValue\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000002)
        const var"c\"CXCompletionContext_ObjCObjectValue\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000004)
        const var"c\"CXCompletionContext_ObjCSelectorValue\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000008)
        const var"c\"CXCompletionContext_CXXClassTypeValue\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000010)
        const var"c\"CXCompletionContext_DotMemberAccess\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000020)
        const var"c\"CXCompletionContext_ArrowMemberAccess\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000040)
        const var"c\"CXCompletionContext_ObjCPropertyAccess\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000080)
        const var"c\"CXCompletionContext_EnumTag\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000100)
        const var"c\"CXCompletionContext_UnionTag\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000200)
        const var"c\"CXCompletionContext_StructTag\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000400)
        const var"c\"CXCompletionContext_ClassTag\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000000800)
        const var"c\"CXCompletionContext_Namespace\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000001000)
        const var"c\"CXCompletionContext_NestedNameSpecifier\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000002000)
        const var"c\"CXCompletionContext_ObjCInterface\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000004000)
        const var"c\"CXCompletionContext_ObjCProtocol\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000008000)
        const var"c\"CXCompletionContext_ObjCCategory\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000010000)
        const var"c\"CXCompletionContext_ObjCInstanceMessage\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000020000)
        const var"c\"CXCompletionContext_ObjCClassMessage\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000040000)
        const var"c\"CXCompletionContext_ObjCSelectorName\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000080000)
        const var"c\"CXCompletionContext_MacroName\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000100000)
        const var"c\"CXCompletionContext_NaturalLanguage\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000200000)
        const var"c\"CXCompletionContext_IncludedFile\"" = var"(c\"enum CXCompletionContext\")"(0x0000000000400000)
        const var"c\"CXCompletionContext_Unknown\"" = var"(c\"enum CXCompletionContext\")"(0x00000000007fffff)
        const CXCompletionContext = var"c\"enum CXCompletionContext\""
        const CXCompletionContext_Unexposed = var"c\"CXCompletionContext_Unexposed\""
        const CXCompletionContext_AnyType = var"c\"CXCompletionContext_AnyType\""
        const CXCompletionContext_AnyValue = var"c\"CXCompletionContext_AnyValue\""
        const CXCompletionContext_ObjCObjectValue = var"c\"CXCompletionContext_ObjCObjectValue\""
        const CXCompletionContext_ObjCSelectorValue = var"c\"CXCompletionContext_ObjCSelectorValue\""
        const CXCompletionContext_CXXClassTypeValue = var"c\"CXCompletionContext_CXXClassTypeValue\""
        const CXCompletionContext_DotMemberAccess = var"c\"CXCompletionContext_DotMemberAccess\""
        const CXCompletionContext_ArrowMemberAccess = var"c\"CXCompletionContext_ArrowMemberAccess\""
        const CXCompletionContext_ObjCPropertyAccess = var"c\"CXCompletionContext_ObjCPropertyAccess\""
        const CXCompletionContext_EnumTag = var"c\"CXCompletionContext_EnumTag\""
        const CXCompletionContext_UnionTag = var"c\"CXCompletionContext_UnionTag\""
        const CXCompletionContext_StructTag = var"c\"CXCompletionContext_StructTag\""
        const CXCompletionContext_ClassTag = var"c\"CXCompletionContext_ClassTag\""
        const CXCompletionContext_Namespace = var"c\"CXCompletionContext_Namespace\""
        const CXCompletionContext_NestedNameSpecifier = var"c\"CXCompletionContext_NestedNameSpecifier\""
        const CXCompletionContext_ObjCInterface = var"c\"CXCompletionContext_ObjCInterface\""
        const CXCompletionContext_ObjCProtocol = var"c\"CXCompletionContext_ObjCProtocol\""
        const CXCompletionContext_ObjCCategory = var"c\"CXCompletionContext_ObjCCategory\""
        const CXCompletionContext_ObjCInstanceMessage = var"c\"CXCompletionContext_ObjCInstanceMessage\""
        const CXCompletionContext_ObjCClassMessage = var"c\"CXCompletionContext_ObjCClassMessage\""
        const CXCompletionContext_ObjCSelectorName = var"c\"CXCompletionContext_ObjCSelectorName\""
        const CXCompletionContext_MacroName = var"c\"CXCompletionContext_MacroName\""
        const CXCompletionContext_NaturalLanguage = var"c\"CXCompletionContext_NaturalLanguage\""
        const CXCompletionContext_IncludedFile = var"c\"CXCompletionContext_IncludedFile\""
        const CXCompletionContext_Unknown = var"c\"CXCompletionContext_Unknown\""
        export var"c\"enum CXCompletionContext\"", var"(c\"enum CXCompletionContext\")", var"c\"CXCompletionContext_Unexposed\"", var"c\"CXCompletionContext_AnyType\"", var"c\"CXCompletionContext_AnyValue\"", var"c\"CXCompletionContext_ObjCObjectValue\"", var"c\"CXCompletionContext_ObjCSelectorValue\"", var"c\"CXCompletionContext_CXXClassTypeValue\"", var"c\"CXCompletionContext_DotMemberAccess\"", var"c\"CXCompletionContext_ArrowMemberAccess\"", var"c\"CXCompletionContext_ObjCPropertyAccess\"", var"c\"CXCompletionContext_EnumTag\"", var"c\"CXCompletionContext_UnionTag\"", var"c\"CXCompletionContext_StructTag\"", var"c\"CXCompletionContext_ClassTag\"", var"c\"CXCompletionContext_Namespace\"", var"c\"CXCompletionContext_NestedNameSpecifier\"", var"c\"CXCompletionContext_ObjCInterface\"", var"c\"CXCompletionContext_ObjCProtocol\"", var"c\"CXCompletionContext_ObjCCategory\"", var"c\"CXCompletionContext_ObjCInstanceMessage\"", var"c\"CXCompletionContext_ObjCClassMessage\"", var"c\"CXCompletionContext_ObjCSelectorName\"", var"c\"CXCompletionContext_MacroName\"", var"c\"CXCompletionContext_NaturalLanguage\"", var"c\"CXCompletionContext_IncludedFile\"", var"c\"CXCompletionContext_Unknown\""
        export CXCompletionContext, CXCompletionContext_Unexposed, CXCompletionContext_AnyType, CXCompletionContext_AnyValue, CXCompletionContext_ObjCObjectValue, CXCompletionContext_ObjCSelectorValue, CXCompletionContext_CXXClassTypeValue, CXCompletionContext_DotMemberAccess, CXCompletionContext_ArrowMemberAccess, CXCompletionContext_ObjCPropertyAccess, CXCompletionContext_EnumTag, CXCompletionContext_UnionTag, CXCompletionContext_StructTag, CXCompletionContext_ClassTag, CXCompletionContext_Namespace, CXCompletionContext_NestedNameSpecifier, CXCompletionContext_ObjCInterface, CXCompletionContext_ObjCProtocol, CXCompletionContext_ObjCCategory, CXCompletionContext_ObjCInstanceMessage, CXCompletionContext_ObjCClassMessage, CXCompletionContext_ObjCSelectorName, CXCompletionContext_MacroName, CXCompletionContext_NaturalLanguage, CXCompletionContext_IncludedFile, CXCompletionContext_Unknown
        var"c\"enum CXCompletionContext\""
        struct Cbinding_clang_defaultCodeCompleteOptions{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{}, :cdecl}, libpath, :clang_defaultCodeCompleteOptions}
        end
        const var"c\"clang_defaultCodeCompleteOptions\"" = Cbinding_clang_defaultCodeCompleteOptions{:clang_defaultCodeCompleteOptions}()
        (func::Cbinding_clang_defaultCodeCompleteOptions)() = begin
                CBinding.funccall(func)
            end
        const clang_defaultCodeCompleteOptions = var"c\"clang_defaultCodeCompleteOptions\""
        export var"c\"clang_defaultCodeCompleteOptions\""
        export clang_defaultCodeCompleteOptions
        var"c\"clang_defaultCodeCompleteOptions\""
        struct Cbinding_clang_codeCompleteAt{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}, CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cuint, CBinding.Cuint, CBinding.Cptr{var"c\"struct CXUnsavedFile\""}, CBinding.Cuint, CBinding.Cuint}, :cdecl}, libpath, :clang_codeCompleteAt}
        end
        const var"c\"clang_codeCompleteAt\"" = Cbinding_clang_codeCompleteAt{:clang_codeCompleteAt}()
        (func::Cbinding_clang_codeCompleteAt)(var"c\"TU\"", var"c\"complete_filename\"", var"c\"complete_line\"", var"c\"complete_column\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"options\"") = begin
                CBinding.funccall(func, var"c\"TU\"", var"c\"complete_filename\"", var"c\"complete_line\"", var"c\"complete_column\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"options\"")
            end
        const clang_codeCompleteAt = var"c\"clang_codeCompleteAt\""
        export var"c\"clang_codeCompleteAt\""
        export clang_codeCompleteAt
        var"c\"clang_codeCompleteAt\""
        struct Cbinding_clang_sortCodeCompletionResults{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{var"c\"CXCompletionResult\""}, CBinding.Cuint}, :cdecl}, libpath, :clang_sortCodeCompletionResults}
        end
        const var"c\"clang_sortCodeCompletionResults\"" = Cbinding_clang_sortCodeCompletionResults{:clang_sortCodeCompletionResults}()
        (func::Cbinding_clang_sortCodeCompletionResults)(var"c\"Results\"", var"c\"NumResults\"") = begin
                CBinding.funccall(func, var"c\"Results\"", var"c\"NumResults\"")
            end
        const clang_sortCodeCompletionResults = var"c\"clang_sortCodeCompletionResults\""
        export var"c\"clang_sortCodeCompletionResults\""
        export clang_sortCodeCompletionResults
        var"c\"clang_sortCodeCompletionResults\""
        struct Cbinding_clang_disposeCodeCompleteResults{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}}, :cdecl}, libpath, :clang_disposeCodeCompleteResults}
        end
        const var"c\"clang_disposeCodeCompleteResults\"" = Cbinding_clang_disposeCodeCompleteResults{:clang_disposeCodeCompleteResults}()
        (func::Cbinding_clang_disposeCodeCompleteResults)(var"c\"Results\"") = begin
                CBinding.funccall(func, var"c\"Results\"")
            end
        const clang_disposeCodeCompleteResults = var"c\"clang_disposeCodeCompleteResults\""
        export var"c\"clang_disposeCodeCompleteResults\""
        export clang_disposeCodeCompleteResults
        var"c\"clang_disposeCodeCompleteResults\""
        struct Cbinding_clang_codeCompleteGetNumDiagnostics{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}}, :cdecl}, libpath, :clang_codeCompleteGetNumDiagnostics}
        end
        const var"c\"clang_codeCompleteGetNumDiagnostics\"" = Cbinding_clang_codeCompleteGetNumDiagnostics{:clang_codeCompleteGetNumDiagnostics}()
        (func::Cbinding_clang_codeCompleteGetNumDiagnostics)(var"c\"Results\"") = begin
                CBinding.funccall(func, var"c\"Results\"")
            end
        const clang_codeCompleteGetNumDiagnostics = var"c\"clang_codeCompleteGetNumDiagnostics\""
        export var"c\"clang_codeCompleteGetNumDiagnostics\""
        export clang_codeCompleteGetNumDiagnostics
        var"c\"clang_codeCompleteGetNumDiagnostics\""
        struct Cbinding_clang_codeCompleteGetDiagnostic{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXDiagnostic\"", CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}, CBinding.Cuint}, :cdecl}, libpath, :clang_codeCompleteGetDiagnostic}
        end
        const var"c\"clang_codeCompleteGetDiagnostic\"" = Cbinding_clang_codeCompleteGetDiagnostic{:clang_codeCompleteGetDiagnostic}()
        (func::Cbinding_clang_codeCompleteGetDiagnostic)(var"c\"Results\"", var"c\"Index\"") = begin
                CBinding.funccall(func, var"c\"Results\"", var"c\"Index\"")
            end
        const clang_codeCompleteGetDiagnostic = var"c\"clang_codeCompleteGetDiagnostic\""
        export var"c\"clang_codeCompleteGetDiagnostic\""
        export clang_codeCompleteGetDiagnostic
        var"c\"clang_codeCompleteGetDiagnostic\""
        struct Cbinding_clang_codeCompleteGetContexts{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Culonglong, CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}}, :cdecl}, libpath, :clang_codeCompleteGetContexts}
        end
        const var"c\"clang_codeCompleteGetContexts\"" = Cbinding_clang_codeCompleteGetContexts{:clang_codeCompleteGetContexts}()
        (func::Cbinding_clang_codeCompleteGetContexts)(var"c\"Results\"") = begin
                CBinding.funccall(func, var"c\"Results\"")
            end
        const clang_codeCompleteGetContexts = var"c\"clang_codeCompleteGetContexts\""
        export var"c\"clang_codeCompleteGetContexts\""
        export clang_codeCompleteGetContexts
        var"c\"clang_codeCompleteGetContexts\""
        struct Cbinding_clang_codeCompleteGetContainerKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXCursorKind\"", CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_codeCompleteGetContainerKind}
        end
        const var"c\"clang_codeCompleteGetContainerKind\"" = Cbinding_clang_codeCompleteGetContainerKind{:clang_codeCompleteGetContainerKind}()
        (func::Cbinding_clang_codeCompleteGetContainerKind)(var"c\"Results\"", var"c\"IsIncomplete\"") = begin
                CBinding.funccall(func, var"c\"Results\"", var"c\"IsIncomplete\"")
            end
        const clang_codeCompleteGetContainerKind = var"c\"clang_codeCompleteGetContainerKind\""
        export var"c\"clang_codeCompleteGetContainerKind\""
        export clang_codeCompleteGetContainerKind
        var"c\"clang_codeCompleteGetContainerKind\""
        struct Cbinding_clang_codeCompleteGetContainerUSR{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}}, :cdecl}, libpath, :clang_codeCompleteGetContainerUSR}
        end
        const var"c\"clang_codeCompleteGetContainerUSR\"" = Cbinding_clang_codeCompleteGetContainerUSR{:clang_codeCompleteGetContainerUSR}()
        (func::Cbinding_clang_codeCompleteGetContainerUSR)(var"c\"Results\"") = begin
                CBinding.funccall(func, var"c\"Results\"")
            end
        const clang_codeCompleteGetContainerUSR = var"c\"clang_codeCompleteGetContainerUSR\""
        export var"c\"clang_codeCompleteGetContainerUSR\""
        export clang_codeCompleteGetContainerUSR
        var"c\"clang_codeCompleteGetContainerUSR\""
        struct Cbinding_clang_codeCompleteGetObjCSelector{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{var"c\"CXCodeCompleteResults\""}}, :cdecl}, libpath, :clang_codeCompleteGetObjCSelector}
        end
        const var"c\"clang_codeCompleteGetObjCSelector\"" = Cbinding_clang_codeCompleteGetObjCSelector{:clang_codeCompleteGetObjCSelector}()
        (func::Cbinding_clang_codeCompleteGetObjCSelector)(var"c\"Results\"") = begin
                CBinding.funccall(func, var"c\"Results\"")
            end
        const clang_codeCompleteGetObjCSelector = var"c\"clang_codeCompleteGetObjCSelector\""
        export var"c\"clang_codeCompleteGetObjCSelector\""
        export clang_codeCompleteGetObjCSelector
        var"c\"clang_codeCompleteGetObjCSelector\""
        struct Cbinding_clang_getClangVersion{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{}, :cdecl}, libpath, :clang_getClangVersion}
        end
        const var"c\"clang_getClangVersion\"" = Cbinding_clang_getClangVersion{:clang_getClangVersion}()
        (func::Cbinding_clang_getClangVersion)() = begin
                CBinding.funccall(func)
            end
        const clang_getClangVersion = var"c\"clang_getClangVersion\""
        export var"c\"clang_getClangVersion\""
        export clang_getClangVersion
        var"c\"clang_getClangVersion\""
        struct Cbinding_clang_toggleCrashRecovery{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cuint}, :cdecl}, libpath, :clang_toggleCrashRecovery}
        end
        const var"c\"clang_toggleCrashRecovery\"" = Cbinding_clang_toggleCrashRecovery{:clang_toggleCrashRecovery}()
        (func::Cbinding_clang_toggleCrashRecovery)(var"c\"isEnabled\"") = begin
                CBinding.funccall(func, var"c\"isEnabled\"")
            end
        const clang_toggleCrashRecovery = var"c\"clang_toggleCrashRecovery\""
        export var"c\"clang_toggleCrashRecovery\""
        export clang_toggleCrashRecovery
        var"c\"clang_toggleCrashRecovery\""
        const var"c\"CXInclusionVisitor\"" = CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXFile\"", CBinding.Cptr{var"c\"CXSourceLocation\""}, CBinding.Cuint, var"c\"CXClientData\""}, :cdecl}}
        const CXInclusionVisitor = var"c\"CXInclusionVisitor\""
        export var"c\"CXInclusionVisitor\""
        export CXInclusionVisitor
        var"c\"CXInclusionVisitor\""
        struct Cbinding_clang_getInclusions{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXInclusionVisitor\"", var"c\"CXClientData\""}, :cdecl}, libpath, :clang_getInclusions}
        end
        const var"c\"clang_getInclusions\"" = Cbinding_clang_getInclusions{:clang_getInclusions}()
        (func::Cbinding_clang_getInclusions)(var"c\"tu\"", var"c\"visitor\"", var"c\"client_data\"") = begin
                CBinding.funccall(func, var"c\"tu\"", var"c\"visitor\"", var"c\"client_data\"")
            end
        const clang_getInclusions = var"c\"clang_getInclusions\""
        export var"c\"clang_getInclusions\""
        export clang_getInclusions
        var"c\"clang_getInclusions\""
        abstract type var"c\"CXEvalResultKind\"" <: Cenum end
        const CXEvalResultKind = var"c\"CXEvalResultKind\""
        export var"c\"CXEvalResultKind\""
        export CXEvalResultKind
        var"c\"CXEvalResultKind\""
        primitive type var"(c\"CXEvalResultKind\")" <: var"c\"CXEvalResultKind\"" 32 end
        (::(Type){var"(c\"CXEvalResultKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXEvalResultKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXEvalResultKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXEval_Int\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXEval_Float\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXEval_ObjCStrLiteral\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXEval_StrLiteral\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXEval_CFStr\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXEval_Other\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXEval_UnExposed\""), 0x0000000000000000}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXEvalResultKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXEvalResultKind\")"}) = begin
                var"(c\"CXEvalResultKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXEvalResultKind\""}) = begin
                var"(c\"CXEvalResultKind\")"
            end
        const var"c\"CXEval_Int\"" = var"(c\"CXEvalResultKind\")"(0x0000000000000001)
        const var"c\"CXEval_Float\"" = var"(c\"CXEvalResultKind\")"(0x0000000000000002)
        const var"c\"CXEval_ObjCStrLiteral\"" = var"(c\"CXEvalResultKind\")"(0x0000000000000003)
        const var"c\"CXEval_StrLiteral\"" = var"(c\"CXEvalResultKind\")"(0x0000000000000004)
        const var"c\"CXEval_CFStr\"" = var"(c\"CXEvalResultKind\")"(0x0000000000000005)
        const var"c\"CXEval_Other\"" = var"(c\"CXEvalResultKind\")"(0x0000000000000006)
        const var"c\"CXEval_UnExposed\"" = var"(c\"CXEvalResultKind\")"(0x0000000000000000)
        const CXEvalResultKind = var"c\"CXEvalResultKind\""
        const CXEval_Int = var"c\"CXEval_Int\""
        const CXEval_Float = var"c\"CXEval_Float\""
        const CXEval_ObjCStrLiteral = var"c\"CXEval_ObjCStrLiteral\""
        const CXEval_StrLiteral = var"c\"CXEval_StrLiteral\""
        const CXEval_CFStr = var"c\"CXEval_CFStr\""
        const CXEval_Other = var"c\"CXEval_Other\""
        const CXEval_UnExposed = var"c\"CXEval_UnExposed\""
        export var"c\"CXEvalResultKind\"", var"(c\"CXEvalResultKind\")", var"c\"CXEval_Int\"", var"c\"CXEval_Float\"", var"c\"CXEval_ObjCStrLiteral\"", var"c\"CXEval_StrLiteral\"", var"c\"CXEval_CFStr\"", var"c\"CXEval_Other\"", var"c\"CXEval_UnExposed\""
        export CXEvalResultKind, CXEval_Int, CXEval_Float, CXEval_ObjCStrLiteral, CXEval_StrLiteral, CXEval_CFStr, CXEval_Other, CXEval_UnExposed
        var"c\"CXEvalResultKind\""
        const var"c\"CXEvalResult\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXEvalResult = var"c\"CXEvalResult\""
        export var"c\"CXEvalResult\""
        export CXEvalResult
        var"c\"CXEvalResult\""
        struct Cbinding_clang_Cursor_Evaluate{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXEvalResult\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_Evaluate}
        end
        const var"c\"clang_Cursor_Evaluate\"" = Cbinding_clang_Cursor_Evaluate{:clang_Cursor_Evaluate}()
        (func::Cbinding_clang_Cursor_Evaluate)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_Evaluate = var"c\"clang_Cursor_Evaluate\""
        export var"c\"clang_Cursor_Evaluate\""
        export clang_Cursor_Evaluate
        var"c\"clang_Cursor_Evaluate\""
        struct Cbinding_clang_EvalResult_getKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXEvalResultKind\"", CBinding.Tuple{var"c\"CXEvalResult\""}, :cdecl}, libpath, :clang_EvalResult_getKind}
        end
        const var"c\"clang_EvalResult_getKind\"" = Cbinding_clang_EvalResult_getKind{:clang_EvalResult_getKind}()
        (func::Cbinding_clang_EvalResult_getKind)(var"c\"E\"") = begin
                CBinding.funccall(func, var"c\"E\"")
            end
        const clang_EvalResult_getKind = var"c\"clang_EvalResult_getKind\""
        export var"c\"clang_EvalResult_getKind\""
        export clang_EvalResult_getKind
        var"c\"clang_EvalResult_getKind\""
        struct Cbinding_clang_EvalResult_getAsInt{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXEvalResult\""}, :cdecl}, libpath, :clang_EvalResult_getAsInt}
        end
        const var"c\"clang_EvalResult_getAsInt\"" = Cbinding_clang_EvalResult_getAsInt{:clang_EvalResult_getAsInt}()
        (func::Cbinding_clang_EvalResult_getAsInt)(var"c\"E\"") = begin
                CBinding.funccall(func, var"c\"E\"")
            end
        const clang_EvalResult_getAsInt = var"c\"clang_EvalResult_getAsInt\""
        export var"c\"clang_EvalResult_getAsInt\""
        export clang_EvalResult_getAsInt
        var"c\"clang_EvalResult_getAsInt\""
        struct Cbinding_clang_EvalResult_getAsLongLong{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Clonglong, CBinding.Tuple{var"c\"CXEvalResult\""}, :cdecl}, libpath, :clang_EvalResult_getAsLongLong}
        end
        const var"c\"clang_EvalResult_getAsLongLong\"" = Cbinding_clang_EvalResult_getAsLongLong{:clang_EvalResult_getAsLongLong}()
        (func::Cbinding_clang_EvalResult_getAsLongLong)(var"c\"E\"") = begin
                CBinding.funccall(func, var"c\"E\"")
            end
        const clang_EvalResult_getAsLongLong = var"c\"clang_EvalResult_getAsLongLong\""
        export var"c\"clang_EvalResult_getAsLongLong\""
        export clang_EvalResult_getAsLongLong
        var"c\"clang_EvalResult_getAsLongLong\""
        struct Cbinding_clang_EvalResult_isUnsignedInt{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXEvalResult\""}, :cdecl}, libpath, :clang_EvalResult_isUnsignedInt}
        end
        const var"c\"clang_EvalResult_isUnsignedInt\"" = Cbinding_clang_EvalResult_isUnsignedInt{:clang_EvalResult_isUnsignedInt}()
        (func::Cbinding_clang_EvalResult_isUnsignedInt)(var"c\"E\"") = begin
                CBinding.funccall(func, var"c\"E\"")
            end
        const clang_EvalResult_isUnsignedInt = var"c\"clang_EvalResult_isUnsignedInt\""
        export var"c\"clang_EvalResult_isUnsignedInt\""
        export clang_EvalResult_isUnsignedInt
        var"c\"clang_EvalResult_isUnsignedInt\""
        struct Cbinding_clang_EvalResult_getAsUnsigned{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Culonglong, CBinding.Tuple{var"c\"CXEvalResult\""}, :cdecl}, libpath, :clang_EvalResult_getAsUnsigned}
        end
        const var"c\"clang_EvalResult_getAsUnsigned\"" = Cbinding_clang_EvalResult_getAsUnsigned{:clang_EvalResult_getAsUnsigned}()
        (func::Cbinding_clang_EvalResult_getAsUnsigned)(var"c\"E\"") = begin
                CBinding.funccall(func, var"c\"E\"")
            end
        const clang_EvalResult_getAsUnsigned = var"c\"clang_EvalResult_getAsUnsigned\""
        export var"c\"clang_EvalResult_getAsUnsigned\""
        export clang_EvalResult_getAsUnsigned
        var"c\"clang_EvalResult_getAsUnsigned\""
        struct Cbinding_clang_EvalResult_getAsDouble{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cdouble, CBinding.Tuple{var"c\"CXEvalResult\""}, :cdecl}, libpath, :clang_EvalResult_getAsDouble}
        end
        const var"c\"clang_EvalResult_getAsDouble\"" = Cbinding_clang_EvalResult_getAsDouble{:clang_EvalResult_getAsDouble}()
        (func::Cbinding_clang_EvalResult_getAsDouble)(var"c\"E\"") = begin
                CBinding.funccall(func, var"c\"E\"")
            end
        const clang_EvalResult_getAsDouble = var"c\"clang_EvalResult_getAsDouble\""
        export var"c\"clang_EvalResult_getAsDouble\""
        export clang_EvalResult_getAsDouble
        var"c\"clang_EvalResult_getAsDouble\""
        struct Cbinding_clang_EvalResult_getAsStr{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Tuple{var"c\"CXEvalResult\""}, :cdecl}, libpath, :clang_EvalResult_getAsStr}
        end
        const var"c\"clang_EvalResult_getAsStr\"" = Cbinding_clang_EvalResult_getAsStr{:clang_EvalResult_getAsStr}()
        (func::Cbinding_clang_EvalResult_getAsStr)(var"c\"E\"") = begin
                CBinding.funccall(func, var"c\"E\"")
            end
        const clang_EvalResult_getAsStr = var"c\"clang_EvalResult_getAsStr\""
        export var"c\"clang_EvalResult_getAsStr\""
        export clang_EvalResult_getAsStr
        var"c\"clang_EvalResult_getAsStr\""
        struct Cbinding_clang_EvalResult_dispose{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXEvalResult\""}, :cdecl}, libpath, :clang_EvalResult_dispose}
        end
        const var"c\"clang_EvalResult_dispose\"" = Cbinding_clang_EvalResult_dispose{:clang_EvalResult_dispose}()
        (func::Cbinding_clang_EvalResult_dispose)(var"c\"E\"") = begin
                CBinding.funccall(func, var"c\"E\"")
            end
        const clang_EvalResult_dispose = var"c\"clang_EvalResult_dispose\""
        export var"c\"clang_EvalResult_dispose\""
        export clang_EvalResult_dispose
        var"c\"clang_EvalResult_dispose\""
        const var"c\"CXRemapping\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXRemapping = var"c\"CXRemapping\""
        export var"c\"CXRemapping\""
        export CXRemapping
        var"c\"CXRemapping\""
        struct Cbinding_clang_getRemappings{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXRemapping\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, :cdecl}, libpath, :clang_getRemappings}
        end
        const var"c\"clang_getRemappings\"" = Cbinding_clang_getRemappings{:clang_getRemappings}()
        (func::Cbinding_clang_getRemappings)(var"c\"path\"") = begin
                CBinding.funccall(func, var"c\"path\"")
            end
        const clang_getRemappings = var"c\"clang_getRemappings\""
        export var"c\"clang_getRemappings\""
        export clang_getRemappings
        var"c\"clang_getRemappings\""
        struct Cbinding_clang_getRemappingsFromFileList{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXRemapping\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}, CBinding.Cuint}, :cdecl}, libpath, :clang_getRemappingsFromFileList}
        end
        const var"c\"clang_getRemappingsFromFileList\"" = Cbinding_clang_getRemappingsFromFileList{:clang_getRemappingsFromFileList}()
        (func::Cbinding_clang_getRemappingsFromFileList)(var"c\"filePaths\"", var"c\"numFiles\"") = begin
                CBinding.funccall(func, var"c\"filePaths\"", var"c\"numFiles\"")
            end
        const clang_getRemappingsFromFileList = var"c\"clang_getRemappingsFromFileList\""
        export var"c\"clang_getRemappingsFromFileList\""
        export clang_getRemappingsFromFileList
        var"c\"clang_getRemappingsFromFileList\""
        struct Cbinding_clang_remap_getNumFiles{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXRemapping\""}, :cdecl}, libpath, :clang_remap_getNumFiles}
        end
        const var"c\"clang_remap_getNumFiles\"" = Cbinding_clang_remap_getNumFiles{:clang_remap_getNumFiles}()
        (func::Cbinding_clang_remap_getNumFiles)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_remap_getNumFiles = var"c\"clang_remap_getNumFiles\""
        export var"c\"clang_remap_getNumFiles\""
        export clang_remap_getNumFiles
        var"c\"clang_remap_getNumFiles\""
        struct Cbinding_clang_remap_getFilenames{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXRemapping\"", CBinding.Cuint, CBinding.Cptr{var"c\"CXString\""}, CBinding.Cptr{var"c\"CXString\""}}, :cdecl}, libpath, :clang_remap_getFilenames}
        end
        const var"c\"clang_remap_getFilenames\"" = Cbinding_clang_remap_getFilenames{:clang_remap_getFilenames}()
        (func::Cbinding_clang_remap_getFilenames)(arg1, var"c\"index\"", var"c\"original\"", var"c\"transformed\"") = begin
                CBinding.funccall(func, arg1, var"c\"index\"", var"c\"original\"", var"c\"transformed\"")
            end
        const clang_remap_getFilenames = var"c\"clang_remap_getFilenames\""
        export var"c\"clang_remap_getFilenames\""
        export clang_remap_getFilenames
        var"c\"clang_remap_getFilenames\""
        struct Cbinding_clang_remap_dispose{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXRemapping\""}, :cdecl}, libpath, :clang_remap_dispose}
        end
        const var"c\"clang_remap_dispose\"" = Cbinding_clang_remap_dispose{:clang_remap_dispose}()
        (func::Cbinding_clang_remap_dispose)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_remap_dispose = var"c\"clang_remap_dispose\""
        export var"c\"clang_remap_dispose\""
        export clang_remap_dispose
        var"c\"clang_remap_dispose\""
        abstract type var"c\"enum CXVisitorResult\"" <: Cenum end
        const CXVisitorResult = var"c\"enum CXVisitorResult\""
        export var"c\"enum CXVisitorResult\""
        export CXVisitorResult
        var"c\"enum CXVisitorResult\""
        primitive type var"(c\"enum CXVisitorResult\")" <: var"c\"enum CXVisitorResult\"" 32 end
        (::(Type){var"(c\"enum CXVisitorResult\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXVisitorResult\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXVisitorResult\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXVisit_Break\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXVisit_Continue\""), 0x0000000000000001}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXVisitorResult\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXVisitorResult\")"}) = begin
                var"(c\"enum CXVisitorResult\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXVisitorResult\""}) = begin
                var"(c\"enum CXVisitorResult\")"
            end
        const var"c\"CXVisit_Break\"" = var"(c\"enum CXVisitorResult\")"(0x0000000000000000)
        const var"c\"CXVisit_Continue\"" = var"(c\"enum CXVisitorResult\")"(0x0000000000000001)
        const CXVisitorResult = var"c\"enum CXVisitorResult\""
        const CXVisit_Break = var"c\"CXVisit_Break\""
        const CXVisit_Continue = var"c\"CXVisit_Continue\""
        export var"c\"enum CXVisitorResult\"", var"(c\"enum CXVisitorResult\")", var"c\"CXVisit_Break\"", var"c\"CXVisit_Continue\""
        export CXVisitorResult, CXVisit_Break, CXVisit_Continue
        var"c\"enum CXVisitorResult\""
        abstract type var"c\"struct CXCursorAndRangeVisitor\"" <: Cstruct end
        const CXCursorAndRangeVisitor = var"c\"struct CXCursorAndRangeVisitor\""
        export var"c\"struct CXCursorAndRangeVisitor\""
        export CXCursorAndRangeVisitor
        var"c\"struct CXCursorAndRangeVisitor\""
        struct var"(c\"struct CXCursorAndRangeVisitor\")" <: var"c\"struct CXCursorAndRangeVisitor\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"struct CXCursorAndRangeVisitor\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"struct CXCursorAndRangeVisitor\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:context, CBinding.Tuple{CBinding.Cptr{CBinding.Cvoid}, CBinding.bitstype(CBinding.Cptr{CBinding.Cvoid}), CBinding.integraltype(CBinding.Cptr{CBinding.Cvoid}), 0, 0, -1}}, CBinding.Tuple{:visit, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{var"c\"enum CXVisitorResult\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cvoid}, var"c\"CXCursor\"", var"c\"CXSourceRange\""}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{var"c\"enum CXVisitorResult\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cvoid}, var"c\"CXCursor\"", var"c\"CXSourceRange\""}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{var"c\"enum CXVisitorResult\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cvoid}, var"c\"CXCursor\"", var"c\"CXSourceRange\""}, :cdecl}}), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"struct CXCursorAndRangeVisitor\")"}) = begin
                var"(c\"struct CXCursorAndRangeVisitor\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"struct CXCursorAndRangeVisitor\""}) = begin
                var"(c\"struct CXCursorAndRangeVisitor\")"
            end
        const CXCursorAndRangeVisitor = var"c\"struct CXCursorAndRangeVisitor\""
        export var"c\"struct CXCursorAndRangeVisitor\"", var"(c\"struct CXCursorAndRangeVisitor\")"
        export CXCursorAndRangeVisitor
        var"c\"struct CXCursorAndRangeVisitor\""
        const var"c\"CXCursorAndRangeVisitor\"" = var"c\"struct CXCursorAndRangeVisitor\""
        const CXCursorAndRangeVisitor = var"c\"CXCursorAndRangeVisitor\""
        export var"c\"CXCursorAndRangeVisitor\""
        export CXCursorAndRangeVisitor
        var"c\"CXCursorAndRangeVisitor\""
        abstract type var"c\"CXResult\"" <: Cenum end
        const CXResult = var"c\"CXResult\""
        export var"c\"CXResult\""
        export CXResult
        var"c\"CXResult\""
        primitive type var"(c\"CXResult\")" <: var"c\"CXResult\"" 32 end
        (::(Type){var"(c\"CXResult\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXResult\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXResult\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXResult_Success\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXResult_Invalid\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXResult_VisitBreak\""), 0x0000000000000002}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXResult\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXResult\")"}) = begin
                var"(c\"CXResult\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXResult\""}) = begin
                var"(c\"CXResult\")"
            end
        const var"c\"CXResult_Success\"" = var"(c\"CXResult\")"(0x0000000000000000)
        const var"c\"CXResult_Invalid\"" = var"(c\"CXResult\")"(0x0000000000000001)
        const var"c\"CXResult_VisitBreak\"" = var"(c\"CXResult\")"(0x0000000000000002)
        const CXResult = var"c\"CXResult\""
        const CXResult_Success = var"c\"CXResult_Success\""
        const CXResult_Invalid = var"c\"CXResult_Invalid\""
        const CXResult_VisitBreak = var"c\"CXResult_VisitBreak\""
        export var"c\"CXResult\"", var"(c\"CXResult\")", var"c\"CXResult_Success\"", var"c\"CXResult_Invalid\"", var"c\"CXResult_VisitBreak\""
        export CXResult, CXResult_Success, CXResult_Invalid, CXResult_VisitBreak
        var"c\"CXResult\""
        struct Cbinding_clang_findReferencesInFile{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXResult\"", CBinding.Tuple{var"c\"CXCursor\"", var"c\"CXFile\"", var"c\"CXCursorAndRangeVisitor\""}, :cdecl}, libpath, :clang_findReferencesInFile}
        end
        const var"c\"clang_findReferencesInFile\"" = Cbinding_clang_findReferencesInFile{:clang_findReferencesInFile}()
        (func::Cbinding_clang_findReferencesInFile)(var"c\"cursor\"", var"c\"file\"", var"c\"visitor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"", var"c\"file\"", var"c\"visitor\"")
            end
        const clang_findReferencesInFile = var"c\"clang_findReferencesInFile\""
        export var"c\"clang_findReferencesInFile\""
        export clang_findReferencesInFile
        var"c\"clang_findReferencesInFile\""
        struct Cbinding_clang_findIncludesInFile{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXResult\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXFile\"", var"c\"CXCursorAndRangeVisitor\""}, :cdecl}, libpath, :clang_findIncludesInFile}
        end
        const var"c\"clang_findIncludesInFile\"" = Cbinding_clang_findIncludesInFile{:clang_findIncludesInFile}()
        (func::Cbinding_clang_findIncludesInFile)(var"c\"TU\"", var"c\"file\"", var"c\"visitor\"") = begin
                CBinding.funccall(func, var"c\"TU\"", var"c\"file\"", var"c\"visitor\"")
            end
        const clang_findIncludesInFile = var"c\"clang_findIncludesInFile\""
        export var"c\"clang_findIncludesInFile\""
        export clang_findIncludesInFile
        var"c\"clang_findIncludesInFile\""
        abstract type var"c\"struct _CXCursorAndRangeVisitorBlock\"" <: Cstruct end
        const _CXCursorAndRangeVisitorBlock = var"c\"struct _CXCursorAndRangeVisitorBlock\""
        export var"c\"struct _CXCursorAndRangeVisitorBlock\""
        export _CXCursorAndRangeVisitorBlock
        var"c\"struct _CXCursorAndRangeVisitorBlock\""
        const var"c\"CXCursorAndRangeVisitorBlock\"" = CBinding.Cptr{var"c\"struct _CXCursorAndRangeVisitorBlock\""}
        const CXCursorAndRangeVisitorBlock = var"c\"CXCursorAndRangeVisitorBlock\""
        export var"c\"CXCursorAndRangeVisitorBlock\""
        export CXCursorAndRangeVisitorBlock
        var"c\"CXCursorAndRangeVisitorBlock\""
        struct Cbinding_clang_findReferencesInFileWithBlock{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXResult\"", CBinding.Tuple{var"c\"CXCursor\"", var"c\"CXFile\"", var"c\"CXCursorAndRangeVisitorBlock\""}, :cdecl}, libpath, :clang_findReferencesInFileWithBlock}
        end
        const var"c\"clang_findReferencesInFileWithBlock\"" = Cbinding_clang_findReferencesInFileWithBlock{:clang_findReferencesInFileWithBlock}()
        (func::Cbinding_clang_findReferencesInFileWithBlock)(arg1, arg2, arg3) = begin
                CBinding.funccall(func, arg1, arg2, arg3)
            end
        const clang_findReferencesInFileWithBlock = var"c\"clang_findReferencesInFileWithBlock\""
        export var"c\"clang_findReferencesInFileWithBlock\""
        export clang_findReferencesInFileWithBlock
        var"c\"clang_findReferencesInFileWithBlock\""
        struct Cbinding_clang_findIncludesInFileWithBlock{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXResult\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", var"c\"CXFile\"", var"c\"CXCursorAndRangeVisitorBlock\""}, :cdecl}, libpath, :clang_findIncludesInFileWithBlock}
        end
        const var"c\"clang_findIncludesInFileWithBlock\"" = Cbinding_clang_findIncludesInFileWithBlock{:clang_findIncludesInFileWithBlock}()
        (func::Cbinding_clang_findIncludesInFileWithBlock)(arg1, arg2, arg3) = begin
                CBinding.funccall(func, arg1, arg2, arg3)
            end
        const clang_findIncludesInFileWithBlock = var"c\"clang_findIncludesInFileWithBlock\""
        export var"c\"clang_findIncludesInFileWithBlock\""
        export clang_findIncludesInFileWithBlock
        var"c\"clang_findIncludesInFileWithBlock\""
        const var"c\"CXIdxClientFile\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXIdxClientFile = var"c\"CXIdxClientFile\""
        export var"c\"CXIdxClientFile\""
        export CXIdxClientFile
        var"c\"CXIdxClientFile\""
        const var"c\"CXIdxClientEntity\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXIdxClientEntity = var"c\"CXIdxClientEntity\""
        export var"c\"CXIdxClientEntity\""
        export CXIdxClientEntity
        var"c\"CXIdxClientEntity\""
        const var"c\"CXIdxClientContainer\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXIdxClientContainer = var"c\"CXIdxClientContainer\""
        export var"c\"CXIdxClientContainer\""
        export CXIdxClientContainer
        var"c\"CXIdxClientContainer\""
        const var"c\"CXIdxClientASTFile\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXIdxClientASTFile = var"c\"CXIdxClientASTFile\""
        export var"c\"CXIdxClientASTFile\""
        export CXIdxClientASTFile
        var"c\"CXIdxClientASTFile\""
        abstract type var"c\"CXIdxLoc\"" <: Cstruct end
        const CXIdxLoc = var"c\"CXIdxLoc\""
        export var"c\"CXIdxLoc\""
        export CXIdxLoc
        var"c\"CXIdxLoc\""
        struct var"(c\"CXIdxLoc\")" <: var"c\"CXIdxLoc\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXIdxLoc\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxLoc\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:ptr_data, CBinding.Tuple{CBinding.Carray{CBinding.Cptr{CBinding.Cvoid}, 2}, CBinding.bitstype(CBinding.Carray{CBinding.Cptr{CBinding.Cvoid}, 2}), CBinding.integraltype(CBinding.Carray{CBinding.Cptr{CBinding.Cvoid}, 2}), 0, 0, -1}}, CBinding.Tuple{:int_data, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxLoc\")"}) = begin
                var"(c\"CXIdxLoc\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxLoc\""}) = begin
                var"(c\"CXIdxLoc\")"
            end
        const CXIdxLoc = var"c\"CXIdxLoc\""
        export var"c\"CXIdxLoc\"", var"(c\"CXIdxLoc\")"
        export CXIdxLoc
        var"c\"CXIdxLoc\""
        abstract type var"c\"CXIdxIncludedFileInfo\"" <: Cstruct end
        const CXIdxIncludedFileInfo = var"c\"CXIdxIncludedFileInfo\""
        export var"c\"CXIdxIncludedFileInfo\""
        export CXIdxIncludedFileInfo
        var"c\"CXIdxIncludedFileInfo\""
        struct var"(c\"CXIdxIncludedFileInfo\")" <: var"c\"CXIdxIncludedFileInfo\""
            mem::CBinding.NTuple{56, CBinding.UInt8}
            var"(c\"CXIdxIncludedFileInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{56, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxIncludedFileInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:hashLoc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 0, 0, -1}}, CBinding.Tuple{:filename, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), 24, 0, -1}}, CBinding.Tuple{:file, CBinding.Tuple{var"c\"CXFile\"", CBinding.bitstype(var"c\"CXFile\""), CBinding.integraltype(var"c\"CXFile\""), 32, 0, -1}}, CBinding.Tuple{:isImport, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 40, 0, -1}}, CBinding.Tuple{:isAngled, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 44, 0, -1}}, CBinding.Tuple{:isModuleImport, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 48, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxIncludedFileInfo\")"}) = begin
                var"(c\"CXIdxIncludedFileInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxIncludedFileInfo\""}) = begin
                var"(c\"CXIdxIncludedFileInfo\")"
            end
        const CXIdxIncludedFileInfo = var"c\"CXIdxIncludedFileInfo\""
        export var"c\"CXIdxIncludedFileInfo\"", var"(c\"CXIdxIncludedFileInfo\")"
        export CXIdxIncludedFileInfo
        var"c\"CXIdxIncludedFileInfo\""
        abstract type var"c\"CXIdxImportedASTFileInfo\"" <: Cstruct end
        const CXIdxImportedASTFileInfo = var"c\"CXIdxImportedASTFileInfo\""
        export var"c\"CXIdxImportedASTFileInfo\""
        export CXIdxImportedASTFileInfo
        var"c\"CXIdxImportedASTFileInfo\""
        struct var"(c\"CXIdxImportedASTFileInfo\")" <: var"c\"CXIdxImportedASTFileInfo\""
            mem::CBinding.NTuple{48, CBinding.UInt8}
            var"(c\"CXIdxImportedASTFileInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{48, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxImportedASTFileInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:file, CBinding.Tuple{var"c\"CXFile\"", CBinding.bitstype(var"c\"CXFile\""), CBinding.integraltype(var"c\"CXFile\""), 0, 0, -1}}, CBinding.Tuple{:module, CBinding.Tuple{var"c\"CXModule\"", CBinding.bitstype(var"c\"CXModule\""), CBinding.integraltype(var"c\"CXModule\""), 8, 0, -1}}, CBinding.Tuple{:loc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 16, 0, -1}}, CBinding.Tuple{:isImplicit, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 40, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxImportedASTFileInfo\")"}) = begin
                var"(c\"CXIdxImportedASTFileInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxImportedASTFileInfo\""}) = begin
                var"(c\"CXIdxImportedASTFileInfo\")"
            end
        const CXIdxImportedASTFileInfo = var"c\"CXIdxImportedASTFileInfo\""
        export var"c\"CXIdxImportedASTFileInfo\"", var"(c\"CXIdxImportedASTFileInfo\")"
        export CXIdxImportedASTFileInfo
        var"c\"CXIdxImportedASTFileInfo\""
        abstract type var"c\"CXIdxEntityKind\"" <: Cenum end
        const CXIdxEntityKind = var"c\"CXIdxEntityKind\""
        export var"c\"CXIdxEntityKind\""
        export CXIdxEntityKind
        var"c\"CXIdxEntityKind\""
        primitive type var"(c\"CXIdxEntityKind\")" <: var"c\"CXIdxEntityKind\"" 32 end
        (::(Type){var"(c\"CXIdxEntityKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXIdxEntityKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXIdxEntityKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXIdxEntity_Unexposed\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXIdxEntity_Typedef\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXIdxEntity_Function\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXIdxEntity_Variable\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXIdxEntity_Field\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXIdxEntity_EnumConstant\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXIdxEntity_ObjCClass\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXIdxEntity_ObjCProtocol\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXIdxEntity_ObjCCategory\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXIdxEntity_ObjCInstanceMethod\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXIdxEntity_ObjCClassMethod\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXIdxEntity_ObjCProperty\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXIdxEntity_ObjCIvar\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXIdxEntity_Enum\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXIdxEntity_Struct\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXIdxEntity_Union\""), 0x000000000000000f}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXClass\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXNamespace\""), 0x0000000000000011}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXNamespaceAlias\""), 0x0000000000000012}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXStaticVariable\""), 0x0000000000000013}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXStaticMethod\""), 0x0000000000000014}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXInstanceMethod\""), 0x0000000000000015}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXConstructor\""), 0x0000000000000016}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXDestructor\""), 0x0000000000000017}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXConversionFunction\""), 0x0000000000000018}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXTypeAlias\""), 0x0000000000000019}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXInterface\""), 0x000000000000001a}, CBinding.Tuple{Symbol("c\"CXIdxEntity_CXXConcept\""), 0x000000000000001b}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXIdxEntityKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxEntityKind\")"}) = begin
                var"(c\"CXIdxEntityKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxEntityKind\""}) = begin
                var"(c\"CXIdxEntityKind\")"
            end
        const var"c\"CXIdxEntity_Unexposed\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000000)
        const var"c\"CXIdxEntity_Typedef\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000001)
        const var"c\"CXIdxEntity_Function\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000002)
        const var"c\"CXIdxEntity_Variable\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000003)
        const var"c\"CXIdxEntity_Field\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000004)
        const var"c\"CXIdxEntity_EnumConstant\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000005)
        const var"c\"CXIdxEntity_ObjCClass\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000006)
        const var"c\"CXIdxEntity_ObjCProtocol\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000007)
        const var"c\"CXIdxEntity_ObjCCategory\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000008)
        const var"c\"CXIdxEntity_ObjCInstanceMethod\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000009)
        const var"c\"CXIdxEntity_ObjCClassMethod\"" = var"(c\"CXIdxEntityKind\")"(0x000000000000000a)
        const var"c\"CXIdxEntity_ObjCProperty\"" = var"(c\"CXIdxEntityKind\")"(0x000000000000000b)
        const var"c\"CXIdxEntity_ObjCIvar\"" = var"(c\"CXIdxEntityKind\")"(0x000000000000000c)
        const var"c\"CXIdxEntity_Enum\"" = var"(c\"CXIdxEntityKind\")"(0x000000000000000d)
        const var"c\"CXIdxEntity_Struct\"" = var"(c\"CXIdxEntityKind\")"(0x000000000000000e)
        const var"c\"CXIdxEntity_Union\"" = var"(c\"CXIdxEntityKind\")"(0x000000000000000f)
        const var"c\"CXIdxEntity_CXXClass\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000010)
        const var"c\"CXIdxEntity_CXXNamespace\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000011)
        const var"c\"CXIdxEntity_CXXNamespaceAlias\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000012)
        const var"c\"CXIdxEntity_CXXStaticVariable\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000013)
        const var"c\"CXIdxEntity_CXXStaticMethod\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000014)
        const var"c\"CXIdxEntity_CXXInstanceMethod\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000015)
        const var"c\"CXIdxEntity_CXXConstructor\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000016)
        const var"c\"CXIdxEntity_CXXDestructor\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000017)
        const var"c\"CXIdxEntity_CXXConversionFunction\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000018)
        const var"c\"CXIdxEntity_CXXTypeAlias\"" = var"(c\"CXIdxEntityKind\")"(0x0000000000000019)
        const var"c\"CXIdxEntity_CXXInterface\"" = var"(c\"CXIdxEntityKind\")"(0x000000000000001a)
        const var"c\"CXIdxEntity_CXXConcept\"" = var"(c\"CXIdxEntityKind\")"(0x000000000000001b)
        const CXIdxEntityKind = var"c\"CXIdxEntityKind\""
        const CXIdxEntity_Unexposed = var"c\"CXIdxEntity_Unexposed\""
        const CXIdxEntity_Typedef = var"c\"CXIdxEntity_Typedef\""
        const CXIdxEntity_Function = var"c\"CXIdxEntity_Function\""
        const CXIdxEntity_Variable = var"c\"CXIdxEntity_Variable\""
        const CXIdxEntity_Field = var"c\"CXIdxEntity_Field\""
        const CXIdxEntity_EnumConstant = var"c\"CXIdxEntity_EnumConstant\""
        const CXIdxEntity_ObjCClass = var"c\"CXIdxEntity_ObjCClass\""
        const CXIdxEntity_ObjCProtocol = var"c\"CXIdxEntity_ObjCProtocol\""
        const CXIdxEntity_ObjCCategory = var"c\"CXIdxEntity_ObjCCategory\""
        const CXIdxEntity_ObjCInstanceMethod = var"c\"CXIdxEntity_ObjCInstanceMethod\""
        const CXIdxEntity_ObjCClassMethod = var"c\"CXIdxEntity_ObjCClassMethod\""
        const CXIdxEntity_ObjCProperty = var"c\"CXIdxEntity_ObjCProperty\""
        const CXIdxEntity_ObjCIvar = var"c\"CXIdxEntity_ObjCIvar\""
        const CXIdxEntity_Enum = var"c\"CXIdxEntity_Enum\""
        const CXIdxEntity_Struct = var"c\"CXIdxEntity_Struct\""
        const CXIdxEntity_Union = var"c\"CXIdxEntity_Union\""
        const CXIdxEntity_CXXClass = var"c\"CXIdxEntity_CXXClass\""
        const CXIdxEntity_CXXNamespace = var"c\"CXIdxEntity_CXXNamespace\""
        const CXIdxEntity_CXXNamespaceAlias = var"c\"CXIdxEntity_CXXNamespaceAlias\""
        const CXIdxEntity_CXXStaticVariable = var"c\"CXIdxEntity_CXXStaticVariable\""
        const CXIdxEntity_CXXStaticMethod = var"c\"CXIdxEntity_CXXStaticMethod\""
        const CXIdxEntity_CXXInstanceMethod = var"c\"CXIdxEntity_CXXInstanceMethod\""
        const CXIdxEntity_CXXConstructor = var"c\"CXIdxEntity_CXXConstructor\""
        const CXIdxEntity_CXXDestructor = var"c\"CXIdxEntity_CXXDestructor\""
        const CXIdxEntity_CXXConversionFunction = var"c\"CXIdxEntity_CXXConversionFunction\""
        const CXIdxEntity_CXXTypeAlias = var"c\"CXIdxEntity_CXXTypeAlias\""
        const CXIdxEntity_CXXInterface = var"c\"CXIdxEntity_CXXInterface\""
        const CXIdxEntity_CXXConcept = var"c\"CXIdxEntity_CXXConcept\""
        export var"c\"CXIdxEntityKind\"", var"(c\"CXIdxEntityKind\")", var"c\"CXIdxEntity_Unexposed\"", var"c\"CXIdxEntity_Typedef\"", var"c\"CXIdxEntity_Function\"", var"c\"CXIdxEntity_Variable\"", var"c\"CXIdxEntity_Field\"", var"c\"CXIdxEntity_EnumConstant\"", var"c\"CXIdxEntity_ObjCClass\"", var"c\"CXIdxEntity_ObjCProtocol\"", var"c\"CXIdxEntity_ObjCCategory\"", var"c\"CXIdxEntity_ObjCInstanceMethod\"", var"c\"CXIdxEntity_ObjCClassMethod\"", var"c\"CXIdxEntity_ObjCProperty\"", var"c\"CXIdxEntity_ObjCIvar\"", var"c\"CXIdxEntity_Enum\"", var"c\"CXIdxEntity_Struct\"", var"c\"CXIdxEntity_Union\"", var"c\"CXIdxEntity_CXXClass\"", var"c\"CXIdxEntity_CXXNamespace\"", var"c\"CXIdxEntity_CXXNamespaceAlias\"", var"c\"CXIdxEntity_CXXStaticVariable\"", var"c\"CXIdxEntity_CXXStaticMethod\"", var"c\"CXIdxEntity_CXXInstanceMethod\"", var"c\"CXIdxEntity_CXXConstructor\"", var"c\"CXIdxEntity_CXXDestructor\"", var"c\"CXIdxEntity_CXXConversionFunction\"", var"c\"CXIdxEntity_CXXTypeAlias\"", var"c\"CXIdxEntity_CXXInterface\"", var"c\"CXIdxEntity_CXXConcept\""
        export CXIdxEntityKind, CXIdxEntity_Unexposed, CXIdxEntity_Typedef, CXIdxEntity_Function, CXIdxEntity_Variable, CXIdxEntity_Field, CXIdxEntity_EnumConstant, CXIdxEntity_ObjCClass, CXIdxEntity_ObjCProtocol, CXIdxEntity_ObjCCategory, CXIdxEntity_ObjCInstanceMethod, CXIdxEntity_ObjCClassMethod, CXIdxEntity_ObjCProperty, CXIdxEntity_ObjCIvar, CXIdxEntity_Enum, CXIdxEntity_Struct, CXIdxEntity_Union, CXIdxEntity_CXXClass, CXIdxEntity_CXXNamespace, CXIdxEntity_CXXNamespaceAlias, CXIdxEntity_CXXStaticVariable, CXIdxEntity_CXXStaticMethod, CXIdxEntity_CXXInstanceMethod, CXIdxEntity_CXXConstructor, CXIdxEntity_CXXDestructor, CXIdxEntity_CXXConversionFunction, CXIdxEntity_CXXTypeAlias, CXIdxEntity_CXXInterface, CXIdxEntity_CXXConcept
        var"c\"CXIdxEntityKind\""
        abstract type var"c\"CXIdxEntityLanguage\"" <: Cenum end
        const CXIdxEntityLanguage = var"c\"CXIdxEntityLanguage\""
        export var"c\"CXIdxEntityLanguage\""
        export CXIdxEntityLanguage
        var"c\"CXIdxEntityLanguage\""
        primitive type var"(c\"CXIdxEntityLanguage\")" <: var"c\"CXIdxEntityLanguage\"" 32 end
        (::(Type){var"(c\"CXIdxEntityLanguage\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXIdxEntityLanguage\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXIdxEntityLanguage\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXIdxEntityLang_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXIdxEntityLang_C\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXIdxEntityLang_ObjC\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXIdxEntityLang_CXX\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXIdxEntityLang_Swift\""), 0x0000000000000004}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXIdxEntityLanguage\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxEntityLanguage\")"}) = begin
                var"(c\"CXIdxEntityLanguage\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxEntityLanguage\""}) = begin
                var"(c\"CXIdxEntityLanguage\")"
            end
        const var"c\"CXIdxEntityLang_None\"" = var"(c\"CXIdxEntityLanguage\")"(0x0000000000000000)
        const var"c\"CXIdxEntityLang_C\"" = var"(c\"CXIdxEntityLanguage\")"(0x0000000000000001)
        const var"c\"CXIdxEntityLang_ObjC\"" = var"(c\"CXIdxEntityLanguage\")"(0x0000000000000002)
        const var"c\"CXIdxEntityLang_CXX\"" = var"(c\"CXIdxEntityLanguage\")"(0x0000000000000003)
        const var"c\"CXIdxEntityLang_Swift\"" = var"(c\"CXIdxEntityLanguage\")"(0x0000000000000004)
        const CXIdxEntityLanguage = var"c\"CXIdxEntityLanguage\""
        const CXIdxEntityLang_None = var"c\"CXIdxEntityLang_None\""
        const CXIdxEntityLang_C = var"c\"CXIdxEntityLang_C\""
        const CXIdxEntityLang_ObjC = var"c\"CXIdxEntityLang_ObjC\""
        const CXIdxEntityLang_CXX = var"c\"CXIdxEntityLang_CXX\""
        const CXIdxEntityLang_Swift = var"c\"CXIdxEntityLang_Swift\""
        export var"c\"CXIdxEntityLanguage\"", var"(c\"CXIdxEntityLanguage\")", var"c\"CXIdxEntityLang_None\"", var"c\"CXIdxEntityLang_C\"", var"c\"CXIdxEntityLang_ObjC\"", var"c\"CXIdxEntityLang_CXX\"", var"c\"CXIdxEntityLang_Swift\""
        export CXIdxEntityLanguage, CXIdxEntityLang_None, CXIdxEntityLang_C, CXIdxEntityLang_ObjC, CXIdxEntityLang_CXX, CXIdxEntityLang_Swift
        var"c\"CXIdxEntityLanguage\""
        abstract type var"c\"CXIdxEntityCXXTemplateKind\"" <: Cenum end
        const CXIdxEntityCXXTemplateKind = var"c\"CXIdxEntityCXXTemplateKind\""
        export var"c\"CXIdxEntityCXXTemplateKind\""
        export CXIdxEntityCXXTemplateKind
        var"c\"CXIdxEntityCXXTemplateKind\""
        primitive type var"(c\"CXIdxEntityCXXTemplateKind\")" <: var"c\"CXIdxEntityCXXTemplateKind\"" 32 end
        (::(Type){var"(c\"CXIdxEntityCXXTemplateKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXIdxEntityCXXTemplateKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXIdxEntityCXXTemplateKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXIdxEntity_NonTemplate\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXIdxEntity_Template\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXIdxEntity_TemplatePartialSpecialization\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXIdxEntity_TemplateSpecialization\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXIdxEntityCXXTemplateKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxEntityCXXTemplateKind\")"}) = begin
                var"(c\"CXIdxEntityCXXTemplateKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxEntityCXXTemplateKind\""}) = begin
                var"(c\"CXIdxEntityCXXTemplateKind\")"
            end
        const var"c\"CXIdxEntity_NonTemplate\"" = var"(c\"CXIdxEntityCXXTemplateKind\")"(0x0000000000000000)
        const var"c\"CXIdxEntity_Template\"" = var"(c\"CXIdxEntityCXXTemplateKind\")"(0x0000000000000001)
        const var"c\"CXIdxEntity_TemplatePartialSpecialization\"" = var"(c\"CXIdxEntityCXXTemplateKind\")"(0x0000000000000002)
        const var"c\"CXIdxEntity_TemplateSpecialization\"" = var"(c\"CXIdxEntityCXXTemplateKind\")"(0x0000000000000003)
        const CXIdxEntityCXXTemplateKind = var"c\"CXIdxEntityCXXTemplateKind\""
        const CXIdxEntity_NonTemplate = var"c\"CXIdxEntity_NonTemplate\""
        const CXIdxEntity_Template = var"c\"CXIdxEntity_Template\""
        const CXIdxEntity_TemplatePartialSpecialization = var"c\"CXIdxEntity_TemplatePartialSpecialization\""
        const CXIdxEntity_TemplateSpecialization = var"c\"CXIdxEntity_TemplateSpecialization\""
        export var"c\"CXIdxEntityCXXTemplateKind\"", var"(c\"CXIdxEntityCXXTemplateKind\")", var"c\"CXIdxEntity_NonTemplate\"", var"c\"CXIdxEntity_Template\"", var"c\"CXIdxEntity_TemplatePartialSpecialization\"", var"c\"CXIdxEntity_TemplateSpecialization\""
        export CXIdxEntityCXXTemplateKind, CXIdxEntity_NonTemplate, CXIdxEntity_Template, CXIdxEntity_TemplatePartialSpecialization, CXIdxEntity_TemplateSpecialization
        var"c\"CXIdxEntityCXXTemplateKind\""
        abstract type var"c\"CXIdxAttrKind\"" <: Cenum end
        const CXIdxAttrKind = var"c\"CXIdxAttrKind\""
        export var"c\"CXIdxAttrKind\""
        export CXIdxAttrKind
        var"c\"CXIdxAttrKind\""
        primitive type var"(c\"CXIdxAttrKind\")" <: var"c\"CXIdxAttrKind\"" 32 end
        (::(Type){var"(c\"CXIdxAttrKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXIdxAttrKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXIdxAttrKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXIdxAttr_Unexposed\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXIdxAttr_IBAction\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXIdxAttr_IBOutlet\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXIdxAttr_IBOutletCollection\""), 0x0000000000000003}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXIdxAttrKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxAttrKind\")"}) = begin
                var"(c\"CXIdxAttrKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxAttrKind\""}) = begin
                var"(c\"CXIdxAttrKind\")"
            end
        const var"c\"CXIdxAttr_Unexposed\"" = var"(c\"CXIdxAttrKind\")"(0x0000000000000000)
        const var"c\"CXIdxAttr_IBAction\"" = var"(c\"CXIdxAttrKind\")"(0x0000000000000001)
        const var"c\"CXIdxAttr_IBOutlet\"" = var"(c\"CXIdxAttrKind\")"(0x0000000000000002)
        const var"c\"CXIdxAttr_IBOutletCollection\"" = var"(c\"CXIdxAttrKind\")"(0x0000000000000003)
        const CXIdxAttrKind = var"c\"CXIdxAttrKind\""
        const CXIdxAttr_Unexposed = var"c\"CXIdxAttr_Unexposed\""
        const CXIdxAttr_IBAction = var"c\"CXIdxAttr_IBAction\""
        const CXIdxAttr_IBOutlet = var"c\"CXIdxAttr_IBOutlet\""
        const CXIdxAttr_IBOutletCollection = var"c\"CXIdxAttr_IBOutletCollection\""
        export var"c\"CXIdxAttrKind\"", var"(c\"CXIdxAttrKind\")", var"c\"CXIdxAttr_Unexposed\"", var"c\"CXIdxAttr_IBAction\"", var"c\"CXIdxAttr_IBOutlet\"", var"c\"CXIdxAttr_IBOutletCollection\""
        export CXIdxAttrKind, CXIdxAttr_Unexposed, CXIdxAttr_IBAction, CXIdxAttr_IBOutlet, CXIdxAttr_IBOutletCollection
        var"c\"CXIdxAttrKind\""
        abstract type var"c\"CXIdxAttrInfo\"" <: Cstruct end
        const CXIdxAttrInfo = var"c\"CXIdxAttrInfo\""
        export var"c\"CXIdxAttrInfo\""
        export CXIdxAttrInfo
        var"c\"CXIdxAttrInfo\""
        struct var"(c\"CXIdxAttrInfo\")" <: var"c\"CXIdxAttrInfo\""
            mem::CBinding.NTuple{64, CBinding.UInt8}
            var"(c\"CXIdxAttrInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{64, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxAttrInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:kind, CBinding.Tuple{var"c\"CXIdxAttrKind\"", CBinding.bitstype(var"c\"CXIdxAttrKind\""), CBinding.integraltype(var"c\"CXIdxAttrKind\""), 0, 0, -1}}, CBinding.Tuple{:cursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 8, 0, -1}}, CBinding.Tuple{:loc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 40, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxAttrInfo\")"}) = begin
                var"(c\"CXIdxAttrInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxAttrInfo\""}) = begin
                var"(c\"CXIdxAttrInfo\")"
            end
        const CXIdxAttrInfo = var"c\"CXIdxAttrInfo\""
        export var"c\"CXIdxAttrInfo\"", var"(c\"CXIdxAttrInfo\")"
        export CXIdxAttrInfo
        var"c\"CXIdxAttrInfo\""
        abstract type var"c\"CXIdxEntityInfo\"" <: Cstruct end
        const CXIdxEntityInfo = var"c\"CXIdxEntityInfo\""
        export var"c\"CXIdxEntityInfo\""
        export CXIdxEntityInfo
        var"c\"CXIdxEntityInfo\""
        struct var"(c\"CXIdxEntityInfo\")" <: var"c\"CXIdxEntityInfo\""
            mem::CBinding.NTuple{80, CBinding.UInt8}
            var"(c\"CXIdxEntityInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{80, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxEntityInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:kind, CBinding.Tuple{var"c\"CXIdxEntityKind\"", CBinding.bitstype(var"c\"CXIdxEntityKind\""), CBinding.integraltype(var"c\"CXIdxEntityKind\""), 0, 0, -1}}, CBinding.Tuple{:templateKind, CBinding.Tuple{var"c\"CXIdxEntityCXXTemplateKind\"", CBinding.bitstype(var"c\"CXIdxEntityCXXTemplateKind\""), CBinding.integraltype(var"c\"CXIdxEntityCXXTemplateKind\""), 4, 0, -1}}, CBinding.Tuple{:lang, CBinding.Tuple{var"c\"CXIdxEntityLanguage\"", CBinding.bitstype(var"c\"CXIdxEntityLanguage\""), CBinding.integraltype(var"c\"CXIdxEntityLanguage\""), 8, 0, -1}}, CBinding.Tuple{:name, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), 16, 0, -1}}, CBinding.Tuple{:USR, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}), 24, 0, -1}}, CBinding.Tuple{:cursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 32, 0, -1}}, CBinding.Tuple{:attributes, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}}}), 64, 0, -1}}, CBinding.Tuple{:numAttributes, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 72, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxEntityInfo\")"}) = begin
                var"(c\"CXIdxEntityInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxEntityInfo\""}) = begin
                var"(c\"CXIdxEntityInfo\")"
            end
        const CXIdxEntityInfo = var"c\"CXIdxEntityInfo\""
        export var"c\"CXIdxEntityInfo\"", var"(c\"CXIdxEntityInfo\")"
        export CXIdxEntityInfo
        var"c\"CXIdxEntityInfo\""
        abstract type var"c\"CXIdxContainerInfo\"" <: Cstruct end
        const CXIdxContainerInfo = var"c\"CXIdxContainerInfo\""
        export var"c\"CXIdxContainerInfo\""
        export CXIdxContainerInfo
        var"c\"CXIdxContainerInfo\""
        struct var"(c\"CXIdxContainerInfo\")" <: var"c\"CXIdxContainerInfo\""
            mem::CBinding.NTuple{32, CBinding.UInt8}
            var"(c\"CXIdxContainerInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{32, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxContainerInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:cursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 0, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxContainerInfo\")"}) = begin
                var"(c\"CXIdxContainerInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxContainerInfo\""}) = begin
                var"(c\"CXIdxContainerInfo\")"
            end
        const CXIdxContainerInfo = var"c\"CXIdxContainerInfo\""
        export var"c\"CXIdxContainerInfo\"", var"(c\"CXIdxContainerInfo\")"
        export CXIdxContainerInfo
        var"c\"CXIdxContainerInfo\""
        abstract type var"c\"CXIdxIBOutletCollectionAttrInfo\"" <: Cstruct end
        const CXIdxIBOutletCollectionAttrInfo = var"c\"CXIdxIBOutletCollectionAttrInfo\""
        export var"c\"CXIdxIBOutletCollectionAttrInfo\""
        export CXIdxIBOutletCollectionAttrInfo
        var"c\"CXIdxIBOutletCollectionAttrInfo\""
        struct var"(c\"CXIdxIBOutletCollectionAttrInfo\")" <: var"c\"CXIdxIBOutletCollectionAttrInfo\""
            mem::CBinding.NTuple{72, CBinding.UInt8}
            var"(c\"CXIdxIBOutletCollectionAttrInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{72, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxIBOutletCollectionAttrInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:attrInfo, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:objcClass, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 8, 0, -1}}, CBinding.Tuple{:classCursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 16, 0, -1}}, CBinding.Tuple{:classLoc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 48, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxIBOutletCollectionAttrInfo\")"}) = begin
                var"(c\"CXIdxIBOutletCollectionAttrInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxIBOutletCollectionAttrInfo\""}) = begin
                var"(c\"CXIdxIBOutletCollectionAttrInfo\")"
            end
        const CXIdxIBOutletCollectionAttrInfo = var"c\"CXIdxIBOutletCollectionAttrInfo\""
        export var"c\"CXIdxIBOutletCollectionAttrInfo\"", var"(c\"CXIdxIBOutletCollectionAttrInfo\")"
        export CXIdxIBOutletCollectionAttrInfo
        var"c\"CXIdxIBOutletCollectionAttrInfo\""
        abstract type var"c\"CXIdxDeclInfoFlags\"" <: Cenum end
        const CXIdxDeclInfoFlags = var"c\"CXIdxDeclInfoFlags\""
        export var"c\"CXIdxDeclInfoFlags\""
        export CXIdxDeclInfoFlags
        var"c\"CXIdxDeclInfoFlags\""
        primitive type var"(c\"CXIdxDeclInfoFlags\")" <: var"c\"CXIdxDeclInfoFlags\"" 32 end
        (::(Type){var"(c\"CXIdxDeclInfoFlags\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXIdxDeclInfoFlags\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXIdxDeclInfoFlags\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXIdxDeclFlag_Skipped\""), 0x0000000000000001}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXIdxDeclInfoFlags\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxDeclInfoFlags\")"}) = begin
                var"(c\"CXIdxDeclInfoFlags\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxDeclInfoFlags\""}) = begin
                var"(c\"CXIdxDeclInfoFlags\")"
            end
        const var"c\"CXIdxDeclFlag_Skipped\"" = var"(c\"CXIdxDeclInfoFlags\")"(0x0000000000000001)
        const CXIdxDeclInfoFlags = var"c\"CXIdxDeclInfoFlags\""
        const CXIdxDeclFlag_Skipped = var"c\"CXIdxDeclFlag_Skipped\""
        export var"c\"CXIdxDeclInfoFlags\"", var"(c\"CXIdxDeclInfoFlags\")", var"c\"CXIdxDeclFlag_Skipped\""
        export CXIdxDeclInfoFlags, CXIdxDeclFlag_Skipped
        var"c\"CXIdxDeclInfoFlags\""
        abstract type var"c\"CXIdxDeclInfo\"" <: Cstruct end
        const CXIdxDeclInfo = var"c\"CXIdxDeclInfo\""
        export var"c\"CXIdxDeclInfo\""
        export CXIdxDeclInfo
        var"c\"CXIdxDeclInfo\""
        struct var"(c\"CXIdxDeclInfo\")" <: var"c\"CXIdxDeclInfo\""
            mem::CBinding.NTuple{128, CBinding.UInt8}
            var"(c\"CXIdxDeclInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{128, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxDeclInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:entityInfo, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:cursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 8, 0, -1}}, CBinding.Tuple{:loc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 40, 0, -1}}, CBinding.Tuple{:semanticContainer, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}), 64, 0, -1}}, CBinding.Tuple{:lexicalContainer, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}), 72, 0, -1}}, CBinding.Tuple{:isRedeclaration, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 80, 0, -1}}, CBinding.Tuple{:isDefinition, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 84, 0, -1}}, CBinding.Tuple{:isContainer, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 88, 0, -1}}, CBinding.Tuple{:declAsContainer, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}), 96, 0, -1}}, CBinding.Tuple{:isImplicit, CBinding.Tuple{CBinding.Cint, CBinding.bitstype(CBinding.Cint), CBinding.integraltype(CBinding.Cint), 104, 0, -1}}, CBinding.Tuple{:attributes, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}}}), 112, 0, -1}}, CBinding.Tuple{:numAttributes, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 120, 0, -1}}, CBinding.Tuple{:flags, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 124, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxDeclInfo\")"}) = begin
                var"(c\"CXIdxDeclInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxDeclInfo\""}) = begin
                var"(c\"CXIdxDeclInfo\")"
            end
        const CXIdxDeclInfo = var"c\"CXIdxDeclInfo\""
        export var"c\"CXIdxDeclInfo\"", var"(c\"CXIdxDeclInfo\")"
        export CXIdxDeclInfo
        var"c\"CXIdxDeclInfo\""
        abstract type var"c\"CXIdxObjCContainerKind\"" <: Cenum end
        const CXIdxObjCContainerKind = var"c\"CXIdxObjCContainerKind\""
        export var"c\"CXIdxObjCContainerKind\""
        export CXIdxObjCContainerKind
        var"c\"CXIdxObjCContainerKind\""
        primitive type var"(c\"CXIdxObjCContainerKind\")" <: var"c\"CXIdxObjCContainerKind\"" 32 end
        (::(Type){var"(c\"CXIdxObjCContainerKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXIdxObjCContainerKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXIdxObjCContainerKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXIdxObjCContainer_ForwardRef\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXIdxObjCContainer_Interface\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXIdxObjCContainer_Implementation\""), 0x0000000000000002}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXIdxObjCContainerKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxObjCContainerKind\")"}) = begin
                var"(c\"CXIdxObjCContainerKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxObjCContainerKind\""}) = begin
                var"(c\"CXIdxObjCContainerKind\")"
            end
        const var"c\"CXIdxObjCContainer_ForwardRef\"" = var"(c\"CXIdxObjCContainerKind\")"(0x0000000000000000)
        const var"c\"CXIdxObjCContainer_Interface\"" = var"(c\"CXIdxObjCContainerKind\")"(0x0000000000000001)
        const var"c\"CXIdxObjCContainer_Implementation\"" = var"(c\"CXIdxObjCContainerKind\")"(0x0000000000000002)
        const CXIdxObjCContainerKind = var"c\"CXIdxObjCContainerKind\""
        const CXIdxObjCContainer_ForwardRef = var"c\"CXIdxObjCContainer_ForwardRef\""
        const CXIdxObjCContainer_Interface = var"c\"CXIdxObjCContainer_Interface\""
        const CXIdxObjCContainer_Implementation = var"c\"CXIdxObjCContainer_Implementation\""
        export var"c\"CXIdxObjCContainerKind\"", var"(c\"CXIdxObjCContainerKind\")", var"c\"CXIdxObjCContainer_ForwardRef\"", var"c\"CXIdxObjCContainer_Interface\"", var"c\"CXIdxObjCContainer_Implementation\""
        export CXIdxObjCContainerKind, CXIdxObjCContainer_ForwardRef, CXIdxObjCContainer_Interface, CXIdxObjCContainer_Implementation
        var"c\"CXIdxObjCContainerKind\""
        abstract type var"c\"CXIdxObjCContainerDeclInfo\"" <: Cstruct end
        const CXIdxObjCContainerDeclInfo = var"c\"CXIdxObjCContainerDeclInfo\""
        export var"c\"CXIdxObjCContainerDeclInfo\""
        export CXIdxObjCContainerDeclInfo
        var"c\"CXIdxObjCContainerDeclInfo\""
        struct var"(c\"CXIdxObjCContainerDeclInfo\")" <: var"c\"CXIdxObjCContainerDeclInfo\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"CXIdxObjCContainerDeclInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxObjCContainerDeclInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:declInfo, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:kind, CBinding.Tuple{var"c\"CXIdxObjCContainerKind\"", CBinding.bitstype(var"c\"CXIdxObjCContainerKind\""), CBinding.integraltype(var"c\"CXIdxObjCContainerKind\""), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxObjCContainerDeclInfo\")"}) = begin
                var"(c\"CXIdxObjCContainerDeclInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxObjCContainerDeclInfo\""}) = begin
                var"(c\"CXIdxObjCContainerDeclInfo\")"
            end
        const CXIdxObjCContainerDeclInfo = var"c\"CXIdxObjCContainerDeclInfo\""
        export var"c\"CXIdxObjCContainerDeclInfo\"", var"(c\"CXIdxObjCContainerDeclInfo\")"
        export CXIdxObjCContainerDeclInfo
        var"c\"CXIdxObjCContainerDeclInfo\""
        abstract type var"c\"CXIdxBaseClassInfo\"" <: Cstruct end
        const CXIdxBaseClassInfo = var"c\"CXIdxBaseClassInfo\""
        export var"c\"CXIdxBaseClassInfo\""
        export CXIdxBaseClassInfo
        var"c\"CXIdxBaseClassInfo\""
        struct var"(c\"CXIdxBaseClassInfo\")" <: var"c\"CXIdxBaseClassInfo\""
            mem::CBinding.NTuple{64, CBinding.UInt8}
            var"(c\"CXIdxBaseClassInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{64, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxBaseClassInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:base, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:cursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 8, 0, -1}}, CBinding.Tuple{:loc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 40, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxBaseClassInfo\")"}) = begin
                var"(c\"CXIdxBaseClassInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxBaseClassInfo\""}) = begin
                var"(c\"CXIdxBaseClassInfo\")"
            end
        const CXIdxBaseClassInfo = var"c\"CXIdxBaseClassInfo\""
        export var"c\"CXIdxBaseClassInfo\"", var"(c\"CXIdxBaseClassInfo\")"
        export CXIdxBaseClassInfo
        var"c\"CXIdxBaseClassInfo\""
        abstract type var"c\"CXIdxObjCProtocolRefInfo\"" <: Cstruct end
        const CXIdxObjCProtocolRefInfo = var"c\"CXIdxObjCProtocolRefInfo\""
        export var"c\"CXIdxObjCProtocolRefInfo\""
        export CXIdxObjCProtocolRefInfo
        var"c\"CXIdxObjCProtocolRefInfo\""
        struct var"(c\"CXIdxObjCProtocolRefInfo\")" <: var"c\"CXIdxObjCProtocolRefInfo\""
            mem::CBinding.NTuple{64, CBinding.UInt8}
            var"(c\"CXIdxObjCProtocolRefInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{64, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxObjCProtocolRefInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:protocol, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:cursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 8, 0, -1}}, CBinding.Tuple{:loc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 40, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxObjCProtocolRefInfo\")"}) = begin
                var"(c\"CXIdxObjCProtocolRefInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxObjCProtocolRefInfo\""}) = begin
                var"(c\"CXIdxObjCProtocolRefInfo\")"
            end
        const CXIdxObjCProtocolRefInfo = var"c\"CXIdxObjCProtocolRefInfo\""
        export var"c\"CXIdxObjCProtocolRefInfo\"", var"(c\"CXIdxObjCProtocolRefInfo\")"
        export CXIdxObjCProtocolRefInfo
        var"c\"CXIdxObjCProtocolRefInfo\""
        abstract type var"c\"CXIdxObjCProtocolRefListInfo\"" <: Cstruct end
        const CXIdxObjCProtocolRefListInfo = var"c\"CXIdxObjCProtocolRefListInfo\""
        export var"c\"CXIdxObjCProtocolRefListInfo\""
        export CXIdxObjCProtocolRefListInfo
        var"c\"CXIdxObjCProtocolRefListInfo\""
        struct var"(c\"CXIdxObjCProtocolRefListInfo\")" <: var"c\"CXIdxObjCProtocolRefListInfo\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"CXIdxObjCProtocolRefListInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxObjCProtocolRefListInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:protocols, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefInfo\""}}}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefInfo\""}}}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefInfo\""}}}}), 0, 0, -1}}, CBinding.Tuple{:numProtocols, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxObjCProtocolRefListInfo\")"}) = begin
                var"(c\"CXIdxObjCProtocolRefListInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxObjCProtocolRefListInfo\""}) = begin
                var"(c\"CXIdxObjCProtocolRefListInfo\")"
            end
        const CXIdxObjCProtocolRefListInfo = var"c\"CXIdxObjCProtocolRefListInfo\""
        export var"c\"CXIdxObjCProtocolRefListInfo\"", var"(c\"CXIdxObjCProtocolRefListInfo\")"
        export CXIdxObjCProtocolRefListInfo
        var"c\"CXIdxObjCProtocolRefListInfo\""
        abstract type var"c\"CXIdxObjCInterfaceDeclInfo\"" <: Cstruct end
        const CXIdxObjCInterfaceDeclInfo = var"c\"CXIdxObjCInterfaceDeclInfo\""
        export var"c\"CXIdxObjCInterfaceDeclInfo\""
        export CXIdxObjCInterfaceDeclInfo
        var"c\"CXIdxObjCInterfaceDeclInfo\""
        struct var"(c\"CXIdxObjCInterfaceDeclInfo\")" <: var"c\"CXIdxObjCInterfaceDeclInfo\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXIdxObjCInterfaceDeclInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxObjCInterfaceDeclInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:containerInfo, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCContainerDeclInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCContainerDeclInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCContainerDeclInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:superInfo, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxBaseClassInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxBaseClassInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxBaseClassInfo\""}}), 8, 0, -1}}, CBinding.Tuple{:protocols, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefListInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefListInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefListInfo\""}}), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxObjCInterfaceDeclInfo\")"}) = begin
                var"(c\"CXIdxObjCInterfaceDeclInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxObjCInterfaceDeclInfo\""}) = begin
                var"(c\"CXIdxObjCInterfaceDeclInfo\")"
            end
        const CXIdxObjCInterfaceDeclInfo = var"c\"CXIdxObjCInterfaceDeclInfo\""
        export var"c\"CXIdxObjCInterfaceDeclInfo\"", var"(c\"CXIdxObjCInterfaceDeclInfo\")"
        export CXIdxObjCInterfaceDeclInfo
        var"c\"CXIdxObjCInterfaceDeclInfo\""
        abstract type var"c\"CXIdxObjCCategoryDeclInfo\"" <: Cstruct end
        const CXIdxObjCCategoryDeclInfo = var"c\"CXIdxObjCCategoryDeclInfo\""
        export var"c\"CXIdxObjCCategoryDeclInfo\""
        export CXIdxObjCCategoryDeclInfo
        var"c\"CXIdxObjCCategoryDeclInfo\""
        struct var"(c\"CXIdxObjCCategoryDeclInfo\")" <: var"c\"CXIdxObjCCategoryDeclInfo\""
            mem::CBinding.NTuple{80, CBinding.UInt8}
            var"(c\"CXIdxObjCCategoryDeclInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{80, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxObjCCategoryDeclInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:containerInfo, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCContainerDeclInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCContainerDeclInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCContainerDeclInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:objcClass, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 8, 0, -1}}, CBinding.Tuple{:classCursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 16, 0, -1}}, CBinding.Tuple{:classLoc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 48, 0, -1}}, CBinding.Tuple{:protocols, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefListInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefListInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefListInfo\""}}), 72, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxObjCCategoryDeclInfo\")"}) = begin
                var"(c\"CXIdxObjCCategoryDeclInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxObjCCategoryDeclInfo\""}) = begin
                var"(c\"CXIdxObjCCategoryDeclInfo\")"
            end
        const CXIdxObjCCategoryDeclInfo = var"c\"CXIdxObjCCategoryDeclInfo\""
        export var"c\"CXIdxObjCCategoryDeclInfo\"", var"(c\"CXIdxObjCCategoryDeclInfo\")"
        export CXIdxObjCCategoryDeclInfo
        var"c\"CXIdxObjCCategoryDeclInfo\""
        abstract type var"c\"CXIdxObjCPropertyDeclInfo\"" <: Cstruct end
        const CXIdxObjCPropertyDeclInfo = var"c\"CXIdxObjCPropertyDeclInfo\""
        export var"c\"CXIdxObjCPropertyDeclInfo\""
        export CXIdxObjCPropertyDeclInfo
        var"c\"CXIdxObjCPropertyDeclInfo\""
        struct var"(c\"CXIdxObjCPropertyDeclInfo\")" <: var"c\"CXIdxObjCPropertyDeclInfo\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXIdxObjCPropertyDeclInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxObjCPropertyDeclInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:declInfo, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:getter, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 8, 0, -1}}, CBinding.Tuple{:setter, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxObjCPropertyDeclInfo\")"}) = begin
                var"(c\"CXIdxObjCPropertyDeclInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxObjCPropertyDeclInfo\""}) = begin
                var"(c\"CXIdxObjCPropertyDeclInfo\")"
            end
        const CXIdxObjCPropertyDeclInfo = var"c\"CXIdxObjCPropertyDeclInfo\""
        export var"c\"CXIdxObjCPropertyDeclInfo\"", var"(c\"CXIdxObjCPropertyDeclInfo\")"
        export CXIdxObjCPropertyDeclInfo
        var"c\"CXIdxObjCPropertyDeclInfo\""
        abstract type var"c\"CXIdxCXXClassDeclInfo\"" <: Cstruct end
        const CXIdxCXXClassDeclInfo = var"c\"CXIdxCXXClassDeclInfo\""
        export var"c\"CXIdxCXXClassDeclInfo\""
        export CXIdxCXXClassDeclInfo
        var"c\"CXIdxCXXClassDeclInfo\""
        struct var"(c\"CXIdxCXXClassDeclInfo\")" <: var"c\"CXIdxCXXClassDeclInfo\""
            mem::CBinding.NTuple{24, CBinding.UInt8}
            var"(c\"CXIdxCXXClassDeclInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{24, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxCXXClassDeclInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:declInfo, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}), 0, 0, -1}}, CBinding.Tuple{:bases, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxBaseClassInfo\""}}}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxBaseClassInfo\""}}}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxBaseClassInfo\""}}}}), 8, 0, -1}}, CBinding.Tuple{:numBases, CBinding.Tuple{CBinding.Cuint, CBinding.bitstype(CBinding.Cuint), CBinding.integraltype(CBinding.Cuint), 16, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxCXXClassDeclInfo\")"}) = begin
                var"(c\"CXIdxCXXClassDeclInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxCXXClassDeclInfo\""}) = begin
                var"(c\"CXIdxCXXClassDeclInfo\")"
            end
        const CXIdxCXXClassDeclInfo = var"c\"CXIdxCXXClassDeclInfo\""
        export var"c\"CXIdxCXXClassDeclInfo\"", var"(c\"CXIdxCXXClassDeclInfo\")"
        export CXIdxCXXClassDeclInfo
        var"c\"CXIdxCXXClassDeclInfo\""
        abstract type var"c\"CXIdxEntityRefKind\"" <: Cenum end
        const CXIdxEntityRefKind = var"c\"CXIdxEntityRefKind\""
        export var"c\"CXIdxEntityRefKind\""
        export CXIdxEntityRefKind
        var"c\"CXIdxEntityRefKind\""
        primitive type var"(c\"CXIdxEntityRefKind\")" <: var"c\"CXIdxEntityRefKind\"" 32 end
        (::(Type){var"(c\"CXIdxEntityRefKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXIdxEntityRefKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXIdxEntityRefKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXIdxEntityRef_Direct\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXIdxEntityRef_Implicit\""), 0x0000000000000002}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXIdxEntityRefKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxEntityRefKind\")"}) = begin
                var"(c\"CXIdxEntityRefKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxEntityRefKind\""}) = begin
                var"(c\"CXIdxEntityRefKind\")"
            end
        const var"c\"CXIdxEntityRef_Direct\"" = var"(c\"CXIdxEntityRefKind\")"(0x0000000000000001)
        const var"c\"CXIdxEntityRef_Implicit\"" = var"(c\"CXIdxEntityRefKind\")"(0x0000000000000002)
        const CXIdxEntityRefKind = var"c\"CXIdxEntityRefKind\""
        const CXIdxEntityRef_Direct = var"c\"CXIdxEntityRef_Direct\""
        const CXIdxEntityRef_Implicit = var"c\"CXIdxEntityRef_Implicit\""
        export var"c\"CXIdxEntityRefKind\"", var"(c\"CXIdxEntityRefKind\")", var"c\"CXIdxEntityRef_Direct\"", var"c\"CXIdxEntityRef_Implicit\""
        export CXIdxEntityRefKind, CXIdxEntityRef_Direct, CXIdxEntityRef_Implicit
        var"c\"CXIdxEntityRefKind\""
        abstract type var"c\"CXSymbolRole\"" <: Cenum end
        const CXSymbolRole = var"c\"CXSymbolRole\""
        export var"c\"CXSymbolRole\""
        export CXSymbolRole
        var"c\"CXSymbolRole\""
        primitive type var"(c\"CXSymbolRole\")" <: var"c\"CXSymbolRole\"" 32 end
        (::(Type){var"(c\"CXSymbolRole\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXSymbolRole\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXSymbolRole\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXSymbolRole_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXSymbolRole_Declaration\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXSymbolRole_Definition\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXSymbolRole_Reference\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXSymbolRole_Read\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXSymbolRole_Write\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXSymbolRole_Call\""), 0x0000000000000020}, CBinding.Tuple{Symbol("c\"CXSymbolRole_Dynamic\""), 0x0000000000000040}, CBinding.Tuple{Symbol("c\"CXSymbolRole_AddressOf\""), 0x0000000000000080}, CBinding.Tuple{Symbol("c\"CXSymbolRole_Implicit\""), 0x0000000000000100}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXSymbolRole\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXSymbolRole\")"}) = begin
                var"(c\"CXSymbolRole\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXSymbolRole\""}) = begin
                var"(c\"CXSymbolRole\")"
            end
        const var"c\"CXSymbolRole_None\"" = var"(c\"CXSymbolRole\")"(0x0000000000000000)
        const var"c\"CXSymbolRole_Declaration\"" = var"(c\"CXSymbolRole\")"(0x0000000000000001)
        const var"c\"CXSymbolRole_Definition\"" = var"(c\"CXSymbolRole\")"(0x0000000000000002)
        const var"c\"CXSymbolRole_Reference\"" = var"(c\"CXSymbolRole\")"(0x0000000000000004)
        const var"c\"CXSymbolRole_Read\"" = var"(c\"CXSymbolRole\")"(0x0000000000000008)
        const var"c\"CXSymbolRole_Write\"" = var"(c\"CXSymbolRole\")"(0x0000000000000010)
        const var"c\"CXSymbolRole_Call\"" = var"(c\"CXSymbolRole\")"(0x0000000000000020)
        const var"c\"CXSymbolRole_Dynamic\"" = var"(c\"CXSymbolRole\")"(0x0000000000000040)
        const var"c\"CXSymbolRole_AddressOf\"" = var"(c\"CXSymbolRole\")"(0x0000000000000080)
        const var"c\"CXSymbolRole_Implicit\"" = var"(c\"CXSymbolRole\")"(0x0000000000000100)
        const CXSymbolRole = var"c\"CXSymbolRole\""
        const CXSymbolRole_None = var"c\"CXSymbolRole_None\""
        const CXSymbolRole_Declaration = var"c\"CXSymbolRole_Declaration\""
        const CXSymbolRole_Definition = var"c\"CXSymbolRole_Definition\""
        const CXSymbolRole_Reference = var"c\"CXSymbolRole_Reference\""
        const CXSymbolRole_Read = var"c\"CXSymbolRole_Read\""
        const CXSymbolRole_Write = var"c\"CXSymbolRole_Write\""
        const CXSymbolRole_Call = var"c\"CXSymbolRole_Call\""
        const CXSymbolRole_Dynamic = var"c\"CXSymbolRole_Dynamic\""
        const CXSymbolRole_AddressOf = var"c\"CXSymbolRole_AddressOf\""
        const CXSymbolRole_Implicit = var"c\"CXSymbolRole_Implicit\""
        export var"c\"CXSymbolRole\"", var"(c\"CXSymbolRole\")", var"c\"CXSymbolRole_None\"", var"c\"CXSymbolRole_Declaration\"", var"c\"CXSymbolRole_Definition\"", var"c\"CXSymbolRole_Reference\"", var"c\"CXSymbolRole_Read\"", var"c\"CXSymbolRole_Write\"", var"c\"CXSymbolRole_Call\"", var"c\"CXSymbolRole_Dynamic\"", var"c\"CXSymbolRole_AddressOf\"", var"c\"CXSymbolRole_Implicit\""
        export CXSymbolRole, CXSymbolRole_None, CXSymbolRole_Declaration, CXSymbolRole_Definition, CXSymbolRole_Reference, CXSymbolRole_Read, CXSymbolRole_Write, CXSymbolRole_Call, CXSymbolRole_Dynamic, CXSymbolRole_AddressOf, CXSymbolRole_Implicit
        var"c\"CXSymbolRole\""
        abstract type var"c\"CXIdxEntityRefInfo\"" <: Cstruct end
        const CXIdxEntityRefInfo = var"c\"CXIdxEntityRefInfo\""
        export var"c\"CXIdxEntityRefInfo\""
        export CXIdxEntityRefInfo
        var"c\"CXIdxEntityRefInfo\""
        struct var"(c\"CXIdxEntityRefInfo\")" <: var"c\"CXIdxEntityRefInfo\""
            mem::CBinding.NTuple{96, CBinding.UInt8}
            var"(c\"CXIdxEntityRefInfo\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{96, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXIdxEntityRefInfo\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:kind, CBinding.Tuple{var"c\"CXIdxEntityRefKind\"", CBinding.bitstype(var"c\"CXIdxEntityRefKind\""), CBinding.integraltype(var"c\"CXIdxEntityRefKind\""), 0, 0, -1}}, CBinding.Tuple{:cursor, CBinding.Tuple{var"c\"CXCursor\"", CBinding.bitstype(var"c\"CXCursor\""), CBinding.integraltype(var"c\"CXCursor\""), 8, 0, -1}}, CBinding.Tuple{:loc, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.bitstype(var"c\"CXIdxLoc\""), CBinding.integraltype(var"c\"CXIdxLoc\""), 40, 0, -1}}, CBinding.Tuple{:referencedEntity, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 64, 0, -1}}, CBinding.Tuple{:parentEntity, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}), 72, 0, -1}}, CBinding.Tuple{:container, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}), 80, 0, -1}}, CBinding.Tuple{:role, CBinding.Tuple{var"c\"CXSymbolRole\"", CBinding.bitstype(var"c\"CXSymbolRole\""), CBinding.integraltype(var"c\"CXSymbolRole\""), 88, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIdxEntityRefInfo\")"}) = begin
                var"(c\"CXIdxEntityRefInfo\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIdxEntityRefInfo\""}) = begin
                var"(c\"CXIdxEntityRefInfo\")"
            end
        const CXIdxEntityRefInfo = var"c\"CXIdxEntityRefInfo\""
        export var"c\"CXIdxEntityRefInfo\"", var"(c\"CXIdxEntityRefInfo\")"
        export CXIdxEntityRefInfo
        var"c\"CXIdxEntityRefInfo\""
        abstract type var"c\"IndexerCallbacks\"" <: Cstruct end
        const IndexerCallbacks = var"c\"IndexerCallbacks\""
        export var"c\"IndexerCallbacks\""
        export IndexerCallbacks
        var"c\"IndexerCallbacks\""
        struct var"(c\"IndexerCallbacks\")" <: var"c\"IndexerCallbacks\""
            mem::CBinding.NTuple{64, CBinding.UInt8}
            var"(c\"IndexerCallbacks\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{64, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"IndexerCallbacks\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:abortQuery, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}), 0, 0, -1}}, CBinding.Tuple{:diagnostic, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", var"c\"CXDiagnosticSet\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", var"c\"CXDiagnosticSet\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", var"c\"CXDiagnosticSet\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}), 8, 0, -1}}, CBinding.Tuple{:enteredMainFile, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientFile\"", CBinding.Tuple{var"c\"CXClientData\"", var"c\"CXFile\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientFile\"", CBinding.Tuple{var"c\"CXClientData\"", var"c\"CXFile\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientFile\"", CBinding.Tuple{var"c\"CXClientData\"", var"c\"CXFile\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}), 16, 0, -1}}, CBinding.Tuple{:ppIncludedFile, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientFile\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxIncludedFileInfo\""}}}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientFile\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxIncludedFileInfo\""}}}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientFile\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxIncludedFileInfo\""}}}, :cdecl}}), 24, 0, -1}}, CBinding.Tuple{:importedASTFile, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientASTFile\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxImportedASTFileInfo\""}}}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientASTFile\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxImportedASTFileInfo\""}}}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientASTFile\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxImportedASTFileInfo\""}}}, :cdecl}}), 32, 0, -1}}, CBinding.Tuple{:startedTranslationUnit, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientContainer\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientContainer\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{var"c\"CXIdxClientContainer\"", CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cvoid}}, :cdecl}}), 40, 0, -1}}, CBinding.Tuple{:indexDeclaration, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}}), 48, 0, -1}}, CBinding.Tuple{:indexEntityReference, CBinding.Tuple{CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityRefInfo\""}}}, :cdecl}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityRefInfo\""}}}, :cdecl}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXClientData\"", CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityRefInfo\""}}}, :cdecl}}), 56, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"IndexerCallbacks\")"}) = begin
                var"(c\"IndexerCallbacks\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"IndexerCallbacks\""}) = begin
                var"(c\"IndexerCallbacks\")"
            end
        const IndexerCallbacks = var"c\"IndexerCallbacks\""
        export var"c\"IndexerCallbacks\"", var"(c\"IndexerCallbacks\")"
        export IndexerCallbacks
        var"c\"IndexerCallbacks\""
        struct Cbinding_clang_index_isEntityObjCContainerKind{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXIdxEntityKind\""}, :cdecl}, libpath, :clang_index_isEntityObjCContainerKind}
        end
        const var"c\"clang_index_isEntityObjCContainerKind\"" = Cbinding_clang_index_isEntityObjCContainerKind{:clang_index_isEntityObjCContainerKind}()
        (func::Cbinding_clang_index_isEntityObjCContainerKind)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_isEntityObjCContainerKind = var"c\"clang_index_isEntityObjCContainerKind\""
        export var"c\"clang_index_isEntityObjCContainerKind\""
        export clang_index_isEntityObjCContainerKind
        var"c\"clang_index_isEntityObjCContainerKind\""
        struct Cbinding_clang_index_getObjCContainerDeclInfo{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCContainerDeclInfo\""}}, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}, libpath, :clang_index_getObjCContainerDeclInfo}
        end
        const var"c\"clang_index_getObjCContainerDeclInfo\"" = Cbinding_clang_index_getObjCContainerDeclInfo{:clang_index_getObjCContainerDeclInfo}()
        (func::Cbinding_clang_index_getObjCContainerDeclInfo)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getObjCContainerDeclInfo = var"c\"clang_index_getObjCContainerDeclInfo\""
        export var"c\"clang_index_getObjCContainerDeclInfo\""
        export clang_index_getObjCContainerDeclInfo
        var"c\"clang_index_getObjCContainerDeclInfo\""
        struct Cbinding_clang_index_getObjCInterfaceDeclInfo{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCInterfaceDeclInfo\""}}, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}, libpath, :clang_index_getObjCInterfaceDeclInfo}
        end
        const var"c\"clang_index_getObjCInterfaceDeclInfo\"" = Cbinding_clang_index_getObjCInterfaceDeclInfo{:clang_index_getObjCInterfaceDeclInfo}()
        (func::Cbinding_clang_index_getObjCInterfaceDeclInfo)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getObjCInterfaceDeclInfo = var"c\"clang_index_getObjCInterfaceDeclInfo\""
        export var"c\"clang_index_getObjCInterfaceDeclInfo\""
        export clang_index_getObjCInterfaceDeclInfo
        var"c\"clang_index_getObjCInterfaceDeclInfo\""
        struct Cbinding_clang_index_getObjCCategoryDeclInfo{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCCategoryDeclInfo\""}}, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}, libpath, :clang_index_getObjCCategoryDeclInfo}
        end
        const var"c\"clang_index_getObjCCategoryDeclInfo\"" = Cbinding_clang_index_getObjCCategoryDeclInfo{:clang_index_getObjCCategoryDeclInfo}()
        (func::Cbinding_clang_index_getObjCCategoryDeclInfo)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getObjCCategoryDeclInfo = var"c\"clang_index_getObjCCategoryDeclInfo\""
        export var"c\"clang_index_getObjCCategoryDeclInfo\""
        export clang_index_getObjCCategoryDeclInfo
        var"c\"clang_index_getObjCCategoryDeclInfo\""
        struct Cbinding_clang_index_getObjCProtocolRefListInfo{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCProtocolRefListInfo\""}}, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}, libpath, :clang_index_getObjCProtocolRefListInfo}
        end
        const var"c\"clang_index_getObjCProtocolRefListInfo\"" = Cbinding_clang_index_getObjCProtocolRefListInfo{:clang_index_getObjCProtocolRefListInfo}()
        (func::Cbinding_clang_index_getObjCProtocolRefListInfo)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getObjCProtocolRefListInfo = var"c\"clang_index_getObjCProtocolRefListInfo\""
        export var"c\"clang_index_getObjCProtocolRefListInfo\""
        export clang_index_getObjCProtocolRefListInfo
        var"c\"clang_index_getObjCProtocolRefListInfo\""
        struct Cbinding_clang_index_getObjCPropertyDeclInfo{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxObjCPropertyDeclInfo\""}}, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}, libpath, :clang_index_getObjCPropertyDeclInfo}
        end
        const var"c\"clang_index_getObjCPropertyDeclInfo\"" = Cbinding_clang_index_getObjCPropertyDeclInfo{:clang_index_getObjCPropertyDeclInfo}()
        (func::Cbinding_clang_index_getObjCPropertyDeclInfo)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getObjCPropertyDeclInfo = var"c\"clang_index_getObjCPropertyDeclInfo\""
        export var"c\"clang_index_getObjCPropertyDeclInfo\""
        export clang_index_getObjCPropertyDeclInfo
        var"c\"clang_index_getObjCPropertyDeclInfo\""
        struct Cbinding_clang_index_getIBOutletCollectionAttrInfo{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxIBOutletCollectionAttrInfo\""}}, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxAttrInfo\""}}}, :cdecl}, libpath, :clang_index_getIBOutletCollectionAttrInfo}
        end
        const var"c\"clang_index_getIBOutletCollectionAttrInfo\"" = Cbinding_clang_index_getIBOutletCollectionAttrInfo{:clang_index_getIBOutletCollectionAttrInfo}()
        (func::Cbinding_clang_index_getIBOutletCollectionAttrInfo)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getIBOutletCollectionAttrInfo = var"c\"clang_index_getIBOutletCollectionAttrInfo\""
        export var"c\"clang_index_getIBOutletCollectionAttrInfo\""
        export clang_index_getIBOutletCollectionAttrInfo
        var"c\"clang_index_getIBOutletCollectionAttrInfo\""
        struct Cbinding_clang_index_getCXXClassDeclInfo{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxCXXClassDeclInfo\""}}, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxDeclInfo\""}}}, :cdecl}, libpath, :clang_index_getCXXClassDeclInfo}
        end
        const var"c\"clang_index_getCXXClassDeclInfo\"" = Cbinding_clang_index_getCXXClassDeclInfo{:clang_index_getCXXClassDeclInfo}()
        (func::Cbinding_clang_index_getCXXClassDeclInfo)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getCXXClassDeclInfo = var"c\"clang_index_getCXXClassDeclInfo\""
        export var"c\"clang_index_getCXXClassDeclInfo\""
        export clang_index_getCXXClassDeclInfo
        var"c\"clang_index_getCXXClassDeclInfo\""
        struct Cbinding_clang_index_getClientContainer{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXIdxClientContainer\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}}, :cdecl}, libpath, :clang_index_getClientContainer}
        end
        const var"c\"clang_index_getClientContainer\"" = Cbinding_clang_index_getClientContainer{:clang_index_getClientContainer}()
        (func::Cbinding_clang_index_getClientContainer)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getClientContainer = var"c\"clang_index_getClientContainer\""
        export var"c\"clang_index_getClientContainer\""
        export clang_index_getClientContainer
        var"c\"clang_index_getClientContainer\""
        struct Cbinding_clang_index_setClientContainer{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxContainerInfo\""}}, var"c\"CXIdxClientContainer\""}, :cdecl}, libpath, :clang_index_setClientContainer}
        end
        const var"c\"clang_index_setClientContainer\"" = Cbinding_clang_index_setClientContainer{:clang_index_setClientContainer}()
        (func::Cbinding_clang_index_setClientContainer)(arg1, arg2) = begin
                CBinding.funccall(func, arg1, arg2)
            end
        const clang_index_setClientContainer = var"c\"clang_index_setClientContainer\""
        export var"c\"clang_index_setClientContainer\""
        export clang_index_setClientContainer
        var"c\"clang_index_setClientContainer\""
        struct Cbinding_clang_index_getClientEntity{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXIdxClientEntity\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}}, :cdecl}, libpath, :clang_index_getClientEntity}
        end
        const var"c\"clang_index_getClientEntity\"" = Cbinding_clang_index_getClientEntity{:clang_index_getClientEntity}()
        (func::Cbinding_clang_index_getClientEntity)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_index_getClientEntity = var"c\"clang_index_getClientEntity\""
        export var"c\"clang_index_getClientEntity\""
        export clang_index_getClientEntity
        var"c\"clang_index_getClientEntity\""
        struct Cbinding_clang_index_setClientEntity{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{var"c\"CXIdxEntityInfo\""}}, var"c\"CXIdxClientEntity\""}, :cdecl}, libpath, :clang_index_setClientEntity}
        end
        const var"c\"clang_index_setClientEntity\"" = Cbinding_clang_index_setClientEntity{:clang_index_setClientEntity}()
        (func::Cbinding_clang_index_setClientEntity)(arg1, arg2) = begin
                CBinding.funccall(func, arg1, arg2)
            end
        const clang_index_setClientEntity = var"c\"clang_index_setClientEntity\""
        export var"c\"clang_index_setClientEntity\""
        export clang_index_setClientEntity
        var"c\"clang_index_setClientEntity\""
        const var"c\"CXIndexAction\"" = CBinding.Cptr{CBinding.Cvoid}
        const CXIndexAction = var"c\"CXIndexAction\""
        export var"c\"CXIndexAction\""
        export CXIndexAction
        var"c\"CXIndexAction\""
        struct Cbinding_clang_IndexAction_create{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXIndexAction\"", CBinding.Tuple{var"c\"CXIndex\""}, :cdecl}, libpath, :clang_IndexAction_create}
        end
        const var"c\"clang_IndexAction_create\"" = Cbinding_clang_IndexAction_create{:clang_IndexAction_create}()
        (func::Cbinding_clang_IndexAction_create)(var"c\"CIdx\"") = begin
                CBinding.funccall(func, var"c\"CIdx\"")
            end
        const clang_IndexAction_create = var"c\"clang_IndexAction_create\""
        export var"c\"clang_IndexAction_create\""
        export clang_IndexAction_create
        var"c\"clang_IndexAction_create\""
        struct Cbinding_clang_IndexAction_dispose{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXIndexAction\""}, :cdecl}, libpath, :clang_IndexAction_dispose}
        end
        const var"c\"clang_IndexAction_dispose\"" = Cbinding_clang_IndexAction_dispose{:clang_IndexAction_dispose}()
        (func::Cbinding_clang_IndexAction_dispose)(arg1) = begin
                CBinding.funccall(func, arg1)
            end
        const clang_IndexAction_dispose = var"c\"clang_IndexAction_dispose\""
        export var"c\"clang_IndexAction_dispose\""
        export clang_IndexAction_dispose
        var"c\"clang_IndexAction_dispose\""
        abstract type var"c\"CXIndexOptFlags\"" <: Cenum end
        const CXIndexOptFlags = var"c\"CXIndexOptFlags\""
        export var"c\"CXIndexOptFlags\""
        export CXIndexOptFlags
        var"c\"CXIndexOptFlags\""
        primitive type var"(c\"CXIndexOptFlags\")" <: var"c\"CXIndexOptFlags\"" 32 end
        (::(Type){var"(c\"CXIndexOptFlags\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"CXIndexOptFlags\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"CXIndexOptFlags\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXIndexOpt_None\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXIndexOpt_SuppressRedundantRefs\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXIndexOpt_IndexFunctionLocalSymbols\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXIndexOpt_IndexImplicitTemplateInstantiations\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXIndexOpt_SuppressWarnings\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXIndexOpt_SkipParsedBodiesInSession\""), 0x0000000000000010}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"CXIndexOptFlags\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXIndexOptFlags\")"}) = begin
                var"(c\"CXIndexOptFlags\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXIndexOptFlags\""}) = begin
                var"(c\"CXIndexOptFlags\")"
            end
        const var"c\"CXIndexOpt_None\"" = var"(c\"CXIndexOptFlags\")"(0x0000000000000000)
        const var"c\"CXIndexOpt_SuppressRedundantRefs\"" = var"(c\"CXIndexOptFlags\")"(0x0000000000000001)
        const var"c\"CXIndexOpt_IndexFunctionLocalSymbols\"" = var"(c\"CXIndexOptFlags\")"(0x0000000000000002)
        const var"c\"CXIndexOpt_IndexImplicitTemplateInstantiations\"" = var"(c\"CXIndexOptFlags\")"(0x0000000000000004)
        const var"c\"CXIndexOpt_SuppressWarnings\"" = var"(c\"CXIndexOptFlags\")"(0x0000000000000008)
        const var"c\"CXIndexOpt_SkipParsedBodiesInSession\"" = var"(c\"CXIndexOptFlags\")"(0x0000000000000010)
        const CXIndexOptFlags = var"c\"CXIndexOptFlags\""
        const CXIndexOpt_None = var"c\"CXIndexOpt_None\""
        const CXIndexOpt_SuppressRedundantRefs = var"c\"CXIndexOpt_SuppressRedundantRefs\""
        const CXIndexOpt_IndexFunctionLocalSymbols = var"c\"CXIndexOpt_IndexFunctionLocalSymbols\""
        const CXIndexOpt_IndexImplicitTemplateInstantiations = var"c\"CXIndexOpt_IndexImplicitTemplateInstantiations\""
        const CXIndexOpt_SuppressWarnings = var"c\"CXIndexOpt_SuppressWarnings\""
        const CXIndexOpt_SkipParsedBodiesInSession = var"c\"CXIndexOpt_SkipParsedBodiesInSession\""
        export var"c\"CXIndexOptFlags\"", var"(c\"CXIndexOptFlags\")", var"c\"CXIndexOpt_None\"", var"c\"CXIndexOpt_SuppressRedundantRefs\"", var"c\"CXIndexOpt_IndexFunctionLocalSymbols\"", var"c\"CXIndexOpt_IndexImplicitTemplateInstantiations\"", var"c\"CXIndexOpt_SuppressWarnings\"", var"c\"CXIndexOpt_SkipParsedBodiesInSession\""
        export CXIndexOptFlags, CXIndexOpt_None, CXIndexOpt_SuppressRedundantRefs, CXIndexOpt_IndexFunctionLocalSymbols, CXIndexOpt_IndexImplicitTemplateInstantiations, CXIndexOpt_SuppressWarnings, CXIndexOpt_SkipParsedBodiesInSession
        var"c\"CXIndexOptFlags\""
        struct Cbinding_clang_indexSourceFile{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXIndexAction\"", var"c\"CXClientData\"", CBinding.Cptr{var"c\"IndexerCallbacks\""}, CBinding.Cuint, CBinding.Cuint, CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}}, CBinding.Cint, CBinding.Cptr{var"c\"struct CXUnsavedFile\""}, CBinding.Cuint, CBinding.Cptr{var"c\"CXTranslationUnit\""}, CBinding.Cuint}, :cdecl}, libpath, :clang_indexSourceFile}
        end
        const var"c\"clang_indexSourceFile\"" = Cbinding_clang_indexSourceFile{:clang_indexSourceFile}()
        (func::Cbinding_clang_indexSourceFile)(arg1, var"c\"client_data\"", var"c\"index_callbacks\"", var"c\"index_callbacks_size\"", var"c\"index_options\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"out_TU\"", var"c\"TU_options\"") = begin
                CBinding.funccall(func, arg1, var"c\"client_data\"", var"c\"index_callbacks\"", var"c\"index_callbacks_size\"", var"c\"index_options\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"out_TU\"", var"c\"TU_options\"")
            end
        const clang_indexSourceFile = var"c\"clang_indexSourceFile\""
        export var"c\"clang_indexSourceFile\""
        export clang_indexSourceFile
        var"c\"clang_indexSourceFile\""
        struct Cbinding_clang_indexSourceFileFullArgv{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXIndexAction\"", var"c\"CXClientData\"", CBinding.Cptr{var"c\"IndexerCallbacks\""}, CBinding.Cuint, CBinding.Cuint, CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, CBinding.Cptr{CBinding.Cconst{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}}}, CBinding.Cint, CBinding.Cptr{var"c\"struct CXUnsavedFile\""}, CBinding.Cuint, CBinding.Cptr{var"c\"CXTranslationUnit\""}, CBinding.Cuint}, :cdecl}, libpath, :clang_indexSourceFileFullArgv}
        end
        const var"c\"clang_indexSourceFileFullArgv\"" = Cbinding_clang_indexSourceFileFullArgv{:clang_indexSourceFileFullArgv}()
        (func::Cbinding_clang_indexSourceFileFullArgv)(arg1, var"c\"client_data\"", var"c\"index_callbacks\"", var"c\"index_callbacks_size\"", var"c\"index_options\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"out_TU\"", var"c\"TU_options\"") = begin
                CBinding.funccall(func, arg1, var"c\"client_data\"", var"c\"index_callbacks\"", var"c\"index_callbacks_size\"", var"c\"index_options\"", var"c\"source_filename\"", var"c\"command_line_args\"", var"c\"num_command_line_args\"", var"c\"unsaved_files\"", var"c\"num_unsaved_files\"", var"c\"out_TU\"", var"c\"TU_options\"")
            end
        const clang_indexSourceFileFullArgv = var"c\"clang_indexSourceFileFullArgv\""
        export var"c\"clang_indexSourceFileFullArgv\""
        export clang_indexSourceFileFullArgv
        var"c\"clang_indexSourceFileFullArgv\""
        struct Cbinding_clang_indexTranslationUnit{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cint, CBinding.Tuple{var"c\"CXIndexAction\"", var"c\"CXClientData\"", CBinding.Cptr{var"c\"IndexerCallbacks\""}, CBinding.Cuint, CBinding.Cuint, var"c\"CXTranslationUnit\""}, :cdecl}, libpath, :clang_indexTranslationUnit}
        end
        const var"c\"clang_indexTranslationUnit\"" = Cbinding_clang_indexTranslationUnit{:clang_indexTranslationUnit}()
        (func::Cbinding_clang_indexTranslationUnit)(arg1, var"c\"client_data\"", var"c\"index_callbacks\"", var"c\"index_callbacks_size\"", var"c\"index_options\"", arg6) = begin
                CBinding.funccall(func, arg1, var"c\"client_data\"", var"c\"index_callbacks\"", var"c\"index_callbacks_size\"", var"c\"index_options\"", arg6)
            end
        const clang_indexTranslationUnit = var"c\"clang_indexTranslationUnit\""
        export var"c\"clang_indexTranslationUnit\""
        export clang_indexTranslationUnit
        var"c\"clang_indexTranslationUnit\""
        struct Cbinding_clang_indexLoc_getFileLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXIdxLoc\"", CBinding.Cptr{var"c\"CXIdxClientFile\""}, CBinding.Cptr{var"c\"CXFile\""}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}, CBinding.Cptr{CBinding.Cuint}}, :cdecl}, libpath, :clang_indexLoc_getFileLocation}
        end
        const var"c\"clang_indexLoc_getFileLocation\"" = Cbinding_clang_indexLoc_getFileLocation{:clang_indexLoc_getFileLocation}()
        (func::Cbinding_clang_indexLoc_getFileLocation)(var"c\"loc\"", var"c\"indexFile\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"") = begin
                CBinding.funccall(func, var"c\"loc\"", var"c\"indexFile\"", var"c\"file\"", var"c\"line\"", var"c\"column\"", var"c\"offset\"")
            end
        const clang_indexLoc_getFileLocation = var"c\"clang_indexLoc_getFileLocation\""
        export var"c\"clang_indexLoc_getFileLocation\""
        export clang_indexLoc_getFileLocation
        var"c\"clang_indexLoc_getFileLocation\""
        struct Cbinding_clang_indexLoc_getCXSourceLocation{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXSourceLocation\"", CBinding.Tuple{var"c\"CXIdxLoc\""}, :cdecl}, libpath, :clang_indexLoc_getCXSourceLocation}
        end
        const var"c\"clang_indexLoc_getCXSourceLocation\"" = Cbinding_clang_indexLoc_getCXSourceLocation{:clang_indexLoc_getCXSourceLocation}()
        (func::Cbinding_clang_indexLoc_getCXSourceLocation)(var"c\"loc\"") = begin
                CBinding.funccall(func, var"c\"loc\"")
            end
        const clang_indexLoc_getCXSourceLocation = var"c\"clang_indexLoc_getCXSourceLocation\""
        export var"c\"clang_indexLoc_getCXSourceLocation\""
        export clang_indexLoc_getCXSourceLocation
        var"c\"clang_indexLoc_getCXSourceLocation\""
        const var"c\"CXFieldVisitor\"" = CBinding.Cptr{CBinding.Cfunction{var"c\"enum CXVisitorResult\"", CBinding.Tuple{var"c\"CXCursor\"", var"c\"CXClientData\""}, :cdecl}}
        const CXFieldVisitor = var"c\"CXFieldVisitor\""
        export var"c\"CXFieldVisitor\""
        export CXFieldVisitor
        var"c\"CXFieldVisitor\""
        struct Cbinding_clang_Type_visitFields{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXType\"", var"c\"CXFieldVisitor\"", var"c\"CXClientData\""}, :cdecl}, libpath, :clang_Type_visitFields}
        end
        const var"c\"clang_Type_visitFields\"" = Cbinding_clang_Type_visitFields{:clang_Type_visitFields}()
        (func::Cbinding_clang_Type_visitFields)(var"c\"T\"", var"c\"visitor\"", var"c\"client_data\"") = begin
                CBinding.funccall(func, var"c\"T\"", var"c\"visitor\"", var"c\"client_data\"")
            end
        const clang_Type_visitFields = var"c\"clang_Type_visitFields\""
        export var"c\"clang_Type_visitFields\""
        export clang_Type_visitFields
        var"c\"clang_Type_visitFields\""
        abstract type var"c\"enum CXBinaryOperatorKind\"" <: Cenum end
        const CXBinaryOperatorKind = var"c\"enum CXBinaryOperatorKind\""
        export var"c\"enum CXBinaryOperatorKind\""
        export CXBinaryOperatorKind
        var"c\"enum CXBinaryOperatorKind\""
        primitive type var"(c\"enum CXBinaryOperatorKind\")" <: var"c\"enum CXBinaryOperatorKind\"" 32 end
        (::(Type){var"(c\"enum CXBinaryOperatorKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXBinaryOperatorKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXBinaryOperatorKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXBinaryOperator_Invalid\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_PtrMemD\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_PtrMemI\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Mul\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Div\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Rem\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Add\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Sub\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Shl\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Shr\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Cmp\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_LT\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_GT\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_LE\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_GE\""), 0x000000000000000e}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_EQ\""), 0x000000000000000f}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_NE\""), 0x0000000000000010}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_And\""), 0x0000000000000011}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Xor\""), 0x0000000000000012}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Or\""), 0x0000000000000013}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_LAnd\""), 0x0000000000000014}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_LOr\""), 0x0000000000000015}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Assign\""), 0x0000000000000016}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_MulAssign\""), 0x0000000000000017}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_DivAssign\""), 0x0000000000000018}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_RemAssign\""), 0x0000000000000019}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_AddAssign\""), 0x000000000000001a}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_SubAssign\""), 0x000000000000001b}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_ShlAssign\""), 0x000000000000001c}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_ShrAssign\""), 0x000000000000001d}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_AndAssign\""), 0x000000000000001e}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_XorAssign\""), 0x000000000000001f}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_OrAssign\""), 0x0000000000000020}, CBinding.Tuple{Symbol("c\"CXBinaryOperator_Comma\""), 0x0000000000000021}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXBinaryOperatorKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXBinaryOperatorKind\")"}) = begin
                var"(c\"enum CXBinaryOperatorKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXBinaryOperatorKind\""}) = begin
                var"(c\"enum CXBinaryOperatorKind\")"
            end
        const var"c\"CXBinaryOperator_Invalid\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000000)
        const var"c\"CXBinaryOperator_PtrMemD\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000001)
        const var"c\"CXBinaryOperator_PtrMemI\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000002)
        const var"c\"CXBinaryOperator_Mul\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000003)
        const var"c\"CXBinaryOperator_Div\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000004)
        const var"c\"CXBinaryOperator_Rem\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000005)
        const var"c\"CXBinaryOperator_Add\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000006)
        const var"c\"CXBinaryOperator_Sub\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000007)
        const var"c\"CXBinaryOperator_Shl\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000008)
        const var"c\"CXBinaryOperator_Shr\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000009)
        const var"c\"CXBinaryOperator_Cmp\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000000a)
        const var"c\"CXBinaryOperator_LT\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000000b)
        const var"c\"CXBinaryOperator_GT\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000000c)
        const var"c\"CXBinaryOperator_LE\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000000d)
        const var"c\"CXBinaryOperator_GE\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000000e)
        const var"c\"CXBinaryOperator_EQ\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000000f)
        const var"c\"CXBinaryOperator_NE\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000010)
        const var"c\"CXBinaryOperator_And\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000011)
        const var"c\"CXBinaryOperator_Xor\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000012)
        const var"c\"CXBinaryOperator_Or\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000013)
        const var"c\"CXBinaryOperator_LAnd\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000014)
        const var"c\"CXBinaryOperator_LOr\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000015)
        const var"c\"CXBinaryOperator_Assign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000016)
        const var"c\"CXBinaryOperator_MulAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000017)
        const var"c\"CXBinaryOperator_DivAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000018)
        const var"c\"CXBinaryOperator_RemAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000019)
        const var"c\"CXBinaryOperator_AddAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000001a)
        const var"c\"CXBinaryOperator_SubAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000001b)
        const var"c\"CXBinaryOperator_ShlAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000001c)
        const var"c\"CXBinaryOperator_ShrAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000001d)
        const var"c\"CXBinaryOperator_AndAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000001e)
        const var"c\"CXBinaryOperator_XorAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x000000000000001f)
        const var"c\"CXBinaryOperator_OrAssign\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000020)
        const var"c\"CXBinaryOperator_Comma\"" = var"(c\"enum CXBinaryOperatorKind\")"(0x0000000000000021)
        const CXBinaryOperatorKind = var"c\"enum CXBinaryOperatorKind\""
        const CXBinaryOperator_Invalid = var"c\"CXBinaryOperator_Invalid\""
        const CXBinaryOperator_PtrMemD = var"c\"CXBinaryOperator_PtrMemD\""
        const CXBinaryOperator_PtrMemI = var"c\"CXBinaryOperator_PtrMemI\""
        const CXBinaryOperator_Mul = var"c\"CXBinaryOperator_Mul\""
        const CXBinaryOperator_Div = var"c\"CXBinaryOperator_Div\""
        const CXBinaryOperator_Rem = var"c\"CXBinaryOperator_Rem\""
        const CXBinaryOperator_Add = var"c\"CXBinaryOperator_Add\""
        const CXBinaryOperator_Sub = var"c\"CXBinaryOperator_Sub\""
        const CXBinaryOperator_Shl = var"c\"CXBinaryOperator_Shl\""
        const CXBinaryOperator_Shr = var"c\"CXBinaryOperator_Shr\""
        const CXBinaryOperator_Cmp = var"c\"CXBinaryOperator_Cmp\""
        const CXBinaryOperator_LT = var"c\"CXBinaryOperator_LT\""
        const CXBinaryOperator_GT = var"c\"CXBinaryOperator_GT\""
        const CXBinaryOperator_LE = var"c\"CXBinaryOperator_LE\""
        const CXBinaryOperator_GE = var"c\"CXBinaryOperator_GE\""
        const CXBinaryOperator_EQ = var"c\"CXBinaryOperator_EQ\""
        const CXBinaryOperator_NE = var"c\"CXBinaryOperator_NE\""
        const CXBinaryOperator_And = var"c\"CXBinaryOperator_And\""
        const CXBinaryOperator_Xor = var"c\"CXBinaryOperator_Xor\""
        const CXBinaryOperator_Or = var"c\"CXBinaryOperator_Or\""
        const CXBinaryOperator_LAnd = var"c\"CXBinaryOperator_LAnd\""
        const CXBinaryOperator_LOr = var"c\"CXBinaryOperator_LOr\""
        const CXBinaryOperator_Assign = var"c\"CXBinaryOperator_Assign\""
        const CXBinaryOperator_MulAssign = var"c\"CXBinaryOperator_MulAssign\""
        const CXBinaryOperator_DivAssign = var"c\"CXBinaryOperator_DivAssign\""
        const CXBinaryOperator_RemAssign = var"c\"CXBinaryOperator_RemAssign\""
        const CXBinaryOperator_AddAssign = var"c\"CXBinaryOperator_AddAssign\""
        const CXBinaryOperator_SubAssign = var"c\"CXBinaryOperator_SubAssign\""
        const CXBinaryOperator_ShlAssign = var"c\"CXBinaryOperator_ShlAssign\""
        const CXBinaryOperator_ShrAssign = var"c\"CXBinaryOperator_ShrAssign\""
        const CXBinaryOperator_AndAssign = var"c\"CXBinaryOperator_AndAssign\""
        const CXBinaryOperator_XorAssign = var"c\"CXBinaryOperator_XorAssign\""
        const CXBinaryOperator_OrAssign = var"c\"CXBinaryOperator_OrAssign\""
        const CXBinaryOperator_Comma = var"c\"CXBinaryOperator_Comma\""
        export var"c\"enum CXBinaryOperatorKind\"", var"(c\"enum CXBinaryOperatorKind\")", var"c\"CXBinaryOperator_Invalid\"", var"c\"CXBinaryOperator_PtrMemD\"", var"c\"CXBinaryOperator_PtrMemI\"", var"c\"CXBinaryOperator_Mul\"", var"c\"CXBinaryOperator_Div\"", var"c\"CXBinaryOperator_Rem\"", var"c\"CXBinaryOperator_Add\"", var"c\"CXBinaryOperator_Sub\"", var"c\"CXBinaryOperator_Shl\"", var"c\"CXBinaryOperator_Shr\"", var"c\"CXBinaryOperator_Cmp\"", var"c\"CXBinaryOperator_LT\"", var"c\"CXBinaryOperator_GT\"", var"c\"CXBinaryOperator_LE\"", var"c\"CXBinaryOperator_GE\"", var"c\"CXBinaryOperator_EQ\"", var"c\"CXBinaryOperator_NE\"", var"c\"CXBinaryOperator_And\"", var"c\"CXBinaryOperator_Xor\"", var"c\"CXBinaryOperator_Or\"", var"c\"CXBinaryOperator_LAnd\"", var"c\"CXBinaryOperator_LOr\"", var"c\"CXBinaryOperator_Assign\"", var"c\"CXBinaryOperator_MulAssign\"", var"c\"CXBinaryOperator_DivAssign\"", var"c\"CXBinaryOperator_RemAssign\"", var"c\"CXBinaryOperator_AddAssign\"", var"c\"CXBinaryOperator_SubAssign\"", var"c\"CXBinaryOperator_ShlAssign\"", var"c\"CXBinaryOperator_ShrAssign\"", var"c\"CXBinaryOperator_AndAssign\"", var"c\"CXBinaryOperator_XorAssign\"", var"c\"CXBinaryOperator_OrAssign\"", var"c\"CXBinaryOperator_Comma\""
        export CXBinaryOperatorKind, CXBinaryOperator_Invalid, CXBinaryOperator_PtrMemD, CXBinaryOperator_PtrMemI, CXBinaryOperator_Mul, CXBinaryOperator_Div, CXBinaryOperator_Rem, CXBinaryOperator_Add, CXBinaryOperator_Sub, CXBinaryOperator_Shl, CXBinaryOperator_Shr, CXBinaryOperator_Cmp, CXBinaryOperator_LT, CXBinaryOperator_GT, CXBinaryOperator_LE, CXBinaryOperator_GE, CXBinaryOperator_EQ, CXBinaryOperator_NE, CXBinaryOperator_And, CXBinaryOperator_Xor, CXBinaryOperator_Or, CXBinaryOperator_LAnd, CXBinaryOperator_LOr, CXBinaryOperator_Assign, CXBinaryOperator_MulAssign, CXBinaryOperator_DivAssign, CXBinaryOperator_RemAssign, CXBinaryOperator_AddAssign, CXBinaryOperator_SubAssign, CXBinaryOperator_ShlAssign, CXBinaryOperator_ShrAssign, CXBinaryOperator_AndAssign, CXBinaryOperator_XorAssign, CXBinaryOperator_OrAssign, CXBinaryOperator_Comma
        var"c\"enum CXBinaryOperatorKind\""
        struct Cbinding_clang_getBinaryOperatorKindSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"enum CXBinaryOperatorKind\""}, :cdecl}, libpath, :clang_getBinaryOperatorKindSpelling}
        end
        const var"c\"clang_getBinaryOperatorKindSpelling\"" = Cbinding_clang_getBinaryOperatorKindSpelling{:clang_getBinaryOperatorKindSpelling}()
        (func::Cbinding_clang_getBinaryOperatorKindSpelling)(var"c\"kind\"") = begin
                CBinding.funccall(func, var"c\"kind\"")
            end
        const clang_getBinaryOperatorKindSpelling = var"c\"clang_getBinaryOperatorKindSpelling\""
        export var"c\"clang_getBinaryOperatorKindSpelling\""
        export clang_getBinaryOperatorKindSpelling
        var"c\"clang_getBinaryOperatorKindSpelling\""
        struct Cbinding_clang_getCursorBinaryOperatorKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXBinaryOperatorKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorBinaryOperatorKind}
        end
        const var"c\"clang_getCursorBinaryOperatorKind\"" = Cbinding_clang_getCursorBinaryOperatorKind{:clang_getCursorBinaryOperatorKind}()
        (func::Cbinding_clang_getCursorBinaryOperatorKind)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorBinaryOperatorKind = var"c\"clang_getCursorBinaryOperatorKind\""
        export var"c\"clang_getCursorBinaryOperatorKind\""
        export clang_getCursorBinaryOperatorKind
        var"c\"clang_getCursorBinaryOperatorKind\""
        abstract type var"c\"enum CXUnaryOperatorKind\"" <: Cenum end
        const CXUnaryOperatorKind = var"c\"enum CXUnaryOperatorKind\""
        export var"c\"enum CXUnaryOperatorKind\""
        export CXUnaryOperatorKind
        var"c\"enum CXUnaryOperatorKind\""
        primitive type var"(c\"enum CXUnaryOperatorKind\")" <: var"c\"enum CXUnaryOperatorKind\"" 32 end
        (::(Type){var"(c\"enum CXUnaryOperatorKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXUnaryOperatorKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXUnaryOperatorKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXUnaryOperator_Invalid\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_PostInc\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_PostDec\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_PreInc\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_PreDec\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_AddrOf\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_Deref\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_Plus\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_Minus\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_Not\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_LNot\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_Real\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_Imag\""), 0x000000000000000c}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_Extension\""), 0x000000000000000d}, CBinding.Tuple{Symbol("c\"CXUnaryOperator_Coawait\""), 0x000000000000000e}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXUnaryOperatorKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXUnaryOperatorKind\")"}) = begin
                var"(c\"enum CXUnaryOperatorKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXUnaryOperatorKind\""}) = begin
                var"(c\"enum CXUnaryOperatorKind\")"
            end
        const var"c\"CXUnaryOperator_Invalid\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000000)
        const var"c\"CXUnaryOperator_PostInc\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000001)
        const var"c\"CXUnaryOperator_PostDec\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000002)
        const var"c\"CXUnaryOperator_PreInc\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000003)
        const var"c\"CXUnaryOperator_PreDec\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000004)
        const var"c\"CXUnaryOperator_AddrOf\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000005)
        const var"c\"CXUnaryOperator_Deref\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000006)
        const var"c\"CXUnaryOperator_Plus\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000007)
        const var"c\"CXUnaryOperator_Minus\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000008)
        const var"c\"CXUnaryOperator_Not\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x0000000000000009)
        const var"c\"CXUnaryOperator_LNot\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x000000000000000a)
        const var"c\"CXUnaryOperator_Real\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x000000000000000b)
        const var"c\"CXUnaryOperator_Imag\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x000000000000000c)
        const var"c\"CXUnaryOperator_Extension\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x000000000000000d)
        const var"c\"CXUnaryOperator_Coawait\"" = var"(c\"enum CXUnaryOperatorKind\")"(0x000000000000000e)
        const CXUnaryOperatorKind = var"c\"enum CXUnaryOperatorKind\""
        const CXUnaryOperator_Invalid = var"c\"CXUnaryOperator_Invalid\""
        const CXUnaryOperator_PostInc = var"c\"CXUnaryOperator_PostInc\""
        const CXUnaryOperator_PostDec = var"c\"CXUnaryOperator_PostDec\""
        const CXUnaryOperator_PreInc = var"c\"CXUnaryOperator_PreInc\""
        const CXUnaryOperator_PreDec = var"c\"CXUnaryOperator_PreDec\""
        const CXUnaryOperator_AddrOf = var"c\"CXUnaryOperator_AddrOf\""
        const CXUnaryOperator_Deref = var"c\"CXUnaryOperator_Deref\""
        const CXUnaryOperator_Plus = var"c\"CXUnaryOperator_Plus\""
        const CXUnaryOperator_Minus = var"c\"CXUnaryOperator_Minus\""
        const CXUnaryOperator_Not = var"c\"CXUnaryOperator_Not\""
        const CXUnaryOperator_LNot = var"c\"CXUnaryOperator_LNot\""
        const CXUnaryOperator_Real = var"c\"CXUnaryOperator_Real\""
        const CXUnaryOperator_Imag = var"c\"CXUnaryOperator_Imag\""
        const CXUnaryOperator_Extension = var"c\"CXUnaryOperator_Extension\""
        const CXUnaryOperator_Coawait = var"c\"CXUnaryOperator_Coawait\""
        export var"c\"enum CXUnaryOperatorKind\"", var"(c\"enum CXUnaryOperatorKind\")", var"c\"CXUnaryOperator_Invalid\"", var"c\"CXUnaryOperator_PostInc\"", var"c\"CXUnaryOperator_PostDec\"", var"c\"CXUnaryOperator_PreInc\"", var"c\"CXUnaryOperator_PreDec\"", var"c\"CXUnaryOperator_AddrOf\"", var"c\"CXUnaryOperator_Deref\"", var"c\"CXUnaryOperator_Plus\"", var"c\"CXUnaryOperator_Minus\"", var"c\"CXUnaryOperator_Not\"", var"c\"CXUnaryOperator_LNot\"", var"c\"CXUnaryOperator_Real\"", var"c\"CXUnaryOperator_Imag\"", var"c\"CXUnaryOperator_Extension\"", var"c\"CXUnaryOperator_Coawait\""
        export CXUnaryOperatorKind, CXUnaryOperator_Invalid, CXUnaryOperator_PostInc, CXUnaryOperator_PostDec, CXUnaryOperator_PreInc, CXUnaryOperator_PreDec, CXUnaryOperator_AddrOf, CXUnaryOperator_Deref, CXUnaryOperator_Plus, CXUnaryOperator_Minus, CXUnaryOperator_Not, CXUnaryOperator_LNot, CXUnaryOperator_Real, CXUnaryOperator_Imag, CXUnaryOperator_Extension, CXUnaryOperator_Coawait
        var"c\"enum CXUnaryOperatorKind\""
        struct Cbinding_clang_getUnaryOperatorKindSpelling{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"enum CXUnaryOperatorKind\""}, :cdecl}, libpath, :clang_getUnaryOperatorKindSpelling}
        end
        const var"c\"clang_getUnaryOperatorKindSpelling\"" = Cbinding_clang_getUnaryOperatorKindSpelling{:clang_getUnaryOperatorKindSpelling}()
        (func::Cbinding_clang_getUnaryOperatorKindSpelling)(var"c\"kind\"") = begin
                CBinding.funccall(func, var"c\"kind\"")
            end
        const clang_getUnaryOperatorKindSpelling = var"c\"clang_getUnaryOperatorKindSpelling\""
        export var"c\"clang_getUnaryOperatorKindSpelling\""
        export clang_getUnaryOperatorKindSpelling
        var"c\"clang_getUnaryOperatorKindSpelling\""
        struct Cbinding_clang_getCursorUnaryOperatorKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXUnaryOperatorKind\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getCursorUnaryOperatorKind}
        end
        const var"c\"clang_getCursorUnaryOperatorKind\"" = Cbinding_clang_getCursorUnaryOperatorKind{:clang_getCursorUnaryOperatorKind}()
        (func::Cbinding_clang_getCursorUnaryOperatorKind)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getCursorUnaryOperatorKind = var"c\"clang_getCursorUnaryOperatorKind\""
        export var"c\"clang_getCursorUnaryOperatorKind\""
        export clang_getCursorUnaryOperatorKind
        var"c\"clang_getCursorUnaryOperatorKind\""
        abstract type var"c\"CXComment\"" <: Cstruct end
        const CXComment = var"c\"CXComment\""
        export var"c\"CXComment\""
        export CXComment
        var"c\"CXComment\""
        struct var"(c\"CXComment\")" <: var"c\"CXComment\""
            mem::CBinding.NTuple{16, CBinding.UInt8}
            var"(c\"CXComment\")"(::CBinding.UndefInitializer, mem::CBinding.NTuple{16, CBinding.UInt8}) = begin
                    new(mem)
                end
        end
        (CBinding.CBinding).fields(::CBinding.Type{var"(c\"CXComment\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{:ASTNode, CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}, CBinding.bitstype(CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}), CBinding.integraltype(CBinding.Cptr{CBinding.Cconst{CBinding.Cvoid}}), 0, 0, -1}}, CBinding.Tuple{:TranslationUnit, CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.bitstype(var"c\"CXTranslationUnit\""), CBinding.integraltype(var"c\"CXTranslationUnit\""), 8, 0, -1}}}
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"CXComment\")"}) = begin
                var"(c\"CXComment\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"CXComment\""}) = begin
                var"(c\"CXComment\")"
            end
        const CXComment = var"c\"CXComment\""
        export var"c\"CXComment\"", var"(c\"CXComment\")"
        export CXComment
        var"c\"CXComment\""
        struct Cbinding_clang_Cursor_getParsedComment{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXComment\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_Cursor_getParsedComment}
        end
        const var"c\"clang_Cursor_getParsedComment\"" = Cbinding_clang_Cursor_getParsedComment{:clang_Cursor_getParsedComment}()
        (func::Cbinding_clang_Cursor_getParsedComment)(var"c\"C\"") = begin
                CBinding.funccall(func, var"c\"C\"")
            end
        const clang_Cursor_getParsedComment = var"c\"clang_Cursor_getParsedComment\""
        export var"c\"clang_Cursor_getParsedComment\""
        export clang_Cursor_getParsedComment
        var"c\"clang_Cursor_getParsedComment\""
        abstract type var"c\"enum CXCommentKind\"" <: Cenum end
        const CXCommentKind = var"c\"enum CXCommentKind\""
        export var"c\"enum CXCommentKind\""
        export CXCommentKind
        var"c\"enum CXCommentKind\""
        primitive type var"(c\"enum CXCommentKind\")" <: var"c\"enum CXCommentKind\"" 32 end
        (::(Type){var"(c\"enum CXCommentKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCommentKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCommentKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXComment_Null\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXComment_Text\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXComment_InlineCommand\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXComment_HTMLStartTag\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXComment_HTMLEndTag\""), 0x0000000000000004}, CBinding.Tuple{Symbol("c\"CXComment_Paragraph\""), 0x0000000000000005}, CBinding.Tuple{Symbol("c\"CXComment_BlockCommand\""), 0x0000000000000006}, CBinding.Tuple{Symbol("c\"CXComment_ParamCommand\""), 0x0000000000000007}, CBinding.Tuple{Symbol("c\"CXComment_TParamCommand\""), 0x0000000000000008}, CBinding.Tuple{Symbol("c\"CXComment_VerbatimBlockCommand\""), 0x0000000000000009}, CBinding.Tuple{Symbol("c\"CXComment_VerbatimBlockLine\""), 0x000000000000000a}, CBinding.Tuple{Symbol("c\"CXComment_VerbatimLine\""), 0x000000000000000b}, CBinding.Tuple{Symbol("c\"CXComment_FullComment\""), 0x000000000000000c}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCommentKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCommentKind\")"}) = begin
                var"(c\"enum CXCommentKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCommentKind\""}) = begin
                var"(c\"enum CXCommentKind\")"
            end
        const var"c\"CXComment_Null\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000000)
        const var"c\"CXComment_Text\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000001)
        const var"c\"CXComment_InlineCommand\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000002)
        const var"c\"CXComment_HTMLStartTag\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000003)
        const var"c\"CXComment_HTMLEndTag\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000004)
        const var"c\"CXComment_Paragraph\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000005)
        const var"c\"CXComment_BlockCommand\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000006)
        const var"c\"CXComment_ParamCommand\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000007)
        const var"c\"CXComment_TParamCommand\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000008)
        const var"c\"CXComment_VerbatimBlockCommand\"" = var"(c\"enum CXCommentKind\")"(0x0000000000000009)
        const var"c\"CXComment_VerbatimBlockLine\"" = var"(c\"enum CXCommentKind\")"(0x000000000000000a)
        const var"c\"CXComment_VerbatimLine\"" = var"(c\"enum CXCommentKind\")"(0x000000000000000b)
        const var"c\"CXComment_FullComment\"" = var"(c\"enum CXCommentKind\")"(0x000000000000000c)
        const CXCommentKind = var"c\"enum CXCommentKind\""
        const CXComment_Null = var"c\"CXComment_Null\""
        const CXComment_Text = var"c\"CXComment_Text\""
        const CXComment_InlineCommand = var"c\"CXComment_InlineCommand\""
        const CXComment_HTMLStartTag = var"c\"CXComment_HTMLStartTag\""
        const CXComment_HTMLEndTag = var"c\"CXComment_HTMLEndTag\""
        const CXComment_Paragraph = var"c\"CXComment_Paragraph\""
        const CXComment_BlockCommand = var"c\"CXComment_BlockCommand\""
        const CXComment_ParamCommand = var"c\"CXComment_ParamCommand\""
        const CXComment_TParamCommand = var"c\"CXComment_TParamCommand\""
        const CXComment_VerbatimBlockCommand = var"c\"CXComment_VerbatimBlockCommand\""
        const CXComment_VerbatimBlockLine = var"c\"CXComment_VerbatimBlockLine\""
        const CXComment_VerbatimLine = var"c\"CXComment_VerbatimLine\""
        const CXComment_FullComment = var"c\"CXComment_FullComment\""
        export var"c\"enum CXCommentKind\"", var"(c\"enum CXCommentKind\")", var"c\"CXComment_Null\"", var"c\"CXComment_Text\"", var"c\"CXComment_InlineCommand\"", var"c\"CXComment_HTMLStartTag\"", var"c\"CXComment_HTMLEndTag\"", var"c\"CXComment_Paragraph\"", var"c\"CXComment_BlockCommand\"", var"c\"CXComment_ParamCommand\"", var"c\"CXComment_TParamCommand\"", var"c\"CXComment_VerbatimBlockCommand\"", var"c\"CXComment_VerbatimBlockLine\"", var"c\"CXComment_VerbatimLine\"", var"c\"CXComment_FullComment\""
        export CXCommentKind, CXComment_Null, CXComment_Text, CXComment_InlineCommand, CXComment_HTMLStartTag, CXComment_HTMLEndTag, CXComment_Paragraph, CXComment_BlockCommand, CXComment_ParamCommand, CXComment_TParamCommand, CXComment_VerbatimBlockCommand, CXComment_VerbatimBlockLine, CXComment_VerbatimLine, CXComment_FullComment
        var"c\"enum CXCommentKind\""
        abstract type var"c\"enum CXCommentInlineCommandRenderKind\"" <: Cenum end
        const CXCommentInlineCommandRenderKind = var"c\"enum CXCommentInlineCommandRenderKind\""
        export var"c\"enum CXCommentInlineCommandRenderKind\""
        export CXCommentInlineCommandRenderKind
        var"c\"enum CXCommentInlineCommandRenderKind\""
        primitive type var"(c\"enum CXCommentInlineCommandRenderKind\")" <: var"c\"enum CXCommentInlineCommandRenderKind\"" 32 end
        (::(Type){var"(c\"enum CXCommentInlineCommandRenderKind\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCommentInlineCommandRenderKind\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCommentInlineCommandRenderKind\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXCommentInlineCommandRenderKind_Normal\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXCommentInlineCommandRenderKind_Bold\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCommentInlineCommandRenderKind_Monospaced\""), 0x0000000000000002}, CBinding.Tuple{Symbol("c\"CXCommentInlineCommandRenderKind_Emphasized\""), 0x0000000000000003}, CBinding.Tuple{Symbol("c\"CXCommentInlineCommandRenderKind_Anchor\""), 0x0000000000000004}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCommentInlineCommandRenderKind\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCommentInlineCommandRenderKind\")"}) = begin
                var"(c\"enum CXCommentInlineCommandRenderKind\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCommentInlineCommandRenderKind\""}) = begin
                var"(c\"enum CXCommentInlineCommandRenderKind\")"
            end
        const var"c\"CXCommentInlineCommandRenderKind_Normal\"" = var"(c\"enum CXCommentInlineCommandRenderKind\")"(0x0000000000000000)
        const var"c\"CXCommentInlineCommandRenderKind_Bold\"" = var"(c\"enum CXCommentInlineCommandRenderKind\")"(0x0000000000000001)
        const var"c\"CXCommentInlineCommandRenderKind_Monospaced\"" = var"(c\"enum CXCommentInlineCommandRenderKind\")"(0x0000000000000002)
        const var"c\"CXCommentInlineCommandRenderKind_Emphasized\"" = var"(c\"enum CXCommentInlineCommandRenderKind\")"(0x0000000000000003)
        const var"c\"CXCommentInlineCommandRenderKind_Anchor\"" = var"(c\"enum CXCommentInlineCommandRenderKind\")"(0x0000000000000004)
        const CXCommentInlineCommandRenderKind = var"c\"enum CXCommentInlineCommandRenderKind\""
        const CXCommentInlineCommandRenderKind_Normal = var"c\"CXCommentInlineCommandRenderKind_Normal\""
        const CXCommentInlineCommandRenderKind_Bold = var"c\"CXCommentInlineCommandRenderKind_Bold\""
        const CXCommentInlineCommandRenderKind_Monospaced = var"c\"CXCommentInlineCommandRenderKind_Monospaced\""
        const CXCommentInlineCommandRenderKind_Emphasized = var"c\"CXCommentInlineCommandRenderKind_Emphasized\""
        const CXCommentInlineCommandRenderKind_Anchor = var"c\"CXCommentInlineCommandRenderKind_Anchor\""
        export var"c\"enum CXCommentInlineCommandRenderKind\"", var"(c\"enum CXCommentInlineCommandRenderKind\")", var"c\"CXCommentInlineCommandRenderKind_Normal\"", var"c\"CXCommentInlineCommandRenderKind_Bold\"", var"c\"CXCommentInlineCommandRenderKind_Monospaced\"", var"c\"CXCommentInlineCommandRenderKind_Emphasized\"", var"c\"CXCommentInlineCommandRenderKind_Anchor\""
        export CXCommentInlineCommandRenderKind, CXCommentInlineCommandRenderKind_Normal, CXCommentInlineCommandRenderKind_Bold, CXCommentInlineCommandRenderKind_Monospaced, CXCommentInlineCommandRenderKind_Emphasized, CXCommentInlineCommandRenderKind_Anchor
        var"c\"enum CXCommentInlineCommandRenderKind\""
        abstract type var"c\"enum CXCommentParamPassDirection\"" <: Cenum end
        const CXCommentParamPassDirection = var"c\"enum CXCommentParamPassDirection\""
        export var"c\"enum CXCommentParamPassDirection\""
        export CXCommentParamPassDirection
        var"c\"enum CXCommentParamPassDirection\""
        primitive type var"(c\"enum CXCommentParamPassDirection\")" <: var"c\"enum CXCommentParamPassDirection\"" 32 end
        (::(Type){var"(c\"enum CXCommentParamPassDirection\")"})(val::CBinding.Integer = CBinding.zero(CBinding.Cuint)) = begin
                (CBinding.Core).Intrinsics.bitcast(var"(c\"enum CXCommentParamPassDirection\")", CBinding.convert(CBinding.Cuint, val))
            end
        (CBinding.CBinding).values(::CBinding.Type{var"(c\"enum CXCommentParamPassDirection\")"}) = begin
                CBinding.Tuple{CBinding.Tuple{Symbol("c\"CXCommentParamPassDirection_In\""), 0x0000000000000000}, CBinding.Tuple{Symbol("c\"CXCommentParamPassDirection_Out\""), 0x0000000000000001}, CBinding.Tuple{Symbol("c\"CXCommentParamPassDirection_InOut\""), 0x0000000000000002}}
            end
        (CBinding.Base).Enums.basetype(::CBinding.Type{var"(c\"enum CXCommentParamPassDirection\")"}) = begin
                CBinding.Cuint
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"(c\"enum CXCommentParamPassDirection\")"}) = begin
                var"(c\"enum CXCommentParamPassDirection\")"
            end
        (CBinding.CBinding).bitstype(::CBinding.Type{var"c\"enum CXCommentParamPassDirection\""}) = begin
                var"(c\"enum CXCommentParamPassDirection\")"
            end
        const var"c\"CXCommentParamPassDirection_In\"" = var"(c\"enum CXCommentParamPassDirection\")"(0x0000000000000000)
        const var"c\"CXCommentParamPassDirection_Out\"" = var"(c\"enum CXCommentParamPassDirection\")"(0x0000000000000001)
        const var"c\"CXCommentParamPassDirection_InOut\"" = var"(c\"enum CXCommentParamPassDirection\")"(0x0000000000000002)
        const CXCommentParamPassDirection = var"c\"enum CXCommentParamPassDirection\""
        const CXCommentParamPassDirection_In = var"c\"CXCommentParamPassDirection_In\""
        const CXCommentParamPassDirection_Out = var"c\"CXCommentParamPassDirection_Out\""
        const CXCommentParamPassDirection_InOut = var"c\"CXCommentParamPassDirection_InOut\""
        export var"c\"enum CXCommentParamPassDirection\"", var"(c\"enum CXCommentParamPassDirection\")", var"c\"CXCommentParamPassDirection_In\"", var"c\"CXCommentParamPassDirection_Out\"", var"c\"CXCommentParamPassDirection_InOut\""
        export CXCommentParamPassDirection, CXCommentParamPassDirection_In, CXCommentParamPassDirection_Out, CXCommentParamPassDirection_InOut
        var"c\"enum CXCommentParamPassDirection\""
        struct Cbinding_clang_Comment_getKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXCommentKind\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_Comment_getKind}
        end
        const var"c\"clang_Comment_getKind\"" = Cbinding_clang_Comment_getKind{:clang_Comment_getKind}()
        (func::Cbinding_clang_Comment_getKind)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_Comment_getKind = var"c\"clang_Comment_getKind\""
        export var"c\"clang_Comment_getKind\""
        export clang_Comment_getKind
        var"c\"clang_Comment_getKind\""
        struct Cbinding_clang_Comment_getNumChildren{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_Comment_getNumChildren}
        end
        const var"c\"clang_Comment_getNumChildren\"" = Cbinding_clang_Comment_getNumChildren{:clang_Comment_getNumChildren}()
        (func::Cbinding_clang_Comment_getNumChildren)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_Comment_getNumChildren = var"c\"clang_Comment_getNumChildren\""
        export var"c\"clang_Comment_getNumChildren\""
        export clang_Comment_getNumChildren
        var"c\"clang_Comment_getNumChildren\""
        struct Cbinding_clang_Comment_getChild{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXComment\"", CBinding.Tuple{var"c\"CXComment\"", CBinding.Cuint}, :cdecl}, libpath, :clang_Comment_getChild}
        end
        const var"c\"clang_Comment_getChild\"" = Cbinding_clang_Comment_getChild{:clang_Comment_getChild}()
        (func::Cbinding_clang_Comment_getChild)(var"c\"Comment\"", var"c\"ChildIdx\"") = begin
                CBinding.funccall(func, var"c\"Comment\"", var"c\"ChildIdx\"")
            end
        const clang_Comment_getChild = var"c\"clang_Comment_getChild\""
        export var"c\"clang_Comment_getChild\""
        export clang_Comment_getChild
        var"c\"clang_Comment_getChild\""
        struct Cbinding_clang_Comment_isWhitespace{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_Comment_isWhitespace}
        end
        const var"c\"clang_Comment_isWhitespace\"" = Cbinding_clang_Comment_isWhitespace{:clang_Comment_isWhitespace}()
        (func::Cbinding_clang_Comment_isWhitespace)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_Comment_isWhitespace = var"c\"clang_Comment_isWhitespace\""
        export var"c\"clang_Comment_isWhitespace\""
        export clang_Comment_isWhitespace
        var"c\"clang_Comment_isWhitespace\""
        struct Cbinding_clang_InlineContentComment_hasTrailingNewline{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_InlineContentComment_hasTrailingNewline}
        end
        const var"c\"clang_InlineContentComment_hasTrailingNewline\"" = Cbinding_clang_InlineContentComment_hasTrailingNewline{:clang_InlineContentComment_hasTrailingNewline}()
        (func::Cbinding_clang_InlineContentComment_hasTrailingNewline)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_InlineContentComment_hasTrailingNewline = var"c\"clang_InlineContentComment_hasTrailingNewline\""
        export var"c\"clang_InlineContentComment_hasTrailingNewline\""
        export clang_InlineContentComment_hasTrailingNewline
        var"c\"clang_InlineContentComment_hasTrailingNewline\""
        struct Cbinding_clang_TextComment_getText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_TextComment_getText}
        end
        const var"c\"clang_TextComment_getText\"" = Cbinding_clang_TextComment_getText{:clang_TextComment_getText}()
        (func::Cbinding_clang_TextComment_getText)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_TextComment_getText = var"c\"clang_TextComment_getText\""
        export var"c\"clang_TextComment_getText\""
        export clang_TextComment_getText
        var"c\"clang_TextComment_getText\""
        struct Cbinding_clang_InlineCommandComment_getCommandName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_InlineCommandComment_getCommandName}
        end
        const var"c\"clang_InlineCommandComment_getCommandName\"" = Cbinding_clang_InlineCommandComment_getCommandName{:clang_InlineCommandComment_getCommandName}()
        (func::Cbinding_clang_InlineCommandComment_getCommandName)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_InlineCommandComment_getCommandName = var"c\"clang_InlineCommandComment_getCommandName\""
        export var"c\"clang_InlineCommandComment_getCommandName\""
        export clang_InlineCommandComment_getCommandName
        var"c\"clang_InlineCommandComment_getCommandName\""
        struct Cbinding_clang_InlineCommandComment_getRenderKind{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXCommentInlineCommandRenderKind\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_InlineCommandComment_getRenderKind}
        end
        const var"c\"clang_InlineCommandComment_getRenderKind\"" = Cbinding_clang_InlineCommandComment_getRenderKind{:clang_InlineCommandComment_getRenderKind}()
        (func::Cbinding_clang_InlineCommandComment_getRenderKind)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_InlineCommandComment_getRenderKind = var"c\"clang_InlineCommandComment_getRenderKind\""
        export var"c\"clang_InlineCommandComment_getRenderKind\""
        export clang_InlineCommandComment_getRenderKind
        var"c\"clang_InlineCommandComment_getRenderKind\""
        struct Cbinding_clang_InlineCommandComment_getNumArgs{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_InlineCommandComment_getNumArgs}
        end
        const var"c\"clang_InlineCommandComment_getNumArgs\"" = Cbinding_clang_InlineCommandComment_getNumArgs{:clang_InlineCommandComment_getNumArgs}()
        (func::Cbinding_clang_InlineCommandComment_getNumArgs)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_InlineCommandComment_getNumArgs = var"c\"clang_InlineCommandComment_getNumArgs\""
        export var"c\"clang_InlineCommandComment_getNumArgs\""
        export clang_InlineCommandComment_getNumArgs
        var"c\"clang_InlineCommandComment_getNumArgs\""
        struct Cbinding_clang_InlineCommandComment_getArgText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\"", CBinding.Cuint}, :cdecl}, libpath, :clang_InlineCommandComment_getArgText}
        end
        const var"c\"clang_InlineCommandComment_getArgText\"" = Cbinding_clang_InlineCommandComment_getArgText{:clang_InlineCommandComment_getArgText}()
        (func::Cbinding_clang_InlineCommandComment_getArgText)(var"c\"Comment\"", var"c\"ArgIdx\"") = begin
                CBinding.funccall(func, var"c\"Comment\"", var"c\"ArgIdx\"")
            end
        const clang_InlineCommandComment_getArgText = var"c\"clang_InlineCommandComment_getArgText\""
        export var"c\"clang_InlineCommandComment_getArgText\""
        export clang_InlineCommandComment_getArgText
        var"c\"clang_InlineCommandComment_getArgText\""
        struct Cbinding_clang_HTMLTagComment_getTagName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_HTMLTagComment_getTagName}
        end
        const var"c\"clang_HTMLTagComment_getTagName\"" = Cbinding_clang_HTMLTagComment_getTagName{:clang_HTMLTagComment_getTagName}()
        (func::Cbinding_clang_HTMLTagComment_getTagName)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_HTMLTagComment_getTagName = var"c\"clang_HTMLTagComment_getTagName\""
        export var"c\"clang_HTMLTagComment_getTagName\""
        export clang_HTMLTagComment_getTagName
        var"c\"clang_HTMLTagComment_getTagName\""
        struct Cbinding_clang_HTMLStartTagComment_isSelfClosing{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_HTMLStartTagComment_isSelfClosing}
        end
        const var"c\"clang_HTMLStartTagComment_isSelfClosing\"" = Cbinding_clang_HTMLStartTagComment_isSelfClosing{:clang_HTMLStartTagComment_isSelfClosing}()
        (func::Cbinding_clang_HTMLStartTagComment_isSelfClosing)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_HTMLStartTagComment_isSelfClosing = var"c\"clang_HTMLStartTagComment_isSelfClosing\""
        export var"c\"clang_HTMLStartTagComment_isSelfClosing\""
        export clang_HTMLStartTagComment_isSelfClosing
        var"c\"clang_HTMLStartTagComment_isSelfClosing\""
        struct Cbinding_clang_HTMLStartTag_getNumAttrs{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_HTMLStartTag_getNumAttrs}
        end
        const var"c\"clang_HTMLStartTag_getNumAttrs\"" = Cbinding_clang_HTMLStartTag_getNumAttrs{:clang_HTMLStartTag_getNumAttrs}()
        (func::Cbinding_clang_HTMLStartTag_getNumAttrs)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_HTMLStartTag_getNumAttrs = var"c\"clang_HTMLStartTag_getNumAttrs\""
        export var"c\"clang_HTMLStartTag_getNumAttrs\""
        export clang_HTMLStartTag_getNumAttrs
        var"c\"clang_HTMLStartTag_getNumAttrs\""
        struct Cbinding_clang_HTMLStartTag_getAttrName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\"", CBinding.Cuint}, :cdecl}, libpath, :clang_HTMLStartTag_getAttrName}
        end
        const var"c\"clang_HTMLStartTag_getAttrName\"" = Cbinding_clang_HTMLStartTag_getAttrName{:clang_HTMLStartTag_getAttrName}()
        (func::Cbinding_clang_HTMLStartTag_getAttrName)(var"c\"Comment\"", var"c\"AttrIdx\"") = begin
                CBinding.funccall(func, var"c\"Comment\"", var"c\"AttrIdx\"")
            end
        const clang_HTMLStartTag_getAttrName = var"c\"clang_HTMLStartTag_getAttrName\""
        export var"c\"clang_HTMLStartTag_getAttrName\""
        export clang_HTMLStartTag_getAttrName
        var"c\"clang_HTMLStartTag_getAttrName\""
        struct Cbinding_clang_HTMLStartTag_getAttrValue{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\"", CBinding.Cuint}, :cdecl}, libpath, :clang_HTMLStartTag_getAttrValue}
        end
        const var"c\"clang_HTMLStartTag_getAttrValue\"" = Cbinding_clang_HTMLStartTag_getAttrValue{:clang_HTMLStartTag_getAttrValue}()
        (func::Cbinding_clang_HTMLStartTag_getAttrValue)(var"c\"Comment\"", var"c\"AttrIdx\"") = begin
                CBinding.funccall(func, var"c\"Comment\"", var"c\"AttrIdx\"")
            end
        const clang_HTMLStartTag_getAttrValue = var"c\"clang_HTMLStartTag_getAttrValue\""
        export var"c\"clang_HTMLStartTag_getAttrValue\""
        export clang_HTMLStartTag_getAttrValue
        var"c\"clang_HTMLStartTag_getAttrValue\""
        struct Cbinding_clang_BlockCommandComment_getCommandName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_BlockCommandComment_getCommandName}
        end
        const var"c\"clang_BlockCommandComment_getCommandName\"" = Cbinding_clang_BlockCommandComment_getCommandName{:clang_BlockCommandComment_getCommandName}()
        (func::Cbinding_clang_BlockCommandComment_getCommandName)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_BlockCommandComment_getCommandName = var"c\"clang_BlockCommandComment_getCommandName\""
        export var"c\"clang_BlockCommandComment_getCommandName\""
        export clang_BlockCommandComment_getCommandName
        var"c\"clang_BlockCommandComment_getCommandName\""
        struct Cbinding_clang_BlockCommandComment_getNumArgs{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_BlockCommandComment_getNumArgs}
        end
        const var"c\"clang_BlockCommandComment_getNumArgs\"" = Cbinding_clang_BlockCommandComment_getNumArgs{:clang_BlockCommandComment_getNumArgs}()
        (func::Cbinding_clang_BlockCommandComment_getNumArgs)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_BlockCommandComment_getNumArgs = var"c\"clang_BlockCommandComment_getNumArgs\""
        export var"c\"clang_BlockCommandComment_getNumArgs\""
        export clang_BlockCommandComment_getNumArgs
        var"c\"clang_BlockCommandComment_getNumArgs\""
        struct Cbinding_clang_BlockCommandComment_getArgText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\"", CBinding.Cuint}, :cdecl}, libpath, :clang_BlockCommandComment_getArgText}
        end
        const var"c\"clang_BlockCommandComment_getArgText\"" = Cbinding_clang_BlockCommandComment_getArgText{:clang_BlockCommandComment_getArgText}()
        (func::Cbinding_clang_BlockCommandComment_getArgText)(var"c\"Comment\"", var"c\"ArgIdx\"") = begin
                CBinding.funccall(func, var"c\"Comment\"", var"c\"ArgIdx\"")
            end
        const clang_BlockCommandComment_getArgText = var"c\"clang_BlockCommandComment_getArgText\""
        export var"c\"clang_BlockCommandComment_getArgText\""
        export clang_BlockCommandComment_getArgText
        var"c\"clang_BlockCommandComment_getArgText\""
        struct Cbinding_clang_BlockCommandComment_getParagraph{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXComment\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_BlockCommandComment_getParagraph}
        end
        const var"c\"clang_BlockCommandComment_getParagraph\"" = Cbinding_clang_BlockCommandComment_getParagraph{:clang_BlockCommandComment_getParagraph}()
        (func::Cbinding_clang_BlockCommandComment_getParagraph)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_BlockCommandComment_getParagraph = var"c\"clang_BlockCommandComment_getParagraph\""
        export var"c\"clang_BlockCommandComment_getParagraph\""
        export clang_BlockCommandComment_getParagraph
        var"c\"clang_BlockCommandComment_getParagraph\""
        struct Cbinding_clang_ParamCommandComment_getParamName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_ParamCommandComment_getParamName}
        end
        const var"c\"clang_ParamCommandComment_getParamName\"" = Cbinding_clang_ParamCommandComment_getParamName{:clang_ParamCommandComment_getParamName}()
        (func::Cbinding_clang_ParamCommandComment_getParamName)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_ParamCommandComment_getParamName = var"c\"clang_ParamCommandComment_getParamName\""
        export var"c\"clang_ParamCommandComment_getParamName\""
        export clang_ParamCommandComment_getParamName
        var"c\"clang_ParamCommandComment_getParamName\""
        struct Cbinding_clang_ParamCommandComment_isParamIndexValid{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_ParamCommandComment_isParamIndexValid}
        end
        const var"c\"clang_ParamCommandComment_isParamIndexValid\"" = Cbinding_clang_ParamCommandComment_isParamIndexValid{:clang_ParamCommandComment_isParamIndexValid}()
        (func::Cbinding_clang_ParamCommandComment_isParamIndexValid)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_ParamCommandComment_isParamIndexValid = var"c\"clang_ParamCommandComment_isParamIndexValid\""
        export var"c\"clang_ParamCommandComment_isParamIndexValid\""
        export clang_ParamCommandComment_isParamIndexValid
        var"c\"clang_ParamCommandComment_isParamIndexValid\""
        struct Cbinding_clang_ParamCommandComment_getParamIndex{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_ParamCommandComment_getParamIndex}
        end
        const var"c\"clang_ParamCommandComment_getParamIndex\"" = Cbinding_clang_ParamCommandComment_getParamIndex{:clang_ParamCommandComment_getParamIndex}()
        (func::Cbinding_clang_ParamCommandComment_getParamIndex)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_ParamCommandComment_getParamIndex = var"c\"clang_ParamCommandComment_getParamIndex\""
        export var"c\"clang_ParamCommandComment_getParamIndex\""
        export clang_ParamCommandComment_getParamIndex
        var"c\"clang_ParamCommandComment_getParamIndex\""
        struct Cbinding_clang_ParamCommandComment_isDirectionExplicit{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_ParamCommandComment_isDirectionExplicit}
        end
        const var"c\"clang_ParamCommandComment_isDirectionExplicit\"" = Cbinding_clang_ParamCommandComment_isDirectionExplicit{:clang_ParamCommandComment_isDirectionExplicit}()
        (func::Cbinding_clang_ParamCommandComment_isDirectionExplicit)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_ParamCommandComment_isDirectionExplicit = var"c\"clang_ParamCommandComment_isDirectionExplicit\""
        export var"c\"clang_ParamCommandComment_isDirectionExplicit\""
        export clang_ParamCommandComment_isDirectionExplicit
        var"c\"clang_ParamCommandComment_isDirectionExplicit\""
        struct Cbinding_clang_ParamCommandComment_getDirection{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXCommentParamPassDirection\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_ParamCommandComment_getDirection}
        end
        const var"c\"clang_ParamCommandComment_getDirection\"" = Cbinding_clang_ParamCommandComment_getDirection{:clang_ParamCommandComment_getDirection}()
        (func::Cbinding_clang_ParamCommandComment_getDirection)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_ParamCommandComment_getDirection = var"c\"clang_ParamCommandComment_getDirection\""
        export var"c\"clang_ParamCommandComment_getDirection\""
        export clang_ParamCommandComment_getDirection
        var"c\"clang_ParamCommandComment_getDirection\""
        struct Cbinding_clang_TParamCommandComment_getParamName{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_TParamCommandComment_getParamName}
        end
        const var"c\"clang_TParamCommandComment_getParamName\"" = Cbinding_clang_TParamCommandComment_getParamName{:clang_TParamCommandComment_getParamName}()
        (func::Cbinding_clang_TParamCommandComment_getParamName)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_TParamCommandComment_getParamName = var"c\"clang_TParamCommandComment_getParamName\""
        export var"c\"clang_TParamCommandComment_getParamName\""
        export clang_TParamCommandComment_getParamName
        var"c\"clang_TParamCommandComment_getParamName\""
        struct Cbinding_clang_TParamCommandComment_isParamPositionValid{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_TParamCommandComment_isParamPositionValid}
        end
        const var"c\"clang_TParamCommandComment_isParamPositionValid\"" = Cbinding_clang_TParamCommandComment_isParamPositionValid{:clang_TParamCommandComment_isParamPositionValid}()
        (func::Cbinding_clang_TParamCommandComment_isParamPositionValid)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_TParamCommandComment_isParamPositionValid = var"c\"clang_TParamCommandComment_isParamPositionValid\""
        export var"c\"clang_TParamCommandComment_isParamPositionValid\""
        export clang_TParamCommandComment_isParamPositionValid
        var"c\"clang_TParamCommandComment_isParamPositionValid\""
        struct Cbinding_clang_TParamCommandComment_getDepth{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_TParamCommandComment_getDepth}
        end
        const var"c\"clang_TParamCommandComment_getDepth\"" = Cbinding_clang_TParamCommandComment_getDepth{:clang_TParamCommandComment_getDepth}()
        (func::Cbinding_clang_TParamCommandComment_getDepth)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_TParamCommandComment_getDepth = var"c\"clang_TParamCommandComment_getDepth\""
        export var"c\"clang_TParamCommandComment_getDepth\""
        export clang_TParamCommandComment_getDepth
        var"c\"clang_TParamCommandComment_getDepth\""
        struct Cbinding_clang_TParamCommandComment_getIndex{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cuint, CBinding.Tuple{var"c\"CXComment\"", CBinding.Cuint}, :cdecl}, libpath, :clang_TParamCommandComment_getIndex}
        end
        const var"c\"clang_TParamCommandComment_getIndex\"" = Cbinding_clang_TParamCommandComment_getIndex{:clang_TParamCommandComment_getIndex}()
        (func::Cbinding_clang_TParamCommandComment_getIndex)(var"c\"Comment\"", var"c\"Depth\"") = begin
                CBinding.funccall(func, var"c\"Comment\"", var"c\"Depth\"")
            end
        const clang_TParamCommandComment_getIndex = var"c\"clang_TParamCommandComment_getIndex\""
        export var"c\"clang_TParamCommandComment_getIndex\""
        export clang_TParamCommandComment_getIndex
        var"c\"clang_TParamCommandComment_getIndex\""
        struct Cbinding_clang_VerbatimBlockLineComment_getText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_VerbatimBlockLineComment_getText}
        end
        const var"c\"clang_VerbatimBlockLineComment_getText\"" = Cbinding_clang_VerbatimBlockLineComment_getText{:clang_VerbatimBlockLineComment_getText}()
        (func::Cbinding_clang_VerbatimBlockLineComment_getText)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_VerbatimBlockLineComment_getText = var"c\"clang_VerbatimBlockLineComment_getText\""
        export var"c\"clang_VerbatimBlockLineComment_getText\""
        export clang_VerbatimBlockLineComment_getText
        var"c\"clang_VerbatimBlockLineComment_getText\""
        struct Cbinding_clang_VerbatimLineComment_getText{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_VerbatimLineComment_getText}
        end
        const var"c\"clang_VerbatimLineComment_getText\"" = Cbinding_clang_VerbatimLineComment_getText{:clang_VerbatimLineComment_getText}()
        (func::Cbinding_clang_VerbatimLineComment_getText)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_VerbatimLineComment_getText = var"c\"clang_VerbatimLineComment_getText\""
        export var"c\"clang_VerbatimLineComment_getText\""
        export clang_VerbatimLineComment_getText
        var"c\"clang_VerbatimLineComment_getText\""
        struct Cbinding_clang_HTMLTagComment_getAsString{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_HTMLTagComment_getAsString}
        end
        const var"c\"clang_HTMLTagComment_getAsString\"" = Cbinding_clang_HTMLTagComment_getAsString{:clang_HTMLTagComment_getAsString}()
        (func::Cbinding_clang_HTMLTagComment_getAsString)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_HTMLTagComment_getAsString = var"c\"clang_HTMLTagComment_getAsString\""
        export var"c\"clang_HTMLTagComment_getAsString\""
        export clang_HTMLTagComment_getAsString
        var"c\"clang_HTMLTagComment_getAsString\""
        struct Cbinding_clang_FullComment_getAsHTML{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_FullComment_getAsHTML}
        end
        const var"c\"clang_FullComment_getAsHTML\"" = Cbinding_clang_FullComment_getAsHTML{:clang_FullComment_getAsHTML}()
        (func::Cbinding_clang_FullComment_getAsHTML)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_FullComment_getAsHTML = var"c\"clang_FullComment_getAsHTML\""
        export var"c\"clang_FullComment_getAsHTML\""
        export clang_FullComment_getAsHTML
        var"c\"clang_FullComment_getAsHTML\""
        struct Cbinding_clang_FullComment_getAsXML{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXComment\""}, :cdecl}, libpath, :clang_FullComment_getAsXML}
        end
        const var"c\"clang_FullComment_getAsXML\"" = Cbinding_clang_FullComment_getAsXML{:clang_FullComment_getAsXML}()
        (func::Cbinding_clang_FullComment_getAsXML)(var"c\"Comment\"") = begin
                CBinding.funccall(func, var"c\"Comment\"")
            end
        const clang_FullComment_getAsXML = var"c\"clang_FullComment_getAsXML\""
        export var"c\"clang_FullComment_getAsXML\""
        export clang_FullComment_getAsXML
        var"c\"clang_FullComment_getAsXML\""
        abstract type var"c\"struct CXAPISetImpl\"" <: Cstruct end
        const CXAPISetImpl = var"c\"struct CXAPISetImpl\""
        export var"c\"struct CXAPISetImpl\""
        export CXAPISetImpl
        var"c\"struct CXAPISetImpl\""
        const var"c\"CXAPISet\"" = CBinding.Cptr{var"c\"struct CXAPISetImpl\""}
        const CXAPISet = var"c\"CXAPISet\""
        export var"c\"CXAPISet\""
        export CXAPISet
        var"c\"CXAPISet\""
        struct Cbinding_clang_createAPISet{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"enum CXErrorCode\"", CBinding.Tuple{var"c\"CXTranslationUnit\"", CBinding.Cptr{var"c\"CXAPISet\""}}, :cdecl}, libpath, :clang_createAPISet}
        end
        const var"c\"clang_createAPISet\"" = Cbinding_clang_createAPISet{:clang_createAPISet}()
        (func::Cbinding_clang_createAPISet)(var"c\"tu\"", var"c\"out_api\"") = begin
                CBinding.funccall(func, var"c\"tu\"", var"c\"out_api\"")
            end
        const clang_createAPISet = var"c\"clang_createAPISet\""
        export var"c\"clang_createAPISet\""
        export clang_createAPISet
        var"c\"clang_createAPISet\""
        struct Cbinding_clang_disposeAPISet{name} <: CBinding.Cbinding{CBinding.Cfunction{CBinding.Cvoid, CBinding.Tuple{var"c\"CXAPISet\""}, :cdecl}, libpath, :clang_disposeAPISet}
        end
        const var"c\"clang_disposeAPISet\"" = Cbinding_clang_disposeAPISet{:clang_disposeAPISet}()
        (func::Cbinding_clang_disposeAPISet)(var"c\"api\"") = begin
                CBinding.funccall(func, var"c\"api\"")
            end
        const clang_disposeAPISet = var"c\"clang_disposeAPISet\""
        export var"c\"clang_disposeAPISet\""
        export clang_disposeAPISet
        var"c\"clang_disposeAPISet\""
        struct Cbinding_clang_getSymbolGraphForUSR{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{CBinding.Cptr{CBinding.Cconst{CBinding.Cchar}}, var"c\"CXAPISet\""}, :cdecl}, libpath, :clang_getSymbolGraphForUSR}
        end
        const var"c\"clang_getSymbolGraphForUSR\"" = Cbinding_clang_getSymbolGraphForUSR{:clang_getSymbolGraphForUSR}()
        (func::Cbinding_clang_getSymbolGraphForUSR)(var"c\"usr\"", var"c\"api\"") = begin
                CBinding.funccall(func, var"c\"usr\"", var"c\"api\"")
            end
        const clang_getSymbolGraphForUSR = var"c\"clang_getSymbolGraphForUSR\""
        export var"c\"clang_getSymbolGraphForUSR\""
        export clang_getSymbolGraphForUSR
        var"c\"clang_getSymbolGraphForUSR\""
        struct Cbinding_clang_getSymbolGraphForCursor{name} <: CBinding.Cbinding{CBinding.Cfunction{var"c\"CXString\"", CBinding.Tuple{var"c\"CXCursor\""}, :cdecl}, libpath, :clang_getSymbolGraphForCursor}
        end
        const var"c\"clang_getSymbolGraphForCursor\"" = Cbinding_clang_getSymbolGraphForCursor{:clang_getSymbolGraphForCursor}()
        (func::Cbinding_clang_getSymbolGraphForCursor)(var"c\"cursor\"") = begin
                CBinding.funccall(func, var"c\"cursor\"")
            end
        const clang_getSymbolGraphForCursor = var"c\"clang_getSymbolGraphForCursor\""
        export var"c\"clang_getSymbolGraphForCursor\""
        export clang_getSymbolGraphForCursor
        var"c\"clang_getSymbolGraphForCursor\""
    end
end
