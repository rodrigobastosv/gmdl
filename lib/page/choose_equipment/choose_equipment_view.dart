import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/cubits.dart';
import '../../widget/general/gm_scaffold.dart';
import '../pages.dart';

class ChooseEquipmentView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GMScaffold(
      backgroundColor: const Color(0xFF24242A),
      title: 'LOAD ROUTE',
      body: BlocConsumer<ChooseEquipmentCubit, ChooseEquipmentState>(
        listener: (_, state) {
          if (state is EquipmentFound) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const LoadRoutePage(),
              ),
            );
          }
        },
        builder: (_, state) => Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 48, right: 18, left: 18),
            child: Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Equipment',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(MdiIcons.truckCheck),
                      ),
                      onSaved: (equipmentKey) => context
                          .read<ChooseEquipmentCubit>()
                          .getEquipmentInfo(equipmentKey),
                      validator: (equipmentKey) =>
                          equipmentKey.isEmpty ? 'Required Field' : null,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    MdiIcons.qrcodeScan,
                    color: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final _form = _formKey.currentState;
          if (_form.validate()) {
            _form.save();
          }
        },
        child: const Icon(
          MdiIcons.mapCheck,
        ),
        backgroundColor: const Color(0xFFB0D25A),
      ),
    );
  }
}
