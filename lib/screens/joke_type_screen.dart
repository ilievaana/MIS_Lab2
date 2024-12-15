import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class JokeTypeScreen extends StatelessWidget {
  final String type;

  JokeTypeScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$type Jokes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 60),
                  SizedBox(height: 10),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No jokes found for "$type"',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      joke.setup,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        joke.punchline,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
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


