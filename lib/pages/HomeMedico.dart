import 'package:flutter/material.dart' hide Route;
import 'package:flutter_application_1/widgets/NavigatorCardWidget.dart';
import 'package:flutter_application_1/widgets/DrawerMenu.dart';
import 'package:flutter_application_1/MainRouter.dart';

class HomeMedico extends StatelessWidget {
  final String title;

  const HomeMedico({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final List<Route> routes = MainRouter.medicoRoutes;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: DrawerMenu(routes: routes),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              "Home",
              style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            ),
          ),
          ...routes.where((r) => r.show).map((route) => NavigatorCardWidget(
                title: route.title,
                route: route.path,
                icon: route.icon,
                subtitle: route.subtitle,
              )),
        ],
      ),
    );
  }
}
