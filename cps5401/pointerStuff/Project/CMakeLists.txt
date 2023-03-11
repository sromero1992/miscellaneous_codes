cmake_minimum_required(VERSION 2.8)
project(RootFinding)
set(CMAKE_BUILD_TYPE Release)

# The major version number: Number of problems supported
set(RF_MAJOR_VERSION 2)
# The minor version number: Order of accuracy
set(RF_MINOR_VERSION 2)
# The growth version number:
set(RF_GRWTH_VERSION 1)
# The full version
set(RF_VERSION
    ${RF_MAJOR_VERSION}.${RF_MINOR_VERSION}.${RF_GRWTH_VERSION}
    )

# Bring the headers into the project
include_directories(include)

# Add source files
file(GLOB SOURCES "main/*.c" "src/*.c")

# Configure file that pass CMake settings to the source

# Executable
add_executable(test_rf ${SOURCES})
