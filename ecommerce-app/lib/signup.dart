import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // TODO: Add text editing controllers (101)
  final _firstnameController = TextEditingController();
  final _lastnameControlller = TextEditingController();
  final _emailControlller = TextEditingController();
  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
              controller: _firstnameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'First name',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Last name]
            TextField(
              controller: _lastnameControlller,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Last name',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Email]
            TextField(
              controller: _emailControlller,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Address]
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Username]
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            // spacer
            SizedBox(height: 12.0),

            // [Password]
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            
            
            // TODO: Add button bar (101)
            ButtonBar(
              // TODO: Add a beveled rectangular border to CANCEL (103)
              children: <Widget>[

                // TODO: Add buttons (101)
                FlatButton(
                  child: Text('BACK TO LOGIN'),
                  onPressed: () {
                    // TODO: Clear the text fields (101)
                     _usernameController.clear();
                    _passwordController.clear();
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