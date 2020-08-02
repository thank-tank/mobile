import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;

  TitleBar(this.pageName);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      centerTitle: true,
      title: Text(
        this.pageName,
        style: Theme.of(context).textTheme.headline1,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: IconButton(
            icon: Icon(
              Icons.notifications,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
