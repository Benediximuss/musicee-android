import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/asset_manager.dart';

import '../utils/color_manager.dart';

class SongCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;

  const SongCard({
    super.key,
    this.title = "SONG TITLE",
    this.artist = "ARTIST NAME",
    this.imagePath = AssetManager.placeholderAlbumArt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SongDetailScreen(
        //       title: title,
        //       artist: artist,
        //       imagePath: imagePath,
        //     ),
        //   ),
        // );
        Navigator.pushNamed(
          context,
          Routes.songDetailsScreen,
          arguments: {
            'title': title,
            'artist': artist,
            'imagePath': imagePath,
          },
        );
      },
      child: Container(
        width: 150,
        height: 50,
        margin: const EdgeInsets.only(right: 8.0, left: 8.0),
        decoration: BoxDecoration(
            color: ColorManager.swatchPrimary.shade100,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    artist,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
