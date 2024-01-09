// // login_page.dart
//
// import 'package:blocnewsdemo/blocs/authbloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// import '../blocs/autstat.dart';
//
// class LoginPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final AuthBloc authBloc = context.read<AuthBloc>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
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
//                 ElevatedButton(
//                   onPressed: () {
//                     // Retrieve email and password from controllers
//                     String email = emailController.text;
//                     String password = passwordController.text;
//
//                     // Pass email and password to the LoginEvent
//                     authBloc.add(LoginEvent(email, password));
//                   },
//                   child: Text('Login'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
