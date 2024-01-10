import 'dart:convert';
import 'package:client/controller/application/applications_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/application.dart';
import 'package:client/model/user.dart';
import 'package:client/view/manage_properties/applications/incoming_application.dart';
import 'package:client/view/manage_properties/applications/sent_application.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllApplications extends StatefulWidget {
  const AllApplications({Key? key});

  @override
  _AllApplicationsState createState() => _AllApplicationsState();
}

class _AllApplicationsState extends State<AllApplications> {
  bool isLoading = true; // Add a boolean variable for loading state
  ApplicationsController controller =
      Get.put(ApplicationsController(), permanent: true);

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    String? userDtoJson = sharepref.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
    User user = User.fromJson(userDto);
    await controller.getApplications(user.id!);

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if data is still loading
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }

    const applicationStatus = [
      "All",
      "Pending",
      "Approved",
    ];

    const applicationType = [
      "All",
      "For daily rent",
      "For monthly rent",
      "For sell",
    ];

    return Scaffold(
      body: Column(
        children: [
          Container(height: 8),
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

          // Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton<String>(
                  alignment: Alignment.centerLeft,
                  isExpanded: true,
                  value: controller.applicationStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.applicationStatus = newValue!;
                      loadData();
                    });
                  },
                  items: applicationStatus.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton<String>(
                  alignment: Alignment.centerLeft,
                  isExpanded: true,
                  value: controller.applicationType,
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.applicationType = newValue!;
                      loadData();
                    });
                  },
                  items: applicationType.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Container(height: 12),
          Expanded(
            child: Container(
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Scaffold(
                  appBar: TabBar(
                    onTap: (value) {
                      if (value == 0) {
                        setState(() {
                          controller.applicationTo = "Landlord";
                        });
                        loadData();
                      } else {
                        setState(() {
                          controller.applicationTo = "Customer";
                        });
                        loadData();
                      }
                    },
                    tabs: const [
                      Tab(text: 'Incoming Applications'),
                      Tab(text: 'Sent Applications'),
                    ],
                    overlayColor: MaterialStatePropertyAll(Colors.grey[350]),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    unselectedLabelColor: Colors.grey[700],
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      // Content for 'Incoming Applications' tab
                      contentIncomingApplications(),

                      // Content for 'Sent Applications' tab
                      contentSentApplications(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentIncomingApplications() {
    if (controller.applications.isEmpty) {
      return const Center(
        child: Text(
          "No any incoming appliaction",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: controller.applications.length,
          itemBuilder: (context, index) {
            Application application = controller.applications[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  Get.to(const IncomingApplication(), arguments: application);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(application.applicationDate),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        (application.user.name!.length <= 38)
                            ? application.user.name!
                            : '${application.user.name!.substring(0, 38)}...',
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
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text(
                                application.applicationStatus.toString(),
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
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text(
                                controller
                                    .applications[index].property.propertyCode,
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
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget contentSentApplications() {
    if (controller.applications.isEmpty) {
      return const Center(
        child: Text(
          "No any sent appliaction",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: controller.applications.length,
          itemBuilder: (context, index) {
            Application application = controller.applications[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  Get.to(const SentApplication(), arguments: application);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          Text(
                             DateFormat('yyyy-MM-dd')
                                .format(application.applicationDate),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        (application.property.user!.name!.length) <= 38
                            ? application.property.user!.name!
                            : '${application.property.user!.name!.substring(0, 38)}...',
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
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text(
                                application.applicationStatus.toString(),
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
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text(
                                controller
                                    .applications[index].property.propertyCode,
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
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
