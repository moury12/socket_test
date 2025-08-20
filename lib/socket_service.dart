import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  void connect(String userId) {
    if (socket != null) {
      try {
        socket!.clearListeners();
        socket!.disconnect();
        socket!.destroy();
      } catch (e) {
        print('Error while cleaning old socket: $e');
      }
      socket = null;
      print('🔥 Old socket destroyed');
    }

    socket = IO.io(
      'http://18.211.171.8:8001',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'userId': userId})
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();

    socket!.once('connect', (_) {
      print('✅ Connected to socket with userId: $userId');
    });

    socket!.once('disconnect', (_) {
      print('❌ Disconnected from socket');
    });

    socket!.on('message', (data) {
      print('📩 Received message: $data');
    });
  }

  void disconnect() {
    if (socket != null) {
      try {
        socket!.clearListeners();
        socket!.disconnect();
        socket!.destroy();
      } catch (e) {
        print('Error while disconnecting: $e');
      }
      socket = null;
      print('❌ Disconnected from socket server');
    }
  }
}
