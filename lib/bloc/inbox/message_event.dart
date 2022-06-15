
import 'package:equatable/equatable.dart';

abstract class InboxEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchInbox extends InboxEvent{
  FetchInbox();
}

