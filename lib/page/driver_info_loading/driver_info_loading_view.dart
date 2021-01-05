import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/driver_info/driver_info_cubit.dart';

import '../../main.dart';

class DriverInfoLoadingView extends StatelessWidget {
  const DriverInfoLoadingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
          icon: Icon(Icons.http),
          onPressed: () {
            alice.showInspector();
          },
        ),
        ],
      ),
      body: BlocConsumer<DriverInfoCubit, DriverInfoState>(
        listener: (_, state) {
          if (state is DriverInfoSuccess) {
            print('a');
          }
        },
        builder: (_, state) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
