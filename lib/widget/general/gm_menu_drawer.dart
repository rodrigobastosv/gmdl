import 'package:flutter/material.dart';

import '../side_menu_items.dart';

class GMMenuDrawer extends StatelessWidget {
  const GMMenuDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF24242A),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/gmd7.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Image.asset('assets/images/top_menu.png'),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(0),
                itemBuilder: (_, i) {
                  return ListTile(
                    onTap: () => sideMenuItems[i].onTap(context),
                    leading: Icon(
                      sideMenuItems[i].icon,
                      color: Colors.white,
                    ),
                    title: Text(
                      sideMenuItems[i].text,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, i) => const Divider(
                  color: Colors.white,
                ),
                itemCount: sideMenuItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
