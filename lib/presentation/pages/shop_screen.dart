// lib/presentation/pages/shop_screen.dart

import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'product_detail_screen.dart';

class ShopCategory {
  final String title;
  final int count;
  final String imageUrl;

  ShopCategory({
    required this.title,
    required this.count,
    required this.imageUrl,
  });
}

class ShopScreen extends StatefulWidget {
  final Function(Product)? onAddToCart;
  final VoidCallback? onBuyNow;

  const ShopScreen({super.key, this.onAddToCart, this.onBuyNow});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String? _selectedCategory;
  String _searchQuery = '';

  final List<ShopCategory> _categories = [
    ShopCategory(
      title: 'Camisas',
      count: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500',
    ),
    ShopCategory(
      title: 'Jeans',
      count: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500',
    ),
    ShopCategory(
      title: 'Busos',
      count: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=500',
    ),
    ShopCategory(
      title: 'Blusas',
      count: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1551803091-e20673f15770?auto=format&fit=crop&w=500&q=80',
    ),
    ShopCategory(
      title: 'Faldas',
      count: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=500',
    ),
    ShopCategory(
      title: 'Chaquetas',
      count: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
    ),
  ];

  final List<Product> _allProducts = [
    // --- CAMISAS (6) ---
    Product(
      id: 'c1',
      title: 'Camisa de Lino',
      category: 'Camisas',
      price: '\$89.000',
      rating: 4.8,
      description: 'Camisa de lino natural. Fresca y sofisticada.',
      imageUrl:
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500',
    ),
    Product(
      id: 'c2',
      title: 'Camisa Oxford Blanca',
      category: 'Camisas',
      price: '\$95.000',
      rating: 4.6,
      description: 'Camisa clásica de algodón oxford de alta durabilidad.',
      imageUrl:
          'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500',
    ),
    Product(
      id: 'c3',
      title: 'Camisa Denim Casual',
      category: 'Camisas',
      price: '\$110.000',
      rating: 4.7,
      description: 'Camisa en mezclilla ligera con broches metálicos.',
      imageUrl:
          'https://images.unsplash.com/photo-1578932750294-f5075e85f44a?w=500',
    ),
    Product(
      id: 'c4',
      title: 'Camisa Rayas Veraniega',
      category: 'Camisas',
      price: '\$85.000',
      rating: 4.4,
      description:
          'Camisa fresca de manga corta con patrón de rayas verticales.',
      imageUrl:
          'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=500',
    ),
    Product(
      id: 'c5',
      title: 'Camisa Negra Formal',
      category: 'Camisas',
      price: '\$98.000',
      rating: 4.9,
      description: 'Camisa de vestir slim fit en elegante tono negro.',
      imageUrl:
          'https://images.unsplash.com/photo-1620012253295-c15cc3e65df4?w=500',
    ),
    Product(
      id: 'c6',
      title: 'Camisa Franela Cuadros',
      category: 'Camisas',
      price: '\$105.000',
      rating: 4.5,
      description: 'Camisa abrigada de franela suave con diseño de cuadros.',
      imageUrl:
          'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=500',
    ),

    // --- JEANS (6) ---
    Product(
      id: 'j1',
      title: 'Jean Slim Fit',
      category: 'Jeans',
      price: '\$115.000',
      rating: 4.6,
      description: 'Pantalón de mezclilla de corte ajustado.',
      imageUrl:
          'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500',
    ),
    Product(
      id: 'j2',
      title: 'Jean Mom Vintage',
      category: 'Jeans',
      price: '\$120.000',
      rating: 4.7,
      description: 'Jeans de tiro alto con lavado clásico retro.',
      imageUrl:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500',
    ),
    Product(
      id: 'j3',
      title: 'Jean Wide Leg Oscuro',
      category: 'Jeans',
      price: '\$130.000',
      rating: 4.8,
      description: 'Pantalón de bota ancha cómodo y moderno.',
      imageUrl:
          'https://images.unsplash.com/photo-1584370848010-d7fe6bc767ec?w=500',
    ),
    Product(
      id: 'j4',
      title: 'Jean Ripped Azul Claro',
      category: 'Jeans',
      price: '\$125.000',
      rating: 4.3,
      description: 'Jeans con detalles desgastados y rotos en las rodillas.',
      imageUrl:
          'https://images.unsplash.com/photo-1511105612320-2e62a04dd044?w=500',
    ),
    Product(
      id: 'j5',
      title: 'Jean Negro Straight',
      category: 'Jeans',
      price: '\$118.000',
      rating: 4.5,
      description: 'Corte recto tradicional en color negro mate.',
      imageUrl:
          'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=500',
    ),
    Product(
      id: 'j6',
      title: 'Jean Cargo Urbano',
      category: 'Jeans',
      price: '\$140.000',
      rating: 4.9,
      description: 'Jeans estilo cargo con bolsillos laterales utilitarios.',
      imageUrl:
          'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500',
    ),

    // --- BUSOS (6) ---
    Product(
      id: 'b1',
      title: 'Buso Hoodie Oversize',
      category: 'Busos',
      price: '\$98.000',
      rating: 4.9,
      description: 'Sudadera con capota en algodón perchado.',
      imageUrl:
          'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=500',
    ),
    Product(
      id: 'b2',
      title: 'Buso Crewneck Minimal',
      category: 'Busos',
      price: '\$89.000',
      rating: 4.5,
      description: 'Buso cerrado de cuello redondo en tono neutro.',
      imageUrl:
          'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=500',
    ),
    Product(
      id: 'b3',
      title: 'Buso con Cierre Alto',
      category: 'Busos',
      price: '\$112.000',
      rating: 4.7,
      description: 'Sudadera alta con medio cierre metálico en el cuello.',
      imageUrl:
          'https://images.unsplash.com/photo-1548883354-7622d03aca27?w=500',
    ),
    Product(
      id: 'b4',
      title: 'Buso Estampado Street',
      category: 'Busos',
      price: '\$105.000',
      rating: 4.6,
      description: 'Buso con diseño gráfico urbano en la parte posterior.',
      imageUrl:
          'https://images.unsplash.com/photo-1578587018452-892bacefd3f2?w=500',
    ),
    Product(
      id: 'b5',
      title: 'Buso Tejido Fino',
      category: 'Busos',
      price: '\$115.000',
      rating: 4.4,
      description: 'Buso tejido de punto suave para climas templados.',
      imageUrl:
          'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=500',
    ),
    Product(
      id: 'b6',
      title: 'Buso Deportivo Comfy',
      category: 'Busos',
      price: '\$95.000',
      rating: 4.8,
      description: 'Buso flexible diseñado para máxima comodidad diaria.',
      imageUrl:
          'https://images.unsplash.com/photo-1509967419530-da38b4704bc6?w=500',
    ),

    // --- BLUSAS (6) ---
    Product(
      id: 'bl1',
      title: 'Blusa Satinada Elegante',
      category: 'Blusas',
      price: '\$78.000',
      rating: 4.7,
      description: 'Blusa de acabado satinado con escote en V.',
      imageUrl:
          'https://images.unsplash.com/photo-1564257631407-4deb1f99d992?w=500',
    ),
    Product(
      id: 'bl2',
      title: 'Blusa Básica Algodón',
      category: 'Blusas',
      price: '\$52.000',
      rating: 4.5,
      description: 'Blusa ligera y fresca de uso cotidiano.',
      imageUrl:
          'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=500',
    ),
    Product(
      id: 'bl3',
      title: 'Top Acanalado Rib',
      category: 'Blusas',
      price: '\$48.000',
      rating: 4.3,
      description: 'Top corto ajustado en tejido elástico texturizado.',
      imageUrl:
          'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=500',
    ),
    Product(
      id: 'bl4',
      title: 'Blusa Estampado Floral',
      category: 'Blusas',
      price: '\$72.000',
      rating: 4.6,
      description:
          'Blusa romántica con detalles de flores y mangas abullonadas.',
      imageUrl:
          'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=500',
    ),
    Product(
      id: 'bl5',
      title: 'Blusa Asimétrica Moderna',
      category: 'Blusas',
      price: '\$82.000',
      rating: 4.8,
      description: 'Diseño vanguardista de un solo hombro.',
      imageUrl:
          'https://images.unsplash.com/photo-1554412933-514a83d2f3c8?w=500',
    ),
    Product(
      id: 'bl6',
      title: 'Blusa Encaje Fino',
      category: 'Blusas',
      price: '\$89.000',
      rating: 4.9,
      description: 'Blusa delicada con transparencias y apliques de encaje.',
      imageUrl:
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500',
    ),

    // --- FALDAS (6) ---
    Product(
      id: 'f1',
      title: 'Falda Midi Plisada',
      category: 'Faldas',
      price: '\$92.000',
      rating: 4.7,
      description: 'Falda larga con pliegues fluidos y gran movimiento.',
      imageUrl:
          'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=500',
    ),
    Product(
      id: 'f2',
      title: 'Minifalda Denim',
      category: 'Faldas',
      price: '\$75.000',
      rating: 4.5,
      description: 'Falda corta de jean con dobladillo clásico.',
      imageUrl:
          'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500',
    ),
    Product(
      id: 'f3',
      title: 'Falda Tubo Eco-Cuero',
      category: 'Faldas',
      price: '\$98.000',
      rating: 4.8,
      description: 'Falda ajustada de cuero sintético con cierre posterior.',
      imageUrl:
          'https://images.unsplash.com/photo-1509967419530-da38b4704bc6?w=500',
    ),
    Product(
      id: 'f4',
      title: 'Falda Larga Boho',
      category: 'Faldas',
      price: '\$88.000',
      rating: 4.4,
      description: 'Falda larga holgada con estampado bohemio.',
      imageUrl:
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500',
    ),
    Product(
      id: 'f5',
      title: 'Falda Corta Deportiva',
      category: 'Faldas',
      price: '\$68.000',
      rating: 4.3,
      description: 'Falda tableada de estilo tenis juvenil y urbano.',
      imageUrl:
          'https://images.unsplash.com/photo-1554412933-514a83d2f3c8?w=500',
    ),
    Product(
      id: 'f6',
      title: 'Falda Satén Asimétrica',
      category: 'Faldas',
      price: '\$95.000',
      rating: 4.9,
      description: 'Falda elegante en satén brillante con corte al sesgo.',
      imageUrl:
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500',
    ),

    // --- CHAQUETAS (6) ---
    Product(
      id: 'ch1',
      title: 'Chaqueta Denim Oversize',
      category: 'Chaquetas',
      price: '\$145.000',
      rating: 4.8,
      description: 'Chaqueta clásica de mezclilla holgada.',
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
    ),
    Product(
      id: 'ch2',
      title: 'Chaqueta Biker de Cuero',
      category: 'Chaquetas',
      price: '\$185.000',
      rating: 4.9,
      description: 'Chaqueta estilo motociclista con cierres metálicos.',
      imageUrl:
          'https://images.unsplash.com/photo-1520975954732-35dd22299614?w=500',
    ),
    Product(
      id: 'ch3',
      title: 'Chaqueta Puffer Acolchada',
      category: 'Chaquetas',
      price: '\$160.000',
      rating: 4.7,
      description: 'Chaqueta térmica impermeable ideal para frío intenso.',
      imageUrl:
          'https://images.unsplash.com/photo-1544441893-675973e31985?w=500',
    ),
    Product(
      id: 'ch4',
      title: 'Blazer Formal Elegante',
      category: 'Chaquetas',
      price: '\$155.000',
      rating: 4.6,
      description: 'Blazer estructurado con solapa clásica para oficina.',
      imageUrl:
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=500',
    ),
    Product(
      id: 'ch5',
      title: 'Chaqueta Rompevientos',
      category: 'Chaquetas',
      price: '\$125.000',
      rating: 4.4,
      description: 'Chaqueta ligera deportiva con capucha ajustable.',
      imageUrl:
          'https://images.unsplash.com/photo-1608256246200-53e635b5b65f?w=500',
    ),
    Product(
      id: 'ch6',
      title: 'Chaqueta Bomber Urban',
      category: 'Chaquetas',
      price: '\$138.000',
      rating: 4.7,
      description: 'Chaqueta bomber con bordes elásticos acanalados.',
      imageUrl:
          'https://images.unsplash.com/photo-1548883354-7622d03aca27?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark
        ? const Color(0xFF141622)
        : const Color(0xFFF3ECE7);
    final cardBg = isDark ? const Color(0xFF1D2030) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
    final textSecondary = isDark ? const Color(0xFF8B8FA8) : Colors.grey;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: _selectedCategory == null
            ? _buildCategoryGrid(cardBg, textPrimary, textSecondary)
            : _buildProductList(cardBg, textPrimary, textSecondary),
      ),
    );
  }

  Widget _buildCategoryGrid(
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Tienda',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Selecciona una categoría',
          style: TextStyle(fontSize: 12, color: textSecondary),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.82,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return GestureDetector(
              onTap: () => setState(() {
                _selectedCategory = category.title;
                _searchQuery = '';
              }),
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
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
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
                            category.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${category.count} artículos',
                            style: TextStyle(
                              fontSize: 10,
                              color: textSecondary,
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
    );
  }

  Widget _buildProductList(
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
  ) {
    final filteredProducts = _allProducts.where((p) {
      return p.category == _selectedCategory &&
          p.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _selectedCategory = null),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: cardBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: textPrimary,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _selectedCategory!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Barra de búsqueda dentro de la categoría
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: textSecondary, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val),
                        style: TextStyle(color: textPrimary, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Buscar en $_selectedCategory...',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    'No hay productos que coincidan',
                    style: TextStyle(color: textSecondary),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: product,
                              onAddToCart: () =>
                                  widget.onAddToCart?.call(product),
                              onBuyNow: widget.onBuyNow,
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
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                child: Image.network(
                                  product.imageUrl,
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
                                    product.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product.price,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
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
                  },
                ),
        ),
      ],
    );
  }
}
