import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musicee_app/utils/color_manager.dart';

class AddFriendButton extends StatelessWidget {
  const AddFriendButton(
      {Key? key,
      required this.isLoading,
      required this.isFriend,
      required this.onPressed})
      : super(key: key);

  final bool isLoading;
  final bool isFriend;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 180,
      child: OutlinedButton(
        onPressed: (!isLoading && !isFriend) ? onPressed : null,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(
            width: isFriend ? 4 : 3,
            color: isFriend ? ColorManager.colorPrimary : ColorManager.colorPrimary,
          ),
          // backgroundColor: isLoading ? Colors.green.shade200 : ColorManager.colorBG,
        ),
        child: isLoading
            ? SpinKitThreeBounce(
                color: isFriend ? ColorManager.colorPrimary : ColorManager.colorPrimary,
                size: 25,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    isFriend ? Icons.favorite_rounded : Icons.group_add_rounded,
                    size: 40,
                    color: isFriend ? ColorManager.colorPrimary : ColorManager.colorPrimary,
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      isFriend ? 'In friends' : 'Add friend',
                      style: TextStyle(
                        fontSize: 25,
                        color:
                            isFriend ? ColorManager.colorPrimary : ColorManager.colorPrimary,
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
