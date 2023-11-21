import 'dart:developer';

import 'package:client/controller/contracts/contracts_controller.dart';
import 'package:client/model/contract.dart';
import 'package:client/model/contractActivity.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Details extends StatefulWidget {
  final Contract contract;
  const Details({Key? key, required this.contract}) : super(key: key);
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<Details> {
  int _currentStep = 0;
  bool showMoreSummary = false;
  String summaryString = "Show more";
  StepperType stepperType = StepperType.vertical;
// bool isLoading = true; // Add a boolean variable for loading state

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//     setState(() {});
//   }

//   void loadData() async {
//     AllContractsControllerImp controller =
//         Get.put(AllContractsControllerImp(), permanent: true);
//     String? userDtoJson = sharepref!.getString("user");
//     Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
//     User user = User.fromJson(userDto);
//     controller.userId = user.id;
//     await controller.getAllContrcats();

//     setState(() {
//       isLoading = false; // Set isLoading to false when data is loaded
//     });
//   }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    ContractsControllerImp controller = Get.put(ContractsControllerImp());

    // if (isLoading) {
    //   return Center(
    //     child: CircularProgressIndicator(), // Show a loading indicator
    //   );
    // }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15), // Adjust the margin as needed
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Summary",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Container(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text("Contract type")),
                        ],
                      ),
                      Text(widget.contract.contractType)
                    ],
                  ),
                  Container(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: Colors.grey,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text("Start date")),
                        ],
                      ),
                      Text(
                          widget.contract.startDate.toString().substring(0, 11))
                    ],
                  ),
                  showMoreSummary
                      ? Column(
                          children: [
                            Container(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.black,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text("Landlord")),
                                  ],
                                ),
                                Text(widget.contract.offer!.landlord!.name!)
                              ],
                            ),
                            Container(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text("Price")),
                                  ],
                                ),
                                Text(widget.contract.offer!.price.toString())
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        showMoreSummary = !showMoreSummary;
                      });
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          !showMoreSummary ? "Show more" : "Show less",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.all(15), // Adjust the margin as needed
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Container(
                    height: 15,
                  ),
                  Container(child: Text(
                      // "Hi, everyone. I will do my best to be as straightforward, to the point and descriptive as possible. I am looking for a web designer/programmer to help me create an online 'tutoring' website that will potentially allow high schoolers to earn volunteer hours for posting their own made foreign language material onto the website. Foreign language material can include things like vocab sets, worksheets, and other educational materials that can be used in a classroom. It is designed to essentially allow high school students who know a second language to provide material that can be used in classrooms and by")),
                      widget.contract.offer!.description)),
                  Container(
                    height: 15,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          "View original offer",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.all(15), // Adjust the margin as needed
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Recent Activity",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Container(
                    height: 15,
                  ),
                  Container(
                    child: Row(children: [
                      Container(
                          margin: EdgeInsets.only(right: 68),
                          child: Text("Date")),
                      Text("Description")
                    ]),
                  ),
                  Container(
                    height: 0.8,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Color.fromARGB(255, 80, 80, 80),
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 25, bottom: 40),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: activities!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // controller.getProperty();
                            // Consider adding state changes here if needed
                          },
                          child: Column(
                            children: [
                              Container(
                                // height: 180, // Adjust the height as needed
                                // margin: EdgeInsets.only(right: 25, left: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 30),
                                      child: Text(
                                        activities[index]
                                            .activityDate
                                            .toString()
                                            .substring(0, 10),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          activities[index].activityDescription,
                                          softWrap: true,
                                          // Other styling options go here
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (activities!.length - 1 != index)
                                Container(
                                  height: 0.8,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  color: Color.fromARGB(255, 80, 80, 80),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.all(15), // Adjust the margin as needed
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Feedback",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Container(
                    height: 15,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "This contract doesn’t have any feedback right now ",
                      )),
                  Container(
                    height: 5,
                  ),
                  Container(
                      child: Icon(
                    Icons.feed_rounded,
                    size: 50,
                  )),
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 6),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          "Give Feedback",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  ),
                  MaterialButton(
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    shape: RoundedRectangleBorder(
                        // border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(18)),
                    onPressed: () {},
                    child: Container(
                        child: Text(
                      "Request Feedback",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    )),
                  ),
                ]),
              ),
              Container(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<ContractActivity> activities = [
  new ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription: "Bassam create new milestone"),
  new ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription:
          "Bassam create new milestone This contract doesn’t have any feedback right nowThis contract doesn’t have any feedback right now"),
  new ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription: "Bassam create new milestone "),
  new ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription: "Bassam create new milestone"),
  new ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription:
          "Bassam create new milestone This contract doesn’t have any feedback right now"),
];
