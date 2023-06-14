import 'package:absher/models/notification_model.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/relative_time.dart';
import '../../../resources/style_app.dart';
class BuildNotificationWidget extends StatelessWidget {
  bool isSee;
  NotificationModel notificationModel;
  BuildNotificationWidget({required this.isSee,required this.notificationModel});

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
                      notificationModel.title!,
                      style: getBoldStyle(
                          color:
                          isSee ? ColorManager.primaryColor : Colors.white,
                          fontSize: 16),
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                      notificationModel.body!,
                      style: getMediumStyle(
                          color:
                          isSee ? ColorManager.primaryColor : Colors.white,
                          fontSize: 14),
                      softWrap: true,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis),
                ),
                Text( RelativeTime.relativeTime(context, notificationModel.createdAt),
                    style: getSemiBoldStyle(
                        color: isSee ? ColorManager.primaryColor : Colors.white,
                        fontSize: 13),
                    overflow: TextOverflow.ellipsis),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
