import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/MainRouter.dart';
import 'package:flutter_application_1/helpers/preferences.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(isDarkMode: Preferences.darkmode),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context)
        .temaActual; // Escucha el cambio de tema

    return MaterialApp(
      title: 'Clinica UTN',
      theme: theme,
      home: const LoginPage(title: 'Clinica UTN'),
      routes: MainRouter.generateRoutes(context),
    );
  }
}
