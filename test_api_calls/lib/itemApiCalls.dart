// Tutorial: https://flutter.dev/docs/cookbook/networking/fetch-data
// Another tutorial on Json Serialisation: https://flutter.dev/docs/development/data-and-backend/json


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



String resource = 'item';
String apiUrl = 'http://localhost:5005/';
Item queriedItem;

// GET
Future<Item> fetchItem(String uid) async {
  String url = apiUrl + resource + '/' + uid;
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully fetch item ' + uid);
    print(response.body);
    return Item.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch item ' + uid);
  }
}

// POST
Future<Item> createItem(Map<String, dynamic> body ) async {
  String uid = body['uid'];
  String url = apiUrl + resource;
  final response =
      await http.put(url, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully create item ' + uid);
    print(response.body);
    return Item.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to create item ' + body['uid']);
  }
}

// PATCH
Future<Item> updateItem(Map<String, dynamic> body ) async {
  String uid = body['uid'];
  String url = apiUrl + resource + '/' + uid;
  final response =
      await http.patch(url, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully update item ' + uid);
    print(response.body);
    return Item.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to update item ' + uid);
  }
}

// DELETE
Future<Item> deleteItem(Map<String, dynamic> body) async {
  String uid = body['uid'];
  String url = apiUrl + resource + '/' + uid;
  final response =
      await http.delete(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully delete item ' + uid);
    return Item.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to delete item ' + uid);
  }
}


// Item API returns a data model like this
// {
//   "_id":"5d8d746d33343a7fd1e15306",
// "uid":"h1",
// "name":"Vintage wooden lamp",
// "description":"A peak example of heritage-era lighting.",
// "category":"Homeware"
// }

class Item {
  String uid;
  String name;
  String description;
  String category;

  Item({this.uid, this.name, this.description, this.category});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'],
      category: json['category'],
    );
  }

  void updateDescription(String newDescription){
    category = newDescription;
  }
}



