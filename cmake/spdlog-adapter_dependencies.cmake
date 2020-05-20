include( FetchContent )


########################################################################
# Forward declarations
########################################################################


########################################################################
# Declare project dependencies
########################################################################

FetchContent_Declare( fmt-adapter
    GIT_REPOSITORY  http://github.com/njoy/fmt-adapter
    GIT_TAG         origin/build/fetchcontent
    )


########################################################################
# Load dependencies
########################################################################

FetchContent_MakeAvailable(
    fmt-adapter
    )
