import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class GMButtonLoading extends StatelessWidget {
  const GMButtonLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color: Colors.white,
      size: 22,
    );
  }
}
