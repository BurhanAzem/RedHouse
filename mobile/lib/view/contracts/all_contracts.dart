import 'dart:convert';
import 'package:client/controller/contract/contracts_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/contract.dart';
import 'package:client/model/user.dart';
import 'package:client/view/contracts/contract.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AllContracts extends StatefulWidget {
  const AllContracts({Key? key});

  @override
  _AllContractsState createState() => _AllContractsState();
}

class _AllContractsState extends State<AllContracts>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true; // Add a boolean variable for loading state
  ContractsController controller =
      Get.put(ContractsController(), permanent: true);

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  Future<void> loadData() async {
    String? userDtoJson = sharepref.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
    User user = User.fromJson(userDto);
    controller.userId = user.id!;
    await controller.getAllContrcats();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    const contractStatus = [
      "All",
      "Closed",
      "Active",
    ];
    const contractType = [
      "All",
      "For monthly rent",
      "For sell",
    ];

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }
    return VisibilityDetector(
      key: const Key('widget1'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          loadData();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Contracts",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: TextFormField(
                // Use your controller here if needed
                style: const TextStyle(height: 1.2),
                decoration: InputDecoration(
                  hintText: "Search by contract, customer, landlord name",
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<String>(
                    alignment: Alignment.centerLeft,
                    isExpanded: true,
                    value: controller.contractStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.contractStatus = newValue!;
                        loadData();
                      });
                    },
                    items: contractStatus.map((String option) {
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
                    value: controller.contractType,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.contractType = newValue!;
                        loadData();
                      });
                    },
                    items: contractType.map((String option) {
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
            Container(
              height: 12,
            ),
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
                            controller.contractTo = "Landlord";
                          });
                          loadData();
                        } else {
                          setState(() {
                            controller.contractTo = "Customer";
                          });
                          loadData();
                        }
                      },
                      tabs: const [
                        Tab(text: 'Landlord Contracts'),
                        Tab(text: 'Customer Contracts'),
                      ],
                      overlayColor: MaterialStatePropertyAll(Colors.grey[350]),
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
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
                        // Content for 'Landlord Contracts' tab
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.contracts.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ContractReview(
                                        contract: controller.contracts[index],
                                      ));
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.handshake,
                                              size: 25,
                                            ),
                                            Text(
                                              (controller.contracts
                                                          .isNotEmpty &&
                                                      index <
                                                          controller
                                                              .contracts.length)
                                                  ? "       ${controller.contracts[index].startDate.toString().length <= 10 ? controller.contracts[index].startDate.toString() : controller.contracts[index].startDate.toString().substring(0, 9)}"
                                                  : "N/A", // Replace "N/A" with a default value or message
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          (controller.contracts[index].offer!
                                                      .description.length <=
                                                  38)
                                              ? controller.contracts[index]
                                                  .offer!.description
                                              : '${controller.contracts[index].offer!.description.substring(0, 38)}...',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
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
                                            height: 0.5,
                                            color: const Color(0xffd92328)),
                                        Container(
                                          height: 1,
                                        ),
                                        Text(
                                          (controller.contracts[index].offer!
                                                      .description.length <=
                                                  100)
                                              ? controller.contracts[index]
                                                  .offer!.description
                                              : '${controller.contracts[index].offer!.description.substring(0, 100)}...',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Price: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller.contracts[index]
                                                      .offer!.price
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Color(0xffd92328)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Contract status: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller.contracts[index]
                                                      .contractStatus,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                        ),

                        // Content for 'Customer Contracts' tab
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.contracts.length,
                            itemBuilder: (context, index) {
                              Contract contract = controller.contracts[index];

                              return GestureDetector(
                                onTap: () {
                                  // Get.toNamed(AppRoute.contract);
                                  Get.to(
                                      () => ContractReview(contract: contract));
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.handshake,
                                              size: 25,
                                            ),
                                            Text(
                                              (controller.contracts[index]
                                                          .startDate
                                                          .toString()
                                                          .length <=
                                                      10)
                                                  ? "       ${controller.contracts[index].startDate.toString()}"
                                                  : "       ${controller.contracts[index].startDate.toString().substring(0, 9)}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          (controller.contracts[index].offer!
                                                      .description.length <=
                                                  38)
                                              ? controller.contracts[index]
                                                  .offer!.description
                                              : '${controller.contracts[index].offer!.description.substring(0, 38)}...',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
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
                                            height: 0.5,
                                            color: const Color(0xffd92328)),
                                        Container(
                                          height: 1,
                                        ),
                                        Text(
                                          (controller.contracts[index].offer!
                                                      .description.length <=
                                                  100)
                                              ? controller.contracts[index]
                                                  .offer!.description
                                              : '${controller.contracts[index].offer!.description.substring(0, 100)}...',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Price: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller.contracts[index]
                                                      .offer!.price
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Color(0xffd92328)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Contract status: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller.contracts[index]
                                                      .contractStatus,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
