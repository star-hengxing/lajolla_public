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

target("Embree")
    set_kind("phony")
    add_includedirs("embree/include", {public = true})

target("3rdparty")
    set_kind("static")
    add_includedirs("src", {public = true})
    add_files("src/3rdparty/*.cpp")
    add_files("src/3rdparty/*.c")

target("lajolla")
    set_default(true)
    set_kind("binary")
    add_files("src/*.cpp")

    if is_plat("windows") then
        add_defines("_WINDOWS")
    end
    add_deps("Embree", "3rdparty")

    if is_plat("windows") then
        add_linkdirs("embree/bin", "embree/lib-win32")
        add_links("embree3", "tbb")
    end

    set_rundir("$(projectdir)")