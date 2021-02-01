import 'package:flutter/material.dart';

class GMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GMAppBar({
    Key key,
    this.title,
    this.leading,
    this.withBackButton,
  }) : super(key: key);

  final String title;
  final Widget leading;
  final bool withBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFB0D25A),
      iconTheme: const IconThemeData(color: Colors.white),
      automaticallyImplyLeading: false,
      leading: _getLeadingWidget(context),
      title: title != null
          ? Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          : null,
      centerTitle: true,
    );
  }

  Widget _getLeadingWidget(BuildContext context) {
    if (leading != null) {
      return leading;
    }
    return withBackButton
        ? GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          )
        : null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
