import 'package:flutter/material.dart';

class MCQWidget extends StatefulWidget {
  final String questionId;
  final String questionText;
  final List<Map<String, String>> options;
  final Function(String?, String) onOptionSelected;

  const MCQWidget({
    required this.questionId,
    required this.questionText,
    required this.options,
    required this.onOptionSelected,
    super.key,
  });

  @override
  MCQWidgetState createState() => MCQWidgetState();
}

class MCQWidgetState extends State<MCQWidget> {
  String? _selectedOptionId;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use minimum height for the column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.questionText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...widget.options.map((option) {
              return RadioListTile<String>(
                title: Text(
                  option['text']!,
                  style: const TextStyle(fontSize: 14),
                ),
                value: option['id']!,
                groupValue: _selectedOptionId,
                onChanged: (value) {
                  setState(() {
                    _selectedOptionId = value;
                  });
                  widget.onOptionSelected(value, widget.questionId);
                },
                activeColor: Theme.of(context).primaryColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                dense: true, // Reduces vertical padding for tighter layout
              );
            }),
          ],
        ),
      ),
    );
  }
}