// lib/presentation/pages/orders_screen.dart

import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'product_detail_screen.dart';

class ClientOrderModel {
  final String id;
  final List<Product> items;
  final int total;
  final String status; // 'Entregado', 'Enviado', 'Preparando', 'Pendiente'
  final String dateStr;

  ClientOrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.dateStr,
  });
}

// Lista global estática para compartir las compras entre Checkout y Mis Compras de forma inmediata
class OrdersManager {
  static final List<ClientOrderModel> sharedOrders = [
    ClientOrderModel(
      id: 'RU-2026-001',
      items: [
        Product(
          id: 'b1',
          title: 'Buso Hoodie Oversize',
          category: 'Busos',
          price: '\$98.000',
          rating: 4.9,
          description:
              'Sudadera con capota en algodón perchado de gramaje pesado.',
          imageUrl:
              'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=500',
        ),
      ],
      total: 98000,
      status: 'Entregado',
      dateStr: '28 Jul 2026',
    ),
    ClientOrderModel(
      id: 'RU-2026-002',
      items: [
        Product(
          id: 'j1',
          title: 'Jean Slim Fit',
          category: 'Jeans',
          price: '\$115.000',
          rating: 4.6,
          description:
              'Pantalón de mezclilla de corte ajustado en tono azul clásico.',
          imageUrl:
              'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500',
        ),
      ],
      total: 204000,
      status: 'Enviado',
      dateStr: '05 Ago 2026',
    ),
  ];

  static void addOrder(ClientOrderModel newOrder) {
    sharedOrders.insert(
      0,
      newOrder,
    ); // Inserta la nueva compra al inicio de la lista
  }
}

class OrdersScreen extends StatefulWidget {
  final Function(Product)? onAddToCart;
  final VoidCallback? onBuyNow;

  const OrdersScreen({super.key, this.onAddToCart, this.onBuyNow});

  @override
  State<OrdersScreen> createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  String _selectedOrderFilter = 'Todos';

  // Método público para actualizar la vista cuando se agregue una compra nueva
  void refreshOrders() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark
        ? const Color(0xFF141622)
        : const Color(0xFFF3ECE7);
    final cardBg = isDark ? const Color(0xFF1D2030) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
    final textSecondary = isDark ? const Color(0xFF8B8FA8) : Colors.grey;

    final filters = [
      'Todos',
      'Pendiente',
      'Preparando',
      'Enviado',
      'Entregado',
    ];

    final filteredOrders = OrdersManager.sharedOrders.where((order) {
      if (_selectedOrderFilter == 'Todos') return true;
      return order.status.toLowerCase() == _selectedOrderFilter.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Text(
                'Mis compras realizadas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ),

            // Filtros horizontales de estado
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = _selectedOrderFilter == filter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedOrderFilter = filter),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2E3148) : cardBg,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : textSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Listado de Órdenes
            Expanded(
              child: filteredOrders.isEmpty
                  ? Center(
                      child: Text(
                        'No hay compras registradas con este filtro',
                        style: TextStyle(color: textSecondary),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return GestureDetector(
                          onTap: () {
                            _showOrderDetailModal(
                              context,
                              order,
                              textPrimary,
                              textSecondary,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      order.id,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textPrimary,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getOrderStatusColor(
                                          order.status,
                                        ).withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        order.status,
                                        style: TextStyle(
                                          color: _getOrderStatusColor(
                                            order.status,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${order.dateStr} · ${order.items.length} producto(s)',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: order.items.map((item) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(item.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total pagado',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textSecondary,
                                      ),
                                    ),
                                    Text(
                                      '\$${order.total}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Modal para ver el detalle de los productos al hacer clic en una orden
  void _showOrderDetailModal(
    BuildContext context,
    ClientOrderModel order,
    Color textPrimary,
    Color textSecondary,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Detalle de Orden',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  Text(
                    order.id,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: order.items.map((product) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: product,
                              onAddToCart: () {
                                if (widget.onAddToCart != null) {
                                  widget.onAddToCart!(product);
                                }
                              },
                              onBuyNow: widget.onBuyNow,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F6F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.imageUrl,
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: textSecondary,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    product.price,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Pagado',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF2E3148),
                    ),
                  ),
                  Text(
                    '\$${order.total}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2E3148),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Color _getOrderStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'entregado':
        return Colors.green;
      case 'enviado':
        return Colors.blue;
      case 'preparando':
        return Colors.orange;
      case 'pendiente':
      default:
        return Colors.amber.shade700;
    }
  }
}
