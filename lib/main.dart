import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const PuzzleGame());
}

class GameController {
  List<int> board = [];

  void shuffleBoard() {
    board = List.generate(16, (index) => index ~/ 2);
    board.shuffle(Random());
  }
}

class PuzzleGame extends StatelessWidget {
  const PuzzleGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Puzzle Game"),
        centerTitle: true,
        backgroundColor: const Color(0xFF6DD5ED),
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.extension,
              size: 100,
              color: Color(0xFF00BCD4),
            ),

            const SizedBox(height: 20),

            const Text(
              "Welcome to Puzzle Game",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesPage(),
                  ),
                );

              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4DD0E1),

                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              child: const Text(
                "Start Game",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {

final List<Map<String, String>> categories = [

{
"title": "Animals",
"emoji": "🐶",
},

{
"title": "Anime",
"emoji": "🎌",
},

{
"title": "Cars",
"emoji": "🚗",
},

{
"title": "Football",
"emoji": "⚽",
},

];

@override
Widget build(BuildContext context) {

return Scaffold(
appBar: AppBar(
title: const Text("Categories"),
centerTitle: true,
backgroundColor: const Color(0xFF6DD5ED),
),

body: Padding(
padding: const EdgeInsets.all(20),

child: GridView.builder(

itemCount: categories.length,

gridDelegate:
const SliverGridDelegateWithFixedCrossAxisCount(

crossAxisCount: 2,
crossAxisSpacing: 20,
mainAxisSpacing: 20,

),

itemBuilder: (context, index) {

return GestureDetector(

onTap: () {

Navigator.push(
context,
MaterialPageRoute(
builder: (context) => GamePage(
categoryName:
categories[index]["title"]!,
),
),
);

},

child: Container(

decoration: BoxDecoration(
color: const Color(0xFFB2EBF2),
borderRadius: BorderRadius.circular(25),
),

  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,

    children: [

      Text(
        categories[index]["emoji"]!,
        style: const TextStyle(
          fontSize: 50,
        ),
      ),

      const SizedBox(height: 10),

      Text(
        categories[index]["title"]!,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),
);
},
),
),
);
}
}

class GamePage extends StatelessWidget {

  final String categoryName;

  GamePage({
    required this.categoryName,
  });

  final GameController controller = GameController();

  @override
  Widget build(BuildContext context) {

    controller.shuffleBoard();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
        backgroundColor: const Color(0xFF6DD5ED),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: GridView.builder(

          itemCount: controller.board.length,

          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,

          ),

          itemBuilder: (context, index) {

            return Container(

              decoration: BoxDecoration(
                color: const Color(0xFF80DEEA),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Center(


                  child: Text(
                    getEmoji(controller.board[index]),
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
            );
          },
        ),
      ),
    );
  }
  String getEmoji(int number) {

    List<String> emojis = [

      "🐶",
      "🐱",
      "🦁",
      "🐸",
      "🐼",
      "🐵",
      "🐰",
      "🦊",

    ];

    return emojis[number];

  }
}