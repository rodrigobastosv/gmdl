import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../general/gm_loading.dart';

class GMLoadingDialog extends StatelessWidget {
  const GMLoadingDialog({
    Key key,
    this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        children: [
          const GMLoading(),
          if (message != null) ...[
            const SizedBox(height: 6),
            Text(
              message,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
