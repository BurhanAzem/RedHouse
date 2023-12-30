import 'package:client/controller/booking/booking_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/property.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateBooking extends StatefulWidget {
  final Property property;

  CreateBooking({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  _CreateBookingState createState() => _CreateBookingState();
}

class _CreateBookingState extends State<CreateBooking>
    with SingleTickerProviderStateMixin {
  LoginControllerImp loginController = Get.put(LoginControllerImp());
  BookingController bookingController = Get.put(BookingController());

  late AnimationController _animationController;
  late Animation<int> _textAnimation;

  int currentStep = 0;

  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  @override
  void initState() {
    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // Create a Tween for the animation
    _textAnimation = IntTween(
            begin: 0,
            end: "Now you can book the property according to the available days"
                .length)
        .animate(_animationController);

    // Start the animation
    _animationController.forward();

    loadData();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void loadData() async {
    await bookingController.getBookingDaysForProperty(widget.property.id);
    print(bookingController.preBookedDays);
    print(bookingController.bookingDays);

    setState(() {});
  }

  Future<void> _selectAvailableDates() async {
    DateTime currentDate = DateTime.now();
    DateTime tomorrow =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
    DateTime lastDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 32);

    DateTime? firstAvailableDate = findFirstAvailableDate(tomorrow, lastDate);

    if (firstAvailableDate == null) {
      // No available date found, show dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: Colors.white,
            ),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "All days are booked",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "All days from tomorrow through the month are booked",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ButtonBar(children: [
                      SizedBox(
                        height: 40,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.5,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          );
        },
      );
      return;
    }

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: firstAvailableDate,
      firstDate: tomorrow,
      lastDate: lastDate,
      selectableDayPredicate: (DateTime date) {
        // Prevent selection of dates in the bookingdays list
        if (bookingController.preBookedDays.contains(date)) {
          return false; // Date is booked, not selectable
        }

        return true; // Date is available and not in the bookingdays list, selectable
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(),
          child: child ?? Container(),
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        if (!bookingController.bookingDays.contains(selectedDate)) {
          bookingController.bookingDays.add(selectedDate);
        }
      });
    }

    print(bookingController.bookingDays);
  }

  DateTime? findFirstAvailableDate(DateTime start, DateTime end) {
    DateTime currentDate = start;
    while (currentDate.isBefore(end)) {
      if (!bookingController.preBookedDays.contains(currentDate)) {
        return currentDate;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return null; // No available date found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        title: const Text(
          "Create Booking",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Body
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.blue)),
        child: ListView(
          // physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          children: [
            Container(
              margin: const EdgeInsets.only(
                  right: 30, left: 30, bottom: 15, top: 50),
              child: AnimatedBuilder(
                animation: _textAnimation,
                builder: (context, child) {
                  String animatedText =
                      "Now you can book the property according to the available days"
                          .substring(0, _textAnimation.value);
                  return Text(
                    animatedText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ),
            Stepper(
                currentStep: currentStep,
                onStepContinue: continueStep,
                onStepCancel: cancelStep,
                controlsBuilder:
                    (BuildContext context, ControlsDetails controlsDetails) {
                  final isLastStep = currentStep == 2;
                  final isFistStep = currentStep == 0;
                  return Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            height: 35,
                            color: Colors.blue,
                            onPressed: controlsDetails.onStepContinue,
                            child: Text(
                              isLastStep ? "CONFIRM" : "NEXT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isFistStep ? 16 : null,
                              ),
                            ),
                          ),
                        ),
                        isFistStep
                            ? const SizedBox(width: 0)
                            : const SizedBox(width: 12),
                        if (currentStep != 0)
                          Expanded(
                            child: MaterialButton(
                              height: 35,
                              color: Colors.grey,
                              onPressed: controlsDetails.onStepCancel,
                              child: const Text(
                                "BACK",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                steps: [
                  // Step 0
                  Step(
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 0,
                    title: const Text(
                      "Booking days",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          // Select Booking Days
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: InkWell(
                              onTap: _selectAvailableDates,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Select Booking Days",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    onPressed: _selectAvailableDates,
                                    icon: const Icon(Icons.date_range_outlined),
                                  )
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          // Booking Days
                          if (bookingController.bookingDays.isNotEmpty)
                            Column(
                              children: [
                                ...bookingController.bookingDays
                                    .map<Widget>((DateTime date) {
                                  return ListTile(
                                    title: Text(
                                      DateFormat('MMM dd', 'en_US')
                                          .format(date),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        // Remove the date from the list
                                        setState(() {
                                          bookingController.bookingDays
                                              .remove(date);
                                        });
                                      },
                                    ),
                                  );
                                }).toList(),

                                // Price
                                Divider(
                                  height: 30,
                                  color: Colors.grey[500],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Price per night",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    const Text(
                                      "\$300.50",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total price",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    const Text(
                                      "\$300.50",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          else
                            Text(
                              "You have not booked any days yet, book your days now",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey[500],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Step 1
                  Step(
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 1,
                    title: const Text(
                      "payment",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    content: const Column(
                      children: [
                        SizedBox(height: 10),
                        // Text(
                        //   "Card Form",
                        //   style: Theme.of(context).textTheme.headlineMedium,
                        // ),
                        // const SizedBox(height: 15),
                      ],
                    ),
                  ),

                  // Step 2
                  Step(
                    isActive: currentStep >= 2,
                    title: const Text(
                      "Complete",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    content: const Text("Complete"),
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
