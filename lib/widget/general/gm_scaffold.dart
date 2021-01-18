import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'gm_menu_drawer.dart';
import 'gm_menu_option.dart';

class GMScaffold extends StatefulWidget {
  const GMScaffold({
    Key key,
    this.title,
    @required this.body,
    this.mainActionButton,
    this.mainActionButtonLabel,
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
  final FloatingActionButton mainActionButton;
  final String mainActionButtonLabel;
  final Widget centerButton;
  final Color backgroundColor;
  final Widget leading;
  final bool withAppBar;
  final bool withBackButton;
  final bool withDrawer;
  final bool withNavigationBar;
  final List<GMMenuOption> menuOptions;

  @override
  _GMScaffoldState createState() => _GMScaffoldState();
}

class _GMScaffoldState extends State<GMScaffold> {
  bool isBottomMenuOpened = false;

  List<GMMenuOption> get menuOptions => widget.menuOptions;
  bool get hasMenuOptions => menuOptions != null && menuOptions.isNotEmpty;
  int get optionsLength => menuOptions?.length ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? const Color(0xFFEEEEEE),
      appBar: _getAppBar(),
      endDrawer: widget.withDrawer ? const GMMenuDrawer() : null,
      body: widget.body,
      floatingActionButton: !isBottomMenuOpened ? _getMainButton() : null,
      floatingActionButtonLocation: widget.withNavigationBar
          ? FloatingActionButtonLocation.endDocked
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar:
          isBottomMenuOpened ? _getMenuOptionsBar() : _getMainNavigationBar(),
    );
  }

  Widget _getMainButton() {
    return widget.mainActionButton != null
        ? Stack(
            fit: StackFit.passthrough,
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              widget.mainActionButton,
              if (widget.mainActionButtonLabel != null)
                Positioned(
                  bottom: -16,
                  child: Text(
                    widget.mainActionButtonLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          )
        : null;
  }

  Widget _getAppBar() {
    return widget.withAppBar
        ? AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            leading: _getLeadingWidget(),
            title: widget.title != null
                ? Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                : null,
            centerTitle: true,
          )
        : null;
  }

  Widget _getLeadingWidget() {
    if (widget.leading != null) {
      return widget.leading;
    }
    return widget.withBackButton
        ? GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
            ),
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
                    color: Colors.white,
                  ),
                  const Text(
                    'Less',
                    style: TextStyle(
                      color: Colors.white,
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
            shape: const CircularNotchedRectangle(),
            notchMargin: -12,
            color: const Color(0xFF181818),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => setState(() => isBottomMenuOpened = true),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      bottom: 2,
                    ),
                    child: Opacity(
                      opacity: hasMenuOptions ? 1 : 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/more.svg',
                            color: Colors.white,
                          ),
                          const Text(
                            'More',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                if (widget.centerButton != null) widget.centerButton,
                const Spacer(),
              ],
            ),
          )
        : null;
  }
}
