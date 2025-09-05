import 'package:flutter/material.dart';
import 'models/api_service.dart';
import 'models/character_models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Marvel Characters',
    theme: ThemeData(useMaterial3: true),
    home: const CharacterListPage(),
  );
}

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});
  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late Future<CharacterResponse> _futureResponse;
  final _controller = TextEditingController(text: 'Spider');

  @override
  void initState() {
    super.initState();
    _futureResponse = ApiService.fetchCharacters(nameStartsWith: _controller.text);
  }

  void _search() {
    setState(() {
      _futureResponse = ApiService.fetchCharacters(nameStartsWith: _controller.text);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Personajes Marvel')),
    body: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Buscar personaje',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _search(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _search, child: const Text('Buscar')),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<CharacterResponse>(
              future: _futureResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('Sin datos'));
                }

                final resp = snapshot.data!;
                return ListView.builder(
                  itemCount: resp.characters.length,
                  itemBuilder: (context, i) {
                    final c = resp.characters[i];
                    final imgUrl = "${c.thumbnail.path}.${c.thumbnail.extension}";
                    return ListTile(
                      leading: Image.network(imgUrl, width: 50, fit: BoxFit.cover),
                      title: Text(c.name),
                      subtitle: Text(
                        c.description.isEmpty ? 'Sin descripción' : c.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
