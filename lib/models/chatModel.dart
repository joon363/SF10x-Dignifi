class ChatMessage {
  final String text;
  final bool isUser;
  final bool isLoading;
  final bool isEnded;
  final String loadingMessage;

  ChatMessage({
    required this.text,
    this.isUser = false,
    this.isLoading = false,
    this.isEnded = false,
    this.loadingMessage = "",
  });
}
