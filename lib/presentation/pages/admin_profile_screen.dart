// lib/presentation/pages/admin_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'login_screen.dart';

class AdminProfileScreen extends StatelessWidget {
  final VoidCallback? onLogout;

  const AdminProfileScreen({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: RaizUrbanaApp.themeNotifier,
      builder: (context, themeMode, child) {
        final isDark = themeMode == ThemeMode.dark;

        // Paleta de colores idéntica a la de la pantalla de cliente
        final scaffoldBg = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);
        final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
        final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
        final iconCircleBg = isDark
            ? const Color(0xFF2E3148)
            : const Color(0xFFF3ECE7);
        final leadingCircleBg = isDark
            ? const Color(0xFF2E3148)
            : const Color(0xFFE8E0D9);
        final badgeBg = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: leadingCircleBg,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: textPrimary, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            title: Text(
              'Mi Perfil',
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8, top: 4),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2E3148)
                          : const Color(0xFFE3DAD4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: textPrimary,
                        size: 22,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF8B8FA8),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF2E3148),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  'AV',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Tarjeta Superior de Información Principal
                Container(
                  padding: const EdgeInsets.all(16),
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
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'AV',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
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
                              'Adrian Villadiego',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'avilladiego@raizurbana.com',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: badgeBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Administrador',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.grey.shade300
                                      : const Color(0xFF2E3148),
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

                // Campos de Información del Usuario
                _buildProfileTile(
                  icon: Icons.person_outline,
                  label: 'NOMBRE COMPLETO',
                  value: 'Adrian Villadiego',
                  cardBg: cardBg,
                  iconCircleBg: iconCircleBg,
                  textPrimary: textPrimary,
                ),
                _buildProfileTile(
                  icon: Icons.email_outlined,
                  label: 'CORREO ELECTRÓNICO',
                  value: 'avilladiego@raizurbana.com',
                  cardBg: cardBg,
                  iconCircleBg: iconCircleBg,
                  textPrimary: textPrimary,
                ),
                _buildProfileTile(
                  icon: Icons.phone_outlined,
                  label: 'TELÉFONO',
                  value: 'No registrado',
                  cardBg: cardBg,
                  iconCircleBg: iconCircleBg,
                  textPrimary: textPrimary,
                ),
                _buildProfileTile(
                  icon: Icons.shield_outlined,
                  label: 'ROL',
                  value: 'Administrador',
                  cardBg: cardBg,
                  iconCircleBg: iconCircleBg,
                  textPrimary: textPrimary,
                ),
                _buildProfileTile(
                  icon: Icons.calendar_today_outlined,
                  label: 'MIEMBRO DESDE',
                  value: 'Enero 2025',
                  cardBg: cardBg,
                  iconCircleBg: iconCircleBg,
                  textPrimary: textPrimary,
                ),

                // Opción de Apariencia Interactivo
                GestureDetector(
                  onTap: () {
                    RaizUrbanaApp.toggleTheme();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: iconCircleBg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isDark
                                ? Icons.nightlight_round
                                : Icons.wb_sunny_outlined,
                            color: isDark
                                ? const Color(0xFF8B92B0)
                                : Colors.amber,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'APARIENCIA',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.grey : Colors.amber,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
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
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(12),
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
                const SizedBox(height: 12),

                // Botón de Cerrar Sesión
                GestureDetector(
                  onTap: () async {
                    // 1. Limpiar la sesión persistente
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('is_logged_in', false);
                    await prefs.remove('user_role');

                    // 2. Notificar callback si se definió
                    if (onLogout != null) {
                      onLogout!();
                    }

                    // 3. Redirigir al Login destruyendo la pila de navegación
                    if (context.mounted) {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            onLoginSuccess: (role) {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const RaizUrbanaApp(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ),
                        (route) => false,
                      );
                    }
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        const Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String label,
    required String value,
    required Color cardBg,
    required Color iconCircleBg,
    required Color textPrimary,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconCircleBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: textPrimary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}
