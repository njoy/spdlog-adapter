cmake_minimum_required( VERSION 3.2 ) 

if( NOT ROOT_DIRECTORY )
    set( ROOT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} )
    if ( NOT fetched_subprojects )
        if ( NOT PYTHON_EXECUTABLE )
            find_package( PythonInterp )
            if ( NOT PYTHONINTERP_FOUND )
                message( FATAL_ERROR "Python interpeter installation was not found." )
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

if( NOT TARGET fmt-adapter )
  add_subdirectory( ${ROOT_DIRECTORY}/subprojects/fmt-adapter )
endif()

message( STATUS "" )
message( STATUS "-----------------------------------------------------------" )
message( STATUS "" )
message( STATUS "spdlog-adapter" )
message( STATUS "Git current branch: ${GIT_BRANCH}" )
message( STATUS "Git commit hash: ${GIT_HASH}" )
message( STATUS "" )
message( STATUS "-----------------------------------------------------------" )

add_library( spdlog-adapter INTERFACE )
target_sources( spdlog-adapter INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/async_logger.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/common.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/formatter.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/logger.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/spdlog.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/tweakme.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/async_log_helper.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/async_logger_impl.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/file_helper.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/log_msg.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/logger_impl.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/mpmc_bounded_q.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/null_mutex.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/os.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/pattern_formatter_impl.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/registry.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/details/spdlog_impl.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/android_sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/ansicolor_sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/base_sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/dist_sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/file_sinks.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/msvc_sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/null_sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/ostream_sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/stdout_sinks.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/syslog_sink.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/include/spdlog/sinks/wincolor_sink.h" )
target_include_directories( spdlog-adapter INTERFACE src/include )
target_link_libraries( spdlog-adapter INTERFACE fmt-adapter )
