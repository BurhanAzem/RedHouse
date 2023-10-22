import 'dart:io';

import 'package:client/controller/manage_propertise/add_property_controller.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AddProperty7 extends StatefulWidget {
  AddProperty7({Key? key}) : super(key: key);

  @override
  _AddProperty7State createState() => _AddProperty7State();
}

class _AddProperty7State extends State<AddProperty7> {
  // final PageController pageController;
    AddPropertyControllerImp controller =
        Get.put(AddPropertyControllerImp(), permanent: true);
    firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  List<File> _photos = [];
  bool isUploading = false; // Add a flag for uploading

  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> imgFromGallery() async {
    final pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
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
          controller.downloadUrls.add(url); // Store the download URL in the list
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
    AddPropertyControllerImp controller =
        Get.put(AddPropertyControllerImp(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Red",
              style: TextStyle(
                color: Color(0xffd92328),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "House Manage Properties",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EasyStepper(
                    finishedStepBackgroundColor: Color(0xffd92328),
                    activeStepBorderColor: Colors.black,
                    stepShape: StepShape.circle,
                    lineStyle: LineStyle(),

                    activeStep: controller.activeStep,
                    activeStepTextColor: Colors.black87,
                    finishedStepTextColor: Colors.black87,
                    internalPadding: 0,
                    // showScrollbar: false,
                    fitWidth: true,
                    showLoadingAnimation: false,
                    stepRadius: 5,
                    showStepBorder: false,
                    steps: [
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 0 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Waiting',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 1 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Order Received',
                        topTitle: true,
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 2 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Preparing',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 3 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'On Way',
                        topTitle: true,
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 4 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 5 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 6 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 7 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 8 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      
                    ],
                    onStepReached: (index) =>
                        setState(() => controller.activeStep = index),
                  ),
                  Image.asset("assets/images/logo.png", scale: 10),
                  Container(height: 5),
                  Text(
                  "When is your property available to rent?",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                ),
                SizedBox(height: 20),
                Text(
                  "Add photos",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                ),
                SizedBox(height: 20),
                Text(
                  "Photos help renters imagine living in your place.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.add,
                          size: 60,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  foregroundDecoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemCount: controller.downloadUrls.length,
                      itemBuilder: (context, index) {
                        final imageUrl = controller.downloadUrls[index];
                        return Image.network(imageUrl);
                      },
                    ),
                  ),
                ),
                  
                ],
              ),
              Container(height: 25),
              isUploading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : MaterialButton(
                    onPressed: () {
                      setState(() {
                    controller.activeStep++;                    
                  });
                      controller.goToAddProperty8();
                    },
                    color: Color(0xffd92328),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
              Container(height: 15),
            ],
          ),
        ),
      ),
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
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
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
