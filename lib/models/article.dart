class Article {
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'] ?? 'Unknown',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ??
          'https://firehouseshelter.com/wp-content/themes/kronos/assets/images/news-placeholder.jpg',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
