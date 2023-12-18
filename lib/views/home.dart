import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocnewsdemo/blocs/news_bloc.dart';
import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_state.dart';

import 'details.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white38,
        elevation: 0, // Removes the shadow
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'images/21601.png', // Replace with the actual path to your image
            height: 24.0, // Adjust the height as needed
            width: 24.0, // Adjust the width as needed
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<NewsBloc>(context).add(FetchNews());
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial) {
            BlocProvider.of<NewsBloc>(context).add(FetchNews());
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(article: article),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 7,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          // child: Image.network(
                          //   article.urlToImage,
                          //   height: 150.0,
                          //   fit: BoxFit.cover,
                          // ),
                          child: Image.network(
                            article.urlToImage,
                            height: 150.0,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                              // Handle the error here, you can show a placeholder or an error message.
                              return Container(
                                color: Colors.white38, // Placeholder color
                                height: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),Center(
                                      child: Text('No image'),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),


                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            article.title,
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is NewsError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
