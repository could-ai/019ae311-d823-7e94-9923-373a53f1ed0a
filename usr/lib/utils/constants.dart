import 'package:flutter/material.dart';

class AppTheme {
  static const Color taskbarColor = Color(0xFFF3F3F3); // Light theme taskbar
  static const Color startMenuColor = Color(0xFFF3F3F3);
  static const Color windowColor = Colors.white;
  static const Color desktopBackgroundColor = Color(0xFF0067C0); // Classic Blue
  
  static const double taskbarHeight = 48.0;
  static const double startMenuWidth = 600.0;
  static const double startMenuHeight = 650.0;
}

class AppAssets {
  // Using Flutter Icons as placeholders for now
  static const IconData windowsLogo = Icons.grid_view_rounded;
  static const IconData edge = Icons.public;
  static const IconData explorer = Icons.folder_open;
  static const IconData store = Icons.shopping_bag_outlined;
  static const IconData settings = Icons.settings_outlined;
  static const IconData terminal = Icons.terminal;
}
