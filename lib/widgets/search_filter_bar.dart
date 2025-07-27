import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class SearchFilterBar extends StatefulWidget {
  const SearchFilterBar({super.key});

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isExpanded = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          productProvider.searchProducts(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    productProvider.searchProducts('');
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        _isExpanded ? Icons.expand_less : Icons.tune,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Filters (Expandable)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isExpanded ? null : 0,
                child: _isExpanded
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category Filter
                            const Text(
                              'Category',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: productProvider.categories.length,
                                itemBuilder: (context, index) {
                                  final category = productProvider.categories[index];
                                  final isSelected = productProvider.selectedCategory == category;
                                  
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      label: Text(category),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        productProvider.filterByCategory(category);
                                      },
                                      backgroundColor: Colors.grey.shade200,
                                      selectedColor: Colors.blue.shade100,
                                      checkmarkColor: Colors.blue,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Price Range Filter
                            const Text(
                              'Price Range',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RangeSlider(
                              values: RangeValues(
                                productProvider.minPrice,
                                productProvider.maxPrice,
                              ),
                              min: 0,
                              max: 1000,
                              divisions: 20,
                              labels: RangeLabels(
                                '\$${productProvider.minPrice.toStringAsFixed(0)}',
                                '\$${productProvider.maxPrice.toStringAsFixed(0)}',
                              ),
                              onChanged: (values) {
                                productProvider.filterByPriceRange(
                                  values.start,
                                  values.end,
                                );
                              },
                            ),
                            
                            // Price Range Display
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${productProvider.minPrice.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$${productProvider.maxPrice.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Clear Filters Button
                            Center(
                              child: TextButton.icon(
                                onPressed: () {
                                  _searchController.clear();
                                  productProvider.clearFilters();
                                },
                                icon: const Icon(Icons.clear_all),
                                label: const Text('Clear All Filters'),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // Divider
              if (_isExpanded)
                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
        );
      },
    );
  }
}