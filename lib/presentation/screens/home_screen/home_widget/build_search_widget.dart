import 'package:absher/presentation/screens/home_screen/home_widget/search_result_screen.dart';
import 'package:flutter/material.dart';

import '../../../../models/category_response.dart';
class BuildSearchWidget extends StatelessWidget {
  List<CategoyResponse> listCategory = [];
   BuildSearchWidget({super.key,required this.listCategory});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: (){
        print("ddd");
       // showSearch(context: context, delegate: Search(listCategory));
      },
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 55),
        child: TextFormField(
          readOnly: true,
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
      ),
    );
  }
}
