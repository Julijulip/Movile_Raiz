// lib/presentation/pages/account_screen.dart

import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String selectedFilter = 'Todos';
  final List<String> filters = ['Todos', 'Pendiente', 'Preparando', 'Enviado'];

  // Lista de compras con URLs de ropa de Unsplash y fallback
  final List<Map<String, dynamic>> orders = [
    {
      'code': 'RU-2026-001',
      'date': '28 Jul 2026 · 1 producto',
      'total': '\$98.000',
      'status': 'Entregado',
      'statusBg': const Color(0xFF0E2A18),
      'statusColor': const Color(0xFF22C55E),
      'images': [
        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=80', // Camiseta Básica
      ],
    },
    {
      'code': 'RU-2026-002',
      'date': '05 Ago 2026 · 2 productos',
      'total': '\$120.000',
      'status': 'Enviado',
      'statusBg': const Color(0xFF252836),
      'statusColor': Colors.grey,
      'images': [
        'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=200&q=80', // Jeans Denim
        'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&w=200&q=80', // Chaqueta
      ],
    },
    {
      'code': 'RU-2026-003',
      'date': '15 Ago 2026 · 1 producto',
      'total': '\$188.000',
      'status': 'Preparando',
      'statusBg': Colors.transparent,
      'statusColor': Colors.grey,
      'images': [
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=200&q=80', // Chaqueta Cuero
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark
        ? const Color(0xFF141622)
        : const Color(0xFFF5EFEA);
    final cardBg = isDark ? const Color(0xFF1D2030) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF1E1E2C);
    final selectedChipBg = isDark
        ? const Color(0xFF535670)
        : const Color(0xFF2E3148);

    final filteredOrders = selectedFilter == 'Todos'
        ? orders
        : orders.where((order) => order['status'] == selectedFilter).toList();

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'Mis compras',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Filtros horizontales
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = filter == selectedFilter;
                  return GestureDetector(
                    onTap: () => setState(() => selectedFilter = filter),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? selectedChipBg : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? selectedChipBg : Colors.white24,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Lista de Compras
            ...filteredOrders.map((order) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order['code'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: order['statusBg'],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            order['status'],
                            style: TextStyle(
                              color: order['statusColor'],
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order['date'],
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),

                    // Renderizado de Miniaturas de Ropa
                    Row(
                      children: (order['images'] as List<String>).map((imgUrl) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              imgUrl,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                              // Si falla la red, muestra un ícono de prenda sin romper la pantalla
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF282C3F),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.checkroom,
                                    size: 16,
                                    color: Colors.white70,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(color: Colors.white12, height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          order['total'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF8B92B0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
