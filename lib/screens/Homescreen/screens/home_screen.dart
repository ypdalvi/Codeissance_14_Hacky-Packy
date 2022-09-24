import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:place_picker/place_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendo/Screens/Homescreen/screens/widgets/services_card.dart';
import 'package:vendo/models/governmentSchemeModel/government_scheme_model.dart';
import 'package:vendo/models/vendorDetailsModel/vendor_details.dart';

import 'package:vendo/providers/government_scheme_provider.dart';
import 'package:vendo/providers/vendor_detailsprovider.dart';
import 'package:vendo/services/dio_client.dart';
import 'package:vendo/util/AppFonts/app_text.dart';
import 'package:vendo/util/AppInterface/ui_helpers.dart';
import 'package:vendo/util/colors.dart';
import '../../../routes.dart';
import 'dart:ui' as ui;

import '../../BMCModule/HomeScreen/qr_scanner.dart';
import '../../Write_complaints_screen/take_picture.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  IconData iconData = Icons.person;
  bool isQRVisible = false;

  String? displayImagePath;
  String? _complaintType;
  VendorModel? vendorDetails;
  bool isInitialized = false;
  XFile? image;
  String? description;
  late final String uniqueString;
  late final String imagePathString;
  late Reference imageRef;
  late final CameraController cameraController;
  late CameraDescription cameraDescription;

  void qrPressed() {
    setState(() {
      isQRVisible = !isQRVisible;
    });
  }

  Future<void> takePhoto() async {
    final _displayImagePath = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(
          camera: cameraDescription,
        ),
      ),
    );
    // setState(
    //   () {
    //     displayImagePath = _displayImagePath;
    //     print(" hi $displayImagePath");
    //   },
    // );
  }

  @override
  void initState() {
    cameraSettings();
    super.initState();
  }

  Future<void> cameraSettings() async {
    late final CameraController _cameraController;
    final _cameras = await availableCameras();

    _cameraController = CameraController(_cameras[0], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      setState(() {
        cameraController = _cameraController;
        isInitialized = true;
        cameraDescription = _cameras[0];
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/anopal.png",
              scale: 4,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Icon(
                  Icons.notifications,
                  color: Colors.green,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.notificationScreen),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    color: Colors.black,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpaceMedium,
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/pp2.jpeg"),
                              backgroundColor: Colors.green[900],
                              radius: 30,
                            ),
                            title: AppText.headingThree(
                              "Yash Dalvi",
                              color: Colors.white,
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  takePhoto();
                                },
                                child: Icon(
                                  Icons.document_scanner_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          verticalSpaceMedium,
                          PhysicalModel(
                            color: Colors.grey.shade900,
                            elevation: 8,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.grey[400],
                                      ),
                                      horizontalSpaceMedium,
                                      AppText.body(
                                        "Age",
                                        color: Colors.grey.shade400,
                                      ),
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  verticalSpaceSmall,
                                  GestureDetector(
                                    onTap: () {
                                      qrPressed();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.green,
                                        ),
                                        horizontalSpaceMedium,
                                        AppText.body(
                                          "Male",
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  verticalSpaceSmall,
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.balance,
                                        color: Colors.green,
                                      ),
                                      horizontalSpaceMedium,
                                      AppText.body(
                                        "70.4 kg",
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  verticalSpaceSmall,
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.height_sharp,
                                        color: Colors.grey[400],
                                      ),
                                      horizontalSpaceMedium,
                                      AppText.body(
                                        "Height",
                                        color: Colors.grey.shade400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          verticalSpaceMedium,
                          PhysicalModel(
                            color: Colors.grey.shade900,
                            elevation: 8,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 6.0),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.bodyBold(
                                      "Nutrient intake summary",
                                      color: Colors.white,
                                    ),
                                    verticalSpaceSmall,
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Colors.green,
                                          maxRadius: 5,
                                        ),
                                        horizontalSpaceSmall,
                                        AppText.caption(
                                          "Carb (0.2 g)",
                                          color: Colors.white,
                                        ),
                                        horizontalSpaceMedium,
                                        CircleAvatar(
                                          backgroundColor: Colors.green[200],
                                          maxRadius: 5,
                                        ),
                                        horizontalSpaceSmall,
                                        AppText.caption(
                                          "Fat (0.2 g)",
                                          color: Colors.white,
                                        ),
                                        horizontalSpaceMedium,
                                        CircleAvatar(
                                          backgroundColor: Colors.green[50],
                                          maxRadius: 5,
                                        ),
                                        horizontalSpaceSmall,
                                        AppText.caption(
                                          "Protien (0.2 g)",
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    AppText.body(
                                      "Actual",
                                      color: Colors.white,
                                    ),
                                    Stack(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 10,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.green[50],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 10,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: Colors.green[200],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: 10,
                                          child: const DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    AppText.body(
                                      "Recommended",
                                      color: Colors.white,
                                    ),
                                    Stack(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 10,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.green[50],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70,
                                          height: 10,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: Colors.green[200],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.50,
                                          height: 10,
                                          child: const DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpaceLarge,
                                    AppText.body(
                                      "Nutrition info",
                                      color: Colors.white,
                                    ),
                                    verticalSpaceSmall,
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green[200],
                                          maxRadius: 5,
                                        ),
                                        horizontalSpaceSmall,
                                        AppText.caption(
                                          "Low intake",
                                          color: Colors.white,
                                        ),
                                        horizontalSpaceMedium,
                                        CircleAvatar(
                                          backgroundColor: Colors.green[800],
                                          maxRadius: 5,
                                        ),
                                        horizontalSpaceSmall,
                                        AppText.caption(
                                          "Average)",
                                          color: Colors.white,
                                        ),
                                        horizontalSpaceMedium,
                                        CircleAvatar(
                                          backgroundColor: Colors.red,
                                          maxRadius: 5,
                                        ),
                                        horizontalSpaceSmall,
                                        AppText.caption(
                                          "HIgh intake",
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        AppText.caption(
                                          "Protien",
                                          color: Colors.white,
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 5,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Colors.green[800],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        AppText.caption(
                                          "Fiber",
                                          color: Colors.white,
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 5,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              height: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Colors.green[300],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        AppText.caption(
                                          "Vitamin A",
                                          color: Colors.white,
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 5,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Colors.green[800],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        AppText.caption(
                                          "Vitamin C",
                                          color: Colors.white,
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 5,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              height: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Colors.green[300],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        AppText.caption(
                                          "Potassium",
                                          color: Colors.white,
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 5,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              height: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        AppText.caption(
                                          "Calcium",
                                          color: Colors.white,
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 5,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              height: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Colors.green[300],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        AppText.caption(
                                          "Saturated Fat",
                                          color: Colors.white,
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 5,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              height: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Colors.green[300],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Visibility(
          //   visible: isQRVisible,
          //   child: GestureDetector(
          //     onTap: () {
          //       qrPressed();
          //     },
          //     child: BackdropFilter(
          //       filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          //       child: Center(
          //         child: Container(
          //             decoration:
          //                 const BoxDecoration(color: Colors.transparent),
          //             width: MediaQuery.of(context).size.width * 0.95,
          //             height: MediaQuery.of(context).size.height * 0.95,
          //             child: Center(
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   AppText.body(
          //                     "hiiii",
          //                     color: Colors.pink,
          //                   )
          //                 ],
          //               ),
          //             )),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
