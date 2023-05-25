import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../resources/style_app.dart';
class BuildNotificationWidget extends StatelessWidget {
  bool isSee;

  BuildNotificationWidget(this.isSee);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: isSee ? Colors.white : Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration:
              BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                      "orem ipsum dolor sit amet,  ut labore et dolore",
                      style: getBoldStyle(
                          color:
                          isSee ? ColorManager.primaryColor : Colors.white,
                          fontSize: 14),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                Text("منذ ساعة",
                    style: getBoldStyle(
                        color: isSee ? ColorManager.primaryColor : Colors.white,
                        fontSize: 13),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
