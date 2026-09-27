// lib/presentation/pages/admin_products_screen.dart

import 'package:flutter/material.dart';
import '../../main.dart';
import '../widgets/profile_bottom_sheet.dart';

// ---------------------------------------------------------------------------
// MODELO DE NOTIFICACIÓN
// ---------------------------------------------------------------------------
class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.isRead = false,
  });
}

// ---------------------------------------------------------------------------
// MODELOS DE DATOS
// ---------------------------------------------------------------------------
class ProductVariant {
  final String colorName;
  final Color color;
  final String size;
  final String price;
  final String status;

  ProductVariant({
    required this.colorName,
    required this.color,
    required this.size,
    required this.price,
    required this.status,
  });
}

class AdminProduct {
  final String id;
  final String name;
  final String targetAudience;
  final String status;
  final String imageUrl;
  final String description;
  final List<ProductVariant> variants;

  AdminProduct({
    required this.id,
    required this.name,
    required this.targetAudience,
    required this.status,
    required this.imageUrl,
    required this.description,
    required this.variants,
  });
}

class ProductCategory {
  final String name;
  final String imageUrl;
  final List<AdminProduct> products;

  ProductCategory({
    required this.name,
    required this.imageUrl,
    required this.products,
  });
}

// Lista global simulada de notificaciones
List<NotificationItem> globalNotifications = [
  NotificationItem(
    id: 'n1',
    title: 'Nueva venta registrada',
    subtitle: 'Orden #V-0091 — María García · \$3,450',
    timeAgo: 'Hace 10 min',
    icon: Icons.shopping_cart_outlined,
    iconColor: const Color(0xFF4B5563),
    iconBgColor: const Color(0xFFE5E7EB),
    isRead: false,
  ),
  NotificationItem(
    id: 'n2',
    title: 'Stock crítico detectado',
    subtitle: 'Collar Semillas: solo 3 unidades',
    timeAgo: 'Hace 35 min',
    icon: Icons.error_outline,
    iconColor: const Color(0xFFDC2626),
    iconBgColor: const Color(0xFFFEE2E2),
    isRead: false,
  ),
  NotificationItem(
    id: 'n3',
    title: 'Pago confirmado',
    subtitle: 'Orden #V-0089 verificada · Laura Torres',
    timeAgo: 'Hace 1 h',
    icon: Icons.check_circle_outline,
    iconColor: const Color(0xFF16A34A),
    iconBgColor: const Color(0xFFDCFCE7),
    isRead: false,
  ),
  NotificationItem(
    id: 'n4',
    title: 'Nuevo miembro del equipo',
    subtitle: 'Valentina Cruz aceptó la invitación',
    timeAgo: 'Hace 3 h',
    icon: Icons.person_add_alt_outlined,
    iconColor: const Color(0xFF4B5563),
    iconBgColor: const Color(0xFFE5E7EB),
    isRead: true,
  ),
  NotificationItem(
    id: 'n5',
    title: 'Meta semanal alcanzada',
    subtitle: '\$48,250 en ventas esta semana',
    timeAgo: 'Hace 5 h',
    icon: Icons.show_chart,
    iconColor: const Color(0xFF4B5563),
    iconBgColor: const Color(0xFFE5E7EB),
    isRead: true,
  ),
  NotificationItem(
    id: 'n6',
    title: 'Producto destacado',
    subtitle: 'Bolsa Artesanal lidera ventas del mes',
    timeAgo: 'Hace 1 d',
    icon: Icons.star_border,
    iconColor: const Color(0xFF4B5563),
    iconBgColor: const Color(0xFFE5E7EB),
    isRead: true,
  ),
];

