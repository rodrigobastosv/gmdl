import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../page/pages.dart';

final menuItems = [
  /*MenuItem(
    'HOS Summary',
    MaterialCommunityIcons.calendar_clock,
  ),
  MenuItem(
    'Mileage Report',
    MaterialCommunityIcons.file_document_edit_outline,
  ),
  MenuItem(
    'Clear Data',
    FontAwesome.eraser,
  ),
  MenuItem(
    'Settings',
    MaterialCommunityIcons.settings,
  ),
  MenuItem(
    'Change Password',
    MaterialCommunityIcons.key_change,
  ),*/
  MenuItem(
      text: 'Sign Out',
      icon: MdiIcons.logout,
      onTap: (context) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const InitialSettingsPage(),
            ),
            (route) => false);
      }),
];

class MenuItem {
  MenuItem({
    this.text,
    this.icon,
    this.onTap,
  });

  String text;
  IconData icon;
  Function(BuildContext) onTap;
}
