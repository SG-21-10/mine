import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product.dart';

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
  final TextEditingController _quantityController = TextEditingController(text: '1');
  final TextEditingController _discountController = TextEditingController(text: '0');
  final TextEditingController _taxController = TextEditingController(text: '0');
  
  int quantity = 1;
  double discount = 0.0;
  double tax = 0.0;

  @override
  void dispose() {
    _quantityController.dispose();
    _discountController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  double get subtotal => widget.product.price * quantity;
  double get discountAmount => subtotal * (discount / 100);
  double get afterDiscount => subtotal - discountAmount;
  double get taxAmount => afterDiscount * (tax / 100);
  double get total => afterDiscount + taxAmount;

  void _updateCalculation() {
    setState(() {
      quantity = int.tryParse(_quantityController.text) ?? 1;
      if (quantity < 1) {
        quantity = 1;
        _quantityController.text = '1';
      }
      
      discount = double.tryParse(_discountController.text) ?? 0.0;
      if (discount < 0) {
        discount = 0;
        _discountController.text = '0';
      } else if (discount > 100) {
        discount = 100;
        _discountController.text = '100';
      }
      
      tax = double.tryParse(_taxController.text) ?? 0.0;
      if (tax < 0) {
        tax = 0;
        _taxController.text = '0';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Fields
            Row(
              children: [
                // Quantity
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantity',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: (value) => _updateCalculation(),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Discount %
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discount (%)',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _discountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: (value) => _updateCalculation(),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Tax %
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tax (%)',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _taxController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: (value) => _updateCalculation(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Calculation Breakdown
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildCalculationRow(
                    'Price per item:',
                    '\$${widget.product.price.toStringAsFixed(2)}',
                  ),
                  _buildCalculationRow(
                    'Quantity:',
                    quantity.toString(),
                  ),
                  const Divider(),
                  _buildCalculationRow(
                    'Subtotal:',
                    '\$${subtotal.toStringAsFixed(2)}',
                  ),
                  if (discount > 0) ...[
                    _buildCalculationRow(
                      'Discount (${discount.toStringAsFixed(1)}%):',
                      '-\$${discountAmount.toStringAsFixed(2)}',
                      isDeduction: true,
                    ),
                    _buildCalculationRow(
                      'After discount:',
                      '\$${afterDiscount.toStringAsFixed(2)}',
                    ),
                  ],
                  if (tax > 0) ...[
                    _buildCalculationRow(
                      'Tax (${tax.toStringAsFixed(1)}%):',
                      '+\$${taxAmount.toStringAsFixed(2)}',
                      isAddition: true,
                    ),
                  ],
                  const Divider(thickness: 2),
                  _buildCalculationRow(
                    'Total:',
                    '\$${total.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculationRow(
    String label,
    String value, {
    bool isTotal = false,
    bool isDeduction = false,
    bool isAddition = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              fontSize: isTotal ? 16 : 14,
              color: isTotal
                  ? Theme.of(context).primaryColor
                  : isDeduction
                      ? Colors.red[600]
                      : isAddition
                          ? Colors.orange[600]
                          : null,
            ),
          ),
        ],
      ),
    );
  }
}