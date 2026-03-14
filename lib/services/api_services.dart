import 'package:dio/dio.dart';
import '../models/movie_model.dart';
class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = "https://movies-api.accel.li/api/v2/list_movies.json";

  Future<List<MovieModel>> fetchMovies() async {
    final response = await _dio.get('https://movies-api.accel.li/api/v2/list_movies.xml');
    if (response.statusCode == 200) {
      List moviesData = response.data['data']['movies'];
      return moviesData.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }}