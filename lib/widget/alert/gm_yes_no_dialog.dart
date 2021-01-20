import 'package:flutter/material.dart';

class GMYesNoDialog extends StatelessWidget {
  const GMYesNoDialog({
    Key key,
    this.onYesCallback,
    this.onNoCallback,
  }) : super(key: key);

  final VoidCallback onYesCallback;
  final VoidCallback onNoCallback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Want to leave the app?'),
      actions: <Widget>[
        FlatButton(
          child: const Text('No'),
          textColor: Theme.of(context).primaryColor,
          onPressed: () async {
            Navigator.of(context).pop(false);
            if (onNoCallback != null) {
              onNoCallback();
            }
          },
        ),
        FlatButton(
          child: const Text('Yes'),
          textColor: Theme.of(context).primaryColor,
          onPressed: () async {
            Navigator.of(context).pop(true);
            if (onYesCallback != null) {
              onYesCallback();
            }
          },
        ),
      ],
    );
  }
}
