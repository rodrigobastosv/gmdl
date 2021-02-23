import 'package:flutter/material.dart';

import 'package:backdrop_modal_route/backdrop_modal_route.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/extension/extensions.dart';

class GMBottomBar extends StatelessWidget {
  const GMBottomBar({
    Key key,
    this.menuOptions,
  }) : super(key: key);

  final List<Widget> menuOptions;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BottomAppBar(
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
              onTap: () => Navigator.of(context).push(
                BackdropModalRoute(
                  topPadding:
                      height - (height - 720.0 + menuOptions.length * 56),
                  overlayContentBuilder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      color: Theme.of(context).bottomAppBarColor,
                      padding: const EdgeInsets.all(24),
                      child: Column(children: menuOptions),
                    );
                  },
                ),
              ),
              child: Opacity(
                opacity: menuOptions != null && menuOptions.isNotEmpty ? 1 : 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/more.svg',
                      color: Theme.of(context).iconTheme.color,
                    ),
                    Text(
                      context.getText('menu.more'),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Theme.of(context).iconTheme.color,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
