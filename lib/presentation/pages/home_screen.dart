// lib/presentation/pages/home_screen.dart

import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(Product) onAddToCart;
  final VoidCallback? onBuyNow;
  final VoidCallback? onGoToStore;

  HomeScreen({
    super.key,
    required this.onAddToCart,
    this.onBuyNow,
    this.onGoToStore,
  });

  final List<Product> popularProducts = [
    Product(
      id: '1',
      title: 'Camiseta Básica Blanca',
      category: 'Camisetas',
      price: '\$42.000',
      rating: 4.5,
      description:
          'Camiseta de algodón 100%, corte regular. Perfecta para el día a día.',
      imageUrl:
          'https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=500',
    ),
    Product(
      id: '2',
      title: 'Camiseta Polo',
      category: 'Camisetas',
      price: '\$75.000',
      rating: 4.4,
      description:
          'Camiseta tipo polo con estampado gráfico urbano y ajuste confort.',
      imageUrl:
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&w=200&q=80',
    ),
    Product(
      id: '3',
      title: 'Camisa de Lino',
      category: 'Camisas',
      price: '\$89.000',
      rating: 4.3,
      description: 'Camisa manga larga en tejido de lino ligero y fresco.',
      imageUrl:
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500',
    ),
    Product(
      id: '4',
      title: 'Pantalón Slim Fit',
      category: 'Pantalones',
      price: '\$115.000',
      rating: 4.3,
      description:
          'Pantalón de corte ajustado con bota doblada en mezclilla clásica.',
      imageUrl:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=200&q=80',
    ),
    Product(
      id: '5',
      title: 'Jean Mom Fit',
      category: 'Pantalones',
      price: '\$125.000',
      rating: 4.4,
      description: 'Jeans de tiro alto con estilo retro y tonos deslavados.',
      imageUrl:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500',
    ),
    Product(
      id: '6',
      title: 'Vestido Camisero',
      category: 'Vestidos',
      price: '\$108.000',
      rating: 4.5,
      description: 'Vestido largo y fluido con cuello estilo camisero.',
      imageUrl:
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500',
    ),
  ];

  final List<Product> newProducts = [
    Product(
      id: '7',
      title: 'Camiseta Oversize',
      category: 'Camisetas',
      price: '\$55.000',
      rating: 4.8,
      description:
          'Camiseta estilo oversize en suave algodón de textura pesada.',
      imageUrl:
          'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=500',
      badge: 'Nuevo',
    ),
    Product(
      id: '8',
      title: 'Camisa Denim',
      category: 'Camisas',
      price: '\$115.000',
      rating: 4.7,
      description: 'Camisa en tejido denim resistente con botones metálicos.',
      imageUrl:
          'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500',
      badge: 'Nuevo',
    ),
    Product(
      id: '9',
      title: 'Jean Skinny',
      category: 'Pantalones',
      price: '\$132.000',
      rating: 4.6,
      description:
          'Jean entallado con tecnología elástica para máxima movilidad.',
      imageUrl:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500',
      badge: 'Nuevo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? Colors.white : const Color(0xFF1E1E2C);
    final cardBg = isDark ? const Color(0xFF242736) : Colors.white;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Bienvenida a',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        Text(
          'Raíz Urbana',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        // Barra de búsqueda
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  style: TextStyle(color: textPrimary),
                  decoration: const InputDecoration(
                    hintText: 'Buscar ropa, accesorios...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF383C56)
                      : const Color(0xFFEBE3DB),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Buscar',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF2C2C3E),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Banner Oferta
        Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=800',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TEMPORADA 2026',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Hasta\n31% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const Text(
                  'Ropa y accesorios seleccionados',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onGoToStore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38405A),
                    minimumSize: const Size(100, 30),
                  ),
                  child: const Text(
                    'Ver ofertas >',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Categorías
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categorías',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            GestureDetector(
              onTap: onGoToStore,
              child: const Text(
                'Ver todas',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildCategoryCard(
              'Ropa',
              '34 productos',
              'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400',
            ),
            _buildCategoryCard(
              'Collares',
              '6 productos',
              'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400',
            ),
            _buildCategoryCard(
              'Manillas',
              '4 productos',
              'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=400',
            ),
            _buildCategoryCard(
              'Aretes',
              '6 productos',
              'https://images.unsplash.com/photo-1630019852942-f89202989a59?w=400',
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Más populares
        Text(
          'Más populares',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const Text(
          'Los favoritos de nuestra comunidad',
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: popularProducts.length,
          itemBuilder: (context, index) {
            final p = popularProducts[index];
            return _buildProductCard(context, p);
          },
        ),
        const SizedBox(height: 20),
        // Nuevos ingresos
        Text(
          'Nuevos ingresos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const Text(
          'Recién llegados a la tienda',
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newProducts.length,
            itemBuilder: (context, index) {
              final p = newProducts[index];
              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 10),
                child: _buildProductCard(context, p),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, String subtitle, String imgUrl) {
    return GestureDetector(
      onTap: onGoToStore,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF1E1E2C);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
              onAddToCart: () => onAddToCart(product),
              onBuyNow: onBuyNow,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: isDark
                              ? const Color(0xFF1A1C28)
                              : Colors.grey[200],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  if (product.badge != null)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E3148),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          product.badge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 10),
                      const Icon(Icons.star, color: Colors.amber, size: 10),
                      const Icon(Icons.star, color: Colors.amber, size: 10),
                      const Icon(Icons.star, color: Colors.amber, size: 10),
                      const Icon(
                        Icons.star_half,
                        color: Colors.amber,
                        size: 10,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Desde',
                    style: TextStyle(fontSize: 8, color: Colors.grey),
                  ),
                  Text(
                    product.price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFF8B8FA8)
                          : const Color(0xFF1E1E2C),
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
