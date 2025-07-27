import '../models/product.dart';

class ProductService {
  static final List<Product> _products = [
    Product(
      id: '1',
      name: 'Wireless Bluetooth Headphones',
      description: 'High-quality wireless headphones with noise cancellation and 30-hour battery life.',
      price: 299.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x200?text=Headphones',
      stock: 25,
      rating: 4.5,
      tags: ['wireless', 'bluetooth', 'headphones', 'audio'],
    ),
    Product(
      id: '2',
      name: 'Smartphone Case',
      description: 'Durable protective case for your smartphone with wireless charging support.',
      price: 29.99,
      category: 'Accessories',
      imageUrl: 'https://via.placeholder.com/300x200?text=Phone+Case',
      stock: 100,
      rating: 4.2,
      tags: ['case', 'protection', 'smartphone', 'wireless'],
    ),
    Product(
      id: '3',
      name: 'Laptop Stand',
      description: 'Adjustable aluminum laptop stand for better ergonomics and cooling.',
      price: 79.99,
      category: 'Office',
      imageUrl: 'https://via.placeholder.com/300x200?text=Laptop+Stand',
      stock: 50,
      rating: 4.7,
      tags: ['laptop', 'stand', 'ergonomic', 'aluminum'],
    ),
    Product(
      id: '4',
      name: 'LED Desk Lamp',
      description: 'Energy-efficient LED desk lamp with adjustable brightness and color temperature.',
      price: 49.99,
      category: 'Office',
      imageUrl: 'https://via.placeholder.com/300x200?text=Desk+Lamp',
      stock: 30,
      rating: 4.3,
      tags: ['led', 'lamp', 'desk', 'adjustable'],
    ),
    Product(
      id: '5',
      name: 'Wireless Mouse',
      description: 'Ergonomic wireless mouse with precision tracking and long battery life.',
      price: 39.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x200?text=Wireless+Mouse',
      stock: 75,
      rating: 4.4,
      tags: ['wireless', 'mouse', 'ergonomic', 'precision'],
    ),
    Product(
      id: '6',
      name: 'Coffee Mug',
      description: 'Ceramic coffee mug with heat-retaining design and comfortable grip.',
      price: 14.99,
      category: 'Kitchen',
      imageUrl: 'https://via.placeholder.com/300x200?text=Coffee+Mug',
      stock: 200,
      rating: 4.1,
      tags: ['coffee', 'mug', 'ceramic', 'kitchen'],
    ),
    Product(
      id: '7',
      name: 'Wireless Charger',
      description: 'Fast wireless charging pad compatible with all Qi-enabled devices.',
      price: 24.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x200?text=Wireless+Charger',
      stock: 60,
      rating: 4.6,
      tags: ['wireless', 'charger', 'fast', 'qi'],
    ),
    Product(
      id: '8',
      name: 'Water Bottle',
      description: 'Stainless steel insulated water bottle that keeps drinks cold for 24 hours.',
      price: 19.99,
      category: 'Sports',
      imageUrl: 'https://via.placeholder.com/300x200?text=Water+Bottle',
      stock: 120,
      rating: 4.8,
      tags: ['water', 'bottle', 'insulated', 'stainless'],
    ),
    Product(
      id: '9',
      name: 'Bluetooth Speaker',
      description: 'Portable Bluetooth speaker with 360-degree sound and waterproof design.',
      price: 89.99,
      category: 'Electronics',
      imageUrl: 'https://via.placeholder.com/300x200?text=Bluetooth+Speaker',
      stock: 40,
      rating: 4.5,
      tags: ['bluetooth', 'speaker', 'portable', 'waterproof'],
    ),
    Product(
      id: '10',
      name: 'Notebook Set',
      description: 'Set of 3 premium notebooks with dotted pages for bullet journaling.',
      price: 24.99,
      category: 'Stationery',
      imageUrl: 'https://via.placeholder.com/300x200?text=Notebook+Set',
      stock: 80,
      rating: 4.2,
      tags: ['notebook', 'journal', 'dotted', 'premium'],
    ),
  ];

  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_products);
  }

  Future<Product?> getProductById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    final lowerQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
             product.description.toLowerCase().contains(lowerQuery) ||
             product.category.toLowerCase().contains(lowerQuery) ||
             product.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    return _products.where((product) => product.category == category).toList();
  }
}