import 'package:flutter/material.dart' hide Route;
import 'package:flutter_application_1/MainRouter.dart';
import 'package:flutter_application_1/widgets/NavigatorCardWidget.dart';
import 'package:flutter_application_1/widgets/DrawerMenu.dart';

class HomePaciente extends StatelessWidget {
  final String title;
  final List<Route> routes;

  const HomePaciente({super.key, required this.title, required this.routes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: DrawerMenu(routes: routes),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: const Text("Home",
                style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic)),
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
