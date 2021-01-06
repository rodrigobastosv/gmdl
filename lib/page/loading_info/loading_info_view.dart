import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/loading_info/loading_info_cubit.dart';
import '../../widget/gm_loading.dart';
import '../choose_equipment/choose_equipment_page.dart';

class LoadingInfoView extends StatelessWidget {
  const LoadingInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24242A),
      body: BlocConsumer<LoadingInfoCubit, LoadingInfoState>(
        listener: (_, state) {
          if (state is AllInfoLoadedSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ChooseEquipmentPage(),
              ),
            );
          }
        },
        builder: (_, state) => Column(
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
        ),
      ),
    );
  }
}
