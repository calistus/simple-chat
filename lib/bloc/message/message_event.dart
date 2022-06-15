
import 'package:equatable/equatable.dart';

import '../../model/MessageModel.dart';

abstract class MessageEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InitMessages extends MessageEvent{
  final List<MessageModel> initialMessage;
  InitMessages(this.initialMessage);
}

class SendMessage extends MessageEvent{
  final MessageModel message;
  final List<MessageModel> existingMessages;
  SendMessage(this.message, this.existingMessages);
}



