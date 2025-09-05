import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/movie_models.dart';
import 'models/api_service.dart';

class ApiService {
  static const String _host = 'movie-database-alternative.p.rapidapi.com';
  static const String _apiKey = 'TU_RAPIDAPI_KEY';

  static Future<MovieSearchResponse> fetchMovies(String title) async {
    final url = Uri.https(
      _host,
      '/',
      {'s': title},
    );

    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-host': 'movie-database-alternative.p.rapidapi.com',
        'x-rapidapi-key': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return MovieSearchResponse.fromJson(jsonMap);
    } else {
      throw Exception('Error al cargar datos: ${response.statusCode}');
    }
  }
}
