/// id : "1003"
/// message : "How about tomorrow then?"
/// modified_at : 1599814026153
/// sender : "John"

class MessageModel {
  MessageModel({
      this.id, 
      this.message, 
      this.modifiedAt, 
      this.sender,});

  MessageModel.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    modifiedAt = json['modified_at'];
    sender = json['sender'];
  }
  String? id;
  String? message;
  int? modifiedAt;
  String? sender;
MessageModel copyWith({  String? id,
  String? message,
  int? modifiedAt,
  String? sender,
}) => MessageModel(  id: id ?? this.id,
  message: message ?? this.message,
  modifiedAt: modifiedAt ?? this.modifiedAt,
  sender: sender ?? this.sender,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['modified_at'] = modifiedAt;
    map['sender'] = sender;
    return map;
  }

}