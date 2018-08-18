# cframe docs target
set( TARGET ${PROJECT_NAME}_docs )

set( FILES_PUBLIC
    License.md
    Manual.md
)

set( FILES_PRIVATE
)

add_custom_target(
    ${TARGET}
    SOURCES
        ${FILES_PUBLIC}
        ${FILES_PRIVATE}
)

source_group(
    \\ FILES
    ${FILES_PUBLIC}
    ${FILES_PRIVATE}
)

set_target_properties(
    ${TARGET}
    PROPERTIES
        FOLDER CFrame
)

install(
    FILES ${FILES_PUBLIC}
    DESTINATION docs/${PROJECT_NAME}
)
