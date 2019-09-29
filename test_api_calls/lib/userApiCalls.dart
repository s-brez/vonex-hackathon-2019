// Tutorial: https://flutter.dev/docs/cookbook/networking/fetch-data
// Another tutorial on Json Serialisation: https://flutter.dev/docs/development/data-and-backend/json


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

// User API returns a data model like this
// {
//   "_id":"5d8d747533343a7fd1e1530c",
// "email":"steve@gmail.com",
// "firstname":"Steve",
// "lastname":"Smith",
// "password":"Password",
// "picker":"true",
// "packer":"true",
// "fb":"/ssmith_fb_url",
// "insta":"/ssmith_fb_url",
// "saveditems":["h1","a1"],
// "listings":["l4","l5","l6"]
// }

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



