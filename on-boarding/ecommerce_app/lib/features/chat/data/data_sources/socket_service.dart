
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class SocketService {
  late IO.Socket socket;

  void connect() async{
      final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('AUTH_TOKEN'); // ✅ Using your key name


    if (token == null) {
      return;
    }

    socket = IO.io(
      'https://g5-flutter-learning-path-be-tvum.onrender.com',
      
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    socket.onConnect((_) {
      print('✅ Socket connected');
    });

    socket.onDisconnect((_) {
      print('❌ Socket disconnected');
    });

    socket.onConnectError((err) {
      print('⚠️ Connect Error: $err');
    });

    socket.onError((err) {
      print('🔥 Socket Error: $err');
    });

    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }
}
