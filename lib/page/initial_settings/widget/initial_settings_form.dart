import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/cubit/cubits.dart';
import '../../../core/entity/locale_option.dart';
import '../../../core/extension/i18n_cubit_extension.dart';
import '../../../core/global/hive.dart';
import '../../../core/keys.dart';
import '../../../core/utils/utils.dart';

class InitialSettingsForm extends StatefulWidget {
  InitialSettingsForm({Key key}) : super(key: key);

  @override
  _InitialSettingsFormState createState() => _InitialSettingsFormState();
}

class _InitialSettingsFormState extends State<InitialSettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String _serverName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18nCubit, I18nState>(
      builder: (_, state) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Form(
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
        ),
        floatingActionButton: FloatingActionButton(
          key: initialSettingsFabKey,
          backgroundColor: const Color(0xFF3AA348),
          onPressed: () {
            final _form = _formKey.currentState;
            if (_form.validate()) {
              _form.save();
              context
                  .read<InitialSettingsCubit>()
                  .validateServerName(_serverName);
            }
          },
          child: SvgPicture.asset(
            'assets/icons/checkmark.svg',
            height: 22,
            width: 22,
          ),
        ),
      ),
    );
  }
}
