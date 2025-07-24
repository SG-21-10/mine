import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/financial_log.dart';
import '../providers/accountant_provider.dart';
import '../theme/app_theme.dart';
import '../../constants/colors.dart';

class MaintainFinancialLogScreen extends StatefulWidget {
  const MaintainFinancialLogScreen({Key? key}) : super(key: key);

  @override
  State<MaintainFinancialLogScreen> createState() => _MaintainFinancialLogScreenState();
}

class _MaintainFinancialLogScreenState extends State<MaintainFinancialLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _referenceController = TextEditingController();
  
  String _selectedType = 'expense';
  DateTime _selectedDate = DateTime.now();
  FinancialLog? _editingLog;

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_editingLog == null ? 'Add Financial Log' : 'Edit Financial Log'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
        ),
        body: Container(
          color: AppColors.background,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTypeSelection(),
                  const SizedBox(height: 24),
                  _buildDescriptionField(),
                  const SizedBox(height: 16),
                  _buildAmountField(),
                  const SizedBox(height: 16),
                  _buildCategoryField(),
                  const SizedBox(height: 16),
                  _buildDateField(),
                  const SizedBox(height: 16),
                  _buildReferenceField(),
                  const SizedBox(height: 32),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Income'),
                    value: 'income',
                    groupValue: _selectedType,
                    activeColor: AppColors.success,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Expense'),
                    value: 'expense',
                    groupValue: _selectedType,
                    activeColor: AppColors.error,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: 'Description',
        prefixIcon: Icon(Icons.description),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      decoration: const InputDecoration(
        labelText: 'Amount',
        prefixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an amount';
        }
        if (double.tryParse(value) == null || double.parse(value) <= 0) {
          return 'Please enter a valid amount';
        }
        return null;
      },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      controller: _categoryController,
      decoration: const InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(Icons.category),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a category';
        }
        return null;
      },
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _selectDate,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date',
          prefixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }

  Widget _buildReferenceField() {
    return TextFormField(
      controller: _referenceController,
      decoration: const InputDecoration(
        labelText: 'Reference (Optional)',
        prefixIcon: Icon(Icons.receipt),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveLog,
            child: Text(_editingLog == null ? 'Add Log' : 'Update Log'),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _saveLog() {
    if (!_formKey.currentState!.validate()) return;

    final log = FinancialLog(
      id: _editingLog?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      description: _descriptionController.text,
      amount: double.parse(_amountController.text),
      type: _selectedType,
      date: _selectedDate,
      category: _categoryController.text,
      reference: _referenceController.text.isEmpty ? null : _referenceController.text,
    );

    final provider = context.read<AccountantProvider>();
    if (_editingLog == null) {
      provider.addFinancialLog(log);
    } else {
      provider.updateFinancialLog(log);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_editingLog == null ? 'Financial log added successfully!' : 'Financial log updated successfully!'),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }
}
