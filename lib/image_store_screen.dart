import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
class ImageStoreScreen extends StatefulWidget {
  const ImageStoreScreen({super.key});

  @override
  State<ImageStoreScreen> createState() => _ImageStoreScreenState();
}

class _ImageStoreScreenState extends State<ImageStoreScreen> {
  final List<ImageCollection> _collections = [
    ImageCollection(
      name: 'Коллекция 1',
      count: 5,
      coinsPerHour: 10,
      imageUrl: 'assets/images/collection1.jpg',
    ),
    ImageCollection(
      name: 'Коллекция 2',
      count: 3,
      coinsPerHour: 15,
      imageUrl: 'assets/images/collection2.jpg',
    ),
    ImageCollection(
      name: 'Коллекция 3',
      count: 4,
      coinsPerHour: 12,
      imageUrl: 'assets/images/collection3.jpg',
    ),
    ImageCollection(
      name: 'Коллекция 4',
      count: 6,
      coinsPerHour: 8,
      imageUrl: 'assets/images/collection4.jpg',
    ),
    ImageCollection(
      name: 'Коллекция 5',
      count: 4,
      coinsPerHour: 12,
      imageUrl: 'assets/images/collection5.jpg',
    ),
    ImageCollection(
      name: 'Коллекция 6',
      count: 5,
      coinsPerHour: 10,
      imageUrl: 'assets/images/collection6.jpg',
    ),
    ImageCollection(
      name: 'Коллекция 7',
      count: 3,
      coinsPerHour: 15,
      imageUrl: 'assets/images/collection7.jpg',
    ),
    ImageCollection(
      name: 'Коллекция 8',
      count: 4,
      coinsPerHour: 12,
      imageUrl: 'assets/images/collection8.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Магазин картинок',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: _collections.length,
                    itemBuilder: (context, index) {
                      final collection = _collections[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              collection.imageUrl,
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              collection.name,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Кол-во: ${collection.count}',
                              style: GoogleFonts.roboto(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${collection.coinsPerHour} монет/час',
                              style: GoogleFonts.roboto(
                                color: Colors.amber,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Назад',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}