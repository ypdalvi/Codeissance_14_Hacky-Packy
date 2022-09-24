import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vendo/models/vendingzoneModel/vendingzone_details.dart';
import 'package:vendo/models/vendorDetailsModel/vendor_details.dart';

import 'package:vendo/providers/vendor_detailsprovider.dart';
import 'package:vendo/util/AppFonts/app_text.dart';
import 'package:vendo/util/AppInterface/ui_helpers.dart';
import 'package:vendo/util/colors.dart';

import '../../routes.dart';
import '../../services/dio_client.dart';

class CopyVendingZoneCard extends ConsumerStatefulWidget {
  CopyVendingZoneCard(
      {Key? key,
      required this.imageUrl,
      required this.postTitle,
      required this.postName})
      : super(key: key);
  final imageUrl;
  final postTitle;
  final postName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VendingZoneCardState();
}

class _VendingZoneCardState extends ConsumerState<CopyVendingZoneCard> {
  @override
  Widget build(BuildContext context) {
    var vendorDetails = ref.read(vendordetailsProvider);
    var imageUrl = widget.imageUrl;
    var postTitle = widget.postTitle;
    var postName = widget.postName;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: getBody(imageUrl, postTitle, postName),
    );
  }

  Widget getBody(imageUrl, postTitle, postName) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    // colorFilter: ColorFilter.mode(
                    //   Colors.black.withOpacity(0.5),
                    //   BlendMode.dstATop,
                    // ),
                    image: AssetImage(imageUrl),
                    fit: BoxFit.fitHeight),
              ),
              // child: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.all(Radius.circular(20)),
              //     child: Image.asset(
              //       imageUrl,
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    child: Container(
                      width: 150,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  verticalSpaceMedium,
                  AppText.headline(postTitle),
                  verticalSpaceMedium,
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.green,
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: AppText.body(postName),
                      )
                    ],
                  ),
                  spacedDivider,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.body(
                          "The Food Guide Pyramid was far from a perfect model for healthy eating, but it did have some strengths. The U.S. Department of Agriculture introduced the pyramid graphic in 1992 after performing extensive consumer research on eating patterns and knowledge. The pyramid was then revamped in 2005 and replaced by a plate.")
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
