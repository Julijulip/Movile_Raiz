// lib/presentation/pages/cart_screen.dart

import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'checkout_screen.dart';
import 'orders_screen.dart'; // Importado para acceder al OrdersManager

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  final Function(int) onRemoveFromCart;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Mapa para gestionar la cantidad individual de cada ítem
  final Map<int, int> _itemQuantities = {};

  int _getQuantity(int index) {
    return _itemQuantities[index] ?? 1;
  }

  void _incrementQuantity(int index) {
    setState(() {
      _itemQuantities[index] = _getQuantity(index) + 1;
    });
  }

  void _decrementQuantity(int index) {
    if (_getQuantity(index) > 1) {
      setState(() {
        _itemQuantities[index] = _getQuantity(index) - 1;
      });
    }
  }

  // Función auxiliar para extraer el valor numérico del precio (ej: "$98.000" -> 98000)
  int _parsePrice(String priceStr) {
    final clean = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(clean) ?? 0;
  }

  // Cálculo dinámico del subtotal
  int get _subtotal {
    int totalSum = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      final priceNum = _parsePrice(widget.cartItems[i].price);
      final qty = _getQuantity(i);
      totalSum += priceNum * qty;
    }
    return totalSum;
  }

  final int _shippingCost = 8000;
  int get _total => _subtotal + _shippingCost;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF1E1E2C);
    final innerCardBg = isDark
        ? const Color(0xFF1A1C28)
        : const Color(0xFFF5EFEA);

    final removeBtnBg = isDark
        ? const Color(0xFF2E3148)
        : const Color(0xFFF3ECE7);
    final removeBtnIcon = isDark ? Colors.grey[300] : Colors.grey[700];

    final royalBlueButtonBg = isDark
        ? const Color(0xFF2563EB)
        : const Color(0xFF1E3A8A);

    if (widget.cartItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tu carrito está vacío',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explora nuestra tienda y agrega prendas a tu carrito.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera: Título e ítems
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Mi carrito',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '(${widget.cartItems.length} items)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Lista de productos
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                final quantity = _getQuantity(index);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Talla estándar · Color base',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.price,
                                  style: TextStyle(
                                    color: isDark
                                        ? const Color(0xFF8B92B0)
                                        : const Color(0xFF2E3148),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Botón de eliminar (X)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _itemQuantities.remove(index);
                              });
                              widget.onRemoveFromCart(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: removeBtnBg,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: removeBtnIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Control de cantidad (- 1 +)
                          Container(
                            decoration: BoxDecoration(
                              color: innerCardBg,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white12),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => _decrementQuantity(index),
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 28,
                                    minHeight: 28,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                Text(
                                  '$quantity',
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _incrementQuantity(index),
                                  icon: const Icon(
                                    Icons.add,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 28,
                                    minHeight: 28,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Resumen de la compra
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      '\$$_subtotal',
                      style: TextStyle(
                        color: textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Envío',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      '\$$_shippingCost',
                      style: TextStyle(
                        color: textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(color: Colors.white12, height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        color: textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '\$$_total',
                      style: TextStyle(
                        color: isDark
                            ? const Color(0xFF8B92B0)
                            : const Color(0xFF2E3148),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Botón Finalizar compra con navegación al Checkout
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(
                    cartItems: widget.cartItems,
                    onOrderPlaced: () {
                      // Al realizar la compra con éxito, vaciamos el carrito localmente
                      setState(() {
                        widget.cartItems.clear();
                        _itemQuantities.clear();
                      });
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.credit_card, size: 16, color: Colors.white),
            label: const Text(
              'Finalizar compra',
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
        ],
      ),
    );
  }
}