#include "netcontrol.h"
#include <QDebug>
#include <QJsonDocument>
#include <QCryptographicHash>

const QString NetControl::MULTICAST_ADDR = "224.0.0.1";
const int     NetControl::MULTICAST_PORT = 6660;//htonl(6660);

NetControl::NetControl(QObject *parent) :
    QObject(parent)
{
    tcpSocket = NULL;
    udpSocket = NULL;
}
void NetControl::startUdpReceiver()
{
    groupAddress = QHostAddress(NetControl::MULTICAST_ADDR);
    udpSocket = new QUdpSocket(this);
    udpSocket->bind(QHostAddress::AnyIPv4, MULTICAST_PORT, QUdpSocket::ShareAddress);
    udpSocket->joinMulticastGroup(groupAddress);
    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(processUdpData()));

}

void NetControl::processUdpData()
{
    //qDebug()<<"Data received";
    while ( udpSocket->hasPendingDatagrams() ) {
      QByteArray datagram;
      QJsonObject server_info;
      datagram.resize(udpSocket->pendingDatagramSize());
      udpSocket->readDatagram(datagram.data(), datagram.size());
      try {
          server_info =  udpToJson(datagram);
      }catch (QString serr) {
          qWarning()<<"unable to parse udp package";
          continue;
      }

      QMap<QString, QString> server_entry;
      QString param;
      for (auto key: {"id", "ip", "hostname", "user"}) {
        param = server_info[key].toString();
        if (param.isEmpty()) {
            qWarning()<<"incoming udp-package does not contain valid "<<key<<"key";
            goto next;
        }
        if (QString(key) == "id") {
            server_entry["json"] = QString(datagram);
            if ( servers.contains(param) && servers[param]["json"] == server_entry["json"]) {
                goto next;
            }
        }
        server_entry[key] = param;
      }
      if ( !server_info["port"].isDouble() ) {
            qWarning()<<"incoming udp-package does not contain valid "<<"port"<<"key";
            continue;
      }
      server_entry["port"] = QString::number(server_info["port"].toInt());

      servers[server_entry["id"]] = server_entry;
      qDebug()<<"New server "<<server_entry["id"]<<"is discovered";
      emit server_discovered(server_entry["json"]);
      next:;
    }
}

QJsonObject  NetControl::udpToJson(const QByteArray &jsonData)
{
    QJsonDocument jsdoc = QJsonDocument::fromJson(jsonData);
    if (jsdoc.isNull()) {
        throw QString("wrong package");
    }
    return jsdoc.object();

}



void NetControl::connectToServer(const QString &server_id, const QString &password)
{
    QMap<QString,QString> server;
    if ( !servers.contains(server_id) ) {
        emit error(QString("No such server: ")+ server_id );
        return;
    }
    server = servers[server_id];
    server["password"] = password;
    servers[server_id] = server;
    current_serv_id = server_id;

    tcpSocket = new QTcpSocket(this);
    connect(tcpSocket, SIGNAL(readyRead()), SLOT(readTCPdata()));
    tcpSocket->connectToHost(server["ip"], server["port"].toInt());
    if (tcpSocket->waitForConnected()) {

    }else {
        emit error("Can't connect to the server");
    }

}
void NetControl::tcp_send(const QMap<QString, QString> &params)
{
    if (tcpSocket) {
      QJsonObject jsobj;
      for (auto k: params.keys()) {
          jsobj[k] = params[k];
      }
      tcpSocket->write(QJsonDocument(jsobj).toJson());
    }else {
      QMap<QString,QString> server = servers[current_serv_id];
      tcpSocket = new QTcpSocket(this);
      connect(tcpSocket, SIGNAL(readyRead()), SLOT(readTCPdata()));
      tcpSocket->connectToHost(server["ip"], server["port"].toInt());
      if (tcpSocket->waitForConnected()) {

      }else {
          emit error("Can't connect to the server");
          tcpSocket=NULL;
      }
    }

}

void NetControl::readTCPdata()
{
  QByteArray data = tcpSocket->readAll();
  QJsonObject jsobj;
  tcpBuffer.append(data);
  qDebug()<<data.length();
  qDebug()<<tcpBuffer.length();
  try {
    jsobj = json_parce(tcpBuffer);
  }catch (QString e) {
      return;
  }
  QString     type = jsobj["type"].toString();
  QString data_str = QString(tcpBuffer);

  tcpBuffer.clear();
  if (type == "auth_key") {
      QMap<QString,QString> server = servers[current_serv_id];
      QString lock = jsobj["lock"].toString();
      QString key = server["password"];
      QCryptographicHash crypto(QCryptographicHash::Sha512);
      crypto.addData(lock.toUtf8());
      crypto.addData(key.toUtf8());
      //qDebug()<<crypto.result().toHex();
      tcp_send({{"type", "auth"}, {"key", crypto.result().toHex()}});
  } else if ( type == "auth") {
      if ( jsobj["result"].toString() == "ok") {
          emit authorized();
          connect(tcpSocket, SIGNAL(disconnected()), SLOT(tcpDisconnected()));
          return;
      }else {
          error("Access DenIEd!");
          return;
      }
  }else if ( type == "files") {
      emit files_received(data_str);
      qDebug("fillles");
  }
}
void NetControl::tcpDisconnected() {
    emit error("Disconnected!");
    tcpSocket=NULL;
}

QJsonObject NetControl::json_parce(const QByteArray &data)
{
    QMap<QString,QString> ret;
    QJsonDocument jsdoc = QJsonDocument::fromJson(data);
    if (jsdoc.isNull()) throw QString("bad data");
    Q_ASSERT(!jsdoc.isNull());
    return jsdoc.object();
}
void NetControl::forward1()
{
    tcp_send({{"type", "forward1"}});
}
void NetControl::forward2()
{
    tcp_send({{"type", "forward2"}});
}
void NetControl::forward3()
{
    tcp_send({{"type", "forward3"}});
}

void NetControl::rewind1()
{
    tcp_send({{"type", "rewind1"}});
}
void NetControl::rewind2()
{
    tcp_send({{"type", "rewind2"}});
}
void NetControl::rewind3()
{
    tcp_send({{"type", "rewind3"}});
}
void NetControl::fullscreen()
{
    tcp_send({{"type", "fullscreen"}});
}
void NetControl::play_pause()
{
    tcp_send({{"type", "play_pause"}});
}
void NetControl::play()
{
    tcp_send({{"type", "play"}});
}
void NetControl::next()
{
    tcp_send({{"type", "prev"}});
}
void NetControl::prev()
{
    tcp_send({{"type", "prev"}});
}
void NetControl::incvol()
{
    tcp_send({{"type", "increase_volume"}});
}
void NetControl::decvol()
{
    tcp_send({{"type", "decrease_volume"}});
}
void NetControl::get_files()
{
    tcp_send({{"type", "ls"}});
}
void NetControl::lsdir(const QString &dir)
{
    tcp_send({{"type", "ls"}, {"path", dir}});
}
void NetControl::play_file(const QString &path)
{
    tcp_send({{"type", "play_file"}, {"path", path}});
}
