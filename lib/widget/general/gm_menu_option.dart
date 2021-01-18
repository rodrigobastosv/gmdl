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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: const Color(0xFF464646),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/$icon.svg',
              height: 40,
              width: 40,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
