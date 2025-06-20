// ignore: unused_import
// ignore_for_file: use_super_parameters

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart' hide Route;
import 'package:flutter_application_1/MainRouter.dart';
import 'package:flutter_application_1/helpers/preferences.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  final List<Route> routes;
  const DrawerMenu({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeaderAlternative(screenWidth: screenWidth),
          ...ListTile.divideTiles(
            context: context,
            tiles: routes.where((route) => route.show).map((route) => ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  dense: true,
                  minLeadingWidth: 25,
                  iconColor: Colors.blueGrey,
                  title: Text(route.title,
                      style: const TextStyle(fontFamily: 'CoolveticaRG')),
                  leading: route.icon,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, route.path);
                  },
                )),
          ).toList()
        ],
      ),
    );
  }
}

class _DrawerHeaderAlternative extends StatefulWidget {
  final double screenWidth;
  const _DrawerHeaderAlternative({
    required this.screenWidth,
  });

  @override
  State<_DrawerHeaderAlternative> createState() =>
      _DrawerHeaderAlternativeState();
}

class _DrawerHeaderAlternativeState extends State<_DrawerHeaderAlternative> {
  bool darkMode = false;
  List<Offset> positions = [];
  Timer? timer; // Declarar el Timer como nullable

  @override
  void initState() {
    super.initState();
    darkMode = Preferences.darkmode;
    positions = List.generate(30, (_) => getStartPosition());

    timer = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      if (mounted) {
        changePositions();
      }
    });
  }

  Offset getRandomPosition() {
    return Offset(getRandomLeftPosition(), getRandomTopPosition(100));
  }

  Offset getStartPosition() {
    return Offset(widget.screenWidth * 0.5, -100);
  }

  void changePositions() {
    setState(() {
      positions = List.generate(30, (_) => getRandomPosition());
    });
  }

  double getRandomTopPosition(int max) {
    return Random().nextDouble() * max;
  }

  double getRandomLeftPosition() {
    return Random().nextDouble() * (widget.screenWidth * 0.8);
  }

  double getRandomSide(int max) {
    return Random().nextDouble() * max;
  }

  Color getRandomColor() {
    return Color.fromRGBO(
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextDouble(),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancela el Timer al destruir el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<ThemeProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        setState(() {
          darkMode = !darkMode;
          Preferences.darkmode = darkMode;
          darkMode ? temaProvider.setDark() : temaProvider.setLight();
          // Cambiar posiciones al hacer tap
          positions = List.generate(30, (_) => getRandomPosition());
        });
      },
      child: DrawerHeader(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            ...List.generate(30, (index) {
              return AnimatedPositioned(
                duration: const Duration(
                    milliseconds: 1500), // Duración de la animación
                curve: Curves.easeInOut, // Curva de animación
                top: positions[index].dy,
                left: positions[index].dx,
                child: Container(
                  width: getRandomSide(50),
                  height: getRandomSide(50),
                  decoration: BoxDecoration(
                    color: getRandomColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  transform: Matrix4.rotationZ(Random().nextDouble()),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
