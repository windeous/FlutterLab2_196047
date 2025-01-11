import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: favoritesProvider.favoriteJokes.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet! Add some jokes to your favorites.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoritesProvider.favoriteJokes.length,
              itemBuilder: (context, index) {
                final joke = favoritesProvider.favoriteJokes[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      joke.setup,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(joke.punchline),
                  ),
                );
              },
            ),
    );
  }
}
