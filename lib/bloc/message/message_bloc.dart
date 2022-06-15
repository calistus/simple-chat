import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idt_messenger/model/InboxModel.dart';
import 'package:idt_messenger/model/MessageModel.dart';

import '../../repository/message_repository.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository repository;

  MessageBloc({required this.repository}) : super(MessageInitial()) {
    on<InitMessages>(_onInitMessages);
    on<SendMessage>(_onSendMessage);
  }

  _onInitMessages(InitMessages event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      emit(MessageLoaded(event.initialMessage));
    } catch (e) {
      emit(MessageError(message: e.toString()));
    }
  }

  _onSendMessage(SendMessage event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    event.existingMessages.insert(0, event.message);
    emit(MessageLoaded(event.existingMessages));
    try {
      MessageModel response = await repository.fetchRandomResponse();
      Future.delayed(const Duration(seconds: 2));
      emit(MessageLoading());
      event.existingMessages.insert(0, response);

      emit(MessageLoaded(event.existingMessages));
    } catch (e) {
      emit(MessageError(message: e.toString()));
    }
  }
}
