import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vendo/models/vendorDetailsModel/vendor_details.dart';
import 'package:vendo/models/vendorReviewModel/vendor_review_model.dart';
import 'package:vendo/screens/BMCModule/HomeScreen/vendor_card.dart';
import 'package:vendo/screens/registration/copy_vending_zone_view.dart';
import 'package:vendo/services/dio_client.dart';
import 'package:vendo/util/AppFonts/app_text.dart';
import 'package:vendo/util/AppInterface/ui_helpers.dart';

import '../../../models/vendor_visit_list/vendor_visit_list.dart';
import '../../../providers/vendor_review_provider.dart';
import '../../../routes.dart';
import '../../Write_complaints_screen/copy_complaints.dart';

class BMCHomePage extends ConsumerStatefulWidget {
  const BMCHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BMCHomePageState();
}

class _BMCHomePageState extends ConsumerState<BMCHomePage> {
  List<VendorReviewModel> vendinReviewList = [
    VendorReviewModel(
        reviewId: "32e",
        vendorId: "vendorId",
        waterClogging: "waterClogging",
        foodCover: "foodCover",
        cleanDrinkingWater: "cleanDrinkingWater",
        vendorWearingGloves: "vendorWearingGloves",
        bmcOfficerId: "bmcOfficerId",
        isApprovedLocation: false,
        isFootTraffic: false,
        isLegalAge: false,
        shortDescription: "shortDescription",
        reviewImageUrl: "reviewImageUrl",
        creditScoreAbsolute: 89)
  ];

  @override
  Widget build(BuildContext context) {
    // final myfeedback = ref.watch(myfeedbackProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AppText.headingTwo(
                "For You Page",
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
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CopyAddComplaints()),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              verticalSpaceMedium,
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => CopyVendingZoneCard(
                            imageUrl: "assets/images/food_pyramid.jpg",
                            postName: "Amaan Ansari",
                            postTitle:
                                "What Were the Benefits of the Food Guide Pyramid?",
                          )),
                ),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey.shade900,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8, right: 8, bottom: 0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  minRadius: 20,
                                  backgroundImage:
                                      AssetImage("assets/images/pp4.jpg"),
                                ),
                              ),
                              horizontalSpaceTiny,
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: AppText.body(
                                  "Amaan Ansari",
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          verticalSpaceSmall,
                          Image.asset(
                            "assets/images/food_pyramid.jpg",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.none,
                          ),
                          verticalSpaceSmall,
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText.subheading(
                                "5 Tips On How To Eat More",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpaceTiny,
              AppText.caption(
                "Published on : 29/08/2001",
                color: Colors.grey.shade200,
              ),
              verticalSpaceMedium,
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => CopyVendingZoneCard(
                            imageUrl: "assets/images/workout.jpg",
                            postName: "Ananya Garg",
                            postTitle: "5 Workout Tips For Absolute Beginners",
                          )),
                ),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey.shade900,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8, right: 8, bottom: 0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  minRadius: 20,
                                  backgroundImage:
                                      AssetImage("assets/images/pp5.jpg"),
                                ),
                              ),
                              horizontalSpaceTiny,
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: AppText.body(
                                  "Ananya Garg",
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          verticalSpaceSmall,
                          Image.asset(
                            "assets/images/workout.jpg",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.none,
                          ),
                          verticalSpaceSmall,
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText.subheading(
                                "5 Workout Tips For Absolute Beginners",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpaceTiny,
              AppText.caption(
                "Published on : 29/08/2001",
                color: Colors.grey.shade200,
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }
}
