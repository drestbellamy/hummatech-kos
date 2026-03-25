import 'package:flutter/material.dart';
import '../models/rule_category_model.dart';

class EditRuleCategoryDialog extends StatefulWidget {
  final RuleCategory category;

  const EditRuleCategoryDialog({
    super.key,
    required this.category,
  });

  @override
  State<EditRuleCategoryDialog> createState() => _EditRuleCategoryDialogState();
}

class _EditRuleCategoryDialogState extends State<EditRuleCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late List<TextEditingController> _ruleControllers;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.category.title);
    _ruleControllers = widget.category.rules
        .map((rule) => TextEditingController(text: rule))
        .toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (var controller in _ruleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addRuleField() {
    setState(() {
      _ruleControllers.add(TextEditingController());
    });
  }

  void _removeRuleField(int index) {
    if (_ruleControllers.length > 1) {
      setState(() {
        _ruleControllers[index].dispose();
        _ruleControllers.removeAt(index);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final rules = _ruleControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList();

      if (rules.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tambahkan minimal satu peraturan'),
            backgroundColor: Color(0xFFE53E3E),
          ),
        );
        return;
      }

      final updatedCategory = RuleCategory(
        id: widget.category.id,
        title: _titleController.text.trim(),
        rules: rules,
      );

      Navigator.pop(context, updatedCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 660),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Edit Peraturan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F2F2F),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: const Color(0xFF6B7280),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Info Banner
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          border: Border.all(color: const Color(0xFFBEDBFF)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF1447E6),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Peraturan berlaku untuk semua kost',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF1447E6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Category Name
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2F2F2F),
                          ),
                          children: [
                            TextSpan(text: 'Nama Kategori '),
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Color(0xFFFB2C36)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFD1D5DC)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFD1D5DC)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFF6B9080)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama kategori harus diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Rules List
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2F2F2F),
                          ),
                          children: [
                            TextSpan(text: 'Daftar Peraturan '),
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Color(0xFFFB2C36)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ..._ruleControllers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final controller = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFD1D5DC),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFD1D5DC),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6B9080),
                                      ),
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
                                onPressed: () => _removeRuleField(index),
                                icon: const Icon(Icons.delete_outline),
                                color: const Color(0xFFE53E3E),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 44,
                                  minHeight: 44,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 8),

                      // Add Item Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _addRuleField,
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Tambah Item'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF6B9080),
                            side: const BorderSide(
                              color: Color(0xFF6B9080),
                              style: BorderStyle.solid,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Color(0xFF6B9080),
                                style: BorderStyle.solid,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF6B7280),
                                side: const BorderSide(color: Color(0xFFD1D5DC)),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6B9080),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
