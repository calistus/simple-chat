import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idt_messenger/bloc/inbox/message_event.dart';
import 'package:idt_messenger/bloc/message/message_bloc.dart';
import 'package:idt_messenger/repository/message_repository.dart';
import 'package:idt_messenger/ui/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/inbox/message_bloc.dart';
import 'bloc/simple_bloc_observer.dart';

void main() {
  // Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<InboxBloc>(create: (context) => InboxBloc(repository: MessageRepository())..add(FetchInbox()),),
      // BlocProvider<MessageBloc>(create: (context) => MessageBloc(repository: MessageRepository()),),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IDT Messenger',
        theme: ThemeData(
          fontFamily: 'Mont',
          appBarTheme: AppBarTheme(
            color: Colors.orange,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}