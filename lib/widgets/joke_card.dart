import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const JokeCard({required this.title, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
