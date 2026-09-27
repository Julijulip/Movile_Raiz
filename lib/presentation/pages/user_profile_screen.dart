// lib/presentation/pages/user_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class UserProfileScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const UserProfileScreen({super.key, required this.onLogout});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String _userName = 'juli';
  String _userEmail = 'julianadiazmesa1@gmail.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'juli';
      _userEmail =
          prefs.getString('user_email') ?? 'julianadiazmesa1@gmail.com';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: RaizUrbanaApp.themeNotifier,
      builder: (context, themeMode, child) {
        final isDark = themeMode == ThemeMode.dark;

        // Colores adaptados
        final scaffoldBg = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);
        final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
        final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
        final iconCircleBg = isDark
            ? const Color(0xFF2E3148)
            : const Color(0xFFF3ECE7);
        final dividerColor = isDark ? Colors.white10 : Colors.grey.shade200;

        final initialLetter = _userName.isNotEmpty
            ? _userName[0].toUpperCase()
            : 'J';

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            backgroundColor: cardBg,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: isDark
                          ? const Color(0xFF2E3148)
                          : const Color(0xFFEBE3DB),
                      radius: 16,
                      child: Text(
                        'RU',
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF2C2C3E),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Raíz Urbana',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2E3148)
                        : const Color(0xFFE5DDD5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: textPrimary, size: 18),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Tarjeta de Información del Usuario
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF383C56),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Text(
                            initialLetter,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _userEmail,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1A1C28)
                                    : const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Cliente activo',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Métricas (Pedidos, Completados, Pendientes)
                Row(
                  children: [
                    _buildStatCard('3', 'Pedidos', cardBg, textPrimary),
                    const SizedBox(width: 10),
                    _buildStatCard('1', 'Completados', cardBg, textPrimary),
                    const SizedBox(width: 10),
                    _buildStatCard('0', 'Pendientes', cardBg, textPrimary),
                  ],
                ),
                const SizedBox(height: 20),

                // Sección Mi Cuenta
                const Text(
                  'MI CUENTA',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildOptionTile(
                        Icons.card_travel_outlined,
                        'Mis compras',
                        '3 pedidos',
                        iconCircleBg,
                        textPrimary,
                      ),
                      Divider(height: 1, indent: 50, color: dividerColor),
                      _buildOptionTile(
                        Icons.person_outline,
                        'Datos personales',
                        'Nombre, correo, teléfono',
                        iconCircleBg,
                        textPrimary,
                      ),
                      Divider(height: 1, indent: 50, color: dividerColor),
                      _buildOptionTile(
                        Icons.location_on_outlined,
                        'Mis direcciones',
                        'Gestionar direcciones',
                        iconCircleBg,
                        textPrimary,
                      ),
                      Divider(height: 1, indent: 50, color: dividerColor),
                      _buildOptionTile(
                        Icons.credit_card_outlined,
                        'Métodos de pago',
                        'Tarjetas y cuentas',
                        iconCircleBg,
                        textPrimary,
                      ),
                      Divider(height: 1, indent: 50, color: dividerColor),
                      _buildOptionTile(
                        Icons.notifications_none_outlined,
                        'Notificaciones',
                        'Preferencias de avisos',
                        iconCircleBg,
                        textPrimary,
                      ),
                      Divider(height: 1, indent: 50, color: dividerColor),
                      _buildOptionTile(
                        Icons.settings_outlined,
                        'Configuración',
                        'Cuenta y privacidad',
                        iconCircleBg,
                        textPrimary,
                      ),
                      Divider(height: 1, indent: 50, color: dividerColor),
                      _buildOptionTile(
                        Icons.shield_outlined,
                        'Ayuda y soporte',
                        'Preguntas frecuentes',
                        iconCircleBg,
                        textPrimary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // BOTÓN APARIENCIA INTERACTIVO
                GestureDetector(
                  onTap: () {
                    RaizUrbanaApp.toggleTheme();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: iconCircleBg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isDark
                                ? Icons.nightlight_round
                                : Icons.wb_sunny_outlined,
                            size: 18,
                            color: isDark
                                ? const Color(0xFF8B92B0)
                                : Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'APARIENCIA',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                isDark
                                    ? 'Modo oscuro activo'
                                    : 'Modo claro activo',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1A1C28)
                                : const Color(0xFFF3ECE7),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            isDark ? 'Oscuro' : 'Claro',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Botón de Cerrar Sesión
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onLogout();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2C1C20)
                          : const Color(0xFFFFEAEA),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF4A2026)
                            : const Color(0xFFFFD6D6),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF4A2026)
                                : const Color(0xFFFFD6D6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.logout,
                            size: 16,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Cerrar sesión',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
    String number,
    String label,
    Color cardBg,
    Color textPrimary,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(
    IconData icon,
    String title,
    String subtitle,
    Color iconBg,
    Color textPrimary,
  ) {
    return ListTile(
      dense: true,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
        child: Icon(icon, size: 16, color: textPrimary),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
