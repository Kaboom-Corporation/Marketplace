import 'package:flutter/material.dart';
// import 'package:placeholder/pages/event_chat/event_chat_cubit.dart';

class MessageEnterWidget extends StatelessWidget {
  MessageEnterWidget({Key? key, required this.sendMessage}) : super(key: key);

  final messageController = TextEditingController();
  final Function sendMessage;

  _sendMessage(BuildContext context) {
    sendMessage(messageController.text);

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[300],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: TextField(
                    controller: messageController,
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      hintText: "сообщение",
                      hintStyle: TextStyle(color: Colors.grey[800], fontSize: 20, fontWeight: FontWeight.w600),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _sendMessage(context);
                },
                icon: Icon(
                  Icons.send,
                  color: Color.fromRGBO(96, 89, 238, 1),
                  size: 30,
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
