import 'package:flutter/cupertino.dart';

import 'package:flutter_icons/flutter_icons.dart';

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
    Octicons.sign_out,
  ),
];

class MenuItem {
  MenuItem(this.text, this.icon);

  String text;
  IconData icon;
}
