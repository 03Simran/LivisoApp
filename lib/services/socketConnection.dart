import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/services.dart';


class JoinScreen extends StatefulWidget {
  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final serverUrl = 'https://liviso.onrender.com'; // Replace with your server URL
  late IO.Socket socket;
  String shopLink = '';

  @override
  void initState() {
    super.initState();
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    // Retrieve the shopLink from the query parameters
   Future.delayed(Duration.zero, () {
  final arguments = ModalRoute.of(context)?.settings?.arguments;
  if (arguments != null && arguments is Map<String, dynamic> && arguments.containsKey('shopLink')) {
    setState(() {
      shopLink = arguments['shopLink'];
    });
  } else {
    // Handle the case where 'shopLink' is not available or 'arguments' is null
    // You can add appropriate error handling or fallback behavior here.
  }
});


  }

  void _joinShop() {
    // Emit the shopLink to the server
    socket.emit('joinShop', shopLink);

    // Handle the rest of your logic here, e.g., listen for responses
    socket.on('notification', (data) {
      // Handle the owner's response, e.g., show a modal for acceptance/rejection.
      // For simplicity, let's assume the owner accepts the call.
       Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CallScreen(),
            ),
          );
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Shop Link: $shopLink'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _joinShop,
              child: Text('Join Shop'),
            ),
          ],
        ),
      ),
    );
  }
}

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  // Add the necessary logic for video calling in this screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Center(
        child: Text('Video Call Screen'),
      ),
    );
  }
}