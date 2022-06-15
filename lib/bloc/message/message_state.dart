import 'package:equatable/equatable.dart';
import 'package:idt_messenger/model/MessageModel.dart';
import 'package:meta/meta.dart';

abstract class MessageState extends Equatable {}

class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoading extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoaded extends MessageState {
  final List<MessageModel> messages;

  MessageLoaded(this.messages);

  @override
  List<Object?> get props => [messages, ];
}


class MessageError extends MessageState {
  final String message;

  MessageError({required this.message});

  @override
  List<Object> get props => [message];
}

