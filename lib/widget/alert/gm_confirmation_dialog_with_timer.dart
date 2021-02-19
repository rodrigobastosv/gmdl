import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/extension/extensions.dart';

class GMConfirmationDialogWithTimer extends StatelessWidget {
  const GMConfirmationDialogWithTimer({
    Key key,
    @required this.seconds,
    @required this.title,
    @required this.description,
    @required this.onConfirm,
  }) : super(key: key);

  final int seconds;
  final String title;
  final String description;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 190,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 16,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 12,
                  ),
            ),
            StreamBuilder<int>(
              stream: Stream<int>.periodic(
                      const Duration(seconds: 1), (i) => seconds - i)
                  .take(seconds + 1),
              builder: (_, snapshot) {
                if (snapshot.data == 0) {
                  Navigator.of(context).pop();
                  onConfirm();
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${snapshot.data ?? seconds}',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                );
              },
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  context.getText('general.button.confirm'),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  context.getText('general.button.cancel'),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
