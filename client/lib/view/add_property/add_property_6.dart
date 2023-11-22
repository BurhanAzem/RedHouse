import 'package:client/controller/manage_propertise/manage_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty6 extends StatefulWidget {
  AddProperty6({Key? key}) : super(key: key);

  @override
  _AddProperty6State createState() => _AddProperty6State();
}

class _AddProperty6State extends State<AddProperty6> {
  ManagePropertyControllerImp controller =
      Get.put(ManagePropertyControllerImp(), permanent: true);

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
        controller.availableDate = pickedDate;
      });
    }
  }

  Future<void> _selectDateBuitYear() async {
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
        controller.builtYear = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagePropertyControllerImp>(
      init: ManagePropertyControllerImp(),
      builder: (ManagePropertyControllerImp controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  controller.decreaseActiveStep();
                  print(controller.activeStep);
                  Navigator.pop(context);
                });
              },
            ),
            title: const Text(
              "Property Date",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.easyStepper(),
                      Image.asset("assets/images/logo.png", scale: 10),
                      Container(height: 5),
                      const Text(
                        "When is your property available to rent?",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(height: 30),
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
                              Text(controller.availableDate
                                  .toString()
                                  .substring(0, 10)),
                              IconButton(
                                  onPressed: _selectDateAvialableOn,
                                  icon: const Icon(Icons.date_range_outlined))
                            ],
                          )),
                      const SizedBox(height: 15),
                      const Text(
                        "Built year",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 23),
                      ),
                      Container(height: 30),
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
                              Text(controller.builtYear
                                  .toString()
                                  .substring(0, 10)),
                              IconButton(
                                  onPressed: _selectDateBuitYear,
                                  icon: const Icon(Icons.date_range_outlined))
                            ],
                          )),
                    ],
                  ),
                  Container(height: 25),
                  Container(
                    height: 0.2,
                    color: Colors.black,
                  ),
                  Container(height: 25),
                  Container(
                      alignment: Alignment.center,
                      child:
                          Image.asset("assets/images/red-tree.png", scale: 3)),
                  const SizedBox(height: 25),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        controller.increaseActiveStep();
                        print(controller.activeStep);
                      });
                      controller.goToAddProperty7();
                    },
                    color: const Color(0xffd92328),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
