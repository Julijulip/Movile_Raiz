// lib/presentation/pages/admin_main_navigation_screen.dart

import 'package:flutter/material.dart';
import '../../main.dart';
import 'admin_dashboard_screen.dart';
import 'admin_sales_screen.dart';
import 'admin_purchases_screen.dart';
import 'admin_products_screen.dart';

class AdminMainNavigationScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const AdminMainNavigationScreen({super.key, this.onLogout});

  @override
  State<AdminMainNavigationScreen> createState() =>
      _AdminMainNavigationScreenState();
}

class _AdminMainNavigationScreenState extends State<AdminMainNavigationScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const AdminDashboardScreen(),
      const AdminSalesScreen(),
      const AdminPurchasesScreen(),
      AdminProductsScreen(onLogout: widget.onLogout),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: RaizUrbanaApp.themeNotifier,
      builder: (context, themeMode, child) {
        final isDark = themeMode == ThemeMode.dark;

        final navBarBg = isDark ? const Color(0xFF242736) : Colors.white;
        final activeColor = isDark ? Colors.white : const Color(0xFF2E3148);
        final inactiveColor = isDark
            ? const Color(0xFF9CA3AF)
            : const Color(0xFF8B8FA8);

        return Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: navBarBg,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: navBarBg,
              selectedItemColor: activeColor,
              unselectedItemColor: inactiveColor,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 11,
              ),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.show_chart_rounded),
                  activeIcon: Icon(Icons.show_chart_rounded, size: 26),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  activeIcon: Icon(Icons.shopping_bag, size: 26),
                  label: 'Ventas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  activeIcon: Icon(Icons.shopping_cart, size: 26),
                  label: 'Compras',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  activeIcon: Icon(Icons.inventory_2, size: 26),
                  label: 'Productos',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
