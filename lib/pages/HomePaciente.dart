import 'package:flutter/material.dart' hide Route;
import 'package:flutter_application_1/widgets/NavigatorCardWidget.dart';
import 'package:flutter_application_1/widgets/DrawerMenu.dart';
import 'package:flutter_application_1/MainRouter.dart';

class HomePaciente extends StatelessWidget {
  final String title;

  const HomePaciente({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final List<Route> routes = MainRouter.pacienteRoutes;
    final theme = Theme.of(context);
    final primary = theme.primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 4,
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      drawer: DrawerMenu(routes: routes),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ColorFiltered(
                              colorFilter:
                                  ColorFilter.mode(primary, BlendMode.srcIn),
                              child: Image.asset(
                                'lib/assets/images/UTN.png',
                                height: 140,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'PPS UTN | 2025',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...routes.where((r) => r.show).map(
                            (route) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: NavigatorCardWidget(
                                title: route.title,
                                route: route.path,
                                icon: route.icon,
                                subtitle: route.subtitle,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
