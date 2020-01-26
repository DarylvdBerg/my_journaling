import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_journaling/screens/register_view.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/widgets/app_name.dart';

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
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppName(),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
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
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
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
                  RaisedButton(
                    onPressed: () => _login(),
                    child: Text('Login'),
                  ),
                  FlatButton(
                    onPressed: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView())),
                    child: Text('Sign up'),
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
