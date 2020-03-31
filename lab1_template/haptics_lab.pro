TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += Main.cpp
HEADERS += 1_HelloWorld.h 4_HapticWall.h Assignment.h 2_ReadDevicePosition.h 5_MagneticEffect.h 3_BasicForceEffects.h 6_HapticSphere.h

MODE = Debug
#MODE = Release

# Specify your Chai3D / haply-chai folder
CHAI3D = ../haply-chai


# Turn off some warnings
QMAKE_CXXFLAGS += /wd4100 # Ignore warning C4100 unreferenced formal parameter
QMAKE_CXXFLAGS_WARN_ON -= -w34100 # Specifically:
#https://stackoverflow.com/questions/20402722/why-disable-specific-warning-not-working-in-visual-studio


# Chai3D Linking below
win32{
    DEFINES += WIN64
    DEFINES += D_CRT_SECURE_NO_DEPRECATE
    QMAKE_CXXFLAGS += /EHsc /MP

    INCLUDEPATH += $${CHAI3D}/src
    INCLUDEPATH += $${CHAI3D}/external/Eigen
    INCLUDEPATH += $${CHAI3D}/external/glew/include
    INCLUDEPATH += $${CHAI3D}/extras/GLFW/include

    DEPENDPATH += $${CHAI3D}/src
    CONFIG(release, debug|release): LIBS += -L$${CHAI3D}/lib/Release/x64/ -lchai3d -lglu32 -lopengl32 -lwinmm
    CONFIG(debug, debug|release): LIBS += -L$${CHAI3D}/lib/Debug/x64/ -lchai3d -lglu32 -lopengl32 -lwinmm
    CONFIG(debug, debug|release): LIBS +=  -L$${CHAI3D}/extras/GLFW/lib/Debug/x64/ -lglfw
    CONFIG(release, debug|release): LIBS +=  -L$${CHAI3D}/extras/GLFW/lib/Release/x64/ -lglfw
    LIBS += -lglu32 -lOpenGl32 -lglu32 -lOpenGl32 -lwinmm -luser32
    LIBS += kernel32.lib
    LIBS += user32.lib
    LIBS += gdi32.lib
    LIBS += winspool.lib
    LIBS += comdlg32.lib
    LIBS += advapi32.lib
    LIBS += shell32.lib
    LIBS += ole32.lib
    LIBS += oleaut32.lib
    LIBS += uuid.lib
    LIBS += odbc32.lib
    LIBS += odbccp32.lib
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





