import 'package:flutter/material.dart';

class OverView extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<OverView> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Milestone timeline',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(
                    primarySwatch: Colors.orange,
                    colorScheme: ColorScheme.light(
                        primary:
                            Color(0xffd92328)) // Set the desired color here
                    ),
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: Text('  ...................... '),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: ''),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: ''),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text('.....'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Home Address'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Postcode'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text(
                        "Propose new milestone",
                        style: TextStyle(color: Colors.black,decoration: TextDecoration.underline,),
                      ),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Mobile Number'),
                          ),
                        ],
                      ),
                      // isActive: _currentStep >= 0,
                      // state: _currentStep >= 2
                      //     ? StepState.complete
                      //     : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.topLeft,
            //   child: MaterialButton(
            //     onPressed: () {},

            //     child: Text(
            //       "Propose new milestone",
            //       style: TextStyle(
            //         color: Colors.black,
            //         decoration: TextDecoration.underline,
            //       ),
            //     ),
            //     // color: Colors.black,
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchStepsType,
        // backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.list,
          size: 25,
          // color: Colors.black,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: switchStepsType,
      //   child: const Icon(Icons.list, size: 30),
      // ),
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

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
