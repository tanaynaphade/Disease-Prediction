class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String? imageUrl; // Make this nullable if it can be null
  final String author;
  final String publishedAt;

  // If there is a source property, ensure it's defined correctly
  final String? sourceName; // Rename this if your class uses a different name

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    this.imageUrl,
    required this.author,
    required this.publishedAt,
    this.sourceName, // Add this if it exists in the JSON response
  });

  // Factory constructor to create an instance from JSON
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      imageUrl: json['urlToImage'],
      author: json['author'] ?? 'Unknown',
      publishedAt: json['publishedAt'],
      sourceName: json['source']['name'] ?? 'Unknown', // Adjust based on your JSON structure
    );
  }
}
