import 'package:flutter/material.dart';
import 'register_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Laptop Pro 15"',
      'description': 'Laptop de alto rendimiento para profesionales',
      'price': 2499.99,
      'category': 'Electrónica',
      'stock': 15,
    },
    {
      'name': 'Mouse Inalámbrico',
      'description': 'Mouse ergonómico 2.4GHz con batería recargable',
      'price': 45.90,
      'category': 'Accesorios',
      'stock': 80,
    },
    {
      'name': 'Teclado Mecánico',
      'description': 'Teclado RGB con switches Cherry MX Red',
      'price': 189.00,
      'category': 'Accesorios',
      'stock': 30,
    },
    {
      'name': 'Monitor 27" 4K',
      'description': 'Pantalla IPS con 144Hz y HDR400',
      'price': 1350.00,
      'category': 'Electrónica',
      'stock': 10,
    },
    {
      'name': 'Polo Deportivo',
      'description': 'Tela transpirable 100% poliéster',
      'price': 39.90,
      'category': 'Ropa',
      'stock': 120,
    },
    {
      'name': 'Zapatillas Running',
      'description': 'Suela antideslizante, plantilla de gel',
      'price': 220.00,
      'category': 'Deportes',
      'stock': 45,
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered {
    if (_query.isEmpty) return _products;
    return _products
        .where(
          (p) =>
              (p['name'] as String)
                  .toLowerCase()
                  .contains(_query.toLowerCase()) ||
              (p['category'] as String)
                  .toLowerCase()
                  .contains(_query.toLowerCase()),
        )
        .toList();
  }

  Color _categoryColor(String category) {
    const map = {
      'Electrónica': Color(0xFF6C4EE8),
      'Accesorios': Color(0xFF00B4D8),
      'Ropa': Color(0xFFEF476F),
      'Alimentos': Color(0xFF06D6A0),
      'Hogar': Color(0xFFFFB703),
      'Deportes': Color(0xFFFF6B35),
      'Otros': Color(0xFF8E9AAF),
    };
    return map[category] ?? const Color(0xFF8E9AAF);
  }

  @override
  Widget build(BuildContext context) {
    final products = _filtered;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0077B6),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Lista de Productos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_products.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RegisterProductScreen()),
        ),
        backgroundColor: const Color(0xFF0077B6),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Agregar',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          _buildSearchHeader(),
          Expanded(
            child: products.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                    itemCount: products.length,
                    itemBuilder: (_, i) => _buildProductCard(products[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      color: const Color(0xFF0077B6),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (v) => setState(() => _query = v),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Buscar por nombre o categoría...',
          hintStyle:
              TextStyle(color: Colors.white.withValues(alpha: 0.6)),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  icon:
                      const Icon(Icons.clear_rounded, color: Colors.white70),
                  onPressed: () {
                    _searchCtrl.clear();
                    setState(() => _query = '');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> p) {
    final color = _categoryColor(p['category'] as String);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child:
                  Icon(Icons.inventory_2_rounded, color: color, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF1A1A2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    p['description'] as String,
                    style:
                        TextStyle(fontSize: 12, color: Colors.grey[500]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          p['category'] as String,
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.layers_rounded,
                          size: 13, color: Colors.grey[400]),
                      const SizedBox(width: 3),
                      Text(
                        'Stock: ${p['stock']}',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'S/. ${(p['price'] as double).toStringAsFixed(2)}',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 72, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Sin resultados',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Prueba con otro término',
            style: TextStyle(fontSize: 13, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
