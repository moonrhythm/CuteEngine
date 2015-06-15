#ifndef FILEIO_H
#define FILEIO_H

#include <QtCore/QObject>
#include <QtCore/QStringList>
#include <QtCore/QFile>
#include <QtCore/QDir>

class FileIO : public QObject
{
        Q_OBJECT

    public:
        explicit FileIO(QObject *parent = 0);
        ~FileIO();

        Q_INVOKABLE QString absoluteFilePath(const QString &fileName) const;
        Q_INVOKABLE QString absolutePath() const;
        Q_INVOKABLE QString canonicalPath() const;
        Q_INVOKABLE bool cd(const QString &dirName);
        Q_INVOKABLE bool cdUp();
        Q_INVOKABLE uint count() const;
        Q_INVOKABLE QString dirName() const;
        Q_INVOKABLE QStringList entryList(const QStringList &nameFilters) const;
        Q_INVOKABLE bool exists(const QString &name) const;
        Q_INVOKABLE bool exists() const;
        Q_INVOKABLE QString filePath(const QString &fileName) const;
        Q_INVOKABLE bool makeAbsolute();
        Q_INVOKABLE bool mkdir(const QString &dirName) const;
        Q_INVOKABLE bool mkpath(const QString &dirPath) const;
        Q_INVOKABLE QString path() const;
        Q_INVOKABLE void refresh() const;
        Q_INVOKABLE QString relativeFilePath(const QString &fileName) const;
        Q_INVOKABLE bool remove(QString &fileName);
        Q_INVOKABLE bool removeRecursively();
        Q_INVOKABLE bool rename(const QString &oldName, const QString &newName);
        Q_INVOKABLE bool rmdir(const QString &dirName) const;
        Q_INVOKABLE bool rmpath(const QString &dirPath) const;
        Q_INVOKABLE void setPath(const QString &path);
        Q_INVOKABLE QString operator[](int pos) const;

        Q_INVOKABLE QString fileName(const QString &filePath) const;

        Q_INVOKABLE QString homePath();
        Q_INVOKABLE QString rootPath();
        Q_INVOKABLE QString tempPath();
        Q_INVOKABLE QString toNativeSeparators(const QString &pathName);

        Q_INVOKABLE QStringList dirIteration(const QString &path, const QStringList &nameFilters, bool listDir, bool recursive);

    signals:

    public slots:

    private:
        QDir _dir;
};

#endif // FILEIO_H
