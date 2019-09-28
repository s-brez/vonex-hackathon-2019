// Tutorial: https://flutter.dev/docs/cookbook/networking/fetch-data
// Another tutorial on Json Serialisation: https://flutter.dev/docs/development/data-and-backend/json


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


String resource = 'messages';
String apiUrl = 'http://localhost:5005/';
Message allMessages;



// GET all messages in the db
Future<Message> fetchAllMessages() async {
  String url = apiUrl + resource;
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully fetch all messages');
    print(response.body);

    return Message.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch all messages in the db');
  }
}

// GET
Future<Message> fetchMessage(String emailSender, {String emailReceiver, int loadLimit = 1000}) async {
  String url = apiUrl + resource + '/' + emailSender;
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
      print('Successfully fetch messages sent by' + emailSender);
      print(response.body);

    return Message.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch messages sent by' + emailSender);
  }
}

// POST
Future<Message> createMessage(Map<String, dynamic> body ) async {
  String toEmail = body['to'];
  String fromEmail = body['from'];
  String url = apiUrl + resource;
  final response =
      await http.put(url, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully create messages sent by ' + fromEmail + ' to ' + toEmail);
    print(response.body);
    return Message.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to create messages sent by ' + fromEmail + ' to ' + toEmail);
  }
}

// PATCH - No patch method. Messages cannot be edited.
// Future<Message> updateMessage(Map<String, dynamic> body ) async {
//   String toEmail = body['to'];
//   String fromEmail = body['from'];
//   String url = apiUrl + resource + '/' + email;
//   final response =
//       await http.patch(url, body: body);

//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON.
//     print('Successfully update messages ' + email);
//     print(response.body);
//     return Message.fromJson(json.decode(response.body));
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to update messages ' + email);
//   }
// }

// DELETE - probably not necessary to have
// Future<Message> deleteMessage(Map<String, dynamic> body) async {
//   String email = body['email'];
//   String url = apiUrl + resource + '/' + email;
//   final response =
//       await http.delete(url);

//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON.
//     print('Successfully delete messages ' + email);
//     return Message.fromJson(json.decode(response.body));
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to delete messages ' + email);
//   }
// }

// JSon Structure of a message
// [
//   {
// "_id":"5d8f6148f5ede19064ed2619",
// "Time":"",
// "to":"alice@gmail.com",
// "from":"steve@gmail.com",
// "text":"Hi Alice, I am interested in your Vintage Lamp item, would you consider a trade for my toaster oven?"},

// {"_id":"5d8f6148f5ede19064ed261a",
// "Time":"",
// "to":"steve@gmail.com",
// "from":"alice@gmail.com",
// "text":"Steve, I might like your toaster oven, could you please list it here on Up-Cycle via 'Add Listing' so I can have a little more info?"
// }
// ]

class Message {
  final String Time;
  final String to;
  final String from;
  final String text;

  Message({this.Time, this.to, this.from, this.text});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      Time: json['Time'],
      to: json['to'],
      from: json['from'],
      text: json['text'],
    );
  }
}



