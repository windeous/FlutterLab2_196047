import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class JokesByTypeScreen extends StatelessWidget {
  final String jokeType;
  const JokesByTypeScreen({super.key, required this.jokeType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildFancyTitle(jokeType),
        centerTitle: true,
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
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jokes[index].setup,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        jokes[index].punchline,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFancyTitle(String jokeType) {
    return Text(
      'Jokes: $jokeType',
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
        color: Colors.black87,
        shadows: [
          Shadow(
            color: Colors.grey,
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
    );
  }
}
