cframe_build_target(
    TARGET_NAME   ${PROJECT_NAME}_scripts
    PROJECT_LABEL Scripts
    GROUP         CFrameSources
    TYPE          Custom
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
    FILES_INSTALL_DIR
        share/${PROJECT_NAME}/cmake
)
