include(UnitTest)

macro(SET_FILE_PROPERTIES PROPERTY)
    foreach(arg ${ARGN})
        string(REGEX REPLACE "^([^ ]+) .+$" "\\1" VAR_NAME ${arg})
        string(REGEX REPLACE "^[^ ]+ +(.+)$" "\\1" VALUE ${arg})
        string(REGEX REPLACE ":" ";" VALUE ${VALUE})
        set(${PROPERTY}_${VAR_NAME} "${VALUE}")
    endforeach()
endmacro()

function(OPENMEEG_COMPARISON_TEST TEST_NAME FILENAME REFERENCE_FILENAME)
    set(COMPARISON_COMMAND compare_matrix)
    if (NOT IS_ABSOLUTE ${FILENAME})
        set(FILENAME ${OpenMEEG_BINARY_DIR}/tests/${FILENAME})
    endif()
    if (NOT IS_ABSOLUTE ${REFERENCE_FILENAME})
        set(REFERENCE_FILENAME ${OpenMEEG_SOURCE_DIR}/tests/${REFERENCE_FILENAME})
    endif()

    if (WIN32)
        set(COMPARISON_COMMAND "${EXECUTABLE_OUTPUT_PATH}/${COMPARISON_COMMAND}")
    else()
        set(COMPARISON_COMMAND "${CMAKE_CURRENT_BINARY_DIR}/${COMPARISON_COMMAND}")
    endif()

    OPENMEEG_TEST("cmp-${TEST_NAME}" 
             ${COMPARISON_COMMAND} ${FILENAME} ${REFERENCE_FILENAME} ${ARGN} DEPENDS ${TEST_NAME})
endfunction()
