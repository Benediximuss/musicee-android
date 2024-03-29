import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/widgets/lists/cards/track_card_horizontal_list.dart';
import 'package:musicee_app/widgets/lists/cards/track_card_vertical_list.dart';

class TrackListView extends StatelessWidget {
  const TrackListView({
    super.key,
    required this.tracksList,
    this.refreshListScreen,
    required this.direction,
    this.onLongPress,
  });

  final List<TrackModel> tracksList;
  final void Function()? refreshListScreen;
  final Axis direction;
  final void Function(String)? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: direction,
      itemCount: tracksList.length,
      itemBuilder: (context, index) {
        if (direction == Axis.vertical) {
          return TrackCardVerticalList(
            trackDetails: tracksList[index],
            refreshListScreen: refreshListScreen,
          );
        } else {
          return TrackCardHorizontalList(
            trackDetails: tracksList[index],
            refreshListScreen: refreshListScreen,
            onLongPress: onLongPress,
          );
        }
      },
    );
  }
}
