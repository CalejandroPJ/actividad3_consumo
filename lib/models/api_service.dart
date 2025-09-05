import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'character_models.dart';

class ApiService {
  static const String _baseUrl = 'gateway.marvel.com';
  static const String _publicKey = '6bdd572173ed09439864ad440a5c7f8c';
  static const String _privateKey = '1f2d93f8bbec63e6e21060a7cb825f614ac1cf5b';

  static String _generateHash(String ts) {
    final bytes = utf8.encode(ts + _privateKey + _publicKey);
    return md5.convert(bytes).toString();
  }

  static Future<CharacterResponse> fetchCharacters({String nameStartsWith = 'Spider'}) async {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = _generateHash(ts);

    final uri = Uri.https(_baseUrl, '/v1/public/characters', {
      'apikey': _publicKey,
      'ts': ts,
      'hash': hash,
      'nameStartsWith': nameStartsWith,
      'limit': '20',
    });

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return CharacterResponse.fromJson(jsonMap);
    } else {
      throw Exception('Error al cargar datos: ${response.statusCode}');
    }
  }
}
