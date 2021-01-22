import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../cubit/cubits.dart';

extension I18nCubitExt on BuildContext {
  String getText(String id) => watch<I18nCubit>().getFormattedText(id);

  String getTextUppercase(String id) => getText(id).toUpperCase();
}
