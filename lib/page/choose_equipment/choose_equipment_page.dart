import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../core/route/route.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_button_loading.dart';
import '../../widget/general/gm_scaffold.dart';

class ChooseEquipmentPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<ChooseEquipmentCubit, ChooseEquipmentState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, ChooseEquipmentState state) {
    if (state is ChooseEquipmentFound) {
      Navigator.of(context).pushNamed(LOAD_ROUTE_PAGE);
    } else if (state is ChooseEquipmentNotFound) {
      showErrorNotification(context, state.errorMessage);
    } else if (state is ChooseEquipmentFailure) {
      showErrorNotification(context, state.errorMessage);
    }
  }

  Widget _builder(BuildContext context, ChooseEquipmentState state) {
    return GMScaffold(
      backgroundColor: const Color(0xFF24242A),
      withNavigationBar: true,
      withBackButton: false,
      title: context.getTextUppercase('menu.load.route'),
      mainButtonAction: () {
        final _form = _formKey.currentState;
        if (_form.validate()) {
          _form.save();
        }
      },
      mainButtonIcon: _getMainButtonIcon(state),
      mainButtonLabel: context.getTextUppercase('menu.load.route'),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 48, right: 18, left: 18),
          child: Form(
            key: _formKey,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: context.getText('equipment.login'),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(MdiIcons.truckCheck),
                    ),
                    onSaved: (equipmentKey) => context
                        .read<ChooseEquipmentCubit>()
                        .getEquipmentInfo(equipmentKey),
                    validator: (equipmentKey) => equipmentKey.isEmpty
                        ? context.getText('loader.validation.required')
                        : null,
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
      ),
    );
  }

  Widget _getMainButtonIcon(ChooseEquipmentState state) {
    if (state is ChooseEquipmentLoad) {
      return const GMButtonLoading();
    } else {
      return SvgPicture.asset('assets/icons/route.svg');
    }
  }
}
