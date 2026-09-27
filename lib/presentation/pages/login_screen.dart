// lib/presentation/pages/login_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthMode { login, register, forgotPassword, successRegister }

class LoginScreen extends StatefulWidget {
  final Function(String role) onLoginSuccess;

  const LoginScreen({super.key, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMode _currentMode = AuthMode.login;
  bool _obscurePassword = true;
  String _registeredEmail = '';

  // Controllers - Login
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Controllers - Registro
  final TextEditingController _regNameController = TextEditingController();
  final TextEditingController _regEmailController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();
  final TextEditingController _regPhoneController = TextEditingController();
  final TextEditingController _regAddressController = TextEditingController();

  // Dropdowns - Registro
  String _selectedGender = 'Hombre';

  // Constantes de prueba
  static const String adminEmail = 'raiz@admin.com';
  static const String adminPassword = '123';
  static const String defaultClientEmail = 'cliente@raizurbana.com';
  static const String defaultClientPassword = 'cliente123';

  // Estilos de color
  final Color _bgColor = const Color(0xFFF3ECE7);
  final Color _cardColor = Colors.white;
  final Color _primaryDark = const Color(0xFF3B3E51);
  final Color _textMuted = const Color(0xFF9E9E9E);
  final Color _labelColor = const Color(0xFF7A7A7A);

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Por favor ingresa correo y contraseña');
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    if (email == adminEmail && password == adminPassword) {
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_role', 'admin');
      widget.onLoginSuccess('admin');
      return;
    }

    if (email == defaultClientEmail && password == defaultClientPassword) {
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_role', 'client');
      widget.onLoginSuccess('client');
      return;
    }

    final savedEmail = prefs.getString('user_email');
    final savedPassword = prefs.getString('user_password');
    final savedRole = prefs.getString('user_role') ?? 'client';

    if (email == savedEmail && password == savedPassword && email.isNotEmpty) {
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_role', savedRole);
      widget.onLoginSuccess(savedRole);
    } else {
      _showMessage('Correo o contraseña incorrectos');
    }
  }

  Future<void> _handleRegister() async {
    final email = _regEmailController.text.trim();
    final password = _regPasswordController.text.trim();

    if (_regNameController.text.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage('Por favor completa los campos obligatorios');
      return;
    }

    // Guardar datos en LocalStorage (todo registro asigna rol cliente automáticamente)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _regNameController.text.trim());
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
    await prefs.setString('user_phone', _regPhoneController.text.trim());
    await prefs.setString('user_address', _regAddressController.text.trim());
    await prefs.setString('user_gender', _selectedGender);
    await prefs.setString('user_role', 'client');
    await prefs.setString('user_status', 'Activo');

    setState(() {
      _registeredEmail = email;
      _currentMode = AuthMode.successRegister;
    });
  }

  Future<void> _handleForgotPassword() async {
    if (_emailController.text.isEmpty) {
      _showMessage('Ingresa tu correo para enviarte el enlace');
      return;
    }
    _showMessage('Enlace de recuperación enviado a tu correo');
    setState(() => _currentMode = AuthMode.login);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: _buildCurrentView(),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (_currentMode) {
      case AuthMode.login:
        return _buildLoginCard();
      case AuthMode.forgotPassword:
        return _buildForgotPasswordView();
      case AuthMode.register:
        return _buildRegisterView();
      case AuthMode.successRegister:
        return _buildSuccessRegisterView();
    }
  }

  // ---------------------------------------------------------------------------
  // 1. VISTA DE INICIAR SESIÓN
  // ---------------------------------------------------------------------------
  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Image.asset(
              'assets/imagenes/logo.png',
              height: 65,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Sistema de gestión comercial',
              style: TextStyle(color: _textMuted, fontSize: 11),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Iniciar sesión',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _primaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Accede a tu panel de gestión',
            style: TextStyle(color: _textMuted, fontSize: 12),
          ),
          const SizedBox(height: 20),
          _buildFieldLabel('CORREO ELECTRÓNICO'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _emailController,
            hint: 'correo@empresa.com',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 16),
          _buildFieldLabel('CONTRASEÑA'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _passwordController,
            hint: '••••••••',
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: _textMuted,
                size: 20,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => setState(() => _currentMode = AuthMode.forgotPassword),
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: _primaryDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _handleLogin,
            icon: const Icon(Icons.shield_outlined, size: 18, color: Colors.white),
            label: const Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryDark,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿No tienes cuenta? ', style: TextStyle(color: _textMuted, fontSize: 13)),
              GestureDetector(
                onTap: () => setState(() => _currentMode = AuthMode.register),
                child: Text(
                  'Regístrate',
                  style: TextStyle(
                    color: _primaryDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. VISTA DE CONFIRMACIÓN DE REGISTRO EXITOSO
  // ---------------------------------------------------------------------------
  Widget _buildSuccessRegisterView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: _primaryDark,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 38,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          '¡Cuenta creada!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _primaryDark,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Tu cuenta ha sido registrada exitosamente.',
          style: TextStyle(color: _textMuted, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Text(
          _registeredEmail.isNotEmpty ? _registeredEmail : 'correo@empresa.com',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: _primaryDark,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Ya puedes iniciar sesión con tus credenciales.',
          style: TextStyle(color: _textMuted, fontSize: 11),
        ),
        const SizedBox(height: 36),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _emailController.text = _registeredEmail;
                _passwordController.clear();
                _currentMode = AuthMode.login;
              });
            },
            icon: const Icon(Icons.shield_outlined, size: 18, color: Colors.white),
            label: const Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryDark,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 3. VISTA DE RECUPERAR CONTRASEÑA
  // ---------------------------------------------------------------------------
  Widget _buildForgotPasswordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: _primaryDark, size: 18),
            onPressed: () => setState(() => _currentMode = AuthMode.login),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _primaryDark,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.near_me_outlined, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 20),
        Text(
          'Recuperar contraseña',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _primaryDark),
        ),
        const SizedBox(height: 8),
        Text(
          'Ingresa tu correo registrado y te enviaremos un enlace para restablecer tu contraseña.',
          style: TextStyle(color: _textMuted, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 24),
        _buildFieldLabel('CORREO ELECTRÓNICO'),
        const SizedBox(height: 6),
        _buildTextField(
          controller: _emailController,
          hint: 'correo@empresa.com',
          icon: Icons.email_outlined,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _handleForgotPassword,
            icon: const Icon(Icons.near_me_outlined, size: 18, color: Colors.white),
            label: const Text(
              'Enviar enlace',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryDark,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => setState(() => _currentMode = AuthMode.login),
            icon: Icon(Icons.arrow_back, size: 16, color: _primaryDark),
            label: Text(
              'Volver al inicio de sesión',
              style: TextStyle(color: _primaryDark, fontWeight: FontWeight.w600, fontSize: 13),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 4. VISTA DE CREAR CUENTA
  // ---------------------------------------------------------------------------
  Widget _buildRegisterView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: _primaryDark, size: 16),
                onPressed: () => setState(() => _currentMode = AuthMode.login),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crear cuenta',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _primaryDark),
                ),
                Text(
                  'Completa los datos para registrarte',
                  style: TextStyle(color: _textMuted, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Bloque 1: Información de cuenta
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel('INFORMACIÓN DE CUENTA'),
              const SizedBox(height: 14),
              _buildFieldLabel('NOMBRE'),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _regNameController,
                hint: 'Ingresa tu nombre',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 14),
              _buildFieldLabel('CORREO ELECTRÓNICO'),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _regEmailController,
                hint: 'Ingresa tu correo electrónico',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 14),
              _buildFieldLabel('CONTRASEÑA'),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _regPasswordController,
                hint: 'Mínimo 6 caracteres',
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: _textMuted,
                    size: 18,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Bloque 2: Información personal
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel('INFORMACIÓN PERSONAL'),
              const SizedBox(height: 14),
              _buildFieldLabel('TELÉFONO'),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _regPhoneController,
                hint: 'Ingresa tu teléfono',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),
              _buildFieldLabel('DIRECCIÓN'),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _regAddressController,
                hint: 'Ingresa tu dirección',
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 14),
              _buildFieldLabel('GÉNERO'),
              const SizedBox(height: 6),
              _buildDropdownField(
                value: _selectedGender,
                items: ['Hombre', 'Mujer', 'Otro'],
                onChanged: (val) => setState(() => _selectedGender = val!),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _handleRegister,
            icon: const Icon(Icons.person_add_alt_1_outlined, size: 18, color: Colors.white),
            label: const Text(
              'Crear cuenta',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryDark,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
          ),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿Ya tienes cuenta? ', style: TextStyle(color: _textMuted, fontSize: 13)),
            GestureDetector(
              onTap: () => setState(() => _currentMode = AuthMode.login),
              child: Text(
                'Inicia sesión',
                style: TextStyle(
                  color: _primaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // WIDGETS AUXILIARES REUTILIZABLES
  // ---------------------------------------------------------------------------
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: _labelColor,
        letterSpacing: 0.6,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: _textMuted, fontSize: 13),
          prefixIcon: Icon(icon, color: _textMuted, size: 18),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: _textMuted),
          style: TextStyle(color: _primaryDark, fontSize: 13),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
        ),
      ),
    );
  }
}