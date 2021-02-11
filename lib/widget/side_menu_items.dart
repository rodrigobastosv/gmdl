import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../core/route/route.dart';

final sideMenuItems = [
  /*SideMenuItem(
    'HOS Summary',
    MaterialCommunityIcons.calendar_clock,
  ),
  SideMenuItem(
    'Mileage Report',
    MaterialCommunityIcons.file_document_edit_outline,
  ),
  SideMenuItem(
    'Clear Data',
    FontAwesome.eraser,
  ),
  SideMenuItem(
    'Settings',
    MaterialCommunityIcons.settings,
  ),
  SideMenuItem(
    'Change Password',
    MaterialCommunityIcons.key_change,
  ),*/
  SideMenuItem(
    text: 'Sign Out',
    icon: MdiIcons.logout,
    onTap: (context) => Navigator.of(context)
        .pushNamedAndRemoveUntil(INITIAL_SETTINGS_PAGE, (route) => false),
  ),
];

class SideMenuItem {
  SideMenuItem({
    this.text,
    this.icon,
    this.onTap,
  });

  String text;
  IconData icon;
  Function(BuildContext) onTap;
}
