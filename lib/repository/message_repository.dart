import 'dart:convert';
import 'dart:math';

import 'package:idt_messenger/model/InboxModel.dart';

import '../config/api_config.dart';
import '../model/MessageModel.dart';
import 'package:http/http.dart' as http;


class MessageRepository {

  Future<MessageModel> fetchRandomResponse() async {
    var randomNum1 = Random().nextInt(3)+1;
    var randomNum2 = Random().nextInt(2)+0;

    var url = Uri.parse("$baseURL/999$randomNum1.json");
    var response = await http.get(url);

    var formattedResponse = "${response.body.substring(0, response.body.length - 2)}]" ;
    var decoded = jsonDecode(formattedResponse);

    return  MessageModel.fromJson(decoded[randomNum2]) ;
  }

  Future<List<InboxModel>> fetchInbox() async {
      var url = Uri.parse("$baseURL/inbox.json");
      var response = await http.get(url);
      var formattedResponse = "${response.body.substring(0, response.body.length - 3)}]" ;
      var decoded = jsonDecode(formattedResponse);

      return (decoded as List).map((inbox) => InboxModel.fromJson(inbox)).toList();
  }

}
