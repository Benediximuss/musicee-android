import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicee_app/utils/asset_manager.dart';

class ElevatedIcon extends StatelessWidget {
  const ElevatedIcon({
    super.key,
    this.iconData,
    this.svgAssetName,
    this.size = 100,
    this.padding = 16,
    this.borderRadius = 10,
    this.color = Colors.black26,
  });

  final IconData? iconData;
  final String? svgAssetName;
  final double size;
  final double padding;
  final double borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Builder(
            builder: (context) {
              if (iconData != null) {
                return Icon(
                  iconData!,
                  size: size,
                  color: Colors.black54,
                );
              } else if (svgAssetName != null) {
                return SvgPicture.asset(
                  svgAssetName!,
                  height: size,
                  width: size,
                  colorFilter: const ColorFilter.mode(
                    Colors.black54,
                    BlendMode.srcIn,
                  ),
                );
              } else {
                return Icon(
                  Icons.warning,
                  size: size,
                  color: Colors.black54,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
