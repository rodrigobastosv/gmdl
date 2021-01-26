import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_button_loading.dart';
import '../../widget/general/gm_scaffold.dart';
import '../pages.dart';
import '../pages_names.dart';

class ChooseEquipmentView extends StatelessWidget {
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
    if (state is EquipmentFound) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const LoadRoutePage(),
          settings: const RouteSettings(name: LOAD_ROUTE_PAGE)
        ),
      );
    } else if (state is EquipmentNotFound) {
      showErrorNotification(state.errorMessage);
    } else if (state is EquipmentFailed) {
      showErrorNotification(state.errorMessage);
    }
  }

  Widget _builder(BuildContext context, ChooseEquipmentState state) {
    return GMScaffold(
      backgroundColor: const Color(0xFF24242A),
      withNavigationBar: true,
      withBackButton: false,
      title: context.getTextUppercase('menu.load.route'),
      mainActionButton: FloatingActionButton(
        onPressed: state is! LoadingEquipment
            ? () {
                final _form = _formKey.currentState;
                if (_form.validate()) {
                  _form.save();
                }
              }
            : null,
        child: _getMainButtonIcon(state),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      mainActionButtonLabel: context.getTextUppercase('menu.load.route'),
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
    if (state is LoadingEquipment || state is EquipmentFound) {
      return const GMButtonLoading();
    } else {
      return SvgPicture.asset('assets/icons/route.svg');
    }
  }
}
