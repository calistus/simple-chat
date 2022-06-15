import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idt_messenger/bloc/message/message_bloc.dart';
import 'package:idt_messenger/bloc/message/message_event.dart';
import 'package:idt_messenger/bloc/message/message_state.dart';
import 'package:idt_messenger/model/InboxModel.dart';
import 'package:idt_messenger/repository/message_repository.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';

import '../bloc/inbox/message_bloc.dart';
import '../model/MessageModel.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final InboxModel inbox;

  const DetailScreen({Key? key, required this.index, required this.inbox})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String imageUrl;
  late bool isLoading;
  late String channelID;
  TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ScrollController listScrollController = ScrollController();
  late MessageBloc messageBloc;
  var textHeading =
      TextStyle(color: Colors.black, fontSize: 20); // Text style for the name

  var textStyle = TextStyle(color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc(repository: MessageRepository())
        ..add(InitMessages([
          MessageModel(
              message: widget.inbox.lastMessage,
              id: const Uuid().v1(),
              sender: widget.inbox.members![0])
        ])),
      child: Builder(
        builder: (context) {
          messageBloc = BlocProvider.of<MessageBloc>(context);
          return Scaffold(
            appBar: AppBar(
                title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(widget.inbox.topic!, style: textHeading),
                Column(
                  children: [
                    Container(
                        height: 23,
                        padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.inbox.members!.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            )),
            body: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessageLoaded) {
                  buildMessage(state);
                }
                return buildMessage(state);
              },
            ),
          );
        },
      ),
    );
  }

  Stack buildMessage(MessageState state) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 78.0),
              child: state is MessageLoaded
                  ? messageList(state.messages)
                  : Container(),
            )),
        Align(alignment: Alignment.bottomCenter, child: typeArea(state)),
      ],
    );
  }

  Widget typeArea(MessageState state) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: TextFormField(
                  validator: (input) =>
                      input!.isEmpty ? "Type your message here" : null,
                  controller: messageController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    border: InputBorder.none,
                  )
                  // hintText: 'while'),
                  ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              state is MessageLoaded
                  ? sendMessage(state.messages)
                  : MessageModel(
                      message: widget.inbox.lastMessage,
                      id: const Uuid().v1(),
                      sender: widget.inbox.members![0]);
              messageController.clear();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
              decoration: BoxDecoration(
                  color: Colors.orange, shape: BoxShape.circle),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 26,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget messageList(List<MessageModel> messages) {
    // messages.reversed.toList();
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) =>
          chatItem(messages[index], messages[index].sender == "me"),
      itemCount: messages.length,
      reverse: true,
      controller: listScrollController,
    );
  }

  void sendMessage(List<MessageModel> existingMessages) {
    var uuid = const Uuid();
    MessageModel message = MessageModel(
        message: messageController.text,
        sender: "me",
        modifiedAt: DateTime.now().millisecondsSinceEpoch,
        id: uuid.v1());

    if (_formKey.currentState!.validate()) {
      messageBloc.add(SendMessage(message, existingMessages));
    }
  }

  Widget chatItem(MessageModel message, bool isMe) {
    return Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, top: 4),
            child: Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200,
                  decoration: isMe
                      ? BoxDecoration(
                          color: Color(0xffDFDFDF),
                          borderRadius: BorderRadius.circular(8.0))
                      : BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8.0)),
                  margin: isMe
                      ? EdgeInsets.only(right: 10.0)
                      : EdgeInsets.only(left: 10.0),
                  child: Container(
                    child: Padding(
                      padding: isMe
                          ? const EdgeInsets.only(right: 10.0)
                          : const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message.message!,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // Text(timeago.format(
                          //     DateTime.fromMicrosecondsSinceEpoch(
                          //         message.modifiedAt!)))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
