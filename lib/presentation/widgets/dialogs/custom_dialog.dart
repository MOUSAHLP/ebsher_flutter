import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, required this.content, this.icon, this.color})
      : super(key: key);
  final Widget content;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  // height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white,
                  ),
                  child: content,
                ),
                Positioned(
                  top: -30,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color ?? Colors.redAccent,
                        ),
                        child: Icon(
                          icon ?? Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
