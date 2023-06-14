import 'package:flutter/material.dart';

import '../../../../core/app_router/app_router.dart';
class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle),
            height: 40,
            width: 40,
            child: const Icon(Icons.share),
          ),
          GestureDetector(
            onTap: () {
              AppRouter.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle),
              height: 40,
              width: 40,
              child: Icon(
                Icons.arrow_forward,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
