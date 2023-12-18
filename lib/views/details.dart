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
//             // Row(
//             //   children: [
//             //     Icon(Icons.person, size: 16.0),
//             //     SizedBox(width: 8.0),
//             //     Text(
//             //       'Author: ${article.author}',
//             //       style: TextStyle(fontSize: 16.0),
//             //     ),
//             //   ],
//             // ),
//             // SizedBox(height: 8.0),
//             // Row(
//             //   children: [
//             //     Icon(Icons.date_range, size: 16.0),
//             //     SizedBox(width: 8.0),
//             //     Text(
//             //       'Published At: ${article.publishedAt}',
//             //       style: TextStyle(fontSize: 16.0),
//             //     ),
//             //   ],
//             // ),
//             Row(
//               children: [
//                 Container(
//                   width: 24.0,
//                   height: 24.0,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.grey,
//                   ),
//                   child: Center(
//                     child: Icon(
//                       CupertinoIcons.person,
//                       size: 16.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.0),
//                 Text(
//                   'Author: ${article.author}',
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8.0),
//             Row(
//               children: [
//                 Container(
//                   width: 24.0,
//                   height: 24.0,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.grey,
//                   ),
//                   child: Center(
//                     child: Icon(
//                       CupertinoIcons.calendar,
//                       size: 16.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.0),
//                 Text(
//                   'Published At: ${article.publishedAt}',
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               ],
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
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/article_model.dart';

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                article.urlToImage,
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
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
    );
  }

  Widget buildIconTextRow({required IconData icon, required String text, required String label}) {
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
}
