import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musicee_app/utils/color_manager.dart';

class LikeButton extends StatelessWidget {
  const LikeButton(
      {Key? key,
      required this.isLoading,
      required this.isLiked,
      required this.onPressed})
      : super(key: key);

  final bool isLoading;
  final bool isLiked;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 140,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(
            width: isLiked ? 4 : 3,
            color: isLiked ? ColorManager.colorPrimary : Colors.grey,
          ),
          // backgroundColor: isLoading ? Colors.green.shade200 : ColorManager.colorBG,
        ),
        child: isLoading
            ? SpinKitThreeBounce(
                color: isLiked ? ColorManager.colorPrimary : Colors.grey,
                size: 25,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                    size: isLiked ? 30 : 30,
                    color: isLiked ? ColorManager.colorPrimary : Colors.grey,
                  ),
                  SizedBox(
                    width: 65,
                    child: Text(
                      isLiked ? 'Liked' : 'Like',
                      style: TextStyle(
                        fontSize: 25,
                        color:
                            isLiked ? ColorManager.colorPrimary : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
