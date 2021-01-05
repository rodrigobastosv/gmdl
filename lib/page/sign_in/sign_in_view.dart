import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/sign_in/sign_in_cubit.dart';
import '../loading_info/loading_info_page.dart';
import 'widget/sign_in_form.dart';

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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const LoadingInfoPage(),
                ),
              );
            }
          },
          builder: (_, state) {
            if (state is UserSigningLoading) {
              return const Center(
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
