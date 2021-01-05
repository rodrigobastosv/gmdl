import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/loading_info/loading_info_cubit.dart';

class LoadingInfoView extends StatelessWidget {
  const LoadingInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoadingInfoCubit, LoadingInfoState>(
        listener: (_, state) {
          if (state is AllInfoLoadedSuccess) {
          }
        },
        builder: (_, state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            if (state is InfoLoading) Text(state.step)
          ],
        ),
      ),
    );
  }
}
