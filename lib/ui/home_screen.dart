import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idt_messenger/model/InboxModel.dart';
import 'package:idt_messenger/ui/detail_screen.dart';
import 'package:idt_messenger/utilities/ui_utils.dart';

import '../bloc/inbox/message_bloc.dart';
import '../bloc/inbox/message_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("IDT Messenger")),
      body: BlocConsumer<InboxBloc, InboxState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InboxLoading) {
            UIUtils.showSimpleLoader();
          } else if (state is InboxError) {
            UIUtils.showError(state.Inbox);
          } else if (state is InboxLoaded) {
            return inboxList(state.Inbox);
          }
          return Container();
        },
      ),
    );
  }
}

Widget inboxList(List<InboxModel> inbox) {
  return ListView.builder(
    itemCount: inbox.length,
    itemBuilder: (context, index) {
      return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(inbox: inbox[index], index: index),
              ));
        },
        title: Text(inbox[index].topic!),
        subtitle: Text(inbox[index].lastMessage!),
        leading: const CircleAvatar(
          backgroundImage: NetworkImage("https://random.imagecdn.app/500/150"),
        ),
      );
    },
  );
}
