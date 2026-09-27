// lib/main.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Capa de Dominio
import 'domain/entities/product.dart';

// Capa de Presentación (Páginas)
import 'presentation/pages/splash_screen.dart';
import 'presentation/pages/login_screen.dart';
import 'presentation/pages/home_screen.dart';
import 'presentation/pages/shop_screen.dart';
import 'presentation/pages/cart_screen.dart';
import 'presentation/pages/orders_screen.dart'; // 👈 Importación correcta de tus compras
import 'presentation/pages/user_profile_screen.dart';
import 'presentation/pages/admin_main_navigation_screen.dart';

void main() {
  runApp(const RaizUrbanaApp());
}

class RaizUrbanaApp extends StatefulWidget {
  const RaizUrbanaApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  static Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = themeNotifier.value == ThemeMode.dark;
    themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
    await prefs.setBool('is_dark_mode', !isDark);
  }

  @override
  State<RaizUrbanaApp> createState() => _RaizUrbanaAppState();
}

class _RaizUrbanaAppState extends State<RaizUrbanaApp> {
  bool _showSplash = true;
  bool _isLoggedIn = false;
  String _userRole = 'admin';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('is_logged_in') ?? false;
    final role = prefs.getString('user_role') ?? 'admin';
    final isDark = prefs.getBool('is_dark_mode') ?? false;

    RaizUrbanaApp.themeNotifier.value = isDark
        ? ThemeMode.dark
        : ThemeMode.light;

    setState(() {
      _isLoggedIn = loggedIn;
      _userRole = role;
    });
  }

  void _onSplashComplete() {
    setState(() {
      _showSplash = false;
    });
  }

  void _onLoginSuccess(String role) {
    setState(() {
      _userRole = role;
      _isLoggedIn = true;
      _showSplash = false;
    });
  }

  void _onLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
    setState(() {
      _isLoggedIn = false;
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: RaizUrbanaApp.themeNotifier,
      builder: (_, currentMode, _) {
        return MaterialApp(
          title: 'Raíz Urbana',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5EFEA),
            cardColor: Colors.white,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF12131C),
            cardColor: const Color(0xFF1E202E),
            useMaterial3: true,
          ),
          home: _showSplash
              ? SplashScreen(onAnimationComplete: _onSplashComplete)
              : (_isLoggedIn
                    ? (_userRole == 'admin'
                          ? AdminMainNavigationScreen(onLogout: _onLogout)
                          : MainNavigationScreen(onLogout: _onLogout))
                    : LoginScreen(onLoginSuccess: _onLoginSuccess)),
        );
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const MainNavigationScreen({super.key, required this.onLogout});

  @override
  State<MainNavigationScreen> createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final List<Product> _cartItems = [];
  String _userName = 'juli';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'juli';
    });
  }

  void setTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });
  }

  void _removeFromCart(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _goToCart() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Widget> pages = [
      HomeScreen(onAddToCart: _addToCart, onBuyNow: _goToCart),
      const ShopScreen(),
      CartScreen(cartItems: _cartItems, onRemoveFromCart: _removeFromCart),
      const OrdersScreen(), // 👈 Instancia correcta de tu pantalla de compras
    ];

    final initialLetter = _userName.isNotEmpty
        ? _userName[0].toUpperCase()
        : 'J';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            color: isDark ? const Color(0xFF1E202E) : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: isDark
                          ? const Color(0xFF2E3148)
                          : const Color(0xFFEBE3DB),
                      radius: 18,
                      child: Text(
                        'RU',
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF2C2C3E),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Raíz Urbana',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: isDark ? Colors.white : const Color(0xFF1E1E2C),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserProfileScreen(onLogout: widget.onLogout),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2E3148)
                          : const Color(0xFFF3ECE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: isDark
                              ? const Color(0xFF535878)
                              : const Color(0xFF383C56),
                          child: Text(
                            initialLetter,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _userName,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF2E3148),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: isDark ? Colors.grey[400] : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: isDark ? const Color(0xFF1E202E) : Colors.white,
        selectedItemColor: isDark
            ? const Color(0xFF8B92B0)
            : const Color(0xFF2E3148),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Tienda',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('${_cartItems.length}'),
              isLabelVisible: _cartItems.isNotEmpty,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            label: 'Carrito',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Compras',
          ),
        ],
      ),
    );
  }
}
