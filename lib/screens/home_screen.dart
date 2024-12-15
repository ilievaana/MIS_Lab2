import 'package:flutter/material.dart';
import '../services/api_services.dart';
import 'random_joke_screen.dart';
import 'joke_type_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline, color: Colors.deepOrange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white24, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<String>>(
          future: ApiService.fetchJokeTypes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final jokeTypes = snapshot.data ?? [];
              return GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Две картички по ред
                  crossAxisSpacing: 12, // Простор меѓу колоните
                  mainAxisSpacing: 12, // Простор меѓу редовите
                  childAspectRatio: 4 / 5, // Помал размер за помали картички
                ),
                itemCount: jokeTypes.length,
                itemBuilder: (context, index) {
                  final color = Colors.primaries[index % Colors.primaries.length];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokeTypeScreen(type: jokeTypes[index]),
                        ),
                      );
                    },
                    child: Text(
                      jokeTypes[index].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16, // Намален текст
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}



