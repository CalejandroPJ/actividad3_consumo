class Thumbnail {
  final String path;
  final String extension;

  Thumbnail({required this.path, required this.extension});

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json['path'] as String,
        extension: json['extension'] as String,
      );

  Map<String, dynamic> toJson() => {'path': path, 'extension': extension};
}

class Character {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        thumbnail: Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'thumbnail': thumbnail.toJson(),
      };
}

class CharacterResponse {
  final int code;
  final String status;
  final List<Character> characters;

  CharacterResponse({
    required this.code,
    required this.status,
    required this.characters,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final results = (data['results'] as List<dynamic>)
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();

    return CharacterResponse(
      code: json['code'] as int,
      status: json['status'] as String,
      characters: results,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'characters': characters.map((c) => c.toJson()).toList(),
      };
}
