#include <QtGui/QGuiApplication>
#include <QtQml>
#include "qtquick2applicationviewer.h"
#include "netcontrol.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<NetControl>("lsd.satanyasha", 1, 0, "NetControl");
    QtQuick2ApplicationViewer viewer;
#ifndef Q_OS_ANDROID
    viewer.setProperty("width", 360);
    viewer.setProperty("height", 640);
#endif
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setMainQmlFile(QStringLiteral("qml/satanyasha/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
