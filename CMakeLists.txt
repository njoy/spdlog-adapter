
cmake_minimum_required( VERSION 3.2 )
set( CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "Supported configuration types" FORCE )
        
if ( NOT GIT_EXECUTABLE )
    find_package( Git 2.1 )
    if ( NOT GIT_FOUND )
        message( FATAL_ERROR "git installation was not found." )
    endif()
endif()

if( NOT ROOT_DIRECTORY )
    set( ROOT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} )
    if ( NOT fetched_subprojects )
        if ( NOT PYTHON_EXECUTABLE )
            find_package( PythonInterp 3.4 )
            if ( NOT PYTHONINTERP_FOUND )
                message( FATAL_ERROR "Python interpreter installation was not found." )
            endif()
        endif()
        execute_process( COMMAND ${PYTHON_EXECUTABLE} "./metaconfigure/fetch_subprojects.py"
                         WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                         RESULT_VARIABLE fetch_failure )
        if ( NOT fetch_failure )
            set( fetched_subprojects TRUE CACHE BOOL "fetch script ran" )
        else()
            message( FATAL_ERROR "Failed to fetch dependencies" )
        endif()
    endif()
endif()

if( NOT is_subproject )
    if( NOT ROOT_DIRECTORY )
        set( ROOT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} )
    endif()
    if ( NOT PYTHON_EXECUTABLE )
        find_package( PythonInterp )
        if ( NOT PYTHONINTERP_FOUND )
            message( FATAL_ERROR "Python interpreter installation was not found." )
        endif()
    endif()
    execute_process( COMMAND ${PYTHON_EXECUTABLE} ./metaconfigure/signature.py ${CMAKE_BINARY_DIR}/signature
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE signature_failure )
    file( READ "${CMAKE_BINARY_DIR}/signature.json" SIGNATURE )
endif()

project( spdlog-adapter LANGUAGES CXX )
get_directory_property( is_subproject PARENT_DIRECTORY )
include( CMakeDependentOption REQUIRED )

if ( NOT GIT_EXECUTABLE )
    find_package( Git )
    if ( NOT GIT_FOUND )
        message( FATAL_ERROR "git installation was not found." )
    endif()
endif()

execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_BRANCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_HASH
    OUTPUT_STRIP_TRAILING_WHITESPACE
) 

message( STATUS "" )
message( STATUS "-----------------------------------------------------------" )
message( STATUS "" )
message( STATUS "spdlog-adapter" )
message( STATUS "Git current branch: ${GIT_BRANCH}" )
message( STATUS "Git commit hash: ${GIT_HASH}" )
message( STATUS "" )
message( STATUS "-----------------------------------------------------------" )

add_library( spdlog-adapter INTERFACE )
# target_compile_definitions( spdlog-adapter INTERFACE SPDLOG_FMT_EXTERNAL )
target_include_directories( spdlog-adapter INTERFACE src/include )
# target_link_libraries( spdlog-adapter INTERFACE fmt-adapter )