// Método global para mostrar el Modal de Notificaciones
void showNotificationsModal(
  BuildContext context, {
  VoidCallback? onStateChanged,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          final isDark = RaizUrbanaApp.themeNotifier.value == ThemeMode.dark;
          final sheetBg = isDark ? const Color(0xFF242736) : Colors.white;
          final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
          final dividerColor = isDark
              ? Colors.white12
              : const Color(0xFFE5E7EB);

          int activeFilter = 0; // 0: Todas, 1: Sin leer
          int unreadCount = globalNotifications.where((n) => !n.isRead).length;

          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              color: sheetBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                // Tirador gris central
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white24 : const Color(0xFFE3DAD4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Cabecera: Notificaciones, Marcar leídas, Cerrar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notificaciones',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                          Text(
                            '$unreadCount sin leer',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setModalState(() {
                            for (var n in globalNotifications) {
                              n.isRead = true;
                            }
                          });
                          if (onStateChanged != null) onStateChanged();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2E3148)
                                : const Color(0xFFECE3DC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Marcar leídas',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2E3148)
                                : const Color(0xFFECE3DC),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Chips de Filtro
                StatefulBuilder(
                  builder: (context, setFilterState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setModalState(() => activeFilter = 0);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: activeFilter == 0
                                    ? const Color(0xFF1E202E)
                                    : (isDark
                                          ? const Color(0xFF2E3148)
                                          : const Color(0xFFECE3DC)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Todas',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: activeFilter == 0
                                      ? Colors.white
                                      : textPrimary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setModalState(() => activeFilter = 1);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: activeFilter == 1
                                    ? const Color(0xFF1E202E)
                                    : (isDark
                                          ? const Color(0xFF2E3148)
                                          : const Color(0xFFECE3DC)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Sin leer ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: activeFilter == 1
                                          ? Colors.white
                                          : textPrimary,
                                    ),
                                  ),
                                  if (unreadCount > 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF8B8FA8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '$unreadCount',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),
                Divider(color: dividerColor, height: 1),

                // Lista de Notificaciones
                Expanded(
                  child: ListView.separated(
                    itemCount: globalNotifications.length,
                    separatorBuilder: (context, index) {
                      final item = globalNotifications[index];
                      if (activeFilter == 1 && item.isRead) {
                        return const SizedBox.shrink();
                      }
                      return Divider(color: dividerColor, height: 1);
                    },
                    itemBuilder: (context, index) {
                      final item = globalNotifications[index];
                      if (activeFilter == 1 && item.isRead) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 14.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: item.iconBgColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item.icon,
                                color: item.iconColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: textPrimary,
                                        ),
                                      ),
                                      if (!item.isRead)
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF8B8FA8),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item.timeAgo,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      const Spacer(),
                                      if (!item.isRead)
                                        GestureDetector(
                                          onTap: () {
                                            setModalState(() {
                                              item.isRead = true;
                                            });
                                            if (onStateChanged != null) {
                                              onStateChanged();
                                            }
                                          },
                                          child: const Text(
                                            'Leída  ',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E202E),
                                            ),
                                          ),
                                        ),
                                      GestureDetector(
                                        onTap: () {
                                          setModalState(() {
                                            globalNotifications.removeAt(index);
                                          });
                                          if (onStateChanged != null) {
                                            onStateChanged();
                                          }
                                        },
                                        child: const Text(
                                          'Eliminar',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFDC2626),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Widget auxiliar del botón de campana para reutilizar en todos los AppBars
Widget buildNotificationIconButton(
  BuildContext context,
  bool isDark,
  Color textPrimary,
  VoidCallback onUpdate,
) {
  final unreadCount = globalNotifications.where((n) => !n.isRead).length;

  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        margin: const EdgeInsets.only(right: 8, top: 4),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2E3148) : const Color(0xFFE3DAD4),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.notifications_none, color: textPrimary, size: 22),
          onPressed: () {
            showNotificationsModal(context, onStateChanged: onUpdate);
          },
        ),
      ),
      if (unreadCount > 0)
        Positioned(
          right: 8,
          top: 4,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFF8B8FA8),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$unreadCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
    ],
  );
}

