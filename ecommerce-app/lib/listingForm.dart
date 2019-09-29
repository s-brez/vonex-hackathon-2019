// name
// description
// category
// Image

// location

import 'package:flutter/material.dart';

class ListingForm extends StatefulWidget {
  @override
  _ListingFormState createState() => _ListingFormState();
}

class _ListingFormState extends State<ListingForm> {
  // TODO: Add text editing controllers (101)
  final _nameController = TextEditingController();
  final _descriptionControlller = TextEditingController();
  final _categoryControlller = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _locationController = TextEditingController();
  // final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/logo.png'),
                ),
                //Image.asset('assets/logo.png'),
                SizedBox(height: 16.0),
                Text('Sign-up',
                style: TextStyle(fontSize: 30.0)),
              ],
            ),
            SizedBox(height: 120.0),
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            // TODO: Wrap Password with AccentColorOverride (103)


            // [First name]
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'First name',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Last name]
            TextField(
              controller: _descriptionControlller,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Last name',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Email]
            TextField(
              controller: _categoryControlller,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Address]
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Username]
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            
            
            
            // TODO: Add button bar (101)
            ButtonBar(
              // TODO: Add a beveled rectangular border to CANCEL (103)
              children: <Widget>[

                // TODO: Add buttons (101)
                FlatButton(
                  child: Text('BACK TO LOGIN'),
                  onPressed: () {
                    // TODO: Clear the text fields (101)
                     _locationController.clear();
                  
                  },
                ),
                // TODO: Add an elevation to NEXT (103)
                // TODO: Add a beveled rectangular border to NEXT (103)
                RaisedButton(
                  child: Text('CONTINUE'),
                  onPressed: () {
                    // TODO: Show the next page (101) 
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)