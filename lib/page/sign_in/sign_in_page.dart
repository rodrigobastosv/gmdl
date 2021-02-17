import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/sign_in/sign_in_cubit.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../core/route/route.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_loading.dart';
import 'widget/sign_in_form.dart';

class SignInPage extends StatefulWidget {
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
          backgroundColor: const Color(0xFFB0D25A),
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
    if (state is SignInSuccess) {
      Navigator.of(context).pushNamed(
        LOAD_INFO_PAGE,
        arguments: state.loginResult.username,
      );
    } else if (state is SignInFailure) {
      showErrorNotification(context, context.getText(state.errorMessage));
    }
  }

  Widget _builder(BuildContext context, SignInState state) {
    if (state is SignInLoad || state is SignInSuccess) {
      return const Center(
        child: GMLoading(),
      );
    } else {
      return SignInForm();
    }
  }
}
