import 'package:flutter/material.dart';
import '../api/api.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Categories'),
      ),
      body: Column(
        children: [
          // Info Box at the Top
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueAccent.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Select a category to explore jokes. Tap the button below to get a random joke!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Expanded FutureBuilder for Categories
          Expanded(
            child: FutureBuilder<List<String>>(
              future: ApiService.getJokeTypes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load joke types'));
                } else {
                  final jokeTypes = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: jokeTypes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading:
                              const Icon(Icons.category, color: Colors.blue),
                          title: Text(
                            jokeTypes[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
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
          ),
          // Random Joke Button at Bottom Left
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 80,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () async {
                    final randomJoke = await ApiService.getRandomJoke();
                    Navigator.pushNamed(context, '/randomJoke',
                        arguments: randomJoke);
                  },
                  child:
                      const Icon(Icons.shuffle, size: 36, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
