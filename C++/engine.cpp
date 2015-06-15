#include "engine.h"

#include <QtCore/QCoreApplication>
#include <QtWidgets/QApplication>
#include <QtGui/QGuiApplication>
#include <QtGui/QScreen>
#include <QtCore/QResource>
#include <QtCore/QDir>
#include <QtCore/QFileInfo>
#include <QtQml/QQmlComponent>
#include <QtCore/QDir>
#include <QtCore/QDirIterator>
#include <QtQml/QQmlContext>
#include <QtQml/QQmlComponent>
#include <QDebug>

Engine::Engine(int argc, char *argv[]) : QObject()
{
    _application = new QGuiApplication(argc, argv);

    // setup QmlEngine

    // _qmlEngine->setImportPathList(QStringList()); // Clear hard code path
    // _qmlEngine->addImportPath(QStringLiteral("qrc:///static")); // static lib
    // _qmlEngine->addImportPath(QStringLiteral("qrc:///")); // CuteEngine
    _qmlAppEngine.addImportPath(QStringLiteral("qrc:///")); // CuteEngine

    // register classes
    _fileIO = new FileIO(_application);

    _qmlAppEngine.rootContext()->setContextProperty("Engine", this);
    _qmlAppEngine.rootContext()->setContextProperty("FileIO", _fileIO);
}

Engine::~Engine()
{
}

int Engine::exec()
{
    _qmlAppEngine.load(QUrl("qrc:///main.qml"));
    return _application->exec();
}

QString Engine::get(const QString &p)
{
    QString scheme = p.left(p.indexOf(':'));
    QString r = p.right(p.length() - scheme.length() - 1);
    if (scheme == "image") // image:img
        return _imagePath.arg(r);
    if (scheme == "sound") // sound:title
        //return ":/sound/" + r;
        return _soundPath.arg(r);
    if (scheme == "video") // video:op
        //return "qrc:/video/" + r;
        return _videoPath.arg(r);
    return p;
}

bool Engine::registerResource(const QString &p)
{
    if (QResource::registerResource(p)) {
        QFileInfo info(p);
        _resourcePath = info.absoluteDir().absolutePath();
        return true;
    }
    return false;
}

void Engine::setBasePath(const QString &basePath)
{
    _basePath = basePath;
    if (_basePath[_basePath.length() - 1] != '/')
        _basePath.append("/");
    _imagePath = _basePath + "image/%1";
    _soundPath = _basePath + "sound/%1";
    _videoPath = _basePath + "video/%1";
}

QString Engine::basePath() const
{
    return _basePath;
}

QString Engine::mainQml() const
{
    return _basePath + "qml/main.qml";
}

bool Engine::online()
{
#ifdef ONLINE
    return true;
#else
    return false;
#endif
}

int Engine::dpi()
{
    return QGuiApplication::primaryScreen()->physicalDotsPerInch();
}
