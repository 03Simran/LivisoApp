import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

String generateRandomRoomId() {
  final random = Random();
  int randomRoomId = 111112;
  return randomRoomId.toString();
}


class ZegoCloudApi {
  
  static Future<Map<String, dynamic>> createRoom() async {
    String roomId = 'Abcdef';
    final response = await http.get(
      Uri.parse('https://stealth-zys3.onrender.com/api/v1/video/create-room?roomName=$roomId'),
      
    );

    if (response.statusCode == 200) {
      final roomData = json.decode(response.body);
      String roomLink = roomData['joinLink'];
      return {'roomLink': roomLink, 'roomId': roomId};
    } else {
      throw Exception('Failed to create room');
    }
  }
}
