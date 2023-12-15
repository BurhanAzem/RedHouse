import 'dart:convert';
import 'dart:io';
import 'package:client/controller/manage_propertise/manage_properties_controller.dart';
import 'package:client/controller/users_auth/account_verification_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/user.dart';
import 'package:client/view/add_property/add_property_8.dart';
import 'package:client/view/bottom_bar/bottom_bar.dart';
import 'package:client/view/more/more.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AccountVerification extends StatefulWidget {
  AccountVerification({Key? key}) : super(key: key);

  @override
  _AccountVerificationState createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  AccountVerificationController controller =
      Get.put(AccountVerificationController(), permanent: true);

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  List<File> _photos = [];
  bool isUploading = false; // Add a flag for uploading

  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> imgFromGallery() async {
    final pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _photos =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
        isUploading = true; // Set the flag to indicate uploading
      });
      await uploadFiles(); // Upload files immediately
    } else {
      print('No images selected.');
    }

    return pickedFiles;
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _photos.add(
            File(pickedFile.path)); // Append the selected image to the list
        isUploading = true; // Set the flag to indicate uploading
      });
      uploadFiles(); // Upload the new image immediately
    } else {
      print('No image selected.');
    }
  }

  Future uploadFiles() async {
    for (final photo in _photos) {
      final fileName = basename(photo.path);
      final destination = 'images/$fileName';

      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
        await ref.putFile(photo);
        final url = await ref.getDownloadURL();
        setState(() {
          controller.downloadUrls
              .add(url); // Store the download URL in the list
        });
      } catch (e) {
        print('Error occurred while uploading: $e');
      }
    }
    setState(() {
      isUploading = false; // Set the flag to indicate uploading is complete
    });
  }

  @override
  Widget build(BuildContext context) {
    const options = [
      "House",
      "Apartment Unit",
      "Townhouse",
      "Entire Department Community"
    ];

    return GetBuilder<AccountVerificationController>(
      init: AccountVerificationController(),
      builder: (AccountVerificationController controller) {
        @override
        void initState() {
          super.initState();
          setState(() {});
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Get.to(() => More());
                });
              },
            ),
            title: const Text(
              "Account verification",
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
                      // controller.easyStepper(),
                      // Image.asset("assets/images/logo.png", scale: 10),
                      Container(height: 5),
                      const Text(
                        "Verify your account by submiting your card ID and recent personal image",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Uploud image for card ID",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 100,
                              height: 100,
                              child: const Icon(
                                Icons.add,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(15),
                          foregroundDecoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Container(
                            margin: const EdgeInsets.all(100),
                            child: controller.downloadUrls.isNotEmpty &&
                                    controller.downloadUrls[0] != null
                                ? Image.network(controller.downloadUrls[0]!)
                                : null,
                          )),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Uploud personal image",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 100,
                              height: 100,
                              child: const Icon(
                                Icons.add,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        foregroundDecoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Container(
                          margin: const EdgeInsets.all(100),
                          child: controller.downloadUrls.length >= 1 &&
                                  controller.downloadUrls[1] != null
                              ? Image.network(controller.downloadUrls[1]!)
                              : null,
                        ),
                      )
                    ],
                  ),
                  Container(height: 25),
                  isUploading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : MaterialButton(
                          onPressed: () {
                            String? userDtoJson = sharepref.getString("user");
                            Map<String, dynamic> userDto =
                                json.decode(userDtoJson ?? "{}");
                            User user = User.fromJson(userDto);
                            controller.userId = user.id!;

                            setState(() {
                              controller.VerifyAccount();
                            });
                            Get.to(() => BottomBar());
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Done",
                            style: TextStyle(
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
      },
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
