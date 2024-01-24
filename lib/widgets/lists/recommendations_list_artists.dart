import 'package:flutter/material.dart';
import 'package:musicee_app/widgets/lists/artist_list_view.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

class RecommendationsListArtists extends StatefulWidget {
  const RecommendationsListArtists({
    Key? key,
    required this.listTitle,
    required this.futureArtistNames,
  }) : super(key: key);

  final String listTitle;
  final Future<List<String>> futureArtistNames;

  @override
  _RecommendationsListArtistsState createState() =>
      _RecommendationsListArtistsState();
}

class _RecommendationsListArtistsState
    extends State<RecommendationsListArtists> {
  late List<String> _artistList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        // color: ColorManager.swatchPrimary.shade200.withOpacity(0.6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.listTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilderWithLoader(
                future: widget.futureArtistNames,
                onComplete: (snapshot) {
                  _artistList = snapshot.data as List<String>;
                  return ArtistListView(
                    artistList: _artistList,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
