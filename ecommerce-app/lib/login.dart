import 'package:flutter/material.dart';

import 'signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO: Add text editing controllers (101)
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
                Text('UP-CYCLE',
                style: TextStyle(fontSize: 30.0)),
              ],
            ),
            SizedBox(height: 120.0),
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            // TODO: Wrap Password with AccentColorOverride (103)


            // TODO: Add TextField widgets (101)
            // [Name]
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
                  child: Text('SIGN UP'),
                  onPressed: () {
                    // TODO: Clear the text fields (101)
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => SignupPage()),
                     );
                  },
                ),
                // TODO: Add an elevation to NEXT (103)
                // TODO: Add a beveled rectangular border to NEXT (103)
                RaisedButton(
                  child: Text('NEXT'),
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