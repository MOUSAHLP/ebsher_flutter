import 'package:flutter/material.dart';
class EditProfileScreen extends StatelessWidget {
  bool isEditing;
   EditProfileScreen({super.key,this.isEditing=false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Container(

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
//              border: Bo
            ),
          ),
        ),

    );
  }
}
