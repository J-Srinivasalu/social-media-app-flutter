// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOService {
  IO.Socket? socket;

  void initializeSocketIO(String? token) {
    debugPrint("socket io initialization started.....");
    debugPrint("i got here: $token");
    socket = IO.io(
      rootApiUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']).setAuth({"token": token}).build(),
    );

    // socket?.connect();
    debugPrint("Socket connected: ${socket?.connected}");
    socket?.onConnecting((data) => debugPrint("connecting...$data"));
    socket?.onConnect((data) => debugPrint("connected...$data"));

    // setting up listeners
  }

  bool isConnected() {
    return socket?.connected == true;
  }
}
