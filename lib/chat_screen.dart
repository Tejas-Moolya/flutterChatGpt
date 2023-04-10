import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:hr_management_app/three_dot.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMesage> _message = [];
  final TextEditingController _controller = TextEditingController();
  final _openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: Duration(seconds: 20)));
  StreamSubscription? _subscription;
  bool isTyping = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _openAI.close();
    super.dispose();
  }

  void _sendMessage() {
    ChatMesage mesage = ChatMesage(text: _controller.text, sender: "user");

    setState(() {
      isTyping = true;
      _message.insert(0, mesage);
    });

    _controller.clear();

    final request =
        CompleteText(prompt: mesage.text, model: kTextDavinci3, maxTokens: 200);

    _subscription?.cancel();
    _subscription =
        _openAI.onCompletionStream(request: request).listen((response) {
      Vx.log(response!.choices[0].text);

      String botText = response.choices[0].text.trim();
      if (_message.isNotEmpty && _message.first.text == botText) {
        // Do not add the same response multiple times
        return;
      }
      ChatMesage botMessage =
          ChatMesage(text: response.choices[0].text, sender: "bot");

      setState(() {
        isTyping = false;
        _message.insert(0, botMessage);
      });
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration:
                const InputDecoration.collapsed(hintText: "send message"),
          ),
        ),
        IconButton(
            onPressed: () {
              _sendMessage();
            },
            icon: const Icon(Icons.send))
      ],
    ).px20();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Center(child: Text("Stress control chat bot"))),
      body: SafeArea(
        child: Column(children: [
          Flexible(
              child: ListView.builder(
                  reverse: true,
                  padding: Vx.m8,
                  itemCount: _message.length,
                  itemBuilder: (context, index) {
                    return _message[index];
                  })),
          if (isTyping) ThreeDots(),
          Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(color: context.cardColor),
            child: _buildTextComposer(),
          )
        ]),
      ),
    );
  }
}
