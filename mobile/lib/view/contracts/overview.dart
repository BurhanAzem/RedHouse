import 'dart:developer';
import 'package:client/controller/contract/contracts_controller.dart';
import 'package:client/controller/contract/milestone_controller.dart';
import 'package:client/model/contract.dart';
import 'package:client/routes.dart';
import 'package:client/view/contracts/add_milestone.dart';
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
  bool isLoading = true; // Add a boolean variable for loading state

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    MilestoneControllerImp milestonesController =
        Get.put(MilestoneControllerImp());

    await milestonesController.getAllMilestonesForContract(widget.contract.id);

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    ContractsControllerImp controller = Get.put(ContractsControllerImp());
    MilestoneControllerImp milestonesController =
        Get.put(MilestoneControllerImp());

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
                margin: const EdgeInsets.all(25), // Adjust the margin as needed
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Earnings",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Container(
                    height: 10,
                  ),
                  const StepProgressIndicator(
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
                  const Row(
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
                  const Row(
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
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                // alignment: Alignment.topLeft,
                child: const Text(
                  'Milestone timeline',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, bottom: 40),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: milestonesController.milestones!.length + 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          // controller.getProperty();
                          setState(() {});
                        },
                        child: milestonesController.milestones!.length != index
                            ? Container(
                                // height: 180, // Adjust the height as needed
                                margin: const EdgeInsets.only(right: 25, left: 5),
                                child: TimelineTile(
                                  isFirst: index == 0,
                                  isLast: index ==
                                      milestonesController.milestones!.length -
                                          1,
                                  beforeLineStyle: LineStyle(
                                    color: milestonesController
                                                .milestones![index]
                                                .milestoneStatus! ==
                                            'Paid'
                                        ? const Color(0xffd92328)
                                        : Color.fromARGB(118, 60, 58, 58),
                                    thickness: 0.8,
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    height: 20,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    indicatorXY: 0,
                                    color: milestonesController
                                                .milestones![index]
                                                .milestoneStatus! ==
                                            'Paid'
                                        ? const Color(0xffd92328)
                                        : const Color.fromARGB(255, 211, 211, 211),
                                    width: 28,
                                    iconStyle: IconStyle(
                                      iconData: milestonesController
                                                  .milestones![index]
                                                  .milestoneStatus ==
                                              'Paid'
                                          ? Icons.done
                                          : Icons.question_mark,
                                      color: milestonesController
                                                  .milestones![index]
                                                  .milestoneStatus ==
                                              'Paid'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  endChild: Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    alignment: const Alignment(0.0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          // margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            milestonesController
                                                .milestones![index]
                                                .milestoneName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(milestonesController
                                            .milestones![index].description),
                                        Container(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(right: 10),
                                              child: Text(
                                                "\$" +
                                                    milestonesController
                                                        .milestones![index]
                                                        .amount
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Chip(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              shadowColor: const Color(0xffd92328),
                                              label: Text(
                                                milestonesController
                                                    .milestones![index]
                                                    .milestoneStatus,
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                // Adjust the border radius as needed
                                              ),
                                              backgroundColor: const Color.fromARGB(
                                                  255,
                                                  255,
                                                  255,
                                                  255), // Set your desired background color
                                              labelStyle: const TextStyle(
                                                color: Color(
                                                    0xffd92328), // Set your desired text color
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
                                margin: const EdgeInsets.only(top: 15),
                                child: TimelineTile(
                                  isFirst: index == 0,
                                  isLast: true,
                                  beforeLineStyle: const LineStyle(
                                    color: Color.fromARGB(255, 42, 42, 42),
                                    thickness: 0.6,
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    color: const Color(0xffd92328),
                                    width: 28,
                                    iconStyle: IconStyle(
                                      iconData: Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  endChild: Container(
                                    alignment: const Alignment(-1.0, 0),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Get.to(AddMilestone(
                                            contract: widget.contract));
                                      },
                                      child: const Text(
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
    );
  }
}
