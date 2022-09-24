import 'package:flutter/material.dart';
import 'package:vendo/screens/Notification_screen/notification_card.dart';
import 'package:vendo/util/AppFonts/app_text.dart';
import 'package:vendo/util/AppInterface/ui_helpers.dart';

import '../../models/notificationModel.dart';
import '../../routes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [
    NotificationModel("Dal Rice with curry ", "8:30 PM", "Meal Type: Dinner",
        "officerReview"),
    NotificationModel("Poha, chai", "9:00 AM", "Meal Type: Breakfast",
        "incentiveEligibility"),
    NotificationModel("Paneer Tikka with roti", "2:00 PM", "Meal Type: Lunch",
        "weeklyBazaar"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AppText.headingTwo(
                "Reminders",
                color: Colors.white,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Icon(
                  Icons.add,
                  color: Colors.green,
                  size: 40,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.complaintPage),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            verticalSpaceTiny,
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: notifications.length,
                  itemBuilder: ((context, index) {
                    return NotificationCard(
                      notificationTopic: notifications[index].topic,
                      notificationDate: notifications[index].releaseDate,
                      notificationDiscription: notifications[index].discription,
                      notificationTag: notifications[index].tag,
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
