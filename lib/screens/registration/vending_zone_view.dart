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

class VendingZoneCard extends ConsumerStatefulWidget {
  VendingZoneCard({Key? key, required this.vendingZone}) : super(key: key);
  VendingzoneModel vendingZone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VendingZoneCardState();
}

class _VendingZoneCardState extends ConsumerState<VendingZoneCard> {
  @override
  Widget build(BuildContext context) {
    final vendingZone = widget.vendingZone;
    var vendorDetails = ref.read(vendordetailsProvider);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: getBody(vendingZone, vendorDetails),
    );
  }

  Widget getBody(VendingzoneModel vendingZone, VendorModel vendorDetails) {
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
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.dstATop,
                    ),
                    image: AssetImage(vendingZone.vendingZoneImageurl),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                    vendingZone.vendingZoneImageurl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
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
                  AppText.headline(vendingZone.vendingZoneLocality),
                  verticalSpaceMedium,
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: AppText.body(vendingZone.vendingZoneAddress),
                      )
                    ],
                  ),
                  spacedDivider,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.bodyBold("Description"),
                      verticalSpaceSmall,
                      Row(
                        children: [
                          Expanded(
                            child: AppText.body(
                                vendingZone.vendingZoneDescription),
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  AppText.bodyBold("Details"),
                  verticalSpaceSmall,
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        color: Colors.green,
                      ),
                      horizontalSpaceSmall,
                      AppText.body(
                          "Available slots : ${vendingZone.maximumVendorsAllowed}"),
                    ],
                  ),
                  verticalSpaceSmall,
                  Row(
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.green,
                      ),
                      horizontalSpaceSmall,
                      AppText.body(
                          "Doctor Fee : ${vendingZone.vendingZoneLocationFee}"),
                    ],
                  ),
                  verticalSpaceSmall,
                  Row(
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.green,
                      ),
                      horizontalSpaceSmall,
                      Row(
                        children: [
                          AppText.body("Website :"),
                          AppText.caption(
                            "https//:komalikaacharyal@gmail.com",
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
