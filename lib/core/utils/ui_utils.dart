import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widget/alert/gm_loading_dialog.dart';
import '../../widget/core/gm_app.dart';
import '../cubit/cubits.dart';
import '../extension/extensions.dart';

Future<void> showProOptimizingDialog(BuildContext context) async {
  showDialog(
    context: navigatorKey.currentContext,
    builder: (_) => GMLoadingDialog(
      message: context.getText('waitingrouteoptimization.popup.subtitle'),
    ),
  );
  await Future.delayed(const Duration(seconds: 5));
  Navigator.of(navigatorKey.currentContext).pop();
}

Future<void> showLunchDialog(BuildContext context) async {
  final hosCubit = context.read<HosCubit>();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider.value(
      value: context.read<HosCubit>(),
      child: Builder(
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Container(
              height: 190,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/lunch.svg',
                        color: const Color(0xFF717272),
                      ),
                      const SizedBox(width: 8),
                      Text(context.getText('hos.lunch.title')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(context.getText('driver.hos.lunch.content')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: BlocBuilder<HosCubit, HosState>(
                      builder: (_, state) => Text(
                        context.read<HosCubit>().lunchTimeInMinutes.toString(),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(context.getText('driver.hos.minutes')),
                  const SizedBox(height: 6),
                  RaisedButton(
                    elevation: 0,
                    color: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      context.getText('hos.endLunch'),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () => hosCubit.endLunch(
                      DateTime.now().toUtcAsString,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
