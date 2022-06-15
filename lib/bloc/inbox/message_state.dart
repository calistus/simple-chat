import 'package:equatable/equatable.dart';
import 'package:idt_messenger/model/InboxModel.dart';

abstract class InboxState extends Equatable {}

class InboxInitial extends InboxState {
  @override
  List<Object> get props => [];
}

class InboxLoading extends InboxState {
  @override
  List<Object> get props => [];
}

class InboxLoaded extends InboxState {
  final List<InboxModel> Inbox;

  InboxLoaded(this.Inbox);

  @override
  List<Object?> get props => [Inbox, ];
}


class InboxError extends InboxState {
  String Inbox;

  InboxError({required this.Inbox});

  @override
  List<Object> get props => [Inbox];
}