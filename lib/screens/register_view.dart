import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_journaling/screens/home_view.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/util/app_colors.dart';

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
        color: AppColor.ACCENTCOLOR,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/app_logo.png'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
                      SizedBox(
                        height: 20,
                      ),
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
                        style: TextStyle(
                          color: Colors.white
                        ),
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
                        style: TextStyle(
                            color: Colors.white
                        ),
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
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Repeat password',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        obscureText: true,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please repeat your password';
                          }

                          if (input != _password) {
                            return 'Confirmation password does not match password';
                          }
                          return null;
                        },
                        onChanged: (input) {
                          setState(() => _repeatPassword = input);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Colors.white,
                        onPressed: () => _register(),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.only(top: 15),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'I already have an account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      }
    }
  }
}
