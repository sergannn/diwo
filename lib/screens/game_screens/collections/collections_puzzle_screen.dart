import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_widgets/bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppBar with hamburger button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 2, 14, 24),
      ),
      home: const CollectionsPuzzleScreen(),
    );
  }
}

class CollectionsPuzzleScreen extends StatelessWidget {
  const CollectionsPuzzleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFF020E18),
        bottomNavigationBar: bottomBar(context),
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Column(children: [
              // Top row with title
              SizedBox(height: 10),
              Container(
                height: 64,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF162E3F),
                        radius: 26,
                        child: Icon(Icons.arrow_back_ios_new,
                            color: Color(0xFF209FFF)),
                      ),
                    ),
                    SizedBox(width: 17, height: 52),
                    // Title
                    SizedBox(width: 6),
                    Text(
                      "Коллекции DiWo Арт",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // GridView with shrinkWrap
              GridView.builder(
                shrinkWrap: true, // Add this
                physics: NeverScrollableScrollPhysics(), // Add this
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: 31,
                itemBuilder: (context, index) {
                  final dayNumber = index + 1;
                  final imageNumber = (dayNumber - 1) % 8 + 1;
                  return PuzzleCard(
                    number: dayNumber,
                    imagePath: 'assets/images/puzzle.png',
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class PuzzleCard extends StatelessWidget {
  final int number;
  final String imagePath;

  const PuzzleCard({
    Key? key,
    required this.number,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 5, 55, 95),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 16,
                  child: Text(
                    number.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text('день', style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}