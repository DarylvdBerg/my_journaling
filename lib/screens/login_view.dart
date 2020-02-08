import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_journaling/screens/register_view.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/util/app_colors.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _email, _password = '';

  AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Container(
        color: AppColor.ACCENTCOLOR,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Image(
                image: AssetImage("assets/app_logo.png"),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) {
                      if (!EmailValidator.validate(input)) {
                        return 'Invalid email address';
                      }

                      if (input.isEmpty) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onChanged: (input) {
                      setState(() => _email = input);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Please enter a password';
                      }

                      if (input.length < 6) {
                        return 'Password must be atleast 6 characters';
                      }
                      return null;
                    },
                    onChanged: (input) {
                      setState(() => _password = input);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.white,
                    onPressed: () => _login(),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    ),
                    child: Text(
                      'I dont have an account yet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      dynamic result = await _auth.login(_email, _password);
      if (result == null) {
        _scaffoldState.currentState.showSnackBar(SnackBar(
          content: Text('Could not sign in with those credentials'),
        ));
      }
    }
  }
}
