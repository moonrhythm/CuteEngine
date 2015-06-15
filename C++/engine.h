#ifndef ENGINE_H
#define ENGINE_H

#define ENGINE_VERSION_MAJOR 1
#define ENGINE_VERSION_MINOR 0
#define ENGINE_VERSION_REVISION 0

#include "mainwindow.h"
#include "fileio.h"

#include <QtCore/QObject>
#include <QtCore/QStringList>
#include <QtWidgets/QApplication>
#include <QtQml/QQmlEngine>
#include <QtQuick/QQuickView>
#include <QtQml/QQmlApplicationEngine>

class Engine : public QObject
{
        Q_OBJECT

        Q_PROPERTY(QString version READ version)
        Q_PROPERTY(int major READ major)
        Q_PROPERTY(int minor READ minor)
        Q_PROPERTY(int revision READ revision)

    public:
        explicit Engine(int argc, char *argv[]);
        ~Engine();

        int exec();

        Q_INVOKABLE QString basePath() const;
        Q_INVOKABLE QString get(const QString &p);
        Q_INVOKABLE QString mainQml() const;
        Q_INVOKABLE bool online();
        Q_INVOKABLE int dpi();

        void setBasePath(const QString &basePath);
        bool registerResource(const QString &p);

        QString version() const { return QString("%1.%2.%3").arg(major(), minor(), revision()); }
        int major() const { return ENGINE_VERSION_MAJOR; }
        int minor() const { return ENGINE_VERSION_MINOR; }
        int revision() const { return ENGINE_VERSION_REVISION; }
    signals:

    private:
        QGuiApplication *_application;
        /*MainWindow *_mainWindow;
        QQuickView *_view;
        QQmlEngine *_qmlEngine;*/
        QQmlApplicationEngine _qmlAppEngine;
        FileIO *_fileIO;
        QString _basePath;
        QString _resourcePath;
        QString _imagePath;
        QString _soundPath;
        QString _videoPath;
};

#endif // ENGINE_H
