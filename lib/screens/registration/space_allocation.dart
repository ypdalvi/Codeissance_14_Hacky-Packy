import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:vendo/Screens/registration/space_allocation_list.dart';
import 'package:vendo/models/vendingzoneModel/vendingzone_details.dart';
import 'package:vendo/providers/vendor_detailsprovider.dart';
import 'package:vendo/util/AppFonts/app_text.dart';
import 'package:vendo/util/AppFonts/styles.dart';
import 'package:vendo/util/AppInterface/ui_helpers.dart';
import 'package:vendo/util/colors.dart';
import '../../routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SpaceAllocation extends ConsumerStatefulWidget {
  const SpaceAllocation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SpaceAllocationState();
}

String vendorCategory = "Doctor";

final dropDownProvider = StateProvider<String>((ref) {
  return vendorCategory;
});

String location = '';
bool _validate = false;

final locationProvider = StateProvider((ref) {
  return location;
});

class _SpaceAllocationState extends ConsumerState<SpaceAllocation> {
  double _sliderTaxValue = 20;
  String _name = '';
  String shopCity = '';
  String? _complaintType = "Doctor";
  bool isVisible = false;

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyClwDKfzGV_7ICoib-lk2rH0iw5IlKW5Lw"),
      ),
    );
    print("wowow34oow ${result.subLocalityLevel1!.name.toString()}");
    print("wowow34oow ${result.subLocalityLevel2!.name.toString()}");

    shopCity = result.city!.name.toString();
    print(shopCity);
    ref.watch(locationProvider.notifier).state =
        result.formattedAddress.toString();
  }

  void onContinue() {
    var vendordata = ref.read(vendordetailsProvider);
    vendordata.vendorCategory = vendorCategory;
    vendordata.shopCity = shopCity;
    vendordata.creditScore = _sliderTaxValue;
    vendordata.shopName = _name;

    log(vendordata.toJson().toString());
    print(" $shopCity ,$vendorCategory , $_sliderTaxValue ");
  }

  List<VendingzoneModel> vendingzonelist = [
    VendingzoneModel(
        vendingZoneId: "dsd",
        vendingZoneLocality: "Dr Komalika Acharya",
        vendingZoneLat: 34,
        vendingZoneLong: 34,
        vendingZoneDescription: "Specilializes in adults' counselling.",
        vendingZoneImageurl: "assets/images/pp1.jpg",
        maximumVendorsAllowed: 90,
        vendingZoneCity: "adas",
        vendingZoneWard: "9/10",
        vendingZoneLocationFee: 4000,
        vendingZoneAddress: "A/103, Somnath, Kanderpada, Dahisar(W)",
        categoryOfVendorsNotAllowed: ["dfs"],
        vendorTypeFavorable: ["sdfs"],
        vendorIdList: [{}]),
    VendingzoneModel(
        vendingZoneId: "dsd",
        vendingZoneLocality: "Dr Prem Dodia",
        vendingZoneLat: 34,
        vendingZoneLong: 34,
        vendingZoneDescription:
            "Specialises in pre-teen and early adolescent counselling.",
        vendingZoneImageurl: "assets/images/pp3.jpg",
        maximumVendorsAllowed: 45,
        vendingZoneCity: "adas",
        vendingZoneWard: "8/10",
        vendingZoneLocationFee: 6000,
        vendingZoneAddress: "10/7 Saraswat Colony, Santacruz ",
        categoryOfVendorsNotAllowed: ["dfs"],
        vendorTypeFavorable: ["sdfs"],
        vendorIdList: [{}]),
  ];

  @override
  Widget build(BuildContext context) {
    String _location = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        automaticallyImplyLeading: false,
        title: AppText.headingOne(
          "Experts Near Me",
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
              bottom: 20,
              left: 0,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.bodyBold(
                        "Type",
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: _complaintType,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _complaintType = newValue!;
                            });
                          },
                          items: <String>[
                            'Doctor',
                            'Therapist',
                            'Nutrionist',
                          ].map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      verticalSpaceMedium,
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextField(
                            onChanged: (value) => value,
                            readOnly: true,
                            onTap: () {
                              showPlacePicker();
                            },
                            decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                labelText: 'Your Location',
                                hintText: 'Your Location',
                                hintStyle: body1Style),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // verticalSpaceMedium,
                      // verticalSpaceLarge,
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20),
                      //   child: AppText.subheading("Location Tax Range"),
                      // ),
                      // verticalSpaceSmall,
                      // Slider(
                      //   activeColor: colors.primary,
                      //   inactiveColor: colors.primary,
                      //   thumbColor: colors.primary,
                      //   value: _sliderTaxValue,
                      //   max: 100000,
                      //   label: _sliderTaxValue.round().toString(),
                      //   onChanged: (double value) {
                      //     setState(() {
                      //       _sliderTaxValue = value;
                      //     });
                      //   },
                      // ),
                      verticalSpaceLarge,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Center(
                          child: SizedBox(
                            height: 50,
                            width: 200,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppText.body(
                                    "Search Experts",
                                    color: colors.backgroundColor,
                                  ),
                                  const Icon(
                                    Icons.search,
                                    color: colors.backgroundColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      Visibility(
                          visible: !isVisible,
                          child: Container(
                            height: 500,
                            color: Colors.black,
                          )),
                      Visibility(
                        visible: isVisible,
                        child: SingleChildScrollView(
                          child: Container(
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20),),
                            height: 500,
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: vendingzonelist.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    child: ListTile(
                                      isThreeLine: true,
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                              vendingzonelist[index]!
                                                  .vendingZoneImageurl,
                                            ),
                                          )
                                        ],
                                      ),
                                      title: Expanded(
                                          child: AppText.bodyBold(
                                        vendingzonelist[index]!
                                            .vendingZoneLocality,
                                        isSingleLined: 2,
                                      )),
                                      subtitle: Expanded(
                                        child: Container(
                                          height: 60,
                                          child: AppText.body(
                                            vendingzonelist[index]!
                                                .vendingZoneDescription,
                                            isSingleLined: 1,
                                          ),
                                        ),
                                      ),
                                      trailing: AppText.body(
                                          vendingzonelist[index]!
                                              .vendingZoneWard),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          Routes.vendingZoneCard,
                                          arguments: VendingZoneViewArguments(
                                              model: vendingzonelist[index]!),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
