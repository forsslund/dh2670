TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += Main.cpp
HEADERS += 1_HelloWorld.h 4_HapticWall.h Assignment.h 2_ReadDevicePosition.h 5_MagneticEffect.h 3_BasicForceEffects.h 6_HapticSphere.h

# Specify your Chai3D / haply-chai folder
CHAI3D = ../haply-chai

# Chai3D Linking below
win32{
    # Turn off some warnings
    QMAKE_CXXFLAGS += /wd4100 # Ignore warning C4100 unreferenced formal parameter
    QMAKE_CXXFLAGS_WARN_ON -= -w34100 # Specifically:
    #https://stackoverflow.com/questions/20402722/why-disable-specific-warning-not-working-in-visual-studio

    DEFINES += WIN64
    DEFINES += D_CRT_SECURE_NO_DEPRECATE
    QMAKE_CXXFLAGS += /EHsc /MP
    QMAKE_CXXFLAGS_RELEASE += /MT
    QMAKE_CXXFLAGS_DEBUG += /MTd

    INCLUDEPATH += $${CHAI3D}/src
    INCLUDEPATH += $${CHAI3D}/external/Eigen
    INCLUDEPATH += $${CHAI3D}/external/glew/include
    INCLUDEPATH += $${CHAI3D}/extras/GLFW/include

    DEPENDPATH += $${CHAI3D}/src
    CONFIG(release, debug|release) {
        LIBS += -L$${CHAI3D}/Release/
        LIBS += -L$${CHAI3D}/extras/GLFW/Debug/
        LIBS += -L$${CHAI3D}/external/github-HaplyHaptics-Haply-API-cpp/Release/
        LIBS += -L$${CHAI3D}/external/github-HaplyHaptics-Haply-API-cpp/external/github-HaplyHaptics-serial/Release/
    }
    CONFIG(debug, debug|release) {
        LIBS += -L$${CHAI3D}/Debug/
        LIBS +=  -L$${CHAI3D}/extras/GLFW/Release/
        LIBS += -L$${CHAI3D}/external/github-HaplyHaptics-Haply-API-cpp/Debug/
        LIBS += -L$${CHAI3D}/external/github-HaplyHaptics-Haply-API-cpp/external/github-HaplyHaptics-serial/Debug/
    }

    LIBS += -lchai3d -lOpenGl32 -lglu32 -lhaply-api-cpp -lwinmm -lglfw -lserial
    LIBS += -lsetupapi -lkernel32 -luser32
    LIBS += -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32
    LIBS += -luuid -lcomdlg32 -ladvapi32
}

# Configured for the KTH CSC Karmosin computer halls
unix!mac {
    CHAI3D = /opt/chai3d/3.2.0

    INCLUDEPATH += $${CHAI3D}/src
    INCLUDEPATH += $${CHAI3D}/external/Eigen
    INCLUDEPATH += $${CHAI3D}/external/glew/include
    INCLUDEPATH += $${CHAI3D}/extras/GLFW/include

    DEFINES += LINUX
    QMAKE_CXXFLAGS += -std=c++0x
    LIBS += -L$${CHAI3D}/external/DHD/lib/lin-x86_64/
    LIBS += -L$${CHAI3D}/build/extras/GLFW
    LIBS += -L$${CHAI3D}/build
    LIBS += -lchai3d
    LIBS += -ldrd
    LIBS += -lpthread
    LIBS += -lrt
    LIBS += -ldl
    LIBS += -lGL
    LIBS += -lGLU
    LIBS += -lusb-1.0
    LIBS += -lglfw
    LIBS += -lX11
    LIBS += -lXcursor
    LIBS += -lXrandr
    LIBS += -lXinerama
}

mac: {
    INCLUDEPATH += $${CHAI3D}/src
    INCLUDEPATH += $${CHAI3D}/external/Eigen
    INCLUDEPATH += $${CHAI3D}/external/glew/include
    INCLUDEPATH += $${CHAI3D}/extras/GLFW/include

    DEFINES += MACOSX
    QMAKE_CXXFLAGS += -std=c++0x
    LIBS += -L$${CHAI3D}/external/DHD/lib/mac-x86_64
    LIBS += -L$${CHAI3D}/external/github-HaplyHaptics-Haply-API-cpp -lhaply-api-cpp
    LIBS += -L$${CHAI3D}/external/github-HaplyHaptics-Haply-API-cpp/external/github-HaplyHaptics-serial -lserial
    LIBS += -L$${CHAI3D}/extras/GLFW
    LIBS += -L$${CHAI3D}/
    LIBS += -lchai3d
    LIBS += -ldrd
    LIBS += -lpthread
    LIBS += -ldl
    LIBS += -lglfw
    LIBS += -framework CoreVideo -framework OpenGL -framework CoreFoundation -framework Cocoa -framework IOKit -framework CoreServices -framework CoreAudio -framework AudioToolbox -framework AudioUnit
}
