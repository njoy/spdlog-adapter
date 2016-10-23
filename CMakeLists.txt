cmake_minimum_required( VERSION 3.2 ) 

project( spdlog-adapter VERSION 0.0.1 LANGUAGES CXX )

execute_process(
    COMMAND git rev-parse --abbrev-ref HEAD
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_BRANCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
    COMMAND git rev-parse HEAD
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_HASH
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

message( STATUS "" )
message( STATUS "-----------------------------------------------------------" )
message( STATUS "" )
message( STATUS "spdlog-adapter Version: 0.0.1" )
message( STATUS "Git current branch: ${GIT_BRANCH}" )
message( STATUS "Git commit hash: ${GIT_HASH}" )
message( STATUS "" )
message( STATUS "-----------------------------------------------------------" ) 
message( STATUS "" ) 

add_library( spdlog-adapter INTERFACE )
target_include_directories( spdlog-adapter INTERFACE src/include )
target_link_libraries( spdlog-adapter INTERFACE fmt-adapter ) 
