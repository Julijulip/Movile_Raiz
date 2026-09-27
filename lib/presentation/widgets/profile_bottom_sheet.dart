// lib/presentation/widgets/profile_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../pages/admin_profile_screen.dart';
import '../pages/login_screen.dart'; // 👈 Asegúrate de tener este import

void showAdminProfileModal(BuildContext context, {VoidCallback? onLogout}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (modalContext) {
      return ValueListenableBuilder<ThemeMode>(
        valueListenable: RaizUrbanaApp.themeNotifier,
        builder: (context, themeMode, child) {
          final isDark = themeMode == ThemeMode.dark;

          final modalBg = isDark ? const Color(0xFF242736) : Colors.white;
          final handleBg = isDark ? Colors.grey.shade700 : Colors.grey.shade300;
          final userCardBg = isDark ? const Color(0xFF1A1C28) : Colors.white;
          final userCardBorder = isDark
              ? const Color(0xFF383C56)
              : Colors.grey.shade200;
          final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
          final textSecondary = isDark ? Colors.grey.shade400 : Colors.grey;

          final optionIconBg = isDark
              ? const Color(0xFF2E3148)
              : const Color(0xFFF3ECE7);
          final optionIconColor = isDark
              ? Colors.white
              : const Color(0xFF2E3148);
          final badgeBg = isDark
              ? const Color(0xFF2E3148)
              : const Color(0xFFF3ECE7);

          return Container(
            decoration: BoxDecoration(
              color: modalBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Indicador superior de arrastre
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: handleBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),

                // Tarjeta de Usuario
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: userCardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: userCardBorder),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E3148),
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              'AV',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF22C55E),
                                shape: BoxShape.circle,
                                border: Border.all(color: userCardBg, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Adrian Villadiego',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: const [
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Color(0xFF22C55E),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'En línea',
                                  style: TextStyle(
                                    color: Color(0xFF22C55E),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                            color: textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Opción 1: Mi Perfil
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: optionIconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: optionIconColor,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Mi Perfil',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    'Cuenta y configuración',
                    style: TextStyle(fontSize: 11, color: textSecondary),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: textSecondary,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.pop(modalContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminProfileScreen(onLogout: onLogout),
                      ),
                    );
                  },
                ),

                // Opción 2: Ajustes
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: optionIconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.settings_outlined,
                      color: optionIconColor,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Ajustes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textPrimary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: textSecondary,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.pop(modalContext);
                  },
                ),

                // Opción 3: Cerrar sesión
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF3B1E1E)
                          : const Color(0xFFFFEAEA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.redAccent,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  onTap: () async {
                    // 1. Borrar datos de la sesión local
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('is_logged_in', false);
                    await prefs.remove('user_role');

                    // 2. Redirigir directamente al Login eliminando todo lo demás
                    if (context.mounted) {
                      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            onLoginSuccess: (role) {
                              // Callback para cuando vuelva a iniciar sesión
                              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
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
                ),

                const SizedBox(height: 12),

                Text(
                  'Raíz Urbana - v2.4.1',
                  style: TextStyle(fontSize: 10, color: textSecondary),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  );
}