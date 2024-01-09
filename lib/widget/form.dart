
import 'package:blocnewsdemo/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authbloc.dart';
import '../blocs/autstat.dart';

class AuthForm extends StatefulWidget {
  final bool isSignIn;

  AuthForm({required this.isSignIn});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context,'/home');
          // Navigate to the next screen (e.g., home screen)
        } else if (state is AuthError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            duration: Duration(seconds: 3),
          ));
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isSignIn) {
                        context.read<AuthCubit>().signIn(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      } else {
                        context.read<AuthCubit>().signUp(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      }
                    }
                  },
                  child: Text(widget.isSignIn ? 'Sign In' : 'Sign Up'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
