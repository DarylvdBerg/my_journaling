import 'package:flutter/material.dart';
import 'package:my_journaling/models/menu_choice.dart';

class Menu {
  static List<MenuChoice> choices = <MenuChoice> [
    MenuChoice(title: "Logout", icon: Icons.person),
    MenuChoice(title: "Notifications", icon: Icons.alarm),
  ];
}