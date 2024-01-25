import 'package:client/controller/contract/offer_controller.dart';
import 'package:client/controller/propertise/properties_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/offer.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class IncomingOffer extends StatefulWidget {
  final Offer offer;
  const IncomingOffer({Key? key, required this.offer}) : super(key: key);
  @override
  _IncomingOffeState createState() => _IncomingOffeState();
}

class _IncomingOffeState extends State<IncomingOffer> {
  OfferController controller = Get.put(OfferController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());
  ManagePropertiesController propertiesController =
      Get.put(ManagePropertiesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Offer Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Body
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(height: 20),

                // Box Informations
                Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Landlord:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text(widget.offer.landlord!.name!,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 196, 39, 27))),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: const Text(
                                  "Offer Status",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )),
                                Container(
                                    child: Text(widget.offer.offerStatus,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 196, 39, 27))))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: const Text("Price",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600))),
                                Text(widget.offer.price.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 196, 39, 27)))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        // margin: const EdgeInsets.only(bottom: 78),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: const Text("Customer:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  Container(
                                      child: Text(
                                    widget.offer.customer!.name!,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 196, 39, 27)),
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: [
                                  Container(
                                      child: const Text("Start date",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  Text(
                                      widget.offer.offerDate
                                          .toString()
                                          .substring(0, 11),
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 196, 39, 27))),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: [
                                  Container(
                                      child: const Text("Expiry date",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  Text(
                                      widget.offer.offerExpires
                                          .toString()
                                          .substring(0, 11),
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 196, 39, 27))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(height: 20),

                // Box description
                Container(
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
                    Text(widget.offer.description),
                    Container(
                      height: 5,
                    ),
                  ]),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() =>
                        HomeInformation(property: widget.offer.property!));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Click here to see property",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffd92328),
                      ),
                    ),
                  ),
                ),
                Container(height: 20),

                // Show "Accept" and "Reject" or "Under Contract"
                if (widget.offer.offerStatus == "Pending")
                  if (widget.offer.property!.propertyStatus != "Under contract")
                    acceptRejectButtons()
                  else
                    underContract(),

                // Show "See Contract"
                if (widget.offer.offerStatus == "Accepted") seeContract(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget acceptRejectButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40,
          width: 168,
          child: ElevatedButton(
            onPressed: () async {
              controller.acceptOffer(widget.offer.id);
              widget.offer.offerStatus = "Accepted";
              await propertiesController.updatePropertyStatus(
                  widget.offer.property!.id, "Under contract");
              widget.offer.property!.propertyStatus = "Under contract";
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Accept",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 168,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              controller.deleteOffer(widget.offer.id);
              setState(() {});
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Reject",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget seeContract() {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.eye,
              size: 17,
            ),
            SizedBox(width: 10),
            Text(
              "See Contract",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget underContract() {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.xmark,
              size: 17,
            ),
            SizedBox(width: 10),
            Text(
              "Under Contract",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
