// lib/presentation/pages/admin_sales_screen.dart

import 'package:flutter/material.dart';
import '../../main.dart';
import '../../domain/entities/product.dart';
import '../widgets/profile_bottom_sheet.dart';
import 'admin_products_screen.dart';

class SaleProduct {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  SaleProduct({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class SaleItem {
  final String code;
  final String clientName;
  final String email;
  final String initials;
  final Color avatarColor;
  final String date;
  final String total;
  final String status; // 'Pagado', 'Pendiente', 'Cancelado'
  final List<SaleProduct> items;

  SaleItem({
    required this.code,
    required this.clientName,
    required this.email,
    required this.initials,
    required this.avatarColor,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
  });
}

class AdminSalesScreen extends StatefulWidget {
  const AdminSalesScreen({super.key});

  @override
  State<AdminSalesScreen> createState() => _AdminSalesScreenState();
}

class _AdminSalesScreenState extends State<AdminSalesScreen> {
  String _selectedFilter = 'Todos';
  String _searchQuery = '';

  final List<SaleItem> _allSales = [
    SaleItem(
      code: 'V-0091',
      clientName: 'María García',
      email: 'maria@gmail.com',
      initials: 'MG',
      avatarColor: const Color(0xFF1E202E),
      date: '03 Ago 2026',
      total: '\$3,450',
      status: 'Pagado',
      items: [
        SaleProduct(
          title: 'Buso Hoodie Oversize',
          description: 'Sudadera con capota en algodón perchado pesado.',
          price: '\$98.000',
          imageUrl: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=500',
        ),
        SaleProduct(
          title: 'Jean Slim Fit',
          description: 'Pantalón de mezclilla de corte ajustado azul clásico.',
          price: '\$115.000',
          imageUrl: 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500',
        ),
        SaleProduct(
          title: 'Camisa de Lino',
          description: 'Camisa de lino natural fresca y sofisticada.',
          price: '\$89.000',
          imageUrl: 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500',
        ),
      ],
    ),
    SaleItem(
      code: 'V-0090',
      clientName: 'Carlos Mendoza',
      email: 'carlos.mendoza@gmail.com',
      initials: 'CM',
      avatarColor: const Color(0xFF8B8FA8),
      date: '03 Ago 2026',
      total: '\$1,200',
      status: 'Pendiente',
      items: [
        SaleProduct(
          title: 'Camiseta Básica Oversize',
          description: 'Algodón suave de alto gramaje para uso diario.',
          price: '\$45.000',
          imageUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=500',
        ),
      ],
    ),
    SaleItem(
      code: 'V-0089',
      clientName: 'Laura Torres',
      email: 'laura.torres@gmail.com',
      initials: 'LT',
      avatarColor: const Color(0xFF8B8FA8),
      date: '02 Ago 2026',
      total: '\$5,800',
      status: 'Pagado',
      items: [
        SaleProduct(
          title: 'Chaqueta Bomber Urbana',
          description: 'Chaqueta impermeable acolchada estilo callejero.',
          price: '\$180.000',
          imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
        ),
      ],
    ),
    SaleItem(
      code: 'V-0088',
      clientName: 'Roberto Sánchez',
      email: 'roberto@gmail.com',
      initials: 'RS',
      avatarColor: const Color(0xFFDC2626),
      date: '02 Ago 2026',
      total: '\$980',
      status: 'Cancelado',
      items: [
        SaleProduct(
          title: 'Gorra Snapback Classic',
          description: 'Gorra ajustable con diseño frontal bordado.',
          price: '\$55.000',
          imageUrl: 'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=500',
        ),
        SaleProduct(
          title: 'Pantaloneta Jogger Sport',
          description: 'Comodidad y ligereza para entrenamiento o descanso.',
          price: '\$75.000',
          imageUrl: 'https://images.unsplash.com/photo-1517445312882-bc9910d016b7?w=500',
        ),
      ],
    ),
    SaleItem(
      code: 'V-0087',
      clientName: 'Ana Jiménez',
      email: 'ana.jimenez@gmail.com',
      initials: 'AJ',
      avatarColor: const Color(0xFFB89B8C),
      date: '01 Ago 2026',
      total: '\$2,340',
      status: 'Pagado',
      items: [
        SaleProduct(
          title: 'Hoodie Minimalista',
          description: 'Sudadera sin estampados con bolsillo canguro.',
          price: '\$110.000',
          imageUrl: 'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=500',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: RaizUrbanaApp.themeNotifier,
      builder: (context, themeMode, child) {
        final isDark = themeMode == ThemeMode.dark;
        final backgroundColor = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);
        final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
        final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
        final innerBlockBg = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);

        final filteredSales = _allSales.where((sale) {
          final matchesFilter =
              _selectedFilter == 'Todos' || sale.status == _selectedFilter;
          final matchesSearch =
              sale.clientName.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              sale.code.toLowerCase().contains(_searchQuery.toLowerCase());
          return matchesFilter && matchesSearch;
        }).toList();

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Ventas',
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              buildNotificationIconButton(context, isDark, textPrimary, () {
                setState(() {});
              }),
              GestureDetector(
                onTap: () => showAdminProfileModal(context),
                child: Container(
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
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),

                // BARRA DE BÚSQUEDA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: TextStyle(color: textPrimary),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Buscar por código o cliente...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        icon: Icon(Icons.search, color: Colors.grey, size: 20),
                        suffixIcon: Icon(
                          Icons.tune,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // FILTROS HORIZONTALES
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: ['Todos', 'Pagado', 'Pendiente', 'Cancelado'].map(
                      (filter) {
                        final isSelected = _selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedFilter = filter),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF1E202E)
                                    : cardBg.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                filter,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),

                const SizedBox(height: 16),

                // LISTA DE VENTAS
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: filteredSales.length,
                    itemBuilder: (context, index) {
                      final sale = filteredSales[index];
                      return _buildSaleCard(
                        context,
                        sale,
                        cardBg,
                        textPrimary,
                        innerBlockBg,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSaleCard(
    BuildContext context,
    SaleItem sale,
    Color cardBg,
    Color textPrimary,
    Color innerBlockBg,
  ) {
    Color statusBg;
    Color statusTextColor;

    if (sale.status == 'Pagado') {
      statusBg = const Color(0xFFDCFCE7);
      statusTextColor = const Color(0xFF166534);
    } else if (sale.status == 'Pendiente') {
      statusBg = const Color(0xFFF3E8E2);
      statusTextColor = const Color(0xFF9A6B56);
    } else {
      statusBg = const Color(0xFFFFEAEA);
      statusTextColor = const Color(0xFFDC2626);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SaleDetailScreen(sale: sale)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: sale.avatarColor,
                  child: Text(
                    sale.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sale.clientName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Código: ${sale.code}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    sale.status,
                    style: TextStyle(
                      color: statusTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Bloque FECHA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: innerBlockBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FECHA',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sale.date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Bloque TOTAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: innerBlockBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sale.total,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DETALLE DE VENTA
class SaleDetailScreen extends StatefulWidget {
  final SaleItem sale;

  const SaleDetailScreen({super.key, required this.sale});

  @override
  State<SaleDetailScreen> createState() => _SaleDetailScreenState();
}

class _SaleDetailScreenState extends State<SaleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: RaizUrbanaApp.themeNotifier,
      builder: (context, themeMode, child) {
        final isDark = themeMode == ThemeMode.dark;
        final backgroundColor = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);
        final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
        final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
        final innerBlockBg = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);

        Color statusBg;
        Color statusTextColor;

        if (widget.sale.status == 'Pagado') {
          statusBg = const Color(0xFFDCFCE7);
          statusTextColor = const Color(0xFF166534);
        } else if (widget.sale.status == 'Pendiente') {
          statusBg = const Color(0xFFF3E8E2);
          statusTextColor = const Color(0xFF9A6B56);
        } else {
          statusBg = const Color(0xFFFFEAEA);
          statusTextColor = const Color(0xFFDC2626);
        }

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2E3148)
                    : const Color(0xFFE8E0D9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: textPrimary, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detalle de Venta',
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.sale.code,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
            actions: [
              buildNotificationIconButton(context, isDark, textPrimary, () {
                setState(() {});
              }),
              GestureDetector(
                onTap: () => showAdminProfileModal(context),
                child: Container(
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
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1D2030)
                                  : const Color(0xFFF8F6F4),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(28),
                                topRight: Radius.circular(28),
                              ),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor: widget.sale.avatarColor,
                                  child: Text(
                                    widget.sale.initials,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  widget.sale.clientName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusBg,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        widget.sale.status,
                                        style: TextStyle(
                                          color: statusTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      widget.sale.email,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListView(
                                children: [
                                  _buildFullWidthDetailTile(
                                    'CÓDIGO',
                                    widget.sale.code,
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildFullWidthDetailTile(
                                    'FECHA',
                                    widget.sale.date,
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildFullWidthDetailTile(
                                    'TOTAL',
                                    widget.sale.total,
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 16),

                                  // SECCIÓN DE ARTÍCULOS COMPRADOS CON DESCRIPCIÓN E IMAGEN
                                  const Text(
                                    'ARTÍCULOS',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...widget.sale.items.map((product) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: innerBlockBg,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                              product.imageUrl,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product.title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: textPrimary,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  product.description,
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            product.price,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFullWidthDetailTile(
    String label,
    String value,
    Color innerBlockBg,
    Color textPrimary,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: innerBlockBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}