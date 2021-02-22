import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants.dart';
import '../../core/entity/locale_option.dart';
import '../../core/global/hive.dart';
import '../../core/keys.dart';
import '../../core/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../core/route/route.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_scaffold.dart';

class InitialSettingsPage extends StatefulWidget {
  @override
  _InitialSettingsPageState createState() => _InitialSettingsPageState();
}

class _InitialSettingsPageState extends State<InitialSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  String _serverName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18nCubit, I18nState>(
      builder: (_, state) => GMScaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        title: context.getTextUppercase('loader.settings'),
        withDrawer: false,
        withBackButton: false,
        withNavigationBar: true,
        mainButtonLabel: context.getText('driver.button.save'),
        mainButtonIcon: SvgPicture.asset(
          'assets/icons/checkmark.svg',
          height: 22,
          width: 22,
        ),
        mainButtonAction: () {
          final _form = _formKey.currentState;
          if (_form.validate()) {
            _form.save();
            context
                .read<InitialSettingsCubit>()
                .validateServerName(_serverName);
          }
        },
        body: BlocConsumer<InitialSettingsCubit, InitialSettingsState>(
          listener: _listener,
          builder: _builder,
        ),
      ),
    );
  }

  void _listener(BuildContext context, InitialSettingsState state) {
    if (state is InitialSettingsValidateServerSuccess) {
      Navigator.of(context).pushNamed(SIGN_IN_PAGE);
    } else if (state is InitialSettingsValidateServerFailure) {
      showErrorNotification(context, context.getText(state.errorMessage));
    }
  }

  Widget _builder(BuildContext context, InitialSettingsState state) => Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/banner_gm.png'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: TextFormField(
                  key: initialSettingsServerKey,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: context.getText('general.server'),
                    prefixIcon: const Icon(MdiIcons.server),
                  ),
                  onSaved: (serverAddress) =>
                      _serverName = getOnlyTenantFromUrl(serverAddress),
                  validator: (serverAddress) => serverAddress.isEmpty
                      ? context.getText('loader.validation.required')
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Container(
                  color: Colors.white,
                  child: DropdownSearch<LocaleOption>(
                    dropdownSearchDecoration: const InputDecoration(
                      prefixIcon: Icon(
                        MdiIcons.earth,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    compareFn: (l1, l2) => l1 == l2,
                    items: localeOptions,
                    hint: context.getText('locale.label'),
                    onChanged: (locale) {
                      final globalBox = Hive.box(GLOBAL_BOX);
                      globalBox.put(LOCALE_KEY, locale.key);
                      context.read<I18nCubit>().changeLocale(locale.key);
                    },
                    selectedItem: LocaleOption('en', 'English'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: context.getText('loader.phone'),
                    prefixIcon: const Icon(MdiIcons.phone),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
