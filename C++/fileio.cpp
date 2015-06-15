#include "fileio.h"

#include <QtCore/QDir>
#include <QtCore/QDirIterator>
#include <QtCore/QFileInfo>

FileIO::FileIO(QObject *parent) : QObject(parent)
{

}

FileIO::~FileIO()
{

}

QString FileIO::absoluteFilePath(const QString &fileName) const
{
    return _dir.absoluteFilePath(fileName);
}

QString FileIO::absolutePath() const
{
    return _dir.absolutePath();
}

QString FileIO::canonicalPath() const
{
    return _dir.canonicalPath();
}

bool FileIO::cd(const QString &dirName)
{
    return _dir.cd(dirName);
}

bool FileIO::cdUp()
{
    return _dir.cdUp();
}

uint FileIO::count() const
{
    return _dir.count();
}

QString FileIO::dirName() const
{
    return _dir.dirName();
}

QStringList FileIO::entryList(const QStringList &nameFilters) const
{
    return _dir.entryList(nameFilters);
}

bool FileIO::exists(const QString &name) const
{
    return _dir.exists(name);
}

bool FileIO::exists() const
{
    return _dir.exists();
}

QString FileIO::filePath(const QString &fileName) const
{
    return _dir.filePath(fileName);
}

bool FileIO::makeAbsolute()
{
    return _dir.makeAbsolute();
}

bool FileIO::mkdir(const QString &dirName) const
{
    return _dir.mkdir(dirName);
}

bool FileIO::mkpath(const QString &dirPath) const
{
    return _dir.mkpath(dirPath);
}

QString FileIO::path() const
{
    return _dir.path();
}

void FileIO::refresh() const
{
    _dir.refresh();
}

QString FileIO::relativeFilePath(const QString &fileName) const
{
    return _dir.relativeFilePath(fileName);
}

bool FileIO::remove(QString &fileName)
{
    return _dir.remove(fileName);
}

bool FileIO::removeRecursively()
{
    return _dir.removeRecursively();
}

bool FileIO::rename(const QString &oldName, const QString &newName)
{
    return _dir.rename(oldName, newName);
}

bool FileIO::rmdir(const QString &dirName) const
{
    return _dir.rmdir(dirName);
}

bool FileIO::rmpath(const QString &dirPath) const
{
    return _dir.rmpath(dirPath);
}

void FileIO::setPath(const QString &path)
{
    _dir.setPath(path);
}

QString FileIO::operator[](int pos) const
{
    return _dir[pos];
}

QString FileIO::homePath()
{
    return QDir::homePath();
}

QString FileIO::rootPath()
{
    return QDir::rootPath();
}

QString FileIO::tempPath()
{
    return QDir::tempPath();
}

QString FileIO::toNativeSeparators(const QString &pathName)
{
    return QDir::toNativeSeparators(pathName);
}

QStringList FileIO::dirIteration(const QString &path, const QStringList &nameFilters, bool listDir, bool recursive)
{
    QStringList result;
    QDirIterator it(path, nameFilters, (listDir ? QDir::Dirs : QDir::NoFilter)
                    | QDir::NoDot | QDir::NoDotAndDotDot | QDir::Files,
                    recursive ? QDirIterator::Subdirectories : QDirIterator::NoIteratorFlags);
    while (it.hasNext())
        result << it.next();
    return result;
}

QString FileIO::fileName(const QString &filePath) const
{
    QFileInfo fileInfo(filePath);
    return fileInfo.fileName();
}
