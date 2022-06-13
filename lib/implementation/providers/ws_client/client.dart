import 'package:socket_io_client/socket_io_client.dart';

typedef Handler = dynamic Function(dynamic data);

class WsClient {
  late final Socket _adaptee;

  WsClient(String host) {
    final option = OptionBuilder()
        .setTransports(["websocket"])
        .disableAutoConnect()
        .build();

    _adaptee = io(host, option);
  }

  void on(String event, Handler handler) {
    _adaptee.on(event, handler);
  }

  void connect() {
    _adaptee.connect();
  }

  void onConnect(Handler handler) {
    _adaptee.on("connected-with-auth", handler);
  }

  void disconnect() {
    _adaptee.disconnect();
  }

  void onDisconnect(Handler handler) {
    _adaptee.onDisconnect(handler);
  }
}
