import 'dart:convert';

import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/application.dart';
import 'package:client/model/user.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AllApplications extends StatefulWidget {
  const AllApplications({Key? key});

  @override
  _AllApplicationsState createState() => _AllApplicationsState();
}

class _AllApplicationsState extends State<AllApplications> {
  bool isLoading = true; // Add a boolean variable for loading state

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    ApplicationsControllerImp controller =
        Get.put(ApplicationsControllerImp(), permanent: true);
    String? userDtoJson = sharepref!.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
    User user = User.fromJson(userDto);
    await controller.getApplications(user.id);

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    ApplicationsControllerImp controller =
        Get.find<ApplicationsControllerImp>();

    // Check if data is still loading
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }

    const contractStatus = [
      "All",
      "Approved App",
      "Pending App",
    ];
    const contractType = [
      "All",
      "Rent Appications",
      "Buy Appications",
    ];
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: TextFormField(
              // Use your controller here if needed
              style: const TextStyle(height: 1.2),
              decoration: InputDecoration(
                hintText: "Search by property code, customer, landlord name",
                suffixIcon: const Icon(Icons.search),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton<String>(
                  value: controller.applicationStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.applicationStatus = newValue!;
                    });
                  },
                  items: contractStatus.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton<String>(
                  value: controller.applicationType,
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.applicationType = newValue!;
                    });
                  },
                  items: contractType.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Container(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.applications.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // controller.getProperty();
                    Get.toNamed(AppRoute.applicationDetails,
                        arguments: controller.applications[index]);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                FontAwesomeIcons.circleDot,
                                size: 25,
                                color: const Color(0xffd92328),
                              ),
                              // Image.asset("assets/images/application_icon.jpg",
                              //     scale: 18),

                              Text(
                                (controller.applications![index]
                                            .applicationDate!
                                            .toString()
                                            .length <=
                                        10)
                                    ? "       ${controller.applications![index].applicationDate!.toString()!}"
                                    : "       ${controller.applications![index].applicationDate!.toString().substring(0, 9)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                            ],
                          ),
                          Text(
                            (controller.applications![index].user!.name!
                                        .length <=
                                    38)
                                ? controller.applications![index].user!.name!
                                : '${controller.applications![index].user!.name!.substring(0, 38)}...',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      isThreeLine:
                          true, // This allows the title to take up more horizontal space
                      subtitle: Column(
                        children: [
                          Container(
                            height: 1,
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1, // Adjust the width as needed
                              ),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.solidFileZipper,
                              size: 25,
                              color: const Color(0xffd92328),
                            ),
                          ),

                          Container(
                            height: 1,
                          ),
                          // Text(
                          //   (controller.applications![index].Message!.length <=
                          //           50)
                          //       ? controller.applications![index].Message!
                          //       : '${controller.applications![index].Message!
                          //               .substring(0, 50)}...',
                          //   style: const TextStyle(fontWeight: FontWeight.w400),
                          // ),
                          Container(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "status: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    controller
                                        .applications![index].applicationStatus!
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Color(0xffd92328)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Property Code: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    controller.applications![index].property
                                        .propertyCode!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Color(0xffd92328)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Add other widgets here for displaying additional information
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
