import 'package:client/model/contract.dart';
import 'package:client/model/contractActivity.dart';
import 'package:flutter/material.dart';

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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15), // Adjust the margin as needed
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
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
                          const Icon(
                            Icons.circle,
                            size: 8,
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text("Contract type")),
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
                          const Icon(
                            Icons.circle,
                            size: 8,
                            color: Colors.grey,
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text("Start date")),
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
                                    const Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.black,
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        child: const Text("Landlord")),
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
                                    const Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        child: const Text("Price")),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          !showMoreSummary ? "Show more" : "Show less",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )),
                  )
                ]),
              ),
              Container(
                margin: const EdgeInsets.all(15), // Adjust the margin as needed
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Container(
                    height: 15,
                  ),
                  Container(
                    child: Text(widget.contract.offer!.description),
                  ),
                  Container(
                    height: 15,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          "View original offer",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  )
                ]),
              ),
              Container(
                margin: const EdgeInsets.all(15), // Adjust the margin as needed
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
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
                          margin: const EdgeInsets.only(right: 68),
                          child: const Text("Date")),
                      const Text("Description")
                    ]),
                  ),
                  Container(
                    height: 0.8,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: const Color.fromARGB(255, 80, 80, 80),
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 25, bottom: 40),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
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
                                      margin: const EdgeInsets.only(right: 30),
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  color: const Color.fromARGB(255, 80, 80, 80),
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
                margin: const EdgeInsets.all(15), // Adjust the margin as needed
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Feedback",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Container(
                    height: 15,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "This contract doesn’t have any feedback right now ",
                      )),
                  Container(
                    height: 5,
                  ),
                  Container(
                      child: const Icon(
                    Icons.feed_rounded,
                    size: 50,
                  )),
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 6),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          "Give Feedback",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  ),
                  MaterialButton(
                    color: Colors.black,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    shape: RoundedRectangleBorder(
                        // border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(18)),
                    onPressed: () {},
                    child: Container(
                        child: const Text(
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
  ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription: "Bassam create new milestone"),
  ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription:
          "Bassam create new milestone This contract doesn’t have any feedback right nowThis contract doesn’t have any feedback right now"),
  ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription: "Bassam create new milestone "),
  ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription: "Bassam create new milestone"),
  ContractActivity(
      id: 1,
      contractId: 1,
      activityDate: DateTime(2023, 11, 1),
      activityDescription:
          "Bassam create new milestone This contract doesn’t have any feedback right now"),
];
