import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer _getYesNoAnswer = GetYesNoAnswer();
  List<Message> messageList = [
    Message(text: 'Hola que tal?', fromWho: FromWho.me),
    Message(text: 'donde estas?', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    if (text.endsWith('?')) {
      herReply();
    }

    notifyListeners();
    scrollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await _getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();
    scrollToBottom();
  }

  Future<void> scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    var scrollTo = chatScrollController.position.maxScrollExtent > 0
        ? chatScrollController.position.extentTotal
        : 0.0;
    chatScrollController.animateTo(
      scrollTo,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
