import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/controller/contracts/all_contracts_controller.dart';
import 'package:client/routes.dart';
import 'package:client/view/contracts/contract.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AllApplications extends StatefulWidget {
   const AllApplications({Key? key});

  @override
  _AllApplicationsState createState() => _AllApplicationsState();
}

class _AllApplicationsState extends State<AllApplications> {
  @override
  Widget build(BuildContext context) {
    ApplicationsControllerImp controller =
        Get.put(ApplicationsControllerImp(), permanent: true);
    const contractStatus = [
      "All",
      "Approved App",
      "Wating App",
    ];
    const contractType = [
      "All",
      "Rent App          ",
      "Buy App",
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: const Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         "All ",
      //         style: TextStyle(
      //           color: Color(0xffd92328),
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       Text(
      //         "Contracts",
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          Container(height: 8,),
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
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton<String>(
                  value: controller.contractStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.contractStatus = newValue!;
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
                  value: controller.contractType,
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.contractType = newValue!;
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
              itemCount: controller.Contracts!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.getProperty();
                    setState(() {
                      
                    });
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
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                FontAwesomeIcons.solidFileZipper,
                                size: 25,
                              ),
                              // Text(
                              //   (controller.Contracts![index].CreatedDate!
                              //               .toString()
                              //               .length <=
                              //           10)
                              //       ? "       ${controller
                              //               .Contracts![index].CreatedDate!
                              //               .toString()!}"
                              //       : "       ${controller
                              //               .Contracts![index].CreatedDate!
                              //               .toString()
                              //               .substring(0, 9)}",
                              //   style: const TextStyle(
                              //       fontWeight: FontWeight.w600, fontSize: 12),
                              // ),
                            ],
                          ),
                          // Text(
                          //   (controller.Contracts![index].Title!.length <= 38)
                          //       ? controller.Contracts![index].Title!
                          //       : '${controller.Contracts![index].Title!
                          //               .substring(0, 38)}...',
                          //   style: const TextStyle(fontWeight: FontWeight.w600),
                          // ),
                        ],
                      ),
                      isThreeLine:
                          true, // This allows the title to take up more horizontal space
                      subtitle: Column(
                        children: [
                          Container(
                            height: 1,
                          ),
                          Container(height: 0.5, color: const Color(0xffd92328)),
                          Container(
                            height: 1,
                          ),
                          // Text(
                          //   (controller.Contracts![index].Description!.length <=
                          //           100)
                          //       ? controller.Contracts![index].Description!
                          //       : '${controller.Contracts![index].Description!
                          //               .substring(0, 100)}...',
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
                                    "Price: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  // Text(
                                  //   controller.Contracts![index].Price!
                                  //       .toString(),
                                  //   style: const TextStyle(
                                  //       fontWeight: FontWeight.w600,
                                  //       fontSize: 12,
                                  //       color: Color(0xffd92328)),
                                  // ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Contract status: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  // Text(
                                  //   controller
                                  //       .Contracts![index].ContractStatus!,
                                  //   style: const TextStyle(
                                  //       fontWeight: FontWeight.w600,
                                  //       fontSize: 12,
                                  //       color: Color(0xffd92328)),
                                  // ),
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