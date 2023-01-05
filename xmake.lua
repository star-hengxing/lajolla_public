set_project("lajolla")

add_rules("mode.debug", "mode.releasedbg", "mode.release", "mode.minsizerel")

set_warnings("all")
set_languages("c++20")

if is_plat("windows") then
    set_runtimes("MD")
end

target("embree")
    set_kind("phony")
    add_includedirs("embree/include", {public = true})

    if is_plat("windows") then
        add_links("embree/lib-win32/*", {public = true})
    elseif is_plat("linux") then
        add_links("embree/lib-linux/*", {public = true})
    elseif is_plat("macosx") then
        add_links("embree/lib-macos/*", {public = true})
    end

target("3rdparty")
    set_kind("static")
    add_includedirs("src", {public = true})
    add_files("src/3rdparty/*.cpp")
    add_files("src/3rdparty/*.c")
    add_deps("embree")

target("lajolla")
    set_default(true)
    set_kind("binary")
    add_files("src/*.cpp")
    add_deps("3rdparty")

    if is_plat("windows") then
        add_defines("_WINDOWS")
        add_linkdirs("embree/bin")
    end

    set_rundir("$(projectdir)")
    -- set_runargs("scenes/cbox/cbox.xml")