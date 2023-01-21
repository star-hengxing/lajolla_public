set_project("lajolla")
set_xmakever("2.7.5")

add_rules("mode.debug", "mode.releasedbg", "mode.release", "mode.minsizerel")

set_warnings("all")
set_languages("c++20")

if is_plat("windows") then
    set_runtimes("MD")
end

package("embree")
    set_homepage("https://www.embree.org/")
    set_description("Intel® Embree is a collection of high-performance ray tracing kernels, developed at Intel.")
    set_license("Apache-2.0")

    on_load(function (package)
        package:set("installdir", path.join(os.scriptdir(), "embree"))
    end)

    on_fetch(function (package)
        local result = {}
        if is_plat("windows") then
            package:add("syslinks", "advapi32")
            result.linkdirs = package:installdir("lib-win32")
            package:addenv("PATH", package:installdir("bin"))
        elseif is_plat("linux") then
            package:addenv("PATH", package:installdir("lib-linux"))
        elseif is_plat("macosx") then
            package:addenv("PATH", package:installdir("lib-macos"))
        end

        result.links = {"embree3", "tbb"}
        result.includedirs = package:installdir("include")
        return result
    end)
package_end()

add_requires("embree")

target("3rdparty")
    set_kind("static")
    add_includedirs("src", {public = true})
    add_files("src/3rdparty/*.cpp")
    add_files("src/3rdparty/*.c")
target_end()

target("lajolla")
    set_default(true)
    set_kind("binary")
    add_files("src/*.cpp")
    add_deps("3rdparty")
    add_packages("embree")

    if is_plat("windows") then
        add_defines("_WINDOWS")
    end

    set_rundir("$(projectdir)")
    set_runargs("scenes/cbox/cbox.xml")
target_end()
