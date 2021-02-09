import 'package:flutter/material.dart';

import '../../core/extension/extensions.dart';

class GMSearchTextField extends StatelessWidget {
  const GMSearchTextField({
    Key key,
    @required this.initialValue,
    @required this.onChanged,
  })  : assert(initialValue != null),
        assert(onChanged != null),
        super(key: key);

  final String initialValue;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD8D8D8),
      child: TextFormField(
        textAlign: TextAlign.left,
        initialValue: initialValue,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: context.getText('search'),
          suffixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.all(20.0),
          isDense: true,
        ),
        cursorColor: Theme.of(context).primaryColor,
        onChanged: onChanged,
      ),
    );
  }
}
