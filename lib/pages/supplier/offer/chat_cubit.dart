import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketplace/shared/data/message.dart';
import 'package:marketplace/shared/data/offer.dart';
import 'package:marketplace/shared/data/procurement.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(DocumentReference<Map<String, dynamic>> offerRef) : super(ChatLoading(ref: offerRef, procName: "")) {
    getAll();
  }

  getAll() async {
    String procurementName = await state.offerRef.get().then((value) => Offer.fromMap(value.data()!).productName);

    var messageSnapshotsStream =
        state.offerRef.collection('messages').orderBy('timeUnix', descending: true).snapshots();

    emit(ChatLoaded(messageSnapshotsStream: messageSnapshotsStream, ref: state.offerRef, procName: procurementName));
  }

  void sendMessage(String text) async {
    state.offerRef
        .collection('messages')
        .add(Message(text: text, timeUnix: DateTime.now().millisecondsSinceEpoch, byPurchaser: false).toMap());
  }
}

abstract class ChatState {
  DocumentReference<Map<String, dynamic>> offerRef;
  String procName;
  ChatState({
    required this.offerRef,
    required this.procName,
  });
}

class ChatLoading extends ChatState {
  ChatLoading({required DocumentReference<Map<String, dynamic>> ref, required String procName})
      : super(offerRef: ref, procName: procName);
}

class ChatLoaded extends ChatState {
  Stream<QuerySnapshot<Map<String, dynamic>>> messageSnapshotsStream;

  ChatLoaded(
      {required DocumentReference<Map<String, dynamic>> ref,
      required this.messageSnapshotsStream,
      required String procName})
      : super(offerRef: ref, procName: procName);
}
