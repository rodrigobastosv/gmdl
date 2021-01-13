import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../widget/general/gm_loading.dart';
import '../pages.dart';

class LoadInfoView extends StatelessWidget {
  const LoadInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24242A),
      body: BlocConsumer<LoadInfoCubit, LoadInfoState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, LoadInfoState state) {
    if (state is AllInfoLoadedSuccess) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ChooseEquipmentPage(),
        ),
      );
    }
  }

  Widget _builder(BuildContext context, LoadInfoState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: GMLoading(),
        ),
        const SizedBox(height: 12),
        if (state is InfoLoading)
          Text(
            state.step,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
