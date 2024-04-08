
include(FetchContent)
set(BENCHMARK_ENABLE_TESTING OFF)

FetchContent_Declare(benchmark
    URL https://github.com/google/benchmark/archive/refs/tags/v1.8.3.zip
    # URL ${CMAKE_CURRENT_LIST_DIR}/benchmark-1.8.3.zip
)
FetchContent_MakeAvailable(benchmark)