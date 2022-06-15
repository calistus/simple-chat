import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idt_messenger/model/InboxModel.dart';

import '../../repository/message_repository.dart';
import 'message_event.dart';
import 'message_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  MessageRepository repository;

  InboxBloc({required this.repository}) : super(InboxInitial()) {
    on<FetchInbox>(_onFetchInbox);
  }

  _onFetchInbox(FetchInbox event, Emitter<InboxState> emit) async {
    emit(InboxLoading());
    try {
      List<InboxModel> inbox = await repository.fetchInbox();
      emit(InboxLoaded(inbox));
    } catch (e) {
      emit(InboxError(Inbox: e.toString()));
    }
  }

}
