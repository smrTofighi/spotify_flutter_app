import 'package:flutter/material.dart';
import 'package:spotify_app/common/helper/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({
    super.key,
    this.title,
    this.hideBack = false,
    this.action,
    this.backGroundColor = Colors.transparent, this.onBackPress,
  });
  final Widget? title;
  final Widget? action;
  final Color? backGroundColor;
  final bool hideBack;
  final Function? onBackPress;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor,
      elevation: 0,
      title: title ?? Text(''),
      actions: [action ?? Container()],
      centerTitle: true,
      leading: Visibility(
        visible: !hideBack,
        child: IconButton(
          onPressed: () {
            
            
            if(onBackPress != null){
              onBackPress!();
            }else {
Navigator.pop(context);
            }
          },
          icon: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.isDarkMode
                  ? Colors.white.withAlpha(20)
                  : Colors.black.withAlpha(20),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 15,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
