import 'package:flutter/material.dart';
import '../models/chatModel.dart';
import '../connections/apiCalls.dart';

class ChatViewModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void updateUserMessage(String text) {
    _messages.add(ChatMessage(text: text, isUser: true));
    notifyListeners();
  }

  void sendUserMessage(String userText) async {
    _messages.add(ChatMessage(isLoading: true, text: "...", loadingMessage: ""));
    notifyListeners();

    final result = await callAPI(userText);
    _messages.removeWhere((m) => m.isLoading);
    if (result == null) {
      _messages.add(ChatMessage(
          text: 'Something Went Wrong. Try again Later',
          isEnded: true)
      );
    }
    else {
      _messages.add(ChatMessage(text: result, isUser: false));
    }

    notifyListeners();
  }
}
