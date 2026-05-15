import 'package:flutter/material.dart';

void main() {
  runApp(const PuzzleGame());
}

class PuzzleGame extends StatelessWidget {
  const PuzzleGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple.shade100,

        appBar: AppBar(
          title: const Text("Puzzle Game"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.extension,
                size: 120,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),

              const Text(
                "Welcome to Puzzle Game",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {},
                child: const Text("Start Game"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}