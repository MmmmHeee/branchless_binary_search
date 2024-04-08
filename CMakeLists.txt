cmake_minimum_required(VERSION 3.12)

project(branchless_binary_search CXX)

cmake_policy(SET CMP0135 NEW)

include(cmake/GoogleBenchmark.cmake)
include(cmake/GoogleTest.cmake)

macro (set_compile_options TARGET)
    if (MSVC)
        target_compile_options(${TARGET} PRIVATE /Ox)
    else()
        target_compile_options(${TARGET} PRIVATE -fms-extensions)
        target_compile_options(${TARGET} PRIVATE -O3)
    endif()
endmacro()

macro (make_assembly_listing TARGET)
    if(MSVC)
        # Trust me, Microsoft docs suck.
        target_compile_options(
            ${TARGET} PRIVATE "/Fa" "/FA"
        )
    else()
        # The trick is that makefiles generator defines a [sourcefile].s target for each sourcefile of a target to generate the listing
        # of that file. We hook a command after build to invoke that target and copy the result file to our ourput directory:
        if (${CMAKE_GENERATOR} STREQUAL "Unix Makefiles")
            add_custom_command(
                TARGET ${TARGET}
                POST_BUILD
                COMMAND make ARGS ${TARGET}.cpp.s
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            )
        endif()
    endif()
endmacro()

add_executable(test test.cpp)
target_link_libraries(test
    PRIVATE gtest
)
set_target_properties(test PROPERTIES
    CXX_STANDARD 20
)
set_compile_options(test)
target_compile_definitions(test PRIVATE ENABLE_GTEST)
make_assembly_listing(test)


add_executable(bench bench.cpp)
target_link_libraries(bench
    PRIVATE benchmark::benchmark
)
set_target_properties(bench PROPERTIES
    CXX_STANDARD 20
)
set_compile_options(bench)
make_assembly_listing(bench)
