import 'package:flutter/cupertino.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    'Sign Out',
    MdiIcons.logout,
  ),
];

class MenuItem {
  MenuItem(this.text, this.icon);

  String text;
  IconData icon;
}
