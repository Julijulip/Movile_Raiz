// lib/screens/register_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  final Function(String)? onRegisterSuccess;

  const RegisterScreen({super.key, this.onRegisterSuccess});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _obscurePassword = true;
  String _selectedGender = 'Hombre';
  String _selectedRole = 'Cliente';
  String _selectedStatus = 'Activo';

  final List<String> _genders = ['Hombre', 'Mujer', 'Otro'];
  final List<String> _roles = ['Cliente', 'Administrador'];
  final List<String> _statuses = ['Activo', 'Inactivo'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage('Por favor completa los campos obligatorios');
      return;
    }

    if (password.length < 6) {
      _showMessage('La contraseña debe tener mínimo 6 caracteres');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
    await prefs.setString('user_phone', phone);
    await prefs.setString('user_address', address);
    await prefs.setString('user_gender', _selectedGender);
    await prefs.setString('user_role', _selectedRole);
    await prefs.setString('user_status', _selectedStatus);
    await prefs.setBool('is_logged_in', true);

    _showMessage('¡Cuenta creada e información guardada localmente!');

    if (widget.onRegisterSuccess != null) {
      widget.onRegisterSuccess!(
        _selectedRole == 'Administrador' ? 'admin' : 'client',
      );
    } else if (mounted) {
      Navigator.pop(context);
    }
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3ECE6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFE8DFD8),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF2E3148),
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Crear cuenta',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E3148),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Completa los datos para registrarte',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // TARJETA 1: INFORMACIÓN DE CUENTA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INFORMACIÓN DE CUENTA',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('NOMBRE'),
                  _buildTextField(
                    _nameController,
                    'Ingresa tu nombre',
                    Icons.person_outline,
                  ),
                  const SizedBox(height: 14),
                  _buildLabel('CORREO ELECTRÓNICO'),
                  _buildTextField(
                    _emailController,
                    'Ingresa tu correo electrónico',
                    Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  _buildLabel('CONTRASEÑA'),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2E3148),
                    ),
                    decoration:
                        _inputDecoration(
                          'Mínimo 6 caracteres',
                          Icons.lock_outline,
                        ).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // TARJETA 2: INFORMACIÓN PERSONAL
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INFORMACIÓN PERSONAL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('TELÉFONO'),
                  _buildTextField(
                    _phoneController,
                    'Ingresa tu teléfono',
                    Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 14),
                  _buildLabel('DIRECCIÓN'),
                  _buildTextField(
                    _addressController,
                    'Ingresa tu dirección',
                    Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 14),
                  _buildLabel('GÉNERO'),
                  _buildDropdown(
                    _selectedGender,
                    _genders,
                    (val) => setState(() => _selectedGender = val!),
                  ),
                  const SizedBox(height: 14),
                  _buildLabel('ROL'),
                  _buildDropdown(
                    _selectedRole,
                    _roles,
                    (val) => setState(() => _selectedRole = val!),
                  ),
                  const SizedBox(height: 14),
                  _buildLabel('ESTADO'),
                  _buildDropdown(
                    _selectedStatus,
                    _statuses,
                    (val) => setState(() => _selectedStatus = val!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Botón Crear Cuenta
            ElevatedButton(
              onPressed: _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF383C56),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.person_add_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Crear cuenta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Enlace a Iniciar sesión
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¿Ya tienes cuenta? ',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Inicia sesión',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E3148),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: Color(0xFF2E3148)),
      decoration: _inputDecoration(hint, icon),
    );
  }

  Widget _buildDropdown(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor:
          Colors.white, // Fuerza el fondo blanco del menú desplegable
      style: const TextStyle(fontSize: 14, color: Color(0xFF2E3148)),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(fontSize: 14, color: Color(0xFF2E3148)),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      borderRadius: BorderRadius.circular(
        16.0,
      ), // Bordes redondeados para el menú flotante
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Color(0xFF383C56), width: 1.5),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
      prefixIcon: Icon(icon, color: Colors.grey[400], size: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Color(0xFF383C56), width: 1.5),
      ),
    );
  }
}
