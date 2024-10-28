import 'package:flutter/material.dart';

class TextFormDetailsWidget extends StatelessWidget {
  const TextFormDetailsWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.inputType,
    this.enabled=true,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      enabled: enabled,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      controller: controller,
      validator: (value){
        if(value==null || value.isEmpty ){
          return label;
        }
        return null;
      },
    );
  }
}