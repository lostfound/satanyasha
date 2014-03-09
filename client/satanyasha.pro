# Add more folders to ship with the application, here
folder_01.source = qml/satanyasha
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
CONFIG += c++11
# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    netcontrol.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    netcontrol.h

OTHER_FILES += \
    qml/satanyasha/ServersListModel.qml \
    qml/satanyasha/ServersList.qml \
    qml/satanyasha/Server.qml \
    qml/satanyasha/Style.qml \
    qml/satanyasha/TextBig.qml \
    qml/satanyasha/TextNormal.qml \
    qml/satanyasha/TextSmall.qml \
    qml/satanyasha/TextButton.qml \
    qml/satanyasha/ControlMenu.qml \
    qml/satanyasha/FilesListModel.qml \
    qml/satanyasha/FilesModel.qml \
    qml/satanyasha/UnicodeButton.qml \
    android/AndroidManifest.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
