#ifndef IMAGETABLE_H
#define IMAGETABLE_H

#include <QAbstractTableModel>
#include <QUrl>
#include <memory>

class imagetable : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit imagetable(QObject *parent = nullptr);

    enum{
        SourceRole = Qt::UserRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, const int role = Qt::DisplayRole) const override;

    QHash<int,QByteArray> roleNames() const override;

signals:

public slots:
    void changeDirectory(const QVariant& qPath);
    void changeColumnCount(const int newCount);
private:
    std::unique_ptr<QVector<QString>> vector;
    int columnC = 1;
    int rowC = 0;
};

#endif // IMAGETABLE_H
