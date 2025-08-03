import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';

Future<String?> callAPI(String message) async {
  final url = Uri.parse(SERVER_ADDR);
  // await Future.delayed(Duration(seconds: 1));
  // return null;
  final payload = {
    "input_value": message,
    "output_type": "chat",
    "input_type": "chat"
  };

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['outputs']?[0]?['outputs']?[0]?['results']?['message']?['text'];
      return text;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
