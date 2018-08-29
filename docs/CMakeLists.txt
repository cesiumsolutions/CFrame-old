# cframe docs target

cframe_build_custom_target(
    TARGET_NAME   ${PROJECT_NAME}_docs
    PROJECT_LABEL Documents
    GROUP         CFrameSources
    FILES_PUBLIC
        License.md
        Manual.md
    FILES_PRIVATE
    INSTALL_DIR
        docs/${PROJECT_NAME}
)
