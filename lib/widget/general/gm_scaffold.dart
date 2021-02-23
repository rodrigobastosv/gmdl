import 'package:flutter/material.dart';

import 'gm_app_bar.dart';
import 'gm_bottom_bar.dart';
import 'gm_menu_drawer.dart';

class GMScaffold extends StatefulWidget {
  const GMScaffold({
    Key key,
    this.title,
    @required this.body,
    this.mainButtonAction,
    this.mainButtonIcon,
    this.mainButtonLabel,
    this.centerButton,
    this.backgroundColor,
    this.leading,
    this.withAppBar = true,
    this.withBackButton = true,
    this.withDrawer = true,
    this.menuOptions,
  })  : assert(body != null),
        super(key: key);

  final String title;
  final Widget body;
  final Function mainButtonAction;
  final Widget mainButtonIcon;
  final String mainButtonLabel;
  final Widget centerButton;
  final Color backgroundColor;
  final Widget leading;
  final bool withAppBar;
  final bool withBackButton;
  final bool withDrawer;
  final List<Widget> menuOptions;

  @override
  _GMScaffoldState createState() => _GMScaffoldState();
}

class _GMScaffoldState extends State<GMScaffold> {
  bool isBottomMenuOpened = false;

  List<Widget> get menuOptions => widget.menuOptions;
  bool get hasMenuOptions => menuOptions != null && menuOptions.isNotEmpty;
  int get optionsLength => menuOptions?.length ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: _getAppBar(),
      endDrawer: widget.withDrawer ? const GMMenuDrawer() : null,
      body: widget.body,
      floatingActionButton: !isBottomMenuOpened ? _getMainButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GMBottomBar(menuOptions: menuOptions),
    );
  }

  Widget _getMainButton() {
    return widget.mainButtonAction != null
        ? FloatingActionButton.extended(
            backgroundColor: Theme.of(context).buttonColor,
            elevation: 4.0,
            icon: widget.mainButtonIcon,
            label: Text(
              widget.mainButtonLabel,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white,
                  ),
            ),
            onPressed: widget.mainButtonAction,
          )
        : null;
  }

  Widget _getAppBar() {
    return widget.withAppBar
        ? GMAppBar(
            title: widget.title,
            leading: widget.leading,
            withBackButton: widget.withBackButton,
          )
        : null;
  }
}
