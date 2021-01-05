import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/sign_in/sign_in_cubit.dart';
import 'package:gm_driver_lite/page/sign_in/widget/sign_in_form.dart';

class SignInView extends StatefulWidget {
  SignInView({Key key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SignInCubit, SignInState>(
          listener: (_, state) {
            if (state is UserSignedSuccess) {
              
            }
          },
          builder: (_, state) {
            if (state is UserSigningLoading) {
              return Center(
                child: CircularProgressIndicator(),
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
