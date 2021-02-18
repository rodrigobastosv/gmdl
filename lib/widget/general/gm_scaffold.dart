import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../core/extension/i18n_cubit_extension.dart';
import 'gm_app_bar.dart';
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
    this.withNavigationBar = true,
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
  final bool withNavigationBar;
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
      bottomNavigationBar:
          isBottomMenuOpened ? _getMenuOptionsBar() : _getMainNavigationBar(),
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

  Widget _getMenuOptionsBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height:
              optionsLength <= 3 ? 64 : (menuOptions.length / 3).floor() * 64.0,
          color: const Color(0xFF181818),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (_, i) => menuOptions[i],
            itemCount: menuOptions.length,
          ),
        ),
        BottomAppBar(
          color: const Color(0xFF181818),
          child: GestureDetector(
            onTap: () => setState(() => isBottomMenuOpened = false),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                bottom: 2,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/icons/more.svg',
                    color: Theme.of(context).iconTheme.color,
                  ),
                  Text(
                    context.getText('menu.less'),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Theme.of(context).iconTheme.color,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getMainNavigationBar() {
    return widget.withNavigationBar
        ? BottomAppBar(
            color: Theme.of(context).bottomAppBarColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    bottom: 2,
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => isBottomMenuOpened = true),
                    child: Opacity(
                      opacity: hasMenuOptions ? 1 : 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/more.svg',
                            color: Theme.of(context).iconTheme.color,
                          ),
                          Text(
                            context.getText('menu.more'),
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : null;
  }
}
