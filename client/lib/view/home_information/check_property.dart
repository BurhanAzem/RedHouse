import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/controller/auth/login_controller.dart';
import 'package:client/controller/history_controller/check_history_contoller.dart';
import 'package:client/model/property.dart';
import 'package:client/model/user_history.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckProperty extends StatefulWidget {
  final Property property;
  const CheckProperty({Key? key, required this.property}) : super(key: key);

  @override
  State<CheckProperty> createState() => _CheckPropertyState();
}

class _CheckPropertyState extends State<CheckProperty> {
  bool isLoading = true; // Add a boolean variable for loading state
  bool isFollowed = false;
  LoginControllerImp LoginController = Get.put(LoginControllerImp());
  CheckHistoryController historyController = Get.put(CheckHistoryController());
  late ApplicationsControllerImp applicationsController;

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    applicationsController =
        Get.put(ApplicationsControllerImp(), permanent: true);
    await applicationsController.getHistoryProperty(widget.property.id);

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }

    historyController.calAverageRating(applicationsController.propertyHistory);
    historyController.calHistoryBars(applicationsController.propertyHistory);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 27),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 3),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 100),
                Column(
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 153, 115, 1),
                      ),
                      child: Center(
                        child: Text(
                          LoginController.getShortenedName("Property"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text(
              "Property",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            Text(
              "ZIP code: ${widget.property.propertyCode}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 7),
            GestureDetector(
              onTap: () {
                setState(() {
                  isFollowed = !isFollowed;
                });
              },
              child: Container(
                width: 140,
                height: 38,
                decoration: BoxDecoration(
                  color: isFollowed ? Colors.grey[300] : Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isFollowed) const SizedBox(width: 10),
                    Text(
                      isFollowed ? "Followed" : "Follow",
                      style: TextStyle(
                        fontSize: 16,
                        color: isFollowed ? Colors.black : Colors.white,
                      ),
                    ),
                    if (isFollowed)
                      const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.black,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Divider(thickness: 1.5),
            // If this property not has history
            if (applicationsController.propertyHistory.isEmpty)
              Container(
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 40, vertical: 90),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/feedback_amico.svg',
                      width: 200,
                      height: 200,
                    ),
                    const Text(
                      "Oops! No results found",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "No contracts have been made on\n this property and therefore\n it has no history",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )

            // If this property has history
            else
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    margin: const EdgeInsets.all(35),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        LineWithIconText(
                          Icons.numbers,
                          'This account has ${applicationsController.propertyHistory.length} contracts that have been agreed upon',
                        ),
                        const SizedBox(height: 13),
                        LineWithIconText(Icons.switch_account,
                            'Whether this account is an landlord or a customer in the contract'),
                        const SizedBox(height: 13),
                        LineWithIconText(Icons.rate_review,
                            'You can see all the ratings and reviews for every contract made by this account'),
                        const SizedBox(height: 13),
                        LineWithIconText(Icons.lock,
                            'The data was taken after the contract was concluded between the two parties'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${historyController.averageRating}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          RatingBarIndicator(
                            rating: historyController.averageRating,
                            itemCount: 5,
                            itemSize: 20,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.black87,
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          buildRatingRow(
                              5,
                              historyController.fiveCount,
                              2 *
                                  applicationsController
                                      .propertyHistory.length),
                          buildRatingRow(
                              4,
                              historyController.fourCount,
                              2 *
                                  applicationsController
                                      .propertyHistory.length),
                          buildRatingRow(
                              3,
                              historyController.threeCount,
                              2 *
                                  applicationsController
                                      .propertyHistory.length),
                          buildRatingRow(
                              2,
                              historyController.twoCount,
                              2 *
                                  applicationsController
                                      .propertyHistory.length),
                          buildRatingRow(
                              1,
                              historyController.oneCount,
                              2 *
                                  applicationsController
                                      .propertyHistory.length),
                        ],
                      )
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: applicationsController.propertyHistory.length,
                    itemBuilder: (context, index) {
                      UserHistory propertyHistory = applicationsController
                          .propertyHistory
                          .elementAt(index);
                      return Card(
                          elevation: 0.7,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          child: Padding(
                            padding: const EdgeInsets.all(17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Delete this row
                                Row(
                                  children: [
                                    const Text(
                                      "This contract was made on ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => HomeInformation(
                                            property: propertyHistory
                                                .contract.offer!.property!));
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "this property",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // here landlord
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red[700],
                                      ),
                                      child: Center(
                                        child: Text(
                                          LoginController.getShortenedName(
                                              propertyHistory
                                                  .contract.offer!.landlord!.name!),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: ListTile(
                                      title: Text(
                                        propertyHistory
                                            .contract.offer!.landlord!.name!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.red[700],
                                        ),
                                      ),
                                      subtitle: const Text(
                                        "landlord",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                                    const Icon(Icons.more_vert),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: propertyHistory.landlordRating
                                          .toDouble(),
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, index) {
                                        return Icon(
                                          Icons.star,
                                          color: Colors.red[700],
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      DateFormat('MM/dd/yy')
                                          .format(DateTime.now()),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  propertyHistory.feedbackToLandlord +
                                      propertyHistory.feedbackToLandlord +
                                      propertyHistory.feedbackToLandlord,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                // here customer
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[700],
                                      ),
                                      child: Center(
                                        child: Text(
                                          LoginController.getShortenedName(
                                              propertyHistory
                                                  .contract.offer!.customer!.name!),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: ListTile(
                                      title: Text(
                                        propertyHistory
                                            .contract.offer!.customer!.name!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                      subtitle: const Text(
                                        "customer",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: propertyHistory.customerRating
                                          .toDouble(),
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, index) {
                                        return Icon(Icons.star,
                                            color: Colors.blue[700]);
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      DateFormat('MM/dd/yy')
                                          .format(DateTime.now()),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  propertyHistory.feedbackToCustomer +
                                      propertyHistory.feedbackToCustomer +
                                      propertyHistory.feedbackToCustomer,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Was this review helpful?",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 55,
                                          child: MaterialButton(
                                            color: propertyHistory.helpful == "Yes"
                                                ? Colors.black
                                                : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.4),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                propertyHistory.helpful = "Yes";
                                              });
                                            },
                                            height: 31,
                                            child: Center(
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                  color: propertyHistory.helpful ==
                                                          "Yes"
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 7),
                                        SizedBox(
                                          width: 55,
                                          child: MaterialButton(
                                            color: propertyHistory.helpful == "No"
                                                ? Colors.black
                                                : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.4),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                propertyHistory.helpful = "No";
                                              });
                                            },
                                            height: 31,
                                            child: Center(
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                  color: propertyHistory.helpful ==
                                                          "No"
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
