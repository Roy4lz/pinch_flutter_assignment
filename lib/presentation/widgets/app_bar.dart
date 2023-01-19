import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            color: ThemeColors.mediumFontColor
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
