import 'dart:developer';

import 'package:client/controller/contracts/contracts_controller.dart';
import 'package:client/model/contract.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OverView extends StatefulWidget {
  final Contract contract;
  const OverView({Key? key, required this.contract}) : super(key: key);
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<OverView> {
  int _currentStep = 0;
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
                margin: EdgeInsets.all(25), // Adjust the margin as needed
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Earnings",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Container(
                    height: 10,
                  ),
                  StepProgressIndicator(
                    totalSteps: 100,
                    currentStep: 65,
                    size: 8,
                    padding: 0,
                    selectedColor: Colors.yellow,
                    unselectedColor: Colors.cyan,
                    roundedEdges: Radius.circular(10),
                    selectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffd92328), Color(0xffd92328)],
                    ),
                    unselectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey, Colors.grey],
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle),
                          Text("    Total price"),
                        ],
                      ),
                      Text("500\$")
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
                            color: Colors.grey,
                          ),
                          Text("    Received"),
                        ],
                      ),
                      Text("290\$")
                    ],
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                // alignment: Alignment.topLeft,
                child: Text(
                  'Milestone timeline',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, bottom: 40),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.milestones!.length + 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          // controller.getProperty();
                          setState(() {});
                        },
                        child: controller.milestones!.length != index
                            ? Container(
                                // height: 180, // Adjust the height as needed
                                margin: EdgeInsets.only(right: 25, left: 5),
                                child: TimelineTile(
                                  isFirst: index == 0,
                                  isLast: index ==
                                      controller.milestones!.length - 1,
                                  beforeLineStyle: LineStyle(
                                    color: controller.milestones![index]
                                                .milestoneStatus! ==
                                            'Paid'
                                        ? Color(0xffd92328)
                                        : Color.fromARGB(255, 211, 211, 211),
                                    thickness: 0.8,
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    height: 20,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    indicatorXY: 0,
                                    color: controller.milestones![index]
                                                .milestoneStatus! ==
                                            'Paid'
                                        ? Color(0xffd92328)
                                        : Color.fromARGB(255, 211, 211, 211),
                                    width: 28,
                                    iconStyle: IconStyle(
                                      iconData: controller.milestones![index]
                                                  .milestoneStatus ==
                                              'Paid'
                                          ? Icons.done
                                          : Icons.question_mark,
                                      color: controller.milestones![index]
                                                  .milestoneStatus ==
                                              'Paid'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  endChild: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    alignment: Alignment(10.0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            controller
                                                .milestones![index].milestoneName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(controller
                                            .milestones![index].description),
                                        Container(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                "\$" +
                                                    controller
                                                        .milestones![index]
                                                        .amount
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Chip(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              shadowColor: Color(0xffd92328),
                                              label: Text(
                                                controller.milestones![index]
                                                    .milestoneStatus,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                   // Adjust the border radius as needed
                                                  ),
                                              backgroundColor: Color.fromARGB(255, 255, 255, 255), // Set your desired background color
                                              labelStyle: TextStyle(
                                                color: Color(0xffd92328), // Set your desired text color
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                // height: 100, // Adjust the height as needed
                                margin: EdgeInsets.only(top: 15),
                                child: TimelineTile(
                                  isFirst: index == 0,
                                  isLast: true,
                                  beforeLineStyle: LineStyle(
                                    color: Color.fromARGB(255, 42, 42, 42),
                                    thickness: 0.6,
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    color: Color(0xffd92328),
                                    width: 28,
                                    iconStyle: IconStyle(
                                      iconData: Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  endChild: Container(
                                    alignment: Alignment(-1.0, 0),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Get.toNamed(AppRoute.addMilestone);
                                      },
                                      child: Text(
                                        "Propose new milestone",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchStepsType,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.list,
          size: 25,
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }
}












          //  Stepper(
          //         type: stepperType,
          //         physics: ScrollPhysics(),
          //         currentStep: _currentStep,
          //         onStepTapped: (step) => tapped(step),
          //         steps: List<Step>.generate(
          //           stepData.length + 1,
          //           (index) {
          //             if (index < stepData.length) {
          //               return Step(
          //                 title: Text(stepData[index].title),
          //                 content: Column(
          //                   children: <Widget>[
          //                     Text(stepData[index].content),
          //                   ],
          //                 ),
          //                 isActive: _currentStep >= index,
          //                 state: _currentStep >= index
          //                     ? StepState.complete
          //                     : StepState.disabled,
          //               );
          //             } else {
          //               return Step(
          //                 title: Text('Create New Step'),
          //                 content: Column(
          //                   children: <Widget>[
          //                     Text('Content for creating a new step'),
          //                   ],
          //                 ),
          //                 isActive: _currentStep >= index,
          //                 state: _currentStep >= index
          //                     ? StepState.complete
          //                     : StepState.disabled,
          //               );
          //             }
          //           },
          //         ),