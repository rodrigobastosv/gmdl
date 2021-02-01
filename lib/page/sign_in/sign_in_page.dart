import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/sign_in/sign_in_cubit.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_loading.dart';
import '../pages.dart';
import 'widget/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  static const routeName = 'SignInPage';

  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF24242A),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          title: Text(
            context.getTextUppercase('driver.hint.login'),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<SignInCubit, SignInState>(
          listener: _listener,
          builder: _builder,
        ),
      ),
    );
  }

  void _listener(BuildContext context, SignInState state) {
    if (state is UserSignedSuccess) {
      Navigator.of(context).pushNamed(
        LoadInfoPage.routeName,
        arguments: state.loginResult.username,
      );
    } else if (state is UserSigningFailed) {
      showErrorNotification(context, context.getText(state.errorMessage));
    }
  }

  Widget _builder(BuildContext context, SignInState state) {
    if (state is UserSigningLoading || state is UserSignedSuccess) {
      return const Center(
        child: GMLoading(),
      );
    } else {
      return SignInForm();
    }
  }
}
