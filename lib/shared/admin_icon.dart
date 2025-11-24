import 'package:auto_sales/admin/admin_home.dart';
import 'package:flutter/material.dart';

class AdminIcon extends StatelessWidget {
  const AdminIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
      },
      icon: Icon(Icons.admin_panel_settings),
    );
  }
}
