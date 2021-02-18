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
      automaticallyImplyLeading: false,
      leading: _getLeadingWidget(context),
      title: title != null
          ? Text(title,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white,
                  ))
          : null,
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
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
