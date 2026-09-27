// lib/presentation/pages/product_detail_screen.dart

import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback? onBuyNow;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
    this.onBuyNow,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'XS';
  String _selectedColor = 'Blanco';
  int _quantity = 1;

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];
  final List<String> _colors = ['Blanco', 'Negro', 'Gris', 'Azul'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark
        ? const Color(0xFF1A1C28)
        : const Color(0xFFF5EFEA);
    final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF1E1E2C);
    final selectedChipBg = isDark
        ? const Color(0xFF383D52)
        : const Color(0xFF2E3148);

    // Ajustes de color para el indicador de stock
    final stockBg = isDark ? const Color(0xFF143823) : const Color(0xFFDCFCE7);
    final stockTextColor = isDark
        ? const Color(0xFF4ADE80)
        : const Color(0xFF166534);

    // Color Azul Rey para el botón "Agregar al carrito"
    final royalBlueButtonBg = isDark
        ? const Color(0xFF2563EB)
        : const Color(0xFF1E3A8A);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: cardBg, shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: textPrimary, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'Detalle',
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                children: [
                  // Imagen principal con bordes redondeados
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.product.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 250,
                        color: cardBg,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Categoría y Calificación
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.product.category,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const Icon(
                            Icons.star_half,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.product.rating} (128)',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Título y Precio
                  Text(
                    widget.product.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.product.price,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? const Color(0xFF8B92B0)
                          : const Color(0xFF2E3148),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Descripción
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sección TALLA
                  const Text(
                    'TALLA',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: _sizes.map((size) {
                      final isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? selectedChipBg
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? selectedChipBg
                                  : (isDark
                                        ? Colors.white24
                                        : Colors.grey.shade400),
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: isSelected ? Colors.white : textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Sección COLOR
                  Row(
                    children: [
                      const Text(
                        'COLOR: ',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        _selectedColor,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: _colors.map((color) {
                      final isSelected = _selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = color),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? selectedChipBg
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? selectedChipBg
                                  : (isDark
                                        ? Colors.white24
                                        : Colors.grey.shade400),
                            ),
                          ),
                          child: Text(
                            color,
                            style: TextStyle(
                              color: isSelected ? Colors.white : textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Cantidad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'CANTIDAD',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark
                                ? Colors.white12
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() => _quantity--);
                                }
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 14,
                                color: Colors.grey,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                '$_quantity',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() => _quantity++),
                              icon: const Icon(
                                Icons.add,
                                size: 14,
                                color: Colors.grey,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Indicador de Stock Actualizado
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: stockBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: stockTextColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '32 en stock',
                          style: TextStyle(
                            color: stockTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Botón inferior fijo (Agregar al Carrito con Azul Rey)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      for (int i = 0; i < _quantity; i++) {
                        widget.onAddToCart();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '¡$_quantity ${widget.product.title} agregado(s) al carrito!',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Agregar al carrito',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: royalBlueButtonBg,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                    ),
                  ),
                  if (widget.onBuyNow != null) ...[
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        widget.onAddToCart();
                        Navigator.pop(context);
                        widget.onBuyNow!();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: isDark
                              ? const Color(0xFF383D52)
                              : const Color(0xFF2E3148),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Comprar ahora',
                        style: TextStyle(
                          color: textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
