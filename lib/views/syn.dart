// import 'package:flutter/material.dart';
//
// import '../contacts/news_repository.dart';
// import '../model/article_model.dart';
//
// class SyncScreen extends StatefulWidget {
//   @override
//   _SyncScreenState createState() => _SyncScreenState();
// }
//
// class _SyncScreenState extends State<SyncScreen> {
//   NewsRepository _newsRepository = NewsRepository();
//   bool _syncInProgress = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Synchronization Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (_syncInProgress)
//               CircularProgressIndicator()
//             else
//               ElevatedButton(
//                 onPressed: () async {
//                   setState(() {
//                     _syncInProgress = true;
//                   });
//
//                   // Perform synchronization
//                   await _synchronizeData();
//
//                   setState(() {
//                     _syncInProgress = false;
//                   });
//                 },
//                 child: Text('Synchronize Data'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _synchronizeData() async {
//     try {
//       // Fetch and save news articles
//       await _newsRepository.synchronizeData();
//
//       // Optionally, show a success message or perform other actions
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Synchronization complete!'),
//       ));
//
//       // Navigate to the home screen
//       Navigator.pushReplacementNamed(context, '/home');
//     } catch (e) {
//       // Handle errors, if any
//       print('Error during synchronization: $e');
//     }
//   }


// Optionally, you can show a success message or navigate to another screen
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Synchronization complete!'),
      // ));

  // }

