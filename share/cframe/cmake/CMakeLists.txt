# cframe scripts target

cframe_build_custom_target(
    NAME    ${PROJECT_NAME}_scripts
    GROUP   CFrame
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
