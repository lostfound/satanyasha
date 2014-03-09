#ifndef NETCONTROL_H
#define NETCONTROL_H

#include <QObject>
#include <QString>
#include <QtNetwork>
#include <QMap>
#include <QJsonObject>
#include <QByteArray>

class NetControl : public QObject
{
    Q_OBJECT
    static const QString MULTICAST_ADDR;
    static const int     MULTICAST_PORT;

    QUdpSocket   *udpSocket;
    QByteArray   tcpBuffer;
    QTcpSocket   *tcpSocket;
    QHostAddress  groupAddress;
    QString       current_serv_id;
    QMap<QString, QMap<QString,QString>> servers;
    QJsonObject   udpToJson(const QByteArray &jsonData);


public:
    explicit NetControl(QObject *parent = 0);
public slots:
    void startUdpReceiver();
    void connectToServer(const QString &server_id, const QString &password);
    void play();
    void play_pause();
    void fullscreen();
    void forward1();
    void forward2();
    void forward3();
    void rewind1();
    void rewind2();
    void rewind3();
    void next();
    void prev();
    void incvol();
    void decvol();
    void get_files();
    void lsdir(const QString &dir);
    void play_file(const QString &path);

signals:
    void server_discovered(const QString &json);
    void files_received   (const QString &json);
    void error            (const QString &error);
    void authorized();
private slots:
    void processUdpData();
    void readTCPdata();
    void tcpDisconnected();
private:
    void tcp_send(const QMap<QString,QString> &params);
    QJsonObject json_parce(const QByteArray &data);
};

#endif // NETCONTROL_H
