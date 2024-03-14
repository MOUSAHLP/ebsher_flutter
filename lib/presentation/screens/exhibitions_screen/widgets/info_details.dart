import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';

class InfoDetails extends StatelessWidget {
  const InfoDetails({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String? label;
  final String? value;


  @override
  Widget build(BuildContext context) {
    if (label == null || value == null||value == "null") return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label!,style: getMediumStyle(color: Colors.white)),
            const SizedBox( width: 5,),
            Expanded(child: Text(value!,style: getMediumStyle(color: Colors.white))),
          ]),
    );
  }
}
