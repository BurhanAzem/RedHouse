import 'package:client/controller/contract/milestone_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMilestone extends StatefulWidget {
  final Contract contract;
  const AddMilestone({Key? key, required this.contract}) : super(key: key);

  @override
  _AddMilestoneState createState() => _AddMilestoneState();
}

class _AddMilestoneState extends State<AddMilestone> {
  MilestoneControllerImp controller = Get.put(MilestoneControllerImp());
  LoginControllerImp loginController = Get.put(LoginControllerImp());

  String nameError = "";
  String amountError = "";
  String descriptionError = "";

  Future<void> _selectDateAvialableOn() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 196, 39, 27),
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        controller.milestoneDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Milestone",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
                  Container(height: 5),
                  const Text(
                    "Milestone Name",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  Container(
                    child: TextFormField(
                      controller: controller.milestoneName,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        // suffixIcon: Icon(Icons.description),
                        hintText: "Milestone name",
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
                    "Amount",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  Container(
                    child: TextFormField(
                      controller: controller.amount,
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
                    "Due Date",
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
                          Text(controller.milestoneDate.toString()),
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
                      controller: controller.description,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        // suffixIcon: Icon(Icons.description),
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
                  Container(height: 5),
                ],
              ),
              Container(height: 25),
              MaterialButton(
                onPressed: () async {
                  setState(() {});
                  // if (controller.formstate.currentState!.validate() &&
                  //     controller.name.text.isNotEmpty &&
                  //     controller.email.text.isNotEmpty &&
                  //     controller.description.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  SnackBar snackBar = const SnackBar(
                    content: Text("Added Successfully"),
                    backgroundColor: Colors.blue,
                  );
                  // controller.userId = loginController.userDto?["id"];

                  await controller.addMilestone(widget.contract.id);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  // }
                },
                height: 40,
                color: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
