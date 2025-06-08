#include "imagetable.h"
#include "math.h"
#include <filesystem>
#include <regex>
imagetable::imagetable(QObject *parent)
    : QAbstractTableModel(parent)
{
    vector = std::make_unique<QVector<QString>>();
}

int imagetable::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return rowC;
}

int imagetable::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return columnC;
}

QVariant imagetable::data(const QModelIndex &index,const int role) const
{
    if (!index.isValid())
        return QVariant();
    int i = index.row()+index.column()*rowC;
    if(i < 0 || i >= vector->size()){
        return "";
    }
    switch(role){
        case SourceRole:
            return vector->at(i);
    }
    return QVariant();
}

void imagetable::changeDirectory(const QVariant& qPath){
    beginResetModel();
    rowC = 0;
    int numberOfEntry = 0;
    vector->clear();
    auto stdPath = qPath.toString().toStdString();

    //Remove prefix from path
    QString filePreFix = "file:///";
    stdPath = stdPath.substr(filePreFix.size(),stdPath.size() - filePreFix.size());

    const std::regex imageFile(".*\\.(png|jpg|bmp)$" , std::regex_constants::ECMAScript | std::regex_constants::icase);

    for(const auto& entry : std::filesystem::directory_iterator(stdPath)){
        std::string path = entry.path().string();
        if(std::regex_match(path,imageFile)){
            vector->append(filePreFix+QString::fromUtf8(path.c_str()));
            if(++numberOfEntry > rowC * columnC){
                rowC++;
            }
        }
    }
    endResetModel();
}

void imagetable::changeColumnCount(const int newCount){
    beginResetModel();
    columnC = newCount < 1 ? 1 : newCount;
    rowC = std::ceil(static_cast<float>(vector->size())/columnC);
    endResetModel();
}

QHash<int,QByteArray> imagetable::roleNames() const{
    QHash<int,QByteArray> names;
    names[SourceRole] = "source";
    return names;
}
