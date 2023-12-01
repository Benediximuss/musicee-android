import 'package:flutter/material.dart';
import 'package:musicee_app/objects/track.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:musicee_app/screens/song_detail_screen.dart';

class ListItemCard extends StatelessWidget {
  final Track track;

  const ListItemCard({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SongDetailScreen(
                title: track.trackName,
                artist: track.trackArtist.join(', '),
                imagePath: 'assets/img/albumart.jpg',
              ),
            ),
          );
        },
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              width: 56, // Adjust the width as needed
              child: const Icon(
                Icons.music_note,
                size: 36, // Adjust the size as needed
              ),
            ), // Musical note icon
            title: Text(track.trackName,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text('Artist: ${track.trackArtist.join(', ')}'),
                const SizedBox(height: 5),
                Text('Album: ${track.trackAlbum}'),
                const SizedBox(height: 5),
                Text('Release Year: ${track.trackReleaseYear}'),
                const SizedBox(height: 5),
                Text('Rating: ${track.trackRating}'),
              ],
            ),
            // Add more customization here if needed
          ),
        ));
  }
}

class AllTracksScreen extends StatefulWidget {
  const AllTracksScreen({super.key});

  @override
  _AllTracksScreenState createState() => _AllTracksScreenState();
}

class _AllTracksScreenState extends State<AllTracksScreen> {
  // Replace this list with your own data
  late List<Track> tracksList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            tracksList = snapshot.data as List<Track>;
            return buildListView();
          }
        },
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: tracksList.length,
      itemBuilder: (context, index) {
        return ListItemCard(track: tracksList[index]);
      },
    );
  }

  void getContent() async {
    print("3131: Fetcing!");
    tracksList = await fetchData();
    print("3131: Fetced!");
  }

  Future<List<Track>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://musicee.us-west-2.elasticbeanstalk.com/tracks/get_tracks',
        ),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Track.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // If an exception occurs (e.g., network error)
      print('Failed to load data. Exception: $e');
      return [];
    }
  }
}
