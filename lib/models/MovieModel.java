class MovieModel {
  final int id;
  final String title;
  final String year;
  final double rating;
  final List<dynamic> genres;
  final String summary;
  final String mediumCoverImage;
  final String backgroundImage;

  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.genres,
    required this.summary,
    required this.mediumCoverImage,
    required this.backgroundImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      year: json['year'].toString(),
      rating: (json['rating'] as num).toDouble(),
      genres: json['genres'] ?? [],
      summary: json['summary'] ?? "",
      mediumCoverImage: json['medium_cover_image'],
      backgroundImage: json['background_image'],
    );
  }
}