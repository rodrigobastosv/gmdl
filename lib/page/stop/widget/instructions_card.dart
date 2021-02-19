import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';

class InstructionsCard extends StatelessWidget {
  const InstructionsCard({
    Key key,
    this.stop,
  })  : assert(stop != null),
        super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INSTRUCTIONS',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Text(
                'INSTRUCTIONS HERE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
