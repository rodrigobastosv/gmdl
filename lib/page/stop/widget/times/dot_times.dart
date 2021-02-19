import 'package:flutter/material.dart';

import '../../../../core/entity/model/models.dart';

class DotTimes extends StatelessWidget {
  const DotTimes({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 4,
        bottom: 4,
      ),
      child: Container(
        height: 140,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 140,
              width: 2,
              color: const Color(0xFF9B9B9B),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                stop.hasBeenArrived
                    ? const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 6,
                        child: Center(
                          child: Icon(
                            Icons.check_circle,
                            size: 12,
                            color: Color(0xFF75B800),
                          ),
                        ),
                      )
                    : const CircleAvatar(
                        backgroundColor: Color(0xFF717373),
                        radius: 4,
                      ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF9B9B9B),
                  radius: 4,
                ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF717373),
                  radius: 4,
                ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF9B9B9B),
                  radius: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
