/***********************************************************************
 **
 **   KRT2.h
 **
 **   This file is part of Cumulus
 **
 ************************************************************************
 **
 **   Copyright (c): 2025 by Axel Pauli (kflog.cumulus@gmail.com)
 **
 **   This program is free software; you can redistribute it and/or modify
 **   it under the terms of the GNU General Public License as published by
 **   the Free Software Foundation; either version 2 of the License, or
 **   (at your option) any later version.
 **
 ***********************************************************************/

#pragma once

#include <QtCore>
#include <QTcpSocket>

class KRT2Thread;

class KRT2 : public QObject
{
  Q_OBJECT

  KRT2() = delete;

 private:

  Q_DISABLE_COPY ( KRT2 )

 public:

  KRT2( QObject *parent, QString ip, QString port );

  virtual ~KRT2();

  /**
   * Sets the active frequency on the radio.
   */
  bool setActiveFrequency( const float frequency,
                           const QString& name );
  /**
   * Sets the standby frequency on the radio.
   */
  bool setStandbyFrequency( const float frequency,
                            const QString& name );

  /**
   * Sends the command to the KRT2 device.
   */
  bool sendFrequency( const uint8_t cmd,
                      const float frequency,
                      const QString& name );
  /**
   * Splits the frequency in the desired KRT2 order.
   *
   * @param fin Frequency in MHz
   * @param mhz Megahertz part of the frequency
   * @param channel KRT Channel part of the frequency
   * @return
   */
  bool splitFreqency( const float fin, uint8_t& mhz, uint8_t& channel );

  /**
   * Send the passed data to the KRT-2 device.
   *
   * @param data
   * @return true in case of success otherwise false.
   */
  bool send( QByteArray& data );

  /**
   * Close the socket connection.
   */
  void close();

 public slots:

   /**
    * Try to establish the connection to the KRT2 device.
    */
   void slotConnect();

 private slots:

  /**
  * Setup a ping slot for KRT2 alive check.
  */
  void slotPing();

  /**
   * Called by the socket, when data are received from the KRT2 device.
   */
  void slotHandleRxData();

  /**
   * Handle disconnected signal.
   */
  void slotDisconnected();

 signals:

   void forwardDeviceError( QString error );

  private:

   /**
    * Handle data coming in from the KRT2 device.
    *
    * returns true, if all necessary data are received, otherwise false.
    */
   bool handleSTX();

  // WiFi data
  QString m_ip;
  QString m_port;
  bool m_connected;
  bool m_sychronized;
  QTcpSocket *m_socket;

  QQueue<QByteArray> m_txQueue;
  QByteArray rxBuffer;
  QMutex mutex;
};
