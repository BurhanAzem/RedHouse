import 'dart:convert';
import 'dart:io';
import 'package:client/controller/users_auth/account_verification_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/user.dart';
import 'package:client/view/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AccountVerification extends StatefulWidget {
  AccountVerification({Key? key}) : super(key: key);

  @override
  _AccountVerificationState createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification>
    with SingleTickerProviderStateMixin {
  AccountVerificationController controller =
      Get.put(AccountVerificationController(), permanent: true);

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  List<File> _photos = [];
  final ImagePicker _picker = ImagePicker();
  late AnimationController _animationController;
  late Animation<int> _textAnimation;
  bool isCard = true;

  Future<List<XFile>?> imgFromGallery() async {
    final pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _photos =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
        // controller.isUploading = true; // Set the flag to indicate uploading
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
        _photos.add(File(pickedFile.path));
        // controller.isUploading = true; // Set the flag to indicate uploading
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
          if (isCard) {
            controller.cardID = url;
          } else {
            controller.personal = url;
          }
        });
      } catch (e) {
        print('Error occurred while uploading: $e');
      }
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
            end:
                "Verify your account by submiting your card ID and recent personal image"
                    .length)
        .animate(_animationController);

    // Start the animation
    _animationController.forward();

    controller.cardID = "";
    controller.personal = "";
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountVerificationController>(
      init: AccountVerificationController(),
      builder: (AccountVerificationController controller) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              "Account verification",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Body
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),

                      // Introduction
                      Image.asset("assets/images/logo.png", scale: 11),
                      Container(
                        child: AnimatedBuilder(
                          animation: _textAnimation,
                          builder: (context, child) {
                            String animatedText =
                                "Verify your account by submiting your card ID and recent personal image"
                                    .substring(0, _textAnimation.value);
                            return Text(
                              animatedText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            );
                          },
                        ),
                      ),

                      // Card ID photo
                      const SizedBox(height: 25),
                      if (controller.cardID == "")
                        InkWell(
                          onTap: () {
                            _showPicker(context);
                            isCard = true;
                          },
                          child: Container(
                            width: 1000,
                            height: 250,
                            foregroundDecoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Uploud image for card ID",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Icon(
                                  FontAwesomeIcons.solidAddressCard,
                                  size: 140,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        InkWell(
                          onTap: () {
                            _showPicker(context);
                            isCard = true;
                          },
                          child: Container(
                            width: 1000,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  controller.cardID,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Personal photo
                      const SizedBox(height: 25),
                      if (controller.personal == "")
                        InkWell(
                          onTap: () {
                            _showPicker(context);
                            isCard = false;
                          },
                          child: Container(
                            width: 1000,
                            height: 250,
                            foregroundDecoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Uploud personal image",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Icon(
                                  FontAwesomeIcons.userGroup,
                                  size: 135,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        InkWell(
                          onTap: () {
                            _showPicker(context);
                            isCard = false;
                          },
                          child: Container(
                            width: 1000,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  controller.personal,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Button
                  const SizedBox(height: 25),
                  if (controller.cardID != "" && controller.personal != "")
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MaterialButton(
                        height: 40,
                        onPressed: () {
                          String? userDtoJson = sharepref.getString("user");
                          Map<String, dynamic> userDto =
                              json.decode(userDtoJson ?? "{}");
                          User user = User.fromJson(userDto);
                          controller.userId = user.id!;

                          setState(() {
                            controller.VerifyAccount();
                          });
                          Get.to(() => const BottomBar());
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
                    ),
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
