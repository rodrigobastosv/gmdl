import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gm_driver_lite/widget/alert/notification.dart';
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
      withNavigationBar: true,
      title: 'EQUIPMENT SELECTION',
      body: BlocConsumer<ChooseEquipmentCubit, ChooseEquipmentState>(
        listener: _listener,
        builder: _builder,
      ),
      mainActionButton: FloatingActionButton(
        onPressed: () {
          final _form = _formKey.currentState;
          if (_form.validate()) {
            _form.save();
          }
        },
        child: SvgPicture.asset('assets/icons/route.svg'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      mainActionButtonLabel: 'LOAD ROUTE',
    );
  }

  void _listener(BuildContext context, ChooseEquipmentState state) {
    if (state is EquipmentFound) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const LoadRoutePage(),
        ),
      );
    } else if (state is EquipmentNotFound) {
      showErrorNotification(state.errorMessage);
    } else if (state is EquipmentFailed) {
      showErrorNotification(state.errorMessage);
    }
  }

  Widget _builder(BuildContext context, ChooseEquipmentState state) {
    return Container(
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
              SvgPicture.asset(
                'assets/icons/qrcode.svg',
                height: 26,
                width: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
