// // signup_page.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../blocs/authbloc.dart';
// import '../blocs/autstat.dart';
//
// // signup_page.dart
//
// import 'package:blocnewsdemo/blocs/authbloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class SignupPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final AuthBloc authBloc = context.read<AuthBloc>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(labelText: 'Email'),
//                   keyboardType: TextInputType.emailAddress,
//                   onChanged: (email) {
//                     // Update email variable as the text changes
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   onChanged: (password) {
//                     // Update password variable as the text changes
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 TextFormField(
//                   controller: confirmPasswordController,
//                   decoration: InputDecoration(labelText: 'Confirm Password'),
//                   obscureText: true,
//                   onChanged: (confirmPassword) {
//                     // Update confirmPassword variable as the text changes
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Retrieve email, password, and confirmPassword from controllers
//                     String email = emailController.text;
//                     String password = passwordController.text;
//                     String confirmPassword = confirmPasswordController.text;
//
//                     // Pass email, password, and confirmPassword to the SignupEvent
//                     authBloc.add(SignupEvent(email, password, confirmPassword));
//                   },
//                   child: Text('Sign Up'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authbloc.dart';
import '../widget/form.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: AuthForm(isSignIn: false),
      ),
    );
  }
}
