import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/core/theme/theme.dart';
import 'package:my_first_flutter_app/locator.dart';
import 'package:my_first_flutter_app/stores/auth_store.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authStore = locator<AuthStore>();

    return Drawer(
      child: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: ThemeSwitcher.withTheme(
                builder: (_, switcher, theme) {
                  return IconButton(
                    onPressed: () => Theme
                        .of(context)
                        .brightness == Brightness.light ? switcher.changeTheme(theme: darkTheme) : switcher.changeTheme(theme: lightTheme),
                    icon: Icon(theme.brightness == Brightness.light ? Icons.brightness_3 : Icons.brightness_7),
                  );
                },
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.business_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Products',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            onTap: () {
              authStore.logoutUser();
              GoRouter.of(context).push('/login');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
