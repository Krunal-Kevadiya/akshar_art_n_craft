import 'package:flutter/material.dart';

enum MenuType { header, menuTitle, menuItem }

class DrawerMenuModel {
  DrawerMenuModel({
    required this.text,
    required this.type,
    this.icon,
    this.email,
    this.url,
    this.routes,
  });

  final String text;
  final String? email;
  final String? url;
  final String? routes;
  final MenuType type;
  final IconData? icon;
}
