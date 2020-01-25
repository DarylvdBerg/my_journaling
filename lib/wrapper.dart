import 'package:flutter/material.dart';
import 'package:my_journaling/screens/home_view.dart';
import 'package:my_journaling/screens/login_view.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Get the current user from the provider stream
    final currentUser = Provider.of<User>(context);

    // Return Login or Home based on if user is logged in.
    return currentUser == null ? LoginView() : HomeView();
  }
}
