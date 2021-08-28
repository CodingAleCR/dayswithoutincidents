import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(child: AppBar(), preferredSize: preferredSize);
  }

  @override
  Size get preferredSize => Size.zero;
}
