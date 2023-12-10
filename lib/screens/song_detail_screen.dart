import 'package:flutter/material.dart';

import '../utils/color_manager.dart';

class SongDetailScreen extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;

  final String trackID = '163BSLhb';

  const SongDetailScreen(
      {super.key,
      required this.title,
      required this.artist,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Song Details',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes the shadow direction
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  imagePath,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                Text(
                  artist,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // RATE FUNCTIONALITY
                    },
                    child: const Text('Rate',
                        style: TextStyle(
                            fontSize: 16, color: ColorManager.colorAppBarText)),
                  ),
                ),
                const SizedBox(width: 35),
                SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // ADD TO LIST FUNCTIONALITY
                      },
                      child: const Text('Add to list',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorManager.colorAppBarText)),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
