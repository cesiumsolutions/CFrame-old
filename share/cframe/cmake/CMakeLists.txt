# cframe scripts target

cframe_build_custom_target(
    TARGET_NAME   ${PROJECT_NAME}_scripts
    PROJECT_LABEL Scripts
    GROUP         CFrameSources
    FILES_PUBLIC
        CFrameBuildFunctions.cmake
        CFrameExternalPackages.cmake
        CFrameInitialize.cmake
        CFrameProjects.cmake
        CFrameUtilities.cmake
        SetupBoost.cmake
        SetupQt.cmake
    FILES_PRIVATE
        CFrameInternal.cmake
    INSTALL_DIR
        share/${PROJECT_NAME}/cmake
)
