// lib/screens/auth_modal.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModal extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const AuthModal({super.key, required this.onLoginSuccess});

  @override
  State<AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends State<AuthModal> {
  bool isRegisterView = false;

  // Controladores de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Guardar en almacenamiento local (LocalStorage)
  Future<void> _handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      _showMessage('Por favor completa todos los campos');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
    await prefs.setBool('is_logged_in', true);

    _showMessage('¡Cuenta creada e inicio de sesión exitoso!');
    if (mounted) {
      Navigator.pop(context);
      widget.onLoginSuccess();
    }
  }

  // Validar credenciales almacenadas
  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('user_email');
    final savedPassword = prefs.getString('user_password');

    if (email == savedEmail && password == savedPassword && email.isNotEmpty) {
      await prefs.setBool('is_logged_in', true);
      _showMessage('¡Bienvenido de nuevo!');
      if (mounted) {
        Navigator.pop(context);
        widget.onLoginSuccess();
      }
    } else {
      _showMessage('Correo o contraseña incorrectos');
    }
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Encabezado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isRegisterView ? 'Crear cuenta' : 'Iniciar sesión',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E1E2C)),
                ),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Color(0xFFF2ECE6), shape: BoxShape.circle),
                    child: const Icon(Icons.close, size: 18, color: Colors.grey),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isRegisterView
                  ? 'Regístrate para guardar tu carrito y realizar pedidos.'
                  : 'Inicia sesión para finalizar tu compra. Tu carrito se conservará.',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 20),

            // Campo de Nombre (solo en Registro)
            if (isRegisterView) ...[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline, color: Colors.grey, size: 20),
                  hintText: 'Nombre completo',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Campo Correo
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey, size: 20),
                hintText: 'correo@email.com',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              ),
            ),
            const SizedBox(height: 12),

            // Campo Contraseña
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey, size: 20),
                hintText: 'Contraseña',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              ),
            ),
            const SizedBox(height: 20),

            // Botón principal
            ElevatedButton(
              onPressed: isRegisterView ? _handleRegister : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A2D43),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isRegisterView ? 'Registrarse' : 'Iniciar sesión',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),

            // Alternar vista
            TextButton(
              onPressed: () => setState(() => isRegisterView = !isRegisterView),
              child: Text(
                isRegisterView ? '¿Ya tienes cuenta? Iniciar sesión' : 'Crear cuenta nueva',
                style: const TextStyle(color: Color(0xFF1E1E2C), fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}