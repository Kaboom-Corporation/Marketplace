import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/purchaser/offer/chat_cubit.dart';
import 'package:marketplace/pages/purchaser/offer/message_enter_widget.dart';
import 'package:marketplace/pages/purchaser/offer/message_widget.dart';
import 'package:marketplace/pages/purchaser/procurement/procurement_nav.dart';
import 'package:marketplace/shared/data/message.dart';
import 'package:marketplace/shared/div.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const ProcurementNav(),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  child: const _ChatSection())),
        ],
      ),
    );
  }
}

class _ChatSection extends StatelessWidget {
  const _ChatSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
                return Text(state.procName, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 50));
              }),
            ],
          ),
          Container(height: 30),
          Row(
            children: const [
              Div(),
            ],
          ),
          Container(height: 30),
          BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
            if (state is ChatLoaded) {
              return _ChatMessages(
                messgeStream: state.messageSnapshotsStream,
              );
            }
            return Container();
          }),
          MessageEnterWidget(sendMessage: BlocProvider.of<ChatCubit>(context).sendMessage),
        ],
      ),
    );
  }
}

class _ChatMessages extends StatelessWidget {
  const _ChatMessages({Key? key, required this.messgeStream}) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> messgeStream;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: messgeStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(0),
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return MessageWidget(message: Message.fromMap(snapshot.data!.docs[index].data()));
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
