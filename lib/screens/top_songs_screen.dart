import 'package:flutter/material.dart';
import 'package:musicee_app/models/genre_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/lists/top_songs_list.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

class TopSongsScreen extends StatefulWidget {
  const TopSongsScreen({super.key});

  @override
  _TopSongsScreenState createState() => _TopSongsScreenState();
}

class _TopSongsScreenState extends State<TopSongsScreen> {
  late List<GenreModel> _topSongsofGenres;

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Songs'),
        actions: [
          TextButton(
            onPressed: () {
              _refresh();
            },
            child: const Icon(
              Icons.refresh,
              color: ColorManager.colorAppBarText,
              size: 30,
            ),
          ),
        ],
      ),
      body: FutureBuilderWithLoader(
        future: APIService.topSongs(),
        onComplete: (snapshot) {
          _topSongsofGenres = snapshot.data as List<GenreModel>;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _topSongsofGenres.length,
            itemBuilder: (context, index) => SizedBox(
              height: 350,
              child: TopSongsList(
                genreName: _topSongsofGenres[index].genreName,
                tracksList: _topSongsofGenres[index].topTracks,
                refreshListScreen: _refresh,
              ),
            ),
          );
        },
      ),
    );
  }
}
