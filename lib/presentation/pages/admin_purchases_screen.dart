// lib/presentation/pages/admin_purchases_screen.dart

import 'package:flutter/material.dart';
import '../../main.dart';
import '../widgets/profile_bottom_sheet.dart';
import 'admin_products_screen.dart';

class PurchaseSupply {
  final String title;
  final String description;
  final String price;

  PurchaseSupply({
    required this.title,
    required this.description,
    required this.price,
  });
}

class PurchaseItem {
  final String code;
  final String supplierName;
  final String initials;
  final Color avatarColor;
  final String date;
  final String total;
  final String status; // 'Pagado', 'Pendiente', 'Cancelado'
  final List<PurchaseSupply> supplies;

  PurchaseItem({
    required this.code,
    required this.supplierName,
    required this.initials,
    required this.avatarColor,
    required this.date,
    required this.total,
    required this.status,
    required this.supplies,
  });
}

class AdminPurchasesScreen extends StatefulWidget {
  const AdminPurchasesScreen({super.key});

  @override
  State<AdminPurchasesScreen> createState() => _AdminPurchasesScreenState();
}

class _AdminPurchasesScreenState extends State<AdminPurchasesScreen> {
  String _selectedFilter = 'Todos';
  String _searchQuery = '';

  final List<PurchaseItem> _allPurchases = [
    PurchaseItem(
      code: 'C-0045',
      supplierName: 'Textiles Colombia S.A.',
      initials: 'TC',
      avatarColor: const Color(0xFF1E202E),
      date: '01 Ago 2026',
      total: '\$12,400',
      status: 'Pagado',
      supplies: [
        PurchaseSupply(
          title: 'Rollo de Algodón Perchado',
          description:
              'Tela de alta calidad para fabricación de hoodies y busos.',
          price: '\$4,500',
        ),
        PurchaseSupply(
          title: 'Tela Denim Oscuro',
          description:
              'Rollo de mezclilla resistente para pantalones y chaquetas.',
          price: '\$7,900',
        ),
      ],
    ),
    PurchaseItem(
      code: 'C-0044',
      supplierName: 'Confecciones Norte',
      initials: 'CN',
      avatarColor: const Color(0xFF8B8FA8),
      date: '30 Jul 2026',
      total: '\$7,800',
      status: 'Pendiente',
      supplies: [
        PurchaseSupply(
          title: 'Hilo de Costura Alta Resistencia',
          description: 'Cajas de hilo poliéster en colores surtidos.',
          price: '\$3,200',
        ),
        PurchaseSupply(
          title: 'Cierres Metálicos Reforzados',
          description: 'Lote de cremalleras de 50 cm para chaquetas.',
          price: '\$4,600',
        ),
      ],
    ),
    PurchaseItem(
      code: 'C-0043',
      supplierName: 'Distribuidora Sur',
      initials: 'DS',
      avatarColor: const Color(0xFF8B8FA8),
      date: '28 Jul 2026',
      total: '\$21,000',
      status: 'Pagado',
      supplies: [
        PurchaseSupply(
          title: 'Etiquetas Bordadas y Marquillas',
          description: 'Paquetes de marquillas con el logo de la marca.',
          price: '\$21,000',
        ),
      ],
    ),
    PurchaseItem(
      code: 'C-0042',
      supplierName: 'Moda Express',
      initials: 'ME',
      avatarColor: const Color(0xFFDC2626),
      date: '25 Jul 2026',
      total: '\$5,300',
      status: 'Cancelado',
      supplies: [
        PurchaseSupply(
          title: 'Botones Metálicos Grabados',
          description: 'Insumos para camisas y chaquetas estilo urbano.',
          price: '\$5,300',
        ),
      ],
    ),
    PurchaseItem(
      code: 'C-0041',
      supplierName: 'Fábricas Bogotá',
      initials: 'FB',
      avatarColor: const Color(0xFF383C56),
      date: '22 Jul 2026',
      total: '\$9,600',
      status: 'Pagado',
      supplies: [
        PurchaseSupply(
          title: 'Elástico Textil Reforzado',
          description: 'Rollos de elástico para pretinas de pantalones.',
          price: '\$9,600',
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

        final scaffoldBg = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);
        final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
        final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
        final innerBlockBg = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);

        final filteredPurchases = _allPurchases.where((purchase) {
          final matchesFilter =
              _selectedFilter == 'Todos' || purchase.status == _selectedFilter;
          final matchesSearch =
              purchase.supplierName.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              purchase.code.toLowerCase().contains(_searchQuery.toLowerCase());
          return matchesFilter && matchesSearch;
        }).toList();

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Gestión de Compras',
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
                      style: TextStyle(color: textPrimary),
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Buscar por proveedor o código...',
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

                // CHIPS DE FILTRO
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
                                    ? (isDark
                                          ? const Color(0xFF383C56)
                                          : const Color(0xFF1E202E))
                                    : (isDark
                                          ? const Color(0xFF242736)
                                          : Colors.white.withOpacity(0.6)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                filter,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                            ? Colors.grey[400]
                                            : const Color(0xFF2E3148)),
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

                // LISTA DE COMPRAS
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: filteredPurchases.length,
                    itemBuilder: (context, index) {
                      final purchase = filteredPurchases[index];
                      return _buildPurchaseCard(
                        context: context,
                        purchase: purchase,
                        cardBg: cardBg,
                        textPrimary: textPrimary,
                        innerBlockBg: innerBlockBg,
                        isDark: isDark,
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

  Widget _buildPurchaseCard({
    required BuildContext context,
    required PurchaseItem purchase,
    required Color cardBg,
    required Color textPrimary,
    required Color innerBlockBg,
    required bool isDark,
  }) {
    Color statusBg;
    Color statusTextColor;

    if (purchase.status == 'Pagado') {
      statusBg = isDark ? const Color(0xFF143823) : const Color(0xFFDCFCE7);
      statusTextColor = isDark
          ? const Color(0xFF4ADE80)
          : const Color(0xFF166534);
    } else if (purchase.status == 'Pendiente') {
      statusBg = isDark ? const Color(0xFF382A22) : const Color(0xFFF3E8E2);
      statusTextColor = isDark
          ? const Color(0xFFFDBA74)
          : const Color(0xFF9A6B56);
    } else {
      statusBg = isDark ? const Color(0xFF3B1E1E) : const Color(0xFFFFEAEA);
      statusTextColor = isDark
          ? const Color(0xFFFCA5A5)
          : const Color(0xFFDC2626);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PurchaseDetailScreen(purchase: purchase),
          ),
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
                  backgroundColor: purchase.avatarColor,
                  child: Text(
                    purchase.initials,
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
                        purchase.supplierName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Código: ${purchase.code}',
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
                    purchase.status,
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
                    purchase.date,
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
                    purchase.total,
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

// ---------------------------------------------------------------------------
// PANTALLA DETALLE DE COMPRA
// ---------------------------------------------------------------------------
class PurchaseDetailScreen extends StatefulWidget {
  final PurchaseItem purchase;

  const PurchaseDetailScreen({super.key, required this.purchase});

  @override
  State<PurchaseDetailScreen> createState() => _PurchaseDetailScreenState();
}

class _PurchaseDetailScreenState extends State<PurchaseDetailScreen> {
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
        final placeholderBg = isDark
            ? const Color(0xFF2E3148)
            : const Color(0xFFE5DFDC);

        Color statusBg;
        Color statusTextColor;

        if (widget.purchase.status == 'Pagado') {
          statusBg = isDark ? const Color(0xFF143823) : const Color(0xFFDCFCE7);
          statusTextColor = isDark
              ? const Color(0xFF4ADE80)
              : const Color(0xFF166534);
        } else if (widget.purchase.status == 'Pendiente') {
          statusBg = isDark ? const Color(0xFF382A22) : const Color(0xFFF3E8E2);
          statusTextColor = isDark
              ? const Color(0xFFFDBA74)
              : const Color(0xFF9A6B56);
        } else {
          statusBg = isDark ? const Color(0xFF3B1E1E) : const Color(0xFFFFEAEA);
          statusTextColor = isDark
              ? const Color(0xFFFCA5A5)
              : const Color(0xFFDC2626);
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
                  'Detalle de Compra',
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.purchase.code,
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
                          // Cabecera del Proveedor
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
                                  backgroundColor: widget.purchase.avatarColor,
                                  child: Text(
                                    widget.purchase.initials,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  widget.purchase.supplierName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusBg,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    widget.purchase.status,
                                    style: TextStyle(
                                      color: statusTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Información e Insumos comprados
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListView(
                                children: [
                                  _buildFullWidthDetailTile(
                                    'CÓDIGO',
                                    widget.purchase.code,
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildFullWidthDetailTile(
                                    'FECHA',
                                    widget.purchase.date,
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildFullWidthDetailTile(
                                    'TOTAL',
                                    widget.purchase.total,
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 16),

                                  // SECCIÓN DE INSUMOS COMPRADOS
                                  const Text(
                                    'INSUMOS',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...widget.purchase.supplies.map((supply) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: innerBlockBg,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: placeholderBg,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.image_outlined,
                                              size: 24,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  supply.title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: textPrimary,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  supply.description,
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            supply.price,
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
    Color blockBg,
    Color textPrimary,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: blockBg,
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
