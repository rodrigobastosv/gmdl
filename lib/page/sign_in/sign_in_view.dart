import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/sign_in/sign_in_cubit.dart';
import '../../widget/general/gm_loading.dart';
import '../pages.dart';
import 'widget/sign_in_form.dart';

class SignInView extends StatefulWidget {
  SignInView({Key key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
          title: const Text(
            'LOGIN',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<SignInCubit, SignInState>(
          listener: (_, state) {
            if (state is UserSignedSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => LoadInfoPage(
                    username: state.loginResult.username,
                  ),
                ),
              );
            }
          },
          builder: (_, state) {
            if (state is UserSigningLoading) {
              return const Center(
                child: GMLoading(),
              );
            } else {
              return SignInForm();
            }
          },
        ),
      ),
    );
  }
}
