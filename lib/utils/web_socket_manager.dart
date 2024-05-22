import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  late WebSocketChannel _channel;
  late WebSocket _webSocket;
  RxString receivedMessage = "".obs; // This full response comes from websocket
  RxInt yourJsonKeyValue =
      0.obs; // collecting any particular value from socket response

  Future<void> connectWebSocket() async {
    List<String> urls = [
      'your-websocket-url', //  socket url 1
      'your-websocket-url', //  socket url 2
    ];
    for (var url in urls) {
      try {
        _webSocket = await WebSocket.connect(url);
        _channel = IOWebSocketChannel(_webSocket);

        _channel.stream.listen(
          (message) {
            _parseReceivedMessage(message); // your particular value
            receivedMessage.value = message; // main response
          },
          onError: (err) {
            connectWebSocket();
          },
          onDone: () {
            connectWebSocket();
          },
          cancelOnError: true,
        );
        Logger().i('WebSocket connection established in: $url');
      } catch (e) {
        connectWebSocket();
        Logger().e('WebSocket connection failed: $e');
      }
    }
  }

  // Decoding main socket response to get particular value
  void _parseReceivedMessage(String message) {
    Logger().d('Received message: $message');
    final Map<String, dynamic> data = jsonDecode(message);
    if (data.containsKey('json_key')) {
      yourJsonKeyValue.value = data['json_key'];
      Logger().d(yourJsonKeyValue.value);
    }
  }

  void sendMessage(String message) {
    if (_webSocket.readyState == WebSocket.open) {
      _webSocket.add(message);
    } else {
      Logger().e('WebSocket is not open.');
    }
  }

  void closeWebSocket() {
    _channel.sink.close();
    Logger().i("WebSocket connection closed!");
  }
}

// TODO: how to use ?
// call WebsocketManager.connectWebSocket()  into any getx controller onReady methode to initiate websocket
