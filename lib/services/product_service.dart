import '../models/product.dart';

class ProductService {
  // Mock product data
  static final List<Product> _products = [
    Product(
      id: '1',
      name: 'iPhone 15 Pro',
      description: 'Latest iPhone with titanium design and A17 Pro chip',
      price: 999.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x300/007AFF/FFFFFF?text=iPhone+15+Pro',
      inStock: true,
    ),
    Product(
      id: '2',
      name: 'MacBook Air M2',
      description: 'Lightweight laptop with M2 chip and all-day battery life',
      price: 1199.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x300/007AFF/FFFFFF?text=MacBook+Air',
      inStock: true,
    ),
    Product(
      id: '3',
      name: 'Nike Air Max 270',
      description: 'Comfortable running shoes with modern design',
      price: 129.99,
      category: 'Footwear',
      imageUrl: 'https://via.placeholder.com/300x300/FF2D55/FFFFFF?text=Nike+Air+Max',
      inStock: true,
    ),
    Product(
      id: '4',
      name: 'Levi\'s 501 Jeans',
      description: 'Classic straight-leg jeans made from premium denim',
      price: 89.99,
      category: 'Clothing',
      imageUrl: 'https://via.placeholder.com/300x300/34C759/FFFFFF?text=Levi\'s+Jeans',
      inStock: true,
    ),
    Product(
      id: '5',
      name: 'Sony WH-1000XM5',
      description: 'Wireless noise-canceling headphones with premium sound',
      price: 349.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x300/FF9500/FFFFFF?text=Sony+Headphones',
      inStock: true,
    ),
    Product(
      id: '6',
      name: 'Adidas Ultraboost 22',
      description: 'High-performance running shoes with boost technology',
      price: 189.99,
      category: 'Footwear',
      imageUrl: 'https://via.placeholder.com/300x300/8E8E93/FFFFFF?text=Ultraboost+22',
      inStock: true,
    ),
    Product(
      id: '7',
      name: 'The North Face Jacket',
      description: 'Waterproof outdoor jacket for all weather conditions',
      price: 249.99,
      category: 'Clothing',
      imageUrl: 'https://via.placeholder.com/300x300/AF52DE/FFFFFF?text=North+Face',
      inStock: false,
    ),
    Product(
      id: '8',
      name: 'iPad Pro 12.9"',
      description: 'Professional tablet with M2 chip and liquid retina display',
      price: 1099.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x300/5856D6/FFFFFF?text=iPad+Pro',
      inStock: true,
    ),
    Product(
      id: '9',
      name: 'Ray-Ban Aviator',
      description: 'Classic aviator sunglasses with UV protection',
      price: 159.99,
      category: 'Accessories',
      imageUrl: 'https://via.placeholder.com/300x300/FF3B30/FFFFFF?text=Ray-Ban',
      inStock: true,
    ),
    Product(
      id: '10',
      name: 'Samsung Galaxy Watch 6',
      description: 'Smart watch with health monitoring and fitness tracking',
      price: 299.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x300/30D158/FFFFFF?text=Galaxy+Watch',
      inStock: true,
    ),
  ];

  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_products);
  }

  Future<Product?> getProductById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}