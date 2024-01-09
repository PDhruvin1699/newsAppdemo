// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../model/article_model.dart';
//
// class DetailsPage extends StatelessWidget {
//   final ArticleModel article;
//
//   DetailsPage({required this.article});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('News Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12.0),
//               child: Image.network(
//                 article.urlToImage,
//                 height: 300.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               article.title,
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.0),
//             buildIconTextRow(
//               icon: CupertinoIcons.person,
//               text: '${article.author}',
//               label: 'Author',
//             ),
//             SizedBox(height: 8.0),
//             buildIconTextRow(
//               icon: CupertinoIcons.calendar,
//               text: '${article.publishedAt}',
//               label: 'Published',
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               article.content,
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildIconTextRow(
//       {required IconData icon, required String text, required String label}) {
//     return Row(
//       children: [
//         Container(
//           width: 24.0,
//           height: 24.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.grey,
//           ),
//           child: Center(
//             child: Icon(
//               icon,
//               size: 16.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         SizedBox(width: 8.0),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 text,
//                 style: TextStyle(fontSize: 16.0),
//               ),
//               Text(
//                 label,
//                 style: TextStyle(fontSize: 12.0, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import '../model/article_model.dart';
import 'dart:io';
//
// class DetailsPage extends StatelessWidget {
//   final ArticleModel article;
//
//   DetailsPage({required this.article});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('News Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             FutureBuilder<bool>(
//               future: _isOnline(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData && snapshot.data == true) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(12.0),
//                     child: Image.network(
//                       article.urlToImage,
//                       height: 300.0,
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 } else {
//                   return FutureBuilder<String>(
//                     future: _getOfflineImagePath(article.urlToImage),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         final String offlineImagePath = snapshot.data!;
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(12.0),
//                           child: Image.file(
//                             File(offlineImagePath),
//                             height: 300.0,
//                             fit: BoxFit.cover,
//                           ),
//                         );
//                       } else {
//                         return Container(); // You can add a loading indicator if needed
//                       }
//                     },
//                   );
//                 }
//               },
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               article.title,
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.0),
//             buildIconTextRow(
//               icon: CupertinoIcons.person,
//               text: '${article.author}',
//               label: 'Author',
//             ),
//             SizedBox(height: 8.0),
//             buildIconTextRow(
//               icon: CupertinoIcons.calendar,
//               text: '${article.publishedAt}',
//               label: 'Published',
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               article.content,
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildIconTextRow(
//       {required IconData icon, required String text, required String label}) {
//     return Row(
//       children: [
//         Container(
//           width: 24.0,
//           height: 24.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.grey,
//           ),
//           child: Center(
//             child: Icon(
//               icon,
//               size: 16.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         SizedBox(width: 8.0),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 text,
//                 style: TextStyle(fontSize: 16.0),
//               ),
//               Text(
//                 label,
//                 style: TextStyle(fontSize: 12.0, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<bool> _isOnline() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   Future<String> _getOfflineImagePath(String onlineImagePath) async {
//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String fileName = onlineImagePath.split('/').last;
//     return '${appDocDir.path}/images/$fileName';
//   }
// }
class DetailsPage extends StatelessWidget {
  final ArticleModel article;

  DetailsPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPhotoViewGallery(context),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  buildIconTextRow(
                    icon: CupertinoIcons.person,
                    text: '${article.author}',
                    label: 'Author',
                  ),
                  SizedBox(height: 8.0),
                  buildIconTextRow(
                    icon: CupertinoIcons.calendar,
                    text: '${article.publishedAt}',
                    label: 'Published',
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    article.content,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoViewGallery(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isOnline(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return Container(
            height: 300.0, // Adjust the height as needed
            child: PhotoView(
              imageProvider: NetworkImage(article.urlToImage),
              minScale: PhotoViewComputedScale.contained * 0.8, // Adjust the minScale for zoom out
              maxScale: PhotoViewComputedScale.covered * 2, // Adjust the maxScale for zoom in
            ),
          );
        } else {
          return FutureBuilder<String>(
            future: _getOfflineImagePath(article.urlToImage),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final String offlineImagePath = snapshot.data!;
                return Container(
                  height: 300.0, // Adjust the height as needed
                  child: PhotoView(
                    imageProvider: FileImage(File(offlineImagePath)),
                    minScale: PhotoViewComputedScale.contained * 0.8, // Adjust the minScale for zoom out
                    maxScale: PhotoViewComputedScale.covered * 2, // Adjust the maxScale for zoom in
                  ),
                );
              } else {
                return Container(); // You can add a loading indicator if needed
              }
            },
          );
        }
      },
    );
  }


  Widget buildIconTextRow(
      {required IconData icon, required String text, required String label}) {
    return Row(
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<bool> _isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<String> _getOfflineImagePath(String onlineImagePath) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String fileName = onlineImagePath.split('/').last;
    return '${appDocDir.path}/images/$fileName';
  }
}