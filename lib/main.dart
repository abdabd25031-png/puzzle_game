import 'package:flutter/material.dart';

void main() => runApp(const PuzzleGame());

class GameController {
  List<int> board = [];

  void shuffleBoard() {
    board = List.generate(16, (index) => index);
    board.shuffle();
  }

  bool movePiece(int index) {
    int emptyIndex = board.indexOf(15);

    if (_isAdjacent(index, emptyIndex)) {
      int temp = board[index];
      board[index] = board[emptyIndex];
      board[emptyIndex] = temp;
      return true;
    }

    return false;
  }

  bool _isAdjacent(int idx1, int idx2) {
    int row1 = idx1 ~/ 4;
    int col1 = idx1 % 4;

    int row2 = idx2 ~/ 4;
    int col2 = idx2 % 4;

    return (row1 - row2).abs() + (col1 - col2).abs() == 1;
  }
}

class PuzzleGame extends StatelessWidget {
  const PuzzleGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Puzzle Game",
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
                    builder: (context) => const CategoriesPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4DD0E1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
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
  const CategoriesPage({super.key});

  final List<Map<String, String>> categories = const [
    {"title": "Animals", "emoji": "🐶"},
    {"title": "Anime", "emoji": "🎌"},
    {"title": "Cars", "emoji": "🚗"},
    {"title": "Football", "emoji": "⚽"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
        backgroundColor: const Color(0xFF6DD5ED),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    categoryName: categories[index]["title"]!,
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
                    style: const TextStyle(fontSize: 50),
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
    );
  }
}

class GamePage extends StatefulWidget {
  final String categoryName;

  const GamePage({
    super.key,
    required this.categoryName,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameController controller = GameController();

  @override
  void initState() {
    super.initState();
    controller.shuffleBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: const Color(0xFF6DD5ED),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: controller.board.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {

            int val = controller.board[index];

            if (val == 15) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }

            String imagePath = "";

            if (widget.categoryName == "Animals") {
              imagePath =
              "assets/animals/PineTools.com_files/$val.jpg";
            }
            else if (widget.categoryName == "Anime") {
              imagePath =
              "assets/Anime/PineTools.com_files/$val.jpg";
            }
            else if (widget.categoryName == "Cars") {
              imagePath =
              "assets/Cars/PineTools.com_files/$val.jpg";
            }
            else if (widget.categoryName == "Football") {
              imagePath =
              "assets/Football/PineTools.com_files/$val.jpg";
            }

            return GestureDetector(
              onTap: () {
                if (controller.movePiece(index)) {
                  setState(() {});
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (
                        context,
                        error,
                        stackTrace,
                        ) {
                      return Center(
                        child: Text(
                          "$val",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}