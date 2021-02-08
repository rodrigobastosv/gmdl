import 'package:flutter/material.dart';
import '../../core/entity/model/models.dart';
import '../../core/utils/utils.dart';

class StopLocationInfo extends StatelessWidget {
  const StopLocationInfo({
    Key key,
    @required this.stop,
    this.textColor = Colors.black,
  }) : super(key: key);

  final StopModel stop;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            getLocationInfo(stop),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            stop.location?.addressLine1 ?? '',
            maxLines: 2,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
