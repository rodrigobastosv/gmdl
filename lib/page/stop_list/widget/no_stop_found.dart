import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/extension/extensions.dart';

class NoStopFound extends StatelessWidget {
  const NoStopFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.getText('list.noResults'),
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: const Color(0xFF95989A),
                ),
          ),
          const SizedBox(height: 8),
          SvgPicture.asset('assets/icons/no-resuts.svg'),
        ],
      ),
    );
  }
}
