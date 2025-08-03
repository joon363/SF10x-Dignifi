import 'package:flutter/material.dart';
import 'package:reentry/theme.dart';
import 'package:reentry/models/chatModel.dart';
import 'package:reentry/viewModels/chatViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:math' as math;


class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text("AI Chatbot",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            centerTitle: true,
          ),
          body: ChatArea(),
        )
      ),
    );
  }
}

class ChatArea extends StatefulWidget{
  const ChatArea({super.key});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        vm.messages.isEmpty ? HelpPrompt() :
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: vm.messages.length,
              itemBuilder: (context, index) {
                return buildMessage(vm.messages[index]);
              },
            ),
          ),

        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 0),
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(8),
            decoration: grayBoxDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: TextField(
                    controller: _controller,
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: '"What should I do next?"',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: primaryColor, size: 30,),
                  onPressed: () async {
                    final userText = _controller.text.trim();
                    FocusScope.of(context).unfocus();
                    if (userText.isEmpty) return;
                    _controller.clear();

                    vm.updateUserMessage(userText);

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                        Future.delayed(Duration(milliseconds: 50), () {
                            _scrollToBottom();
                          });
                      });

                    vm.sendUserMessage(userText);

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                        Future.delayed(Duration(milliseconds: 50), () {
                            _scrollToBottom();
                          });
                      });
                  },
                ),
              ],
            )
          )
        )
      ],
    );
  }
}

class HelpPrompt extends StatelessWidget {
  const HelpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Column(
        children: [
          Text(
            'How can I help you?',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: primaryColor,
            ),
          ),
          Text(
            'Ask Everything.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: primaryColorLight,
            ),
          ),
        ],
      )
    );
  }
}

Widget buildMessage(ChatMessage message) {
  final isUser = message.isUser;
  final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
  final crossAlignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  final textColor = isUser ? Colors.white : Colors.black87;

  Widget botLogo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SvgPicture.asset(width: 30, height: 30, 'assets/images/logo.svg'),
    );
  }

  Widget spinningImage() {
    return Row(
      spacing: 10,
      children: [
        SizedBox(width: 10,),
        SpinningImage(
          imagePath: 'assets/images/loading.png',
        ),
      ],
    );
  }
  Widget messageBox(bool isUser) {
    if (isUser) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: primaryBoxDecoration,
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w500
          ),
        )
      );
    } else {
      return Markdown(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        data: message.text,
        styleSheet: MarkdownStyleSheet(
          p: TextStyle(fontSize: 16)
        )
      );
    }
  }
  return Align(
    alignment: alignment,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: crossAlignment,
        children: [
          if(!message.isUser) botLogo(),
          message.isLoading ? spinningImage() : messageBox(isUser),
        ],
      ),
    )
  );
}

class SpinningImage extends StatefulWidget {
  final String imagePath;
  final double size;
  final Duration duration;

  const SpinningImage({
    super.key,
    required this.imagePath,
    this.size = 40.0,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<SpinningImage> createState() => _SpinningImageState();
}

class _SpinningImageState extends State<SpinningImage>
  with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: Image.asset(widget.imagePath),
      ),
    );
  }
}
