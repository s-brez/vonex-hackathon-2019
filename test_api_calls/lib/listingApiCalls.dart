// Tutorial: https://flutter.dev/docs/cookbook/networking/fetch-data
// Another tutorial on Json Serialisation: https://flutter.dev/docs/development/data-and-backend/json


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



String resource = 'listing';
String apiUrl = 'http://localhost:5005/';
Listing queriedListing;

// GET
Future<Listing> fetchListing(String uid, {bool setAsMainListing = false}) async {
  String url = apiUrl + resource + '/' + uid;
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully fetch listing ' + uid);
    print(response.body);
    
    return Listing.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch listing ' + uid);
  }
}

// POST
Future<Listing> createListing(Map<String, dynamic> body ) async {
  String uid = body['uid'];
  String url = apiUrl + resource;
  final response =
      await http.put(url, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully create listing ' + uid);
    print(response.body);
    return Listing.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to create listing ' + body['uid']);
  }
}

// PATCH
Future<Listing> updateListing(Map<String, dynamic> body ) async {
  String uid = body['uid'];
  String url = apiUrl + resource + '/' + uid;
  final response =
      await http.patch(url, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully update listing ' + uid);
    print(response.body);
    return Listing.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to update listing ' + uid);
  }
}

// DELETE
Future<Listing> deleteListing(Map<String, dynamic> body) async {
  String email = body['uid'];
  String url = apiUrl + resource + '/' + email;
  final response =
      await http.delete(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print('Successfully delete listing ' + email);
    return Listing.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to delete listing ' + email);
  }
}


// {
// "_id":"5d8f611ff5ede19064ed2613",
// "uid":"l1","itemid":"h1",
// "listingemail":"steve@gmail.com",
// "location":"12 Abbotsford St Richmond VIC 3121",
// "active":"true",
// "successful":"false",
// "offers":["alice@gmail.com,$120.00",
// "alice@gmail.com,swap"]
// }

class Listing {
  String uid;
  String listingemail;
  String location;
  bool active;
  bool successful;
  List<String> offers;

  Listing({this.uid, this.listingemail, this.location, this.active, this.successful, this.offers});

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      uid: json['uid'],
      listingemail: json['listingemail'],
      location: json['location'],
      active: json['active'],
      successful: json['successful'],
      offers: json['offers'],
    );
  }

  void setActive(bool isActive){
    active =isActive;
  }

  void setSuccessful(bool isSuccessful){
    successful =isSuccessful;
  }

  void addOffer(String newOffer){
    offers.add(newOffer);
  }

  bool removeOffer(String toRemoved){
    return offers.remove(toRemoved);
  }

  bool isActive(){
    return active;
  }

  bool isSuccessful(){
    return successful;
  }
}



