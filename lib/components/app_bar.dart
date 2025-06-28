import 'package:daily_do_with_hive/constants/colors.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget{

  final bool showLogo;
  final bool showAppBarColor;
  final Color? foregroundColor;
  final Widget? leading;
  final String title;
  final List<Widget>? actions;

  const Appbar({
    super.key,
    this.showLogo = false,
    this.showAppBarColor = false,
    this.foregroundColor,
    this.leading,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: showAppBarColor ? appBarBgColor : Colors.transparent,
      foregroundColor: foregroundColor ?? appBarTextColor,
      scrolledUnderElevation: 0,
      centerTitle: true,
      actionsPadding: EdgeInsets.symmetric(horizontal: 16),

      leading: leading,

      title: showLogo
      ? Image.asset('assets/images/logo.png', height: 30, color: logoColor,)
      : Text(title, style: TextStyle(fontWeight: FontWeight.bold),),

      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}