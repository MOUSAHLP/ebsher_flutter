import 'package:flutter/material.dart';
class BuildSearchWidget extends StatelessWidget {
  const BuildSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 55),
      child: TextFormField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
