import 'dart:developer';

import 'package:client/controller/contracts/contracts_controller.dart';
import 'package:client/model/contract.dart';
import 'package:client/model/offer.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OfferDetails extends StatefulWidget {
  final Offer offer;
  const OfferDetails({Key? key, required this.offer}) : super(key: key);
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<OfferDetails> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  bool showMoreSummary = false;
  String summaryString = "Show more";

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(right: 50),
          alignment: Alignment.center,
          child: Text(
            "Offer Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: 20,
              ),
              Container(
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Landlord:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  Text(widget.offer.landlord!.name!,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 196, 39, 27))),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      // margin: EdgeInsets.only(left: 8),
                                      child: Text("Offer Status",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  Container(
                                      child: Text(widget.offer.offerStatus,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 196, 39, 27))))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text("Price",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  Text(widget.offer.price.toString(),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 196, 39, 27)))
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 78),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text("Client:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                        Container(
                                            child: Text(
                                          widget.offer.customer!.name!,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 196, 39, 27)),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    child: Column(
                                      children: [
                                        Container(
                                            child: Text("Start date",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Text(
                                            widget.offer.offerDate
                                                .toString()
                                                .substring(0, 11),
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 196, 39, 27))),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
              Container(
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
                  Text(widget.offer.description),
                  Container(
                    height: 5,
                  ),
                  showMoreSummary
                      ? Column(
                          children: [
                            Container(
                              height: 5,
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
              Container(height: 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                          40), // Set a large border radius
                      border: Border.all(
                        color:
                            Colors.black, // Adjust the border color as needed
                        width: 1, // Adjust the border width as needed
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Approve",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          50), // Set a large border radius
                      border: Border.all(
                        color:
                            Colors.black, // Adjust the border color as needed
                        width: 1, // Adjust the border width as needed
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Reject",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
