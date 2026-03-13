import 'package:dio/dio.dart';
import '../models/movie_model.dart';
class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = "https://movies-api.accel.li/api/v2/list_movies.json";

  Future<List<MovieModel>> fetchMovies() async {
    try {
      final response = await _dio.get(baseUrl);

      if (response.statusCode == 200) {
        List<dynamic> moviesData = response.data['data']['movies'];
        return moviesData.map((movie) => MovieModel.fromJson(movie)).toList();
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}