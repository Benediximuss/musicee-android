import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/widgets/lists/cards/artist_list_card.dart';
import 'package:musicee_app/widgets/lists/cards/track_card_horizontal_list.dart';
import 'package:musicee_app/widgets/lists/cards/track_card_vertical_list.dart';

class ArtistListView extends StatelessWidget {
  final List<String> artistList;
  final void Function()? refreshListScreen;

  const ArtistListView({
    Key? key,
    required this.artistList,
    this.refreshListScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: artistList.length,
      itemBuilder: (context, index) {
        return ArtistListCard(
          artistName: artistList[index],
          refreshListScreen: refreshListScreen,
        );
      },
    );
  }
}
