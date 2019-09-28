// Tutorial: https://flutter.dev/docs/cookbook/networking/fetch-data
// Another tutorial on Json Serialisation: https://flutter.dev/docs/development/data-and-backend/json


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

[{"_id":"5d8f6148f5ede19064ed2619","Time":"","to":"alice@gmail.com","from":"steve@gmail.com","text":"Hi Alice, I am interested in your Vintage Lamp item, would you consider a trade for my toaster oven?"},{"_id":"5d8f6148f5ede19064ed261a","Time":"","to":"steve@gmail.com","from":"alice@gmail.com","text":"Steve, I might like your toaster oven, could you please list it here on Up-Cycle via 'Add Listing' so I can have a little more info?"}]

String resource = 'user';
String apiUrl = 'http://localhost:5005/';
User mainUser;

// GET
Future<User> fetchUser(String email, {bool setAsMainUser = false}) async {
  String url = apiUrl + resource + '/' + email;
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    if (setAsMainUser){
      mainUser = User.fromJson(json.decode(response.body));
      print('Successfully fetch user ' + email);
      print(response.body);
      return mainUser;
    }
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch user ' + email);
  }
}

// POST
Future<User> createUser(Map<String, dynamic> body ) async {
  String email = body['email'];
  String url = apiUrl + resource;
  final response =
      await http.put(url, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully create user ' + email);
    print(response.body);
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to create user ' + body['email']);
  }
}

// PATCH
Future<User> updateUser(Map<String, dynamic> body ) async {
  String email = body['email'];
  String url = apiUrl + resource + '/' + email;
  final response =
      await http.patch(url, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully update user ' + email);
    print(response.body);
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to update user ' + email);
  }
}

// DELETE
Future<User> deleteUser(Map<String, dynamic> body) async {
  String email = body['email'];
  String url = apiUrl + resource + '/' + email;
  final response =
      await http.delete(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully delete user ' + email);
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to delete user ' + email);
  }
}

class User {
  String email;
  String firstname;
  String lastname;
  String password;
  bool picker;
  bool packer;
  String fb;
  String insta;
  List<String> savedItems;
  List<String> listings; 

  User({this.email, this.firstname, this.lastname, this.password, this.picker, this.packer, this.fb, this.insta, this.savedItems, this.listings});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstname: json['firstname'],
      lastname: json['lastname'],
      password: json['password'],
      picker: json['picker'],
      packer: json['packer'],
      fb: json['fb'],
      insta: json['insta'],
      savedItems: json['savedItems'],
      listings: json['listings'],
    );
  }

  void updatePassword(String newPassword){
    password = newPassword;
  }

  void addSavedItem(String newItem){
    savedItems.add(newItem);
  }

  bool removeSavedItem(String toRemoved){
    return savedItems.remove(toRemoved);
  }

  void addListings(String newListing){
    listings.add(newListing);
  }

  bool removeListings(String toRemoved){
    return listings.remove(toRemoved);
  }
}



