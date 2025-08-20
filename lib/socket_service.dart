import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  void connect(String userId) {
    if (socket != null) {
      try {
        disconnect();
      } catch (e) {
        print('Error while cleaning old socket: $e');
      }
      socket = null;
      print('🔥 Old socket destroyed');
    }
    final Map<String, dynamic> options = {
      'transports': ['websocket'],
      'autoConnect': true,       // Equivalent to .disableAutoConnect()
      'query': {'userId': userId},
      'forceNew': true,           // 👈 THE FIX: Pass 'forceNew' as a key in the map
    };
    socket = IO.io(
      'http://18.211.171.8:8001',
options
    );

    socket!.connect();

    socket!.once('connect', (_) {
      print('✅ Connection successful!');
      print("👉 Connected with socket ID: ${socket?.id}");
      print("👉 Current query params: ${socket?.io.options?['query']}");

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
        socket!.dispose();
      } catch (e) {
        print('Error while disconnecting: $e');
      }
      socket = null;
      print('❌ Disconnected from socket server');
    }
  }
}
