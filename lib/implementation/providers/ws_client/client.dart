import 'package:socket_io_client/socket_io_client.dart';

typedef Handler = dynamic Function(dynamic data);

class WsClient {
  final String host;

  late Socket _adaptee;

  WsClient(this.host);

  void on(String event, Handler handler) {
    _adaptee.on(event, handler);
  }

  void setClient({
    Map<String, String> query = const {},
  }) {
    final option = OptionBuilder()
        .setTransports(["websocket"])
        .setQuery(query)
        .disableAutoConnect()
        .build();

    _adaptee = io(host, option);
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
