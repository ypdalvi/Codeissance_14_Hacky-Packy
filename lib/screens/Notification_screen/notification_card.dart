import 'package:flutter/material.dart';
import 'package:vendo/util/AppFonts/app_text.dart';
import 'package:vendo/util/AppInterface/ui_helpers.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
      {Key? key,
      required this.notificationTopic,
      required this.notificationDate,
      required this.notificationDiscription,
      required this.notificationTag})
      : super(key: key);

  final String notificationTopic;
  final String notificationDate;
  final String notificationDiscription;
  final String notificationTag;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  Widget getIcon(notificationTag) {
    if (notificationTag == "officerReview") {
      return const Icon(Icons.local_police_rounded);
    } else if (notificationTag == "weeklyBazaar") {
      return const Icon(Icons.shop);
    } else {
      return Icon(Icons.money);
    }
  }

  bool isChecked = false;

  void check() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    String notificationTopic = widget.notificationTopic;
    String notificationDate = widget.notificationDate;
    String notificationDiscription = widget.notificationDiscription;
    String notificationTag = widget.notificationTag;

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 8),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.grey.shade900),
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      //AppText.bodyBold(notificationTopic),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          notificationTopic,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      // Expanded(
                      //   child: Container(),
                      // ),
                    ],
                  ),
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (val) {
                        check();
                      },
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        notificationDiscription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      child: AppText.body(
                        notificationDate,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class NotificationCard extends StatefulWidget {
//   const NotificationCard(
//       {Key? key,
//       required this.notificationTopic,
//       required this.notificationDate,
//       required this.notificationDiscription,
//       required this.notificationTag})
//       : super(key: key);
//   final String notificationTopic;
//   final String notificationDate;
//   final String notificationDiscription;
//   final String notificationTag;

//   Widget getIcon(notificationTag) {
//     if (notificationTag == "officerReview") {
//       return const Icon(Icons.local_police_rounded);
//     } else if (notificationTag == "weeklyBazaar") {
//       return const Icon(Icons.shop);
//     } else {
//       return Icon(Icons.money);
//     }
//   }

//   bool isChecked = false;



//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//       child: Material(
//         elevation: 10,
//         child: Container(
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 SizedBox(
//                   child: Row(
//                     children: [
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       //AppText.bodyBold(notificationTopic),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         child: Text(
//                           notificationTopic,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           style: const TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       // Expanded(
//                       //   child: Container(),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 verticalSpaceTiny,
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30),
//                   child: Row(
//                     children: [
//                       Checkbox(value: isChecked, onChanged: (){})
//                       Text(
//                         notificationDiscription,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//                 verticalSpaceSmall,
//                 Row(
//                   children: [
//                     Expanded(child: Container()),
//                     AppText.body(notificationDate),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
