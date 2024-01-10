import 'package:client/view/more/payment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AccountUpgrade extends StatefulWidget {
  const AccountUpgrade({Key? key}) : super(key: key);

  @override
  State<AccountUpgrade> createState() => _AccountUpgradeState();
}

class _AccountUpgradeState extends State<AccountUpgrade> {
  int selectedCardIndex = 0; // Track the index of the selected card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Account Upgrade",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: CardWidget(
                    index: 0,
                    isSelected: selectedCardIndex == 0,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: CardWidget(
                    index: 1,
                    isSelected: selectedCardIndex == 1,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: CardWidget(
                    index: 2,
                    isSelected: selectedCardIndex == 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final int index;
  final bool isSelected;

  const CardWidget({
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    String cardType = _getCardType(index);
    String price = _getCardPrice(index);
    List<String> features = _getCardFeatures(index);
    bool showPaymentButton = _shouldShowPaymentButton(index) && !isSelected;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.red : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            cardType,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map(
                  (feature) => Row(
                    children: [
                      const SizedBox(width: 90),
                      const Icon(
                        FontAwesomeIcons.check,
                        color: Colors.green,
                        size: 17,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        feature,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          if (showPaymentButton)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  Get.to(()=> Payment());
                },
                minWidth: 200,
                height: 40,
                color: Colors.black87,
                child: const Text(
                  "Payment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getCardType(int index) {
    switch (index) {
      case 0:
        return 'Free';
      case 1:
        return 'Monthly Subscription';
      case 2:
        return 'Annual Subscription';
      default:
        return '';
    }
  }

  String _getCardPrice(int index) {
    switch (index) {
      case 0:
        return 'Included';
      case 1:
        return '\$10/month';
      case 2:
        return '\$100/year';
      default:
        return '';
    }
  }

  List<String> _getCardFeatures(int index) {
    switch (index) {
      case 0:
        return [
          'Basic features',
          'Limited storage',
          'Priority support',
          'Priority support'
        ];
      case 1:
        return [
          'All features',
          '10 GB storage',
          'Priority support',
          'Priority support'
        ];
      case 2:
        return [
          'All features',
          '50 GB storage',
          'Priority support',
          'Priority support',
          'Priority support'
        ];
      default:
        return [];
    }
  }

  bool _shouldShowPaymentButton(int index) {
    return index == 1 || index == 2;
  }
}
