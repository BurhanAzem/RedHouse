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

    if (mounted) {
      setState(() {
        isLoading = false; // Set isLoading to false when data is loaded
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if data is still loading
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
        ),
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
                      child: Text(
                        option,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                      Tab(text: 'Incoming Requests'),
                      Tab(text: 'Sent Requests'),
                    ],
                    overlayColor: MaterialStatePropertyAll(Colors.grey[350]),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                    unselectedLabelColor: Colors.grey[700],
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      // Content for 'Incoming Applications' tab
                      // contentIncomingApplications(),
                      FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 1)),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey[200],
                              ),
                            );
                          } else {
                            return contentIncomingApplications();
                          }
                        },
                      ),

                      // Content for 'Sent Applications' tab
                      // contentSentApplications(),
                      FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 1)),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey[200],
                              ),
                            );
                          } else {
                            return contentSentApplications();
                          }
                        },
                      ),
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
          "No Any Incoming Request",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: controller.applications.length,
          itemBuilder: (context, index) {
            Application application = controller.applications[index];
            EdgeInsets _margin;

            if (index == controller.applications.length - 1) {
              _margin =
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 25);
            } else {
              _margin = const EdgeInsets.only(right: 12, left: 12, top: 25);
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  Get.to(const IncomingApplication(), arguments: application);
                });
              },
              child: Container(
                margin: _margin,
                height: 350,
                width: double.infinity,
                child: Stack(
                  children: [
                    Material(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(0, 0),
                              blurRadius: 5,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(left: 190, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              "Request Status",
                              style: TextStyle(
                                color: Color(0xFF191d2d),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              application.applicationStatus,
                              style: const TextStyle(
                                color: Color(0xffd92328),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 17),
                            const Text(
                              "Request Date",
                              style: TextStyle(
                                color: Color(0xFF191d2d),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(application.applicationDate),
                              style: const TextStyle(
                                color: Color(0xffd92328),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 17),
                            const Text(
                              "Client",
                              style: TextStyle(
                                color: Color(0xFF191d2d),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              application.user.name!,
                              style: const TextStyle(
                                color: Color(0xffd92328),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 17),
                            const Text(
                              "Property Code",
                              style: TextStyle(
                                color: Color(0xFF191d2d),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              application.property.propertyCode,
                              style: const TextStyle(
                                color: Color(0xffd92328),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          height: 320,
                          width: 135,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                "Request ${index + 1}",
                                style: const TextStyle(
                                  color: Color(0xFF191d2d),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                application.property.listingType ==
                                        "For daily rent"
                                    ? "Booking"
                                    : "Application",
                                style: const TextStyle(
                                  color: Color(0xffd92328),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Image.asset(
                                "assets/images/accept-request.png",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
          "No Any Sent Request",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: controller.applications.length,
          itemBuilder: (context, index) {
            Application application = controller.applications[index];
            EdgeInsets _margin;

            if (index == controller.applications.length - 1) {
              _margin =
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 25);
            } else {
              _margin = const EdgeInsets.only(right: 12, left: 12, top: 25);
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  Get.to(const SentApplication(), arguments: application);
                });
              },
              child: Container(
                margin: _margin,
                height: 350,
                width: double.infinity,
                child: Stack(
                  children: [
                    Material(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(0, 0),
                              blurRadius: 5,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(left: 190, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              "Request Status",
                              style: TextStyle(
                                color: Color(0xFF191d2d),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              application.applicationStatus,
                              style: const TextStyle(
                                color: Color(0xffd92328),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 17),
                            const Text(
                              "Request Date",
                              style: TextStyle(
                                color: Color(0xFF191d2d),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(application.applicationDate),
                              style: const TextStyle(
                                color: Color(0xffd92328),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 17),
                            const Text(
                              "Landlord",
                              style: TextStyle(
                                color: Color(0xFF191d2d),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              application.property.user!.name!,
                              style: const TextStyle(
                                color: Color(0xffd92328),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 17),
                            const Text(
                              "Property Code",
                              style: TextStyle(
                                color: Color(0xFF191d2d),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              application.property.propertyCode,
                              style: const TextStyle(
                                color: Color(0xffd92328),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          height: 320,
                          width: 135,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                "Request ${index + 1}",
                                style: const TextStyle(
                                  color: Color(0xFF191d2d),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                application.property.listingType ==
                                        "For daily rent"
                                    ? "Booking"
                                    : "Application",
                                style: const TextStyle(
                                  color: Color(0xffd92328),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Image.asset(
                                "assets/images/accept-request.png",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
