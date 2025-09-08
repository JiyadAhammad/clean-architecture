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
import 'signup_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
  static pageRoute() => CupertinoPageRoute(builder: (context) => SigninPage());

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              TextWidget('Sign in.', fontSize: 20, fontWeight: FontWeight.w600),
              AuthFormField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              AuthFormField(
                controller: _passwordController,
                hintText: 'password',
                isObscureText: true,
              ),
              SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
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
                    _passwordController.clear();
                    // Navigate to Home page;
                    Navigator.pushReplacement(context, BlogPage.pageRoute());
                  }
                },
                builder: (context, state) {
                  return AuthButton(
                    isLoading: state is AuthLoading,
                    onTap: () {
                      // Logic for signin
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignin(
                            email: _emailController.text.trim(),
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
                text: 'Dont\'t have an account?',
                highlight: 'Sign Up',
                onTap: () {
                  Navigator.pushReplacement(context, SignupPage.pageRoute());
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
    _passwordController.dispose();
    super.dispose();
  }
}
