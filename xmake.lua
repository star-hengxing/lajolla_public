set_project("lajolla")

add_rules("mode.debug", "mode.releasedbg", "mode.release", "mode.minsizerel")

set_arch("x64")
set_warnings("all")
set_languages("c++20")

if is_os("windows") then
    set_toolchains("clang-cl")
    set_runtimes("MD")
else
    set_toolchains("clang")
end

target("3rdparty")
    set_kind("static")
    add_includedirs("src", {public = true})
    add_files("src/3rdparty/*.cpp")
    add_files("src/3rdparty/*.c")

target("lajolla")
    set_default(true)
    set_kind("binary")
    add_files("src/*.cpp")

    add_includedirs("embree/include")
    add_deps("3rdparty")

    if is_plat("windows") then
        add_defines("_WINDOWS")
        add_linkdirs("embree/bin")
        add_links("embree/lib-win32/*")
    elseif is_plat("linux") then
        add_links("embree/lib-linux/*")
    elseif is_plat("macosx") then
        add_links("embree/lib-macos/*")
    end

    set_rundir("$(projectdir)")