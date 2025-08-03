import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reentry/datas/taskData.dart';
import 'package:reentry/models/taskModel.dart';
import 'config.dart';

List<TaskGroup> getGroupsData() {
  final List<dynamic> data = jsonDecode(dummyStepsResponseJson);
  List<TaskGroup> groups =
    data.map((e) => TaskGroup.fromJson(e)).toList();
  return groups;
}

Future<String?> sendChatbotRequestAPI(String message) async {
  final url = Uri.parse(SERVER_ADDR);
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

