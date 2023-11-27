import 'package:client/controller/contracts/offer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateOffer extends StatefulWidget {
  int landlordId;
  int customerId;
  int propertyId;
  CreateOffer({
    Key? key,
    required this.landlordId,
    required this.customerId,
    required this.propertyId,
  }) : super(key: key);

  @override
  _CreateOfferState createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  OfferController offerController = Get.put(OfferController());

  Future<void> _selectDateAvialableOn() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(1800, 7, 20),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor:
                const Color(0xffd92328), // Change the color of the header
          ),
          child: child ?? Container(),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        // controller.milestoneDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const options = [
      "House",
      "Apartment Unit",
      "Townhouse",
      "Castel",
      "Entire Department Community",
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Create Offer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(height: 5),
                  // const Text(
                  //   "Choose property",
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  // Container(height: 5),
                  // Container(
                  //   child: TextFormField(
                  //     controller: controller.milestoneName,
                  //     style: const TextStyle(),
                  //     decoration: InputDecoration(
                  //       // suffixIcon: Icon(Icons.description),
                  //       hintText: "Milestone name",
                  //       floatingLabelBehavior: FloatingLabelBehavior.always,
                  //       contentPadding: const EdgeInsets.all(5),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(height: 5),
                  // Container(height: 15),
                  const Text(
                    "Price",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  Container(
                    child: TextFormField(
                      // controller: controller.milestoneName,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        // suffixIcon: Icon(Icons.description),
                        hintText: "  \$0.00",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 5),
                  Container(height: 15),
                  const Text(
                    "Offer Expire Date",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(controller.milestoneDate.toString()),
                          IconButton(
                              onPressed: _selectDateAvialableOn,
                              icon: const Icon(Icons.date_range_outlined))
                        ],
                      )),
                  Container(height: 5),
                  Container(height: 15),
                  const Text(
                    "Description (Optional)",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  Container(
                    child: TextFormField(
                      minLines: 7,
                      maxLines: 10,
                      // controller: controller.description,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        hintText:
                            "Example: New house in the center of the city, there is close school and very beautiful view",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 25),
              MaterialButton(
                onPressed: () {
                  setState(() {});
                  ScaffoldMessenger.of(context).clearSnackBars();
                  // setState(() {
                  //   controller.activeStep++;
                  // });
                  // controller.addMilestone();

                  // applicationsController.propertyId = widget.property.id;
                  // applicationsController.userId =
                  //     loginController.userDto?["id"];
                  // applicationsController.addApplication();

                  SnackBar snackBar = const SnackBar(
                    content: Text("Created successfully"),
                    backgroundColor: Colors.blue,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                },
                color: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
