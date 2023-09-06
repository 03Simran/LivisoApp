import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

var uuid = Uuid();

Future<String> loadUserId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var userId;
  if (sharedPreferences.containsKey("userId")) {
    userId = sharedPreferences.getString("userId"); // Corrected key
  } else {
    userId = uuid.v4();
    sharedPreferences.setString("userId", userId);
  }
  return userId;
}
