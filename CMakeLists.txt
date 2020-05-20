########################################################################
# Preamble
########################################################################

cmake_minimum_required( VERSION 3.16 )
project( spdlog-adapter LANGUAGES CXX )

########################################################################
# Dependencies
########################################################################

include( cmake/spdlog-adapter_dependencies.cmake )

########################################################################
# Project targets
########################################################################

add_library( spdlog-adapter INTERFACE )
target_include_directories( spdlog-adapter INTERFACE src/include/ )
target_link_libraries( spdlog-adapter
    INTERFACE fmt-adapter
    )
