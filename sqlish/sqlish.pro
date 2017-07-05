PROJECT_DIR = $${PWD}/..

# Pre-build evnet
system(lupdate -recursive . -ts translate/enus.ts)
win32{
} else {
}

CONFIG(release, debug|release){
    DESTDIR = ../dist/release
    OBJECTS_DIR = release/obj
    MOC_DIR = release/moc
    RCC_DIR = release/rcc
    UI_DIR = release/ui
    QMAKE_CXXFLAGS += -g
}

CONFIG(debug, debug|release){
    DESTDIR = ../dist/debug
    OBJECTS_DIR = debug/obj
    MOC_DIR = debug/moc
    RCC_DIR = debug/rcc
    UI_DIR = debug/ui
    DEFINES += _DEBUG
}

QT += qml quick widgets concurrent

CONFIG += c++11

INCLUDEPATH += \
    ../lib/spdlog/include

win32 {
    INCLUDEPATH += \
        $${PROJECT_DIR}/lib/drmingw/include

    LIBS += \
        $${PROJECT_DIR}/lib/drmingw/lib/libexchndl.a \
        $${PROJECT_DIR}/lib/drmingw/lib/libmgwhelp.a
} else : linux{
    QMAKE_CXXFLAGS += -funwind-tables
    QMAKE_LFLAGS += -rdynamic
} else : mac{
    LIBS += -ldl
    QMAKE_CXXFLAGS += -fno-pie
}

SOURCES += main.cpp

RESOURCES += res/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

include("../lib/quickflux/quickflux.pri")

win32 {
    RC_ICONS += res/Assets/MainIcon.ico
} else : linux{
} else : mac{
    ICON = res/Assets/MainIcon.icns
}

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Copies the given files to the destination directory
#    copyToDestdir($$OTHER_FILES) # a variable containing multiple paths
#    copyToDestdir(run.sh) # a single filename
#    copyToDestdir(run.sh README) # multiple files
defineTest(copyToDestdir) {
    files = $$1

    for(FILE, files) {
        DDIR = $$DESTDIR

        # Replace slashes in paths with backslashes for Windows
        win32:FILE ~= s,/,\\,g
        win32:DDIR ~= s,/,\\,g

        QMAKE_POST_LINK += $$QMAKE_COPY $$quote($$FILE) $$quote($$DDIR) $$escape_expand(\\n\\t)
    }

    export(QMAKE_POST_LINK)
}


win32 {
    copyToDestdir( \
        $${PROJECT_DIR}/lib/drmingw/bin/*.dll \
        $${PROJECT_DIR}/lib/drmingw/bin/symsrv.yes \
    )
} else : linux{
} else : mac{
}

win32 {
    DEPLOY_COMMAND = windeployqt
} else : mac {
    DEPLOY_COMMAND = macdeployqt
    DEPLOY_OPTION = -dmg -qmldir=$$getenv(QTDIR)/qml -always-overwrite
}

CONFIG( release, debug|release ) {
    DEPLOY_TARGET = $$shell_quote($$shell_path($${DESTDIR}/$${TARGET}$${TARGET_CUSTOM_EXT}))

    #  # Uncomment the following line to help debug the deploy command when running qmake
    #  warning($${DEPLOY_COMMAND} $${DEPLOY_TARGET})

    mac {
        QMAKE_POST_LINK += $${DEPLOY_COMMAND} $${DEPLOY_TARGET} $${DEPLOY_OPTION}
    }
}

