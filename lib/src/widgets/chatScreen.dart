import 'dart:async';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:dash_chat/dash_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:swim/src/widgets/titleBar.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String userId;
  final String othername;
  final String otherId;

  ChatScreen(this.username, this.userId, this.othername, this.otherId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  ChatUser user;
  ChatUser otherUser;
  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();
  var i = 0;

  @override
  void initState() {
    super.initState();
    this.user = ChatUser(
      name: widget.username,
      uid: widget.userId,
    );
    this.otherUser = ChatUser(
      name: widget.othername,
      uid: widget.otherId,
    );
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void onSend(ChatMessage message) async {
    print(message.toJson());
    var documentReference = Firestore.instance
        .collection('messages')
        .document(DateTime.now().millisecondsSinceEpoch.toString());

    await Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toJson(),
      );
    });
  }

  Widget sendButtonBuilder(Function func) {
    return IconButton(
      icon: Icon(
        Icons.send,
        color: Colors.black,
      ),
      onPressed: () async {
        func();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(widget.othername),
      body: StreamBuilder(
        stream: Firestore.instance.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          } else {
            List<DocumentSnapshot> items = snapshot.data.documents;
            var messages =
                items.map((i) => ChatMessage.fromJson(i.data)).toList();
            return DashChat(
              key: _chatViewKey,
              user: user,
              messages: messages,
              onSend: onSend,
              sendOnEnter: true,
              sendButtonBuilder: sendButtonBuilder,
              textInputAction: TextInputAction.send,
              inputDecoration: InputDecoration.collapsed(
                hintText: "drip...",
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              alwaysShowSend: true,
              inputTextStyle: TextStyle(fontSize: 16.0, color: Colors.black),
              inputContainerStyle: BoxDecoration(
                border: Border.all(width: 0.0),
                color: Colors.grey,
              ),
              dateFormat: DateFormat('yyyy-MMM-dd'),
              timeFormat: DateFormat('HH:mm'),
              inputMaxLines: 5,
              messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
            );
          }
        },
      ),
    );
  }
}
