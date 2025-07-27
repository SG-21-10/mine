import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/validators.dart';

class PriceCalculator extends StatefulWidget {
  final Product product;

  const PriceCalculator({
    super.key,
    required this.product,
  });

  @override
  State<PriceCalculator> createState() => _PriceCalculatorState();
}

class _PriceCalculatorState extends State<PriceCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController(text: '1');
  final _discountController = TextEditingController(text: '0');
  final _taxController = TextEditingController(text: '0');

  int quantity = 1;
  double discountPercent = 0.0;
  double taxPercent = 0.0;

  @override
  void initState() {
    super.initState();
    _quantityController.addListener(_updateCalculation);
    _discountController.addListener(_updateCalculation);
    _taxController.addListener(_updateCalculation);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _discountController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  void _updateCalculation() {
    setState(() {
      quantity = int.tryParse(_quantityController.text) ?? 1;
      discountPercent = double.tryParse(_discountController.text) ?? 0.0;
      taxPercent = double.tryParse(_taxController.text) ?? 0.0;
    });
  }

  double get subtotal => widget.product.price * quantity;
  double get discountAmount => subtotal * (discountPercent / 100);
  double get afterDiscount => subtotal - discountAmount;
  double get taxAmount => afterDiscount * (taxPercent / 100);
  double get total => afterDiscount + taxAmount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Fields Row
              Row(
                children: [
                  // Quantity Input
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          validator: Validators.validateQuantity,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Discount Input
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Discount (%)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _discountController,
                          keyboardType: TextInputType.number,
                          validator: Validators.validateDiscount,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Tax Input
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tax (%)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _taxController,
                          keyboardType: TextInputType.number,
                          validator: Validators.validateTax,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Calculation Breakdown
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    // Price per item
                    _buildCalculationRow(
                      'Price per item:',
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      isHeader: true,
                    ),
                    const SizedBox(height: 8),
                    
                    // Quantity
                    _buildCalculationRow(
                      'Quantity:',
                      quantity.toString(),
                    ),
                    const SizedBox(height: 8),
                    
                    // Subtotal
                    _buildCalculationRow(
                      'Subtotal:',
                      '\$${subtotal.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                    
                    // Discount (if any)
                    if (discountPercent > 0) ...[
                      const SizedBox(height: 4),
                      _buildCalculationRow(
                        'Discount (${discountPercent.toStringAsFixed(1)}%):',
                        '-\$${discountAmount.toStringAsFixed(2)}',
                        color: Colors.green,
                      ),
                      const SizedBox(height: 4),
                      _buildCalculationRow(
                        'After discount:',
                        '\$${afterDiscount.toStringAsFixed(2)}',
                      ),
                    ],
                    
                    // Tax (if any)
                    if (taxPercent > 0) ...[
                      const SizedBox(height: 4),
                      _buildCalculationRow(
                        'Tax (${taxPercent.toStringAsFixed(1)}%):',
                        '+\$${taxAmount.toStringAsFixed(2)}',
                        color: Colors.orange,
                      ),
                    ],
                    
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 8),
                    
                    // Final Total
                    _buildCalculationRow(
                      'TOTAL:',
                      '\$${total.toStringAsFixed(2)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Stock Validation Message
              if (quantity > widget.product.stock)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red.shade700,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Only ${widget.product.stock} items available in stock',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _quantityController.text = '1';
                        _discountController.text = '0';
                        _taxController.text = '0';
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: quantity <= widget.product.stock
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                _showAddToCartDialog();
                              }
                            }
                          : null,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculationRow(
    String label,
    String value, {
    bool isHeader = false,
    bool isBold = false,
    bool isTotal = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : isHeader ? 14 : 13,
            fontWeight: isTotal || isBold || isHeader
                ? FontWeight.bold
                : FontWeight.normal,
            color: color ?? (isTotal ? Colors.blue : Colors.black87),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : isHeader ? 14 : 13,
            fontWeight: isTotal || isBold || isHeader
                ? FontWeight.bold
                : FontWeight.normal,
            color: color ?? (isTotal ? Colors.blue : Colors.black87),
          ),
        ),
      ],
    );
  }

  void _showAddToCartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to Cart'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${widget.product.name}'),
            Text('Quantity: $quantity'),
            Text('Total: \$${total.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            const Text(
              'This is a demo app. Cart functionality is not implemented.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}