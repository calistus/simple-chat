/// id : "9991"
/// last_message : "How about tomorrow then?"
/// members : ["John","Daniel","Rachel"]
/// topic : "pizza night"
/// modified_at : 1599814026153

class InboxModel {
  InboxModel({
      this.id, 
      this.lastMessage, 
      this.members, 
      this.topic, 
      this.modifiedAt,});

  InboxModel.fromJson(dynamic json) {
    id = json['id'];
    lastMessage = json['last_message'];
    members = json['members'] != null ? json['members'].cast<String>() : [];
    topic = json['topic'];
    modifiedAt = json['modified_at'];
  }
  String? id;
  String? lastMessage;
  List<String>? members;
  String? topic;
  int? modifiedAt;
InboxModel copyWith({  String? id,
  String? lastMessage,
  List<String>? members,
  String? topic,
  int? modifiedAt,
}) => InboxModel(  id: id ?? this.id,
  lastMessage: lastMessage ?? this.lastMessage,
  members: members ?? this.members,
  topic: topic ?? this.topic,
  modifiedAt: modifiedAt ?? this.modifiedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['last_message'] = lastMessage;
    map['members'] = members;
    map['topic'] = topic;
    map['modified_at'] = modifiedAt;
    return map;
  }

}