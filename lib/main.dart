import 'package:flutter/material.dart';
import 'socket_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socket Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SocketTestPage(),
    );
  }
}

class SocketTestPage extends StatefulWidget {
  @override
  _SocketTestPageState createState() => _SocketTestPageState();
}

class _SocketTestPageState extends State<SocketTestPage> {
  final SocketService socketService = SocketService();
  final TextEditingController userIdController = TextEditingController();

  @override
  void dispose() {
    // Disconnect from the socket when the widget is disposed
    socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: 'Enter User ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String userId = userIdController.text;
                if (userId.isNotEmpty) {
                  print("--------------------------------$userId");
                  socketService.connect(userId);  // Connect with new userId
                } else {
                  print('User ID cannot be empty');
                }
              },
              child: Text('Connect to Socket'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                socketService.disconnect();  // Disconnect the current socket
              },
              child: Text('Disconnect from Socket'),
            ),
          ],
        ),
      ),
    );
  }
}

