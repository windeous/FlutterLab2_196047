import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_services.dart';
import '../models/joke.dart';
import '../provider/favorites_provider.dart';

class JokesByTypeScreen extends StatelessWidget {
  final String jokeType;

  const JokesByTypeScreen({super.key, required this.jokeType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes: $jokeType'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.getJokesByType(jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load jokes'));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      joke.setup,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(joke.punchline),
                    trailing: Selector<FavoritesProvider, bool>(
                      selector: (context, provider) =>
                          provider.isFavorite(joke),
                      builder: (context, isFavorite, child) {
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            final favoritesProvider =
                                context.read<FavoritesProvider>();
                            if (isFavorite) {
                              favoritesProvider.removeFavorite(joke);
                            } else {
                              favoritesProvider.addFavorite(joke);
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
