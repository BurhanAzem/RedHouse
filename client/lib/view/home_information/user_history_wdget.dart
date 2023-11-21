import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/controller/auth/login_controller.dart';
import 'package:client/controller/history_controller/check_history_contoller.dart';
import 'package:client/model/user_history.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserHistoryWidget extends StatefulWidget {
  @override
  State<UserHistoryWidget> createState() => _UserHistoryWidgetState();
}

class _UserHistoryWidgetState extends State<UserHistoryWidget> {
  ApplicationsControllerImp applicationsController =
      Get.put(ApplicationsControllerImp());
  CheckHistoryController historyController = Get.put(CheckHistoryController());
  LoginControllerImp LoginController = Get.put(LoginControllerImp());

  @override
  Widget build(BuildContext context) {
    // If this user not has history
    if (applicationsController.userHistory.isEmpty) {
      return Container(
        margin:
            const EdgeInsetsDirectional.symmetric(horizontal: 40, vertical: 85),
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
              "This account did not make any contracts and therefore\nhas no history",
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // If this user has history
    else {
      historyController.calAverageRating(applicationsController.userHistory);
      historyController.calHistoryBars(applicationsController.userHistory);

      return Column(
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
                  'This account has ${applicationsController.userHistory.length} contracts that have been agreed upon',
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
                  buildRatingRow(5, historyController.fiveCount,
                      2 * applicationsController.userHistory.length),
                  buildRatingRow(4, historyController.fourCount,
                      2 * applicationsController.userHistory.length),
                  buildRatingRow(3, historyController.threeCount,
                      2 * applicationsController.userHistory.length),
                  buildRatingRow(2, historyController.twoCount,
                      2 * applicationsController.userHistory.length),
                  buildRatingRow(1, historyController.oneCount,
                      2 * applicationsController.userHistory.length),
                ],
              )
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: applicationsController.userHistory.length,
            itemBuilder: (context, index) {
              UserHistory userHistory =
                  applicationsController.userHistory.elementAt(index);

              return Card(
                  elevation: 1,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // here property
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
                                    property: userHistory.contract.property!));
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
                                      userHistory.contract.landlord!.name!),
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
                                userHistory.contract.landlord!.name!,
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
                              rating: userHistory.landlordRating.toDouble(),
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
                              DateFormat('MM/dd/yy').format(DateTime.now()),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Text(
                          userHistory.feedbackToLandlord +
                              userHistory.feedbackToLandlord +
                              userHistory.feedbackToLandlord +
                              userHistory.feedbackToLandlord +
                              userHistory.feedbackToLandlord,
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
                                      userHistory.contract.customer!.name!),
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
                                userHistory.contract.customer!.name!,
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
                              rating: userHistory.customerRating.toDouble(),
                              itemCount: 5,
                              itemSize: 20,
                              itemBuilder: (context, index) {
                                return Icon(Icons.star,
                                    color: Colors.blue[700]);
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              DateFormat('MM/dd/yy').format(DateTime.now()),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Text(
                          userHistory.feedbackToCustomer +
                              userHistory.feedbackToCustomer +
                              userHistory.feedbackToCustomer +
                              userHistory.feedbackToCustomer +
                              userHistory.feedbackToCustomer +
                              userHistory.feedbackToCustomer,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    color: userHistory.helpful == "Yes"
                                        ? Colors.black
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          color: Colors.black, width: 1.4),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        userHistory.helpful = "Yes";
                                      });
                                    },
                                    height: 31,
                                    child: Center(
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: userHistory.helpful == "Yes"
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
                                    color: userHistory.helpful == "No"
                                        ? Colors.black
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          color: Colors.black, width: 1.4),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        userHistory.helpful = "No";
                                      });
                                    },
                                    height: 31,
                                    child: Center(
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                          color: userHistory.helpful == "No"
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
      );
    }
  }
}
