import 'package:flutter/material.dart';
import 'package:my_journaling/screens/home_view.dart';
import 'package:my_journaling/screens/login_view.dart';
import 'package:my_journaling/screens/register_view.dart';
import 'package:my_journaling/util/routing_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case LoginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginView());
    case RegisterViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterView());
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}