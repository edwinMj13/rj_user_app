import 'package:flutter/material.dart';

class  TextFormFieldAddressDetailsWidget extends StatelessWidget {
  const TextFormFieldAddressDetailsWidget({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 0.5),
      ),
      child: TextFormField(
        maxLength: 50,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
        ),
        controller: controller,
        obscureText: false,
        maxLines: 4,
        minLines: 1,
        validator: (value){
          if(value==null || value.isEmpty){
            return label;
          }
          return null;
        },
      ),
    );
  }
}