// ---------------------------------------------------------------------------
// PANTALLA PRINCIPAL: GRILLA DE CATEGORÍAS DE PRODUCTOS
// ---------------------------------------------------------------------------
class AdminProductsScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const AdminProductsScreen({super.key, this.onLogout});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  final List<ProductCategory> _categories = [
    // 1. CAMISAS
    ProductCategory(
      name: 'Camisas',
      imageUrl:
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?auto=format&fit=crop&w=500&q=80',
      products: [
        AdminProduct(
          id: 'PR10',
          name: 'Camisa Básica',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?auto=format&fit=crop&w=500&q=80',
          description: 'Camisa básica de algodón, suave y versátil.',
          variants: [
            ProductVariant(
              colorName: 'Azul',
              color: const Color(0xFF3B82F6),
              size: 'M',
              price: '\$85.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Blanco',
              color: Colors.white,
              size: 'L',
              price: '\$85.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'S',
              price: '\$85.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Azul',
              color: const Color(0xFF3B82F6),
              size: 'L',
              price: '\$85.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR11',
          name: 'Camisa Manga Larga',
          targetAudience: 'Hombre',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?auto=format&fit=crop&w=500&q=80',
          description:
              'Camisa elegante de manga larga para ocasiones formales.',
          variants: [
            ProductVariant(
              colorName: 'Azul Oscuro',
              color: const Color(0xFF1E202E),
              size: 'M',
              price: '\$92.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Blanco',
              color: Colors.white,
              size: 'M',
              price: '\$92.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Blanco',
              color: Colors.white,
              size: 'L',
              price: '\$92.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR12',
          name: 'Camisa Oversize',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?auto=format&fit=crop&w=500&q=80',
          description: 'Corte amplio de estilo urbano contemporáneo.',
          variants: [
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'M',
              price: '\$89.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Gris',
              color: Colors.grey,
              size: 'L',
              price: '\$89.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Beige',
              color: const Color(0xFFE5D3C3),
              size: 'XL',
              price: '\$89.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR13',
          name: 'Camisa Estampada',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1564257631407-4deb1f99d992?auto=format&fit=crop&w=500&q=80',
          description: 'Diseño floral exclusivo en tela liviana.',
          variants: [
            ProductVariant(
              colorName: 'Blanco / Floral',
              color: Colors.white,
              size: 'S',
              price: '\$88.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Blanco / Floral',
              color: Colors.white,
              size: 'M',
              price: '\$88.000',
              status: 'Activo',
            ),
          ],
        ),
      ],
    ),

    // 2. JEANS
    ProductCategory(
      name: 'Jeans',
      imageUrl:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=500&q=80',
      products: [
        AdminProduct(
          id: 'PR14',
          name: 'Jean Skinny',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=500&q=80',
          description: 'Ajuste entallado con tecnología stretch.',
          variants: [
            ProductVariant(
              colorName: 'Azul',
              color: const Color(0xFF3B82F6),
              size: '30',
              price: '\$110.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: '32',
              price: '\$110.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Azul Oscuro',
              color: const Color(0xFF1E202E),
              size: '28',
              price: '\$110.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR15',
          name: 'Jean Recto',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1582552938357-32b906df40cb?auto=format&fit=crop&w=500&q=80',
          description: 'Corte clásico atemporal de tiro medio.',
          variants: [
            ProductVariant(
              colorName: 'Azul Claro',
              color: const Color(0xFF93C5FD),
              size: '30',
              price: '\$115.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Azul Claro',
              color: const Color(0xFF93C5FD),
              size: '32',
              price: '\$115.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: '34',
              price: '\$115.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR16',
          name: 'Jean Wide Leg',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1560243563-062bfc001d68?auto=format&fit=crop&w=500&q=80',
          description: 'Bota ancha vintage de tendencia.',
          variants: [
            ProductVariant(
              colorName: 'Azul Medio',
              color: const Color(0xFF2563EB),
              size: '28',
              price: '\$120.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Azul Medio',
              color: const Color(0xFF2563EB),
              size: '30',
              price: '\$120.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR17',
          name: 'Jean Cargo',
          targetAudience: 'Hombre',
          status: 'Inactivo',
          imageUrl:
              'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?auto=format&fit=crop&w=500&q=80',
          description: 'Bolsillos laterales utilitarios de alto rendimiento.',
          variants: [
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: '32',
              price: '\$125.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Verde Olivas',
              color: const Color(0xFF4B5320),
              size: '34',
              price: '\$125.000',
              status: 'Activo',
            ),
          ],
        ),
      ],
    ),

    // 3. BUSOS
    ProductCategory(
      name: 'Busos',
      imageUrl:
          'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&w=500&q=80',
      products: [
        AdminProduct(
          id: 'PR18',
          name: 'Buso Básico',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&w=500&q=80',
          description: 'Hoodie afelpado interno ideal para clima frío.',
          variants: [
            ProductVariant(
              colorName: 'Gris',
              color: Colors.grey,
              size: 'M',
              price: '\$95.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'L',
              price: '\$95.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Blanco',
              color: Colors.white,
              size: 'S',
              price: '\$95.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR19',
          name: 'Buso Oversize',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1509967419530-da38b4704bc6?auto=format&fit=crop&w=500&q=80',
          description: 'Silueta amplia urbana con capota reforzada.',
          variants: [
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'L',
              price: '\$105.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Beige',
              color: const Color(0xFFD4C5B9),
              size: 'M',
              price: '\$105.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR20',
          name: 'Buso Estampado',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?auto=format&fit=crop&w=500&q=80',
          description: 'Estampa posterior gráfica de alta durabilidad.',
          variants: [
            ProductVariant(
              colorName: 'Blanco',
              color: Colors.white,
              size: 'M',
              price: '\$98.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Azul',
              color: const Color(0xFF2563EB),
              size: 'L',
              price: '\$98.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'XL',
              price: '\$98.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR21',
          name: 'Buso Deportivo',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=500&q=80',
          description: 'Tejido transpirable para entrenamiento.',
          variants: [
            ProductVariant(
              colorName: 'Gris Oscuro',
              color: const Color(0xFF4B5563),
              size: 'S',
              price: '\$90.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Gris Oscuro',
              color: const Color(0xFF4B5563),
              size: 'M',
              price: '\$90.000',
              status: 'Activo',
            ),
          ],
        ),
      ],
    ),

    // 4. BLUSAS
    ProductCategory(
      name: 'Blusas',
      imageUrl:
          'https://images.unsplash.com/photo-1551803091-e20673f15770?auto=format&fit=crop&w=500&q=80',
      products: [
        AdminProduct(
          id: 'PR22',
          name: 'Blusa Básica',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=500&q=80',
          description: 'Blusa en lino fresco con cuello V.',
          variants: [
            ProductVariant(
              colorName: 'Blanco',
              color: Colors.white,
              size: 'XS',
              price: '\$65.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Blanco',
              color: Colors.white,
              size: 'S',
              price: '\$65.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'M',
              price: '\$65.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR23',
          name: 'Blusa Manga Larga',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1618244972963-dbee1a7edc95?auto=format&fit=crop&w=500&q=80',
          description: 'Detalles abullonados en puños.',
          variants: [
            ProductVariant(
              colorName: 'Rosa Pastel',
              color: const Color(0xFFF472B6),
              size: 'S',
              price: '\$75.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Blanco',
              color: Colors.white,
              size: 'M',
              price: '\$75.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR24',
          name: 'Blusa Casual',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1564257631407-4deb1f99d992?auto=format&fit=crop&w=500&q=80',
          description: 'Prenda ligera de uso diario.',
          variants: [
            ProductVariant(
              colorName: 'Amarillo',
              color: const Color(0xFFFBBF24),
              size: 'S',
              price: '\$70.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Azul',
              color: const Color(0xFF60A5FA),
              size: 'M',
              price: '\$70.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR25',
          name: 'Blusa Elegante',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1485230895905-ec40ba36b9bc?auto=format&fit=crop&w=500&q=80',
          description: 'Acabado en seda sintética de alta calidad.',
          variants: [
            ProductVariant(
              colorName: 'Negro Satinado',
              color: Colors.black,
              size: 'S',
              price: '\$89.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Vino Tinto',
              color: const Color(0xFF881337),
              size: 'M',
              price: '\$89.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Beige Satinado',
              color: const Color(0xFFF59E0B),
              size: 'L',
              price: '\$89.000',
              status: 'Activo',
            ),
          ],
        ),
      ],
    ),

    // 5. FALDAS
    ProductCategory(
      name: 'Faldas',
      imageUrl:
          'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?auto=format&fit=crop&w=500&q=80',
      products: [
        AdminProduct(
          id: 'PR26',
          name: 'Falda Corta',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?auto=format&fit=crop&w=500&q=80',
          description: 'Falda plisada tiro alto.',
          variants: [
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'S',
              price: '\$78.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Gris',
              color: Colors.grey,
              size: 'M',
              price: '\$78.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR27',
          name: 'Falda Midi',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1509551388413-e18d0ac5d495?auto=format&fit=crop&w=500&q=80',
          description: 'Largo intermedio con abertura lateral.',
          variants: [
            ProductVariant(
              colorName: 'Verde Esmeralda',
              color: const Color(0xFF047857),
              size: 'M',
              price: '\$85.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'L',
              price: '\$85.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR28',
          name: 'Falda Larga',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1577900232427-18219b9166a0?auto=format&fit=crop&w=500&q=80',
          description: 'Caída fluida en estampado bohemio.',
          variants: [
            ProductVariant(
              colorName: 'Café / Terracota',
              color: const Color(0xFF9A3412),
              size: 'S',
              price: '\$92.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Café / Terracota',
              color: const Color(0xFF9A3412),
              size: 'M',
              price: '\$92.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR29',
          name: 'Falda Jean',
          targetAudience: 'Mujer',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=500&q=80',
          description: 'Denim rígido con botones frontales.',
          variants: [
            ProductVariant(
              colorName: 'Azul Denim',
              color: const Color(0xFF2563EB),
              size: '28',
              price: '\$82.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Azul Denim',
              color: const Color(0xFF2563EB),
              size: '30',
              price: '\$82.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro Gastado',
              color: const Color(0xFF374151),
              size: '28',
              price: '\$82.000',
              status: 'Activo',
            ),
          ],
        ),
      ],
    ),

    // 6. CHAQUETAS
    ProductCategory(
      name: 'Chaquetas',
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=500&q=80',
      products: [
        AdminProduct(
          id: 'PR21',
          name: 'Chaqueta Jean',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=500&q=80',
          description: 'Chaqueta clásica de denim, icónica y atemporal.',
          variants: [
            ProductVariant(
              colorName: 'Azul',
              color: const Color(0xFF3B82F6),
              size: 'M',
              price: '\$125.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Azul',
              color: const Color(0xFF3B82F6),
              size: 'L',
              price: '\$125.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: const Color(0xFF1E1E1E),
              size: 'M',
              price: '\$118.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR30',
          name: 'Chaqueta Deportiva',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=500&q=80',
          description: 'Rompevientos liviano con tecnología impermeabilizante.',
          variants: [
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'M',
              price: '\$110.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Rojo',
              color: const Color(0xFFEF4444),
              size: 'L',
              price: '\$110.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR31',
          name: 'Chaqueta Bomber',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&w=500&q=80',
          description: 'Forro térmico acolchado con cremallera metálica.',
          variants: [
            ProductVariant(
              colorName: 'Verde Militar',
              color: const Color(0xFF3F6212),
              size: 'M',
              price: '\$135.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'L',
              price: '\$135.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Verde Militar',
              color: const Color(0xFF3F6212),
              size: 'XL',
              price: '\$135.000',
              status: 'Activo',
            ),
          ],
        ),
        AdminProduct(
          id: 'PR32',
          name: 'Chaqueta Casual',
          targetAudience: 'Unisex',
          status: 'Activo',
          imageUrl:
              'https://images.unsplash.com/photo-1521223890158-f9f7c3d5d504?auto=format&fit=crop&w=500&q=80',
          description: 'Corte semiformatorio para uso cotidiano.',
          variants: [
            ProductVariant(
              colorName: 'Café',
              color: const Color(0xFF78350F),
              size: 'M',
              price: '\$140.000',
              status: 'Activo',
            ),
            ProductVariant(
              colorName: 'Negro',
              color: Colors.black,
              size: 'L',
              price: '\$140.000',
              status: 'Activo',
            ),
          ],
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

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Gestión de Productos',
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
                onTap: () =>
                    showAdminProfileModal(context, onLogout: widget.onLogout),
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
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  'Gestión de Productos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Selecciona una categoría para gestionar',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // Grilla de Categorías
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.88,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryProductsScreen(
                              category: category,
                              onLogout: widget.onLogout,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image.network(
                                  category.imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${category.products.length} productos',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// PANTALLA SECUNDARIA: LISTADO DE PRODUCTOS POR CATEGORÍA
// ---------------------------------------------------------------------------
class CategoryProductsScreen extends StatefulWidget {
  final ProductCategory category;
  final VoidCallback? onLogout;

  const CategoryProductsScreen({
    super.key,
    required this.category,
    this.onLogout,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
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

        return Scaffold(
          backgroundColor: scaffoldBg,
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
                  widget.category.name,
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${widget.category.products.length} productos',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
            actions: [
              buildNotificationIconButton(context, isDark, textPrimary, () {
                setState(() {});
              }),
              GestureDetector(
                onTap: () =>
                    showAdminProfileModal(context, onLogout: widget.onLogout),
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: widget.category.products.length,
              itemBuilder: (context, index) {
                final product = widget.category.products[index];
                final isActivo = product.status == 'Activo';

                Color statusBg;
                Color statusTextColor;

                if (isActivo) {
                  statusBg = isDark
                      ? const Color(0xFF143823)
                      : const Color(0xFFDCFCE7);
                  statusTextColor = isDark
                      ? const Color(0xFF4ADE80)
                      : const Color(0xFF166534);
                } else {
                  statusBg = isDark
                      ? const Color(0xFF3B1E1E)
                      : const Color(0xFFFFEAEA);
                  statusTextColor = isDark
                      ? const Color(0xFFFCA5A5)
                      : const Color(0xFFDC2626);
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminProductDetailScreen(
                          product: product,
                          categoryName: widget.category.name,
                          onLogout: widget.onLogout,
                        ),
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
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            product.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: textPrimary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusBg,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      product.status,
                                      style: TextStyle(
                                        color: statusTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                product.targetAudience,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: innerBlockBg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${product.variants.length} variantes',
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
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// PANTALLA TERCER NIVEL: DETALLE DEL PRODUCTO Y SUS VARIANTES (PANTALLA COMPLETA)
// ---------------------------------------------------------------------------
class AdminProductDetailScreen extends StatefulWidget {
  final AdminProduct product;
  final String categoryName;
  final VoidCallback? onLogout;

  const AdminProductDetailScreen({
    super.key,
    required this.product,
    required this.categoryName,
    this.onLogout,
  });

  @override
  State<AdminProductDetailScreen> createState() =>
      _AdminProductDetailScreenState();
}

class _AdminProductDetailScreenState extends State<AdminProductDetailScreen> {
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

        final isActivo = widget.product.status == 'Activo';

        Color statusBg;
        Color statusTextColor;

        if (isActivo) {
          statusBg = isDark ? const Color(0xFF143823) : const Color(0xFFDCFCE7);
          statusTextColor = isDark
              ? const Color(0xFF4ADE80)
              : const Color(0xFF166534);
        } else {
          statusBg = isDark ? const Color(0xFF3B1E1E) : const Color(0xFFFFEAEA);
          statusTextColor = isDark
              ? const Color(0xFFFCA5A5)
              : const Color(0xFFDC2626);
        }

        return Scaffold(
          backgroundColor: scaffoldBg,
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
                  'Detalle del Producto',
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.product.id,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
            actions: [
              buildNotificationIconButton(context, isDark, textPrimary, () {
                setState(() {});
              }),
              GestureDetector(
                onTap: () =>
                    showAdminProfileModal(context, onLogout: widget.onLogout),
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
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                            child: Image.network(
                              widget.product.imageUrl,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListView(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.product.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: textPrimary,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusBg,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          widget.product.status,
                                          style: TextStyle(
                                            color: statusTextColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    widget.product.description,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  _buildFullWidthInfoTile(
                                    'CATEGORÍA',
                                    widget.categoryName,
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildFullWidthInfoTile(
                                    'PÚBLICO',
                                    widget.product.targetAudience,
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildFullWidthInfoTile(
                                    'ESTADO',
                                    widget.product.status.toLowerCase(),
                                    innerBlockBg,
                                    textPrimary,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildFullWidthInfoTile(
                                    'ID DEL PRODUCTO',
                                    widget.product.id,
                                    innerBlockBg,
                                    textPrimary,
                                  ),

                                  const SizedBox(height: 20),
                                  Text(
                                    'Variantes (${widget.product.variants.length})',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  ...widget.product.variants.map((variant) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: innerBlockBg,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 28,
                                            height: 28,
                                            decoration: BoxDecoration(
                                              color: variant.color,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: isDark
                                                    ? Colors.white24
                                                    : Colors.black12,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${variant.colorName} - Talla ${variant.size}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: textPrimary,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  variant.price,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: textPrimary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? const Color(0xFF143823)
                                                  : const Color(0xFFDCFCE7),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Activo',
                                              style: TextStyle(
                                                color: isDark
                                                    ? const Color(0xFF4ADE80)
                                                    : const Color(0xFF166534),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
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

  Widget _buildFullWidthInfoTile(
    String label,
    String value,
    Color blockBg,
    Color textPrimary,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: blockBg,
        borderRadius: BorderRadius.circular(16),
      ),
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
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
