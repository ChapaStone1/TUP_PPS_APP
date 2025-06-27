import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/AuthService.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/helpers/preferences.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool darkMode = Preferences.darkmode;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authService = AuthService();
    final result = await authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'] ?? 'Error desconocido')),
    );

    if (result['ok']) {
      final tipo = result['tipo'];
      if (tipo == 'medico') {
        Navigator.pushReplacementNamed(context, '/home-medico');
      } else if (tipo == 'paciente') {
        Navigator.pushReplacementNamed(context, '/home-paciente');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tipo de usuario desconocido')),
        );
      }
    }
  }

  void _mostrarDialogoSoporte() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Soporte Técnico'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Contactarse con el soporte técnico:\n\n'
                '📧 chapapr@gmail.com\n'
                '📞 291-4705104\n\n'
                'Alumno: Juan Jose Chaparro\n'
                'Legajo Académico: 21737\n'
                'UTN - TUP | PPS 2025',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Image.asset(
                'lib/assets/images/UTN.png',
                height: 40,
                fit: BoxFit.contain,
                color: const Color(0xFF03A9F4),
                colorBlendMode: BlendMode.srcIn,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<ThemeProvider>(context, listen: false);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: [
          Row(
            children: [
              const Icon(Icons.dark_mode),
              Switch(
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                    Preferences.darkmode = value;
                    if (value) {
                      temaProvider.setDark();
                    } else {
                      temaProvider.setLight();
                    }
                  });
                },
                activeColor: Colors.white,
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor.withAlpha((0.8 * 255).round()),
                primaryColor.withAlpha((0.4 * 255).round()),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                shadowColor: primaryColor.withAlpha((0.5 * 255).round()),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Consultorio Médico UTN',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 2),
                                blurRadius: 3,
                                color:
                                    primaryColor.withAlpha((0.5 * 255).round()),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo requerido';
                            }
                            if (!value.contains('@')) return 'Correo inválido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Campo requerido'
                              : null,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 8,
                                    shadowColor: primaryColor
                                        .withAlpha((0.7 * 255).round()),
                                  ),
                                  child: const Text(
                                    'Ingresar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _mostrarDialogoSoporte,
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            '¿No tenés cuenta? Registrate',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Imagen + Texto al final
                        Column(
                          children: [
                            Image.asset(
                              'lib/assets/images/UTN.png',
                              height: 40,
                              fit: BoxFit.contain,
                              color: primaryColor,
                              colorBlendMode: BlendMode.srcIn,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'UTN - TUP | PPS 2025',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
