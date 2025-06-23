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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/UTN.png',
                            height: 180,
                            fit: BoxFit.contain,
                            color: Theme.of(context).primaryColor,
                            colorBlendMode: BlendMode.srcIn,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'PPS UTN | 2025',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 🟢 Lista de tarjetas
                    ...routes.where((r) => r.show).map(
                          (route) => NavigatorCardWidget(
                            title: route.title,
                            route: route.path,
                            icon: route.icon,
                            subtitle: route.subtitle,
                          ),
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
