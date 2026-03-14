class MovieModel {
  final int id;
  final String title;
  final String year;
  final double rating;
  final List<dynamic> genres;
  final String summary;
  final String mediumCoverImage;
  final String backgroundImage;
  final int runtime;
  final String ytTrailerCode;

  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.genres,
    required this.summary,
    required this.mediumCoverImage,
    required this.backgroundImage,
    required this.runtime,
    required this.ytTrailerCode,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? "",
      backgroundImage: json['large_cover_image'] ?? "",
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      summary: json['summary'] ?? "",
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      ytTrailerCode: json['yt_trailer_code'] ?? "", year: '', mediumCoverImage: '',
    );
  }}