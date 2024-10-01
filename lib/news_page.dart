import 'package:flutter/material.dart';
import 'package:new_app/news_service.dart';
import 'news_article.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String selectedCountry = 'global'; // Default to global news
  late Future<List<NewsArticle>> newsArticles;

  @override
  void initState() {
    super.initState();
    newsArticles = NewsService().fetchAgricultureNews(selectedCountry);
  }

  void updateNews(String country) {
    setState(() {
      selectedCountry = country;
      newsArticles = NewsService().fetchAgricultureNews(selectedCountry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agriculture News'),
        backgroundColor: const Color.fromRGBO(223, 240, 227, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Select News Type'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Global Agriculture News'),
                          onTap: () {
                            updateNews('global');
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text('Local Agriculture News'),
                          onTap: () {
                            updateNews('in'); // Change to specific country code if needed
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(223, 240, 227, 1),
        child: FutureBuilder<List<NewsArticle>>(
          future: newsArticles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error fetching news', style: TextStyle(color: Colors.green)));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No agriculture news available', style: TextStyle(color: Colors.green)));
            }

            // Filter out articles with '[Removed]' in the title or source name (case insensitive)
            final filteredArticles = snapshot.data!.where((article) =>
            !article.title.toLowerCase().contains('[removed]') &&
                !(article.sourceName == "[Removed]")).toList();

            if (filteredArticles.isEmpty) {
              return Center(child: Text('No valid agriculture news available', style: TextStyle(color: Colors.green)));
            }

            return ListView.builder(
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final article = filteredArticles[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.imageUrl != null) // Check if imageUrl is not null
                        Image.network(article.imageUrl!, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          article.title,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green), // Set title color to green
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          article.description,
                          style: TextStyle(color: Colors.green), // Set description color to green
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Open the article in a web view or browser
                          // You can use url_launcher package
                        },
                        child: Text('Read more', style: TextStyle(color: Colors.green)), // Set button text color to green
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
