import 'package:client/model/property.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionButtonsWidget extends StatelessWidget {
  final Property property;

  const ActionButtonsWidget({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 175,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () {
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
                          constraints: const BoxConstraints(maxHeight: 550),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Request to apply",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      const TextFieldWithLabel(
                                          label: 'First & last name'),
                                      const TextFieldWithLabel(label: 'Phone'),
                                      const TextFieldWithLabel(label: 'Email'),
                                      const TextFieldWithLabel(
                                          label: 'Message'),
                                      TextFieldWithLabel(
                                          label:
                                              "The price you pay for this property",
                                          property: property),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 16,
                                            right: 37,
                                            top: 20,
                                            bottom: 12),
                                        child: Text(
                                          "You agree to RedHouse's Terms of Use & Privacy Policy. By choosing to contact a property, you also agree that RedHouse Group, landlords, and property managers may call or text you about any inquiries you submit through our services, which may involve use of automated means and prerecorded/artificial voices.",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ButtonBar(
                                  children: [
                                    Container(
                                      width: 220,
                                      height: 40,
                                      color: Colors.blue,
                                      child: MaterialButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Send request",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              height: 45,
              color: Colors.black87,
              child: const Center(
                child: Text(
                  "Request to apply",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 175,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: const BorderSide(color: Colors.black, width: 1.4),
              ),
              onPressed: () {
                // Replace '0598937436' with the desired phone number
                // ignore: deprecated_member_use
                launch('tel:0598937436');
              },
              height: 45,
              child: const Center(
                child: Text(
                  "Request a tour",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final Property? property;
  const TextFieldWithLabel({super.key, required this.label, this.property});

  @override
  Widget build(BuildContext context) {
    String hintText() {
      if (label == "Message") {
        return "Add your message";
      } else if (label == "The price you pay for this property") {
        if (property?.listingType == "For rent") {
          return "Enter the monthly rental price";
        } else {
          return "Enter the buy price";
        }
      }
      return label;
    }

    String suffixText() {
      if (label == "The price you pay for this property") {
        if (property?.listingType == "For rent") {
          return '\$/mo';
        } else {
          return "\$";
        }
      }
      return "";
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            maxLines: label == "Message" ? 3 : 1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              hintText: hintText(),
              border: const OutlineInputBorder(),
              suffixText: suffixText(),
              suffixStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onChanged: (text) {
              print("$label: $text");
            },
          ),
        ],
      ),
    );
  }
}
