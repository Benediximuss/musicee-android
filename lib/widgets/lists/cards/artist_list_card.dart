import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/asset_manager.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArtistListCard extends StatelessWidget {
  const ArtistListCard({
    Key? key,
    required this.artistName,
    required this.refreshListScreen,
  }) : super(key: key);

  final String artistName;
  final void Function()? refreshListScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   Routes.artistTracksScreen,
        //   arguments: {
        //     'artistName': artistName,
        //   },
        // ).then(
        //   (_) {
        //     if (refreshListScreen != null) {
        //       refreshListScreen!();
        //     } else {
        //       print("3131: then null refresh!");
        //     }
        //   },
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          width: 150,
          height: 50,
          margin: const EdgeInsets.only(right: 8.0, left: 8.0),
          decoration: BoxDecoration(
            color: ColorManager.swatchPrimary.shade100,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      AssetManager.iconArtist,
                      height: 50,
                      width: 50,
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          artistName,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
