import 'package:flutter/material.dart';

class CitySearchDialog extends StatefulWidget {
  const CitySearchDialog({super.key});

  @override
  State<CitySearchDialog> createState() => _CitySearchDialogState();
}

class _CitySearchDialogState extends State<CitySearchDialog> {
  late final TextEditingController _cityTextFieldController;

  @override
  void initState() {
    super.initState();
    _cityTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Dialog(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            controller: _cityTextFieldController,
            decoration: InputDecoration(
              hintText: 'Enter city',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed:
                  () => Navigator.pop(context, _cityTextFieldController.text),
              child: Text('Search'),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    _cityTextFieldController.dispose();
    super.dispose();
  }
}
