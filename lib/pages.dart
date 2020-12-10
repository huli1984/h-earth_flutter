class WPPage {
  final int id;
  final String title;
  final String date;
  final String author;
  final String excerpt;
  final String content;
  final String image;
  final String link;
  bool isSaved = false;

  WPPage(
      {
        this.content,
        this.id,
        this.title,
        this.excerpt,
        this.date,
        this.image,
        this.author,
        this.link,
      }
      );

  factory WPPage.fromJSON(Map<String, dynamic> json) {
    return WPPage(
        id: json['id'],
        title: json['title']['rendered'],
        content: json['content']['rendered'],
        date: json['date'] != null
            ? json['date'].toString().replaceFirst('T', ' ')
            : null,
        image: json['_links']['wp:featuredmedia'] != null
            ? json['_links']['wp:featuredmedia'][0]['href']
            : null,
        excerpt: json['excerpt']['rendered'],
        author: json['author'].toString()
    );
  }
}
