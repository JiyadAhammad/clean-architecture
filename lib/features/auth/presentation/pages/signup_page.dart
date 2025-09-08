import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/error_enums.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/widget/rich_text_widget.dart';
import '../../../../core/widget/text_widget.dart';
import '../../../blog/presentation/pages/blog_page.dart';
import '../bloc/auth_bloc.dart';
import '../widget/auth_button.dart';
import '../widget/auth_form_field.dart';
import 'signin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static pageRoute() => CupertinoPageRoute(builder: (context) => SignupPage());
  static const routeName = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    log("AuthScreen build called");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              TextWidget('Sign up.', fontSize: 20, fontWeight: FontWeight.w600),
              AuthFormField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              AuthFormField(controller: _nameController, hintText: 'User name'),
              AuthFormField(
                controller: _passwordController,
                hintText: 'password',
                isObscureText: true,
              ),
              SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listenWhen: (previous, current) => previous != current,
                listener: (context, state) {
                  if (state is AuthFailure) {
                    showSnackBar(
                      context,
                      errorType: ErrorEnums.error,
                      content: state.errorMessage,
                    );
                  } else if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: TextWidget('${state.user.id} user logged in'),
                      ),
                    );
                    _emailController.clear();
                    _nameController.clear();
                    _passwordController.clear();
                    // Navigate to Home page;
                    Navigator.pushReplacement(context, BlogPage.pageRoute());
                  }
                },
                builder: (context, state) {
                  return AuthButton(
                    isLoading: (state is AuthLoading),
                    onTap: () {
                      // Logic for signup
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignup(
                            email: _emailController.text.trim(),
                            name: _nameController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 20),

              CustomRichText(
                text: 'Already have an account?',
                highlight: 'Sign In',
                onTap: () {
                  Navigator.pushReplacement(context, SigninPage.pageRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
