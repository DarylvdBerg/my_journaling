import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_journaling/screens/home_view.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/widgets/app_name.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  String _name, _email, _password, _repeatPassword = '';

  AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (input) {
                      setState(() => _name = input);
                    },
                  ),
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
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Repeat password'),
                    obscureText: true,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Please repeat your password';
                      }

                      if(input != _password) {
                        return 'Confirmation password does not match password';
                      }
                      return null;
                    },
                    onChanged: (input) {
                      setState(() => _repeatPassword = input);
                    },
                  ),
                  RaisedButton(
                    onPressed: () => _register(),
                    child: Text('Register'),
                  ),
                  FlatButton(
                    padding: EdgeInsets.only(top: 15),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Sign in'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _register() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      dynamic result = await _auth.register(_name, _email, _password);

      if (result == null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Please enter valid information!'),
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
      }
    }
  }
}
