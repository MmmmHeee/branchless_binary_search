
include(FetchContent)

if (MSVC)
    # For Windows: Prevent overriding the parent project's compiler/linker settings
    SET(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
endif()

FetchContent_Declare(googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
    # URL ${CMAKE_CURRENT_LIST_DIR}/googletest-1.14.0.zip
)
FetchContent_MakeAvailable(googletest)
