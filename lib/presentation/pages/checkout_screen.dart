// lib/presentation/pages/checkout_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/product.dart';
import 'orders_screen.dart'; // Importado para acceder al OrdersManager

class CheckoutScreen extends StatefulWidget {
  final List<Product> cartItems;
  final VoidCallback? onOrderPlaced;
  final VoidCallback? onClearCart;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    this.onOrderPlaced,
    this.onClearCart,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _nameController = TextEditingController(text: 'juli');
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController(); // Sin número predefinido

  // Ciudad seleccionada por defecto con lista desplegable
  String _selectedCity = 'Bogotá';
  final List<String> _cities = [
    'Bogotá',
    'Medellín',
    'Cali',
    'Barranquilla',
    'Cartagena',
    'Bello',
    'Envigado',
    'Itagüí',
    'Pereira',
    'Bucaramanga',
  ];

  String _paymentMethod = 'bancolombia'; // 'bancolombia' o 'nequi'

  File? _proofFile;
  String? _fileName;
  final ImagePicker _picker = ImagePicker();

  final int _shippingCost = 8000;

  int get _subtotal {
    int sum = 0;
    for (var item in widget.cartItems) {
      final clean = item.price.replaceAll(RegExp(r'[^0-9]'), '');
      sum += int.tryParse(clean) ?? 0;
    }
    return sum;
  }

  int get _total => _subtotal + _shippingCost;

  // Función para seleccionar imagen desde la galería o cámara
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _proofFile = File(image.path);
          _fileName = image.name;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al seleccionar imagen: $e')),
        );
      }
    }
  }

  // Modal para seleccionar Fuente de la imagen
  void _showAttachmentOptions() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1D2030) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Galería de fotos (JPG, PNG)'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.green),
                title: const Text('Tomar foto con la cámara'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmPurchase() {
    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa la dirección de entrega'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_proofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor adjunta el comprobante de pago'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // 1. Crear y agregar la orden al gestor compartido de Mis Compras
    final newOrder = ClientOrderModel(
      id: 'RU-2026-${DateTime.now().millisecond}',
      items: List.from(widget.cartItems),
      total: _total,
      status: 'Pendiente',
      dateStr: 'Hoy',
    );
    OrdersManager.addOrder(newOrder);

    // 2. Vaciar el carrito de compras
    if (widget.onClearCart != null) {
      widget.onClearCart!();
    } else {
      widget.cartItems.clear();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Pedido realizado con éxito! Estado: Pendiente'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    if (widget.onOrderPlaced != null) {
      widget.onOrderPlaced!();
    }

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark
        ? const Color(0xFF141622)
        : const Color(0xFFF5EFEA);
    final cardBg = isDark ? const Color(0xFF1D2030) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF1E1E2C);
    final inputBg = isDark ? const Color(0xFF171926) : const Color(0xFFF0ECE9);

    final royalBlueButtonBg = isDark
        ? const Color(0xFF2563EB)
        : const Color(0xFF1E3A8A);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
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
          'Finalizar compra',
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // 1. DATOS DE ENTREGA
                  _buildSectionContainer(
                    cardBg: cardBg,
                    icon: Icons.person_outline,
                    title: 'DATOS DE ENTREGA',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputField(
                          label: 'NOMBRE COMPLETO',
                          controller: _nameController,
                          inputBg: inputBg,
                          textPrimary: textPrimary,
                        ),
                        const SizedBox(height: 12),
                        _buildInputField(
                          label: 'DIRECCIÓN',
                          controller: _addressController,
                          hint: 'Calle, número...',
                          inputBg: inputBg,
                          textPrimary: textPrimary,
                        ),
                        const SizedBox(height: 12),
                        // SELECTOR DE CIUDAD (Lista corta)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CIUDAD',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                color: inputBg,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedCity,
                                  isExpanded: true,
                                  dropdownColor: cardBg,
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  items: _cities.map((String city) {
                                    return DropdownMenuItem<String>(
                                      value: city,
                                      child: Text(city),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _selectedCity = newValue;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildInputField(
                          label: 'TELÉFONO',
                          controller: _phoneController,
                          hint: 'Número de contacto...',
                          inputBg: inputBg,
                          textPrimary: textPrimary,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. MÉTODO DE PAGO
                  _buildSectionContainer(
                    cardBg: cardBg,
                    icon: Icons.credit_card_outlined,
                    title: 'MÉTODO DE PAGO',
                    child: Column(
                      children: [
                        _buildRadioOption(
                          value: 'bancolombia',
                          groupValue: _paymentMethod,
                          title: 'Bancolombia',
                          onChanged: (val) =>
                              setState(() => _paymentMethod = val!),
                          inputBg: inputBg,
                          textPrimary: textPrimary,
                        ),
                        const SizedBox(height: 10),
                        _buildRadioOption(
                          value: 'nequi',
                          groupValue: _paymentMethod,
                          title: 'Nequi',
                          onChanged: (val) =>
                              setState(() => _paymentMethod = val!),
                          inputBg: inputBg,
                          textPrimary: textPrimary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. COMPROBANTE DE PAGO
                  _buildSectionContainer(
                    cardBg: cardBg,
                    icon: Icons.verified_outlined,
                    title: 'COMPROBANTE DE PAGO',
                    child: GestureDetector(
                      onTap: _showAttachmentOptions,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: inputBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: _proofFile != null
                                ? royalBlueButtonBg
                                : Colors.white24,
                            width: 1.5,
                          ),
                        ),
                        child: _proofFile == null
                            ? Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: cardBg,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.credit_card,
                                      color: royalBlueButtonBg,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Adjuntar comprobante',
                                    style: TextStyle(
                                      color: textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Imagen (JPG, PNG) del comprobante de pago',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: royalBlueButtonBg,
                                    size: 26,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _fileName ?? 'Comprobante adjunto',
                                          style: TextStyle(
                                            color: textPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Text(
                                          '¡Comprobante listo!',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _proofFile = null;
                                        _fileName = null;
                                      });
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. RESUMEN DEL PEDIDO
                  _buildSectionContainer(
                    cardBg: cardBg,
                    title: 'RESUMEN DEL PEDIDO',
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Prendas seleccionadas (${widget.cartItems.length})',
                              style: TextStyle(
                                color: textPrimary,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '\$$_subtotal',
                              style: TextStyle(
                                color: textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
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
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
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
                                color: royalBlueButtonBg,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // BOTÓN DE CONFIRMAR COMPRA
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: _confirmPurchase,
                icon: const Icon(
                  Icons.check_circle_outline,
                  size: 18,
                  color: Colors.white,
                ),
                label: const Text(
                  'Confirmar compra',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContainer({
    required Color cardBg,
    required String title,
    required Widget child,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: Colors.grey),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required Color inputBg,
    required Color textPrimary,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: inputBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption({
    required String value,
    required String groupValue,
    required String title,
    required Function(String?) onChanged,
    required Color inputBg,
    required Color textPrimary,
  }) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: inputBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF6E739B) : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: const Color(0xFF8B92B0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
