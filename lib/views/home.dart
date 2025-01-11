import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_services.dart';
import '../provider/favorites_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, size: 28),
            tooltip: 'View Favorites',
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiService.getJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load joke types'));
          } else {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.category, color: Colors.blue),
                    title: Text(
                      jokeTypes[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/jokesByType',
                        arguments: jokeTypes[index],
                      );
                    },
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
