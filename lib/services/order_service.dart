// lib/services/order_service.dart

import '../domain/entities/product.dart';

class OrderItemModel {
  final String id;
  final List<Product> items;
  final int total;
  final String status; // 'Pendiente', 'Preparando', 'Enviado', 'Entregado'
  final String dateStr;

  OrderItemModel({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.dateStr,
  });
}

class OrderService {
  // Lista global que incluye algunas órdenes de ejemplo y las nuevas que compre el usuario
  static final List<OrderItemModel> myOrders = [
    OrderItemModel(
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
    OrderItemModel(
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
        Product(
          id: 'c1',
          title: 'Camisa de Lino',
          category: 'Camisas',
          price: '\$89.000',
          rating: 4.8,
          description:
              'Camisa de lino natural. Fresca y sofisticada para cualquier ocasión.',
          imageUrl:
              'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500',
        ),
      ],
      total: 120000,
      status: 'Enviado',
      dateStr: '05 Ago 2026',
    ),
  ];

  static void addOrder(List<Product> products, int totalAmount) {
    final newOrder = OrderItemModel(
      id: 'RU-2026-${DateTime.now().millisecond}',
      items: List.from(products),
      total: totalAmount,
      status: 'Pendiente',
      dateStr: 'Hoy',
    );
    myOrders.insert(0, newOrder);
  }
}
