import 'package:flutter/material.dart';

import 'gm_menu_drawer.dart';

class GMScaffold extends StatelessWidget {
  const GMScaffold({
    Key key,
    this.title,
    @required this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.leading,
    this.withBackButton = true,
    this.withDrawer = true,
  })  : assert(body != null),
        super(key: key);

  final String title;
  final Widget body;
  final FloatingActionButton floatingActionButton;
  final Color backgroundColor;
  final Widget leading;
  final bool withBackButton;
  final bool withDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xFFEEEEEE),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        leading: _getLeadingWidget(),
        title: title != null
            ? Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : null,
        centerTitle: true,
      ),
      endDrawer: withDrawer ? const GMMenuDrawer() : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _getLeadingWidget() {
    if (leading != null) {
      return leading;
    }
    return withBackButton
        ? const Icon(
            Icons.arrow_back_ios,
          )
        : null;
  }
}
