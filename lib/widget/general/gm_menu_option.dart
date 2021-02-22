import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class GMMenuOption extends StatelessWidget {
  const GMMenuOption({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onTap,
  })  : assert(icon != null),
        assert(text != null),
        assert(onTap != null),
        super(key: key);

  final String icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(
        'assets/icons/$icon.svg',
        height: 22,
        width: 22,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
