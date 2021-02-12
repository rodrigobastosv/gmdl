import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/route/route.dart';
import '../../widget/general/gm_loading.dart';

class LoadInfoPage extends StatelessWidget {
  const LoadInfoPage({Key key}) : super(key: key);

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
    if (state is LoadInfoAllInfoLoadSuccess) {
      Navigator.of(context).pushReplacementNamed(CHOOSE_EQUIPMENT_PAGE);
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
        if (state is LoadInfoInfoLoading)
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
