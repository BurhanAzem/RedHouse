// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:path/path.dart';

// class ImageUploads extends StatefulWidget {
//   ImageUploads({Key? key}) : super(key: key);

//   @override
//   _ImageUploadsState createState() => _ImageUploadsState();
// }

// class _ImageUploadsState extends State<ImageUploads> {
//   firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;

//   List<File> _photos = [];
//   List<String> _downloadUrls = [];
//   bool isUploading = false; // Add a flag for uploading

//   final ImagePicker _picker = ImagePicker();

//   Future<List<XFile>?> imgFromGallery() async {
//     final pickedFiles = await _picker.pickMultiImage();

//     if (pickedFiles != null && pickedFiles.isNotEmpty) {
//       setState(() {
//         _photos =
//             pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
//         isUploading = true; // Set the flag to indicate uploading
//       });
//       await uploadFiles(); // Upload files immediately
//     } else {
//       print('No images selected.');
//     }

//     return pickedFiles;
//   }

//   Future imgFromCamera() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       setState(() {
//         _photos.add(
//             File(pickedFile.path)); // Append the selected image to the list
//         isUploading = true; // Set the flag to indicate uploading
//       });
//       uploadFiles(); // Upload the new image immediately
//     } else {
//       print('No image selected.');
//     }
//   }

//   Future uploadFiles() async {
//     for (final photo in _photos) {
//       final fileName = basename(photo.path);
//       final destination = 'images/$fileName';

//       try {
//         final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
//         await ref.putFile(photo);
//         final url = await ref.getDownloadURL();
//         setState(() {
//           _downloadUrls.add(url); // Store the download URL in the list
//         });
//       } catch (e) {
//         print('Error occurred while uploading: $e');
//       }
//     }
//     setState(() {
//       isUploading = false; // Set the flag to indicate uploading is complete
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             Text(
//               "Red",
//               style: TextStyle(
//                 color: Color(0xffd92328),
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               "House Manage Properties",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset("assets/images/logo.png", scale: 10),
//                 const SizedBox(height: 5),
//                 const Text(
//                   "When is your property available to rent?",
//                   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Add photos",
//                   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Photos help renters imagine living in your place.",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       _showPicker(context);
//                     },
//                     child: CircleAvatar(
//                       radius: 55,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[400],
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         width: 100,
//                         height: 100,
//                         child: const Icon(
//                           Icons.add,
//                           size: 60,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(15),
//                   foregroundDecoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: const BorderRadius.all(Radius.circular(5))),
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         childAspectRatio: 1,
//                       ),
//                       itemCount: _downloadUrls.length,
//                       itemBuilder: (context, index) {
//                         final imageUrl = _downloadUrls[index];
//                         return Image.network(imageUrl);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 5),
//             isUploading
//                 ? const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : MaterialButton(
//                     onPressed: () {
//                       // controller.goToAddProperty2();
//                     },
//                     color: const Color(0xffd92328),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Text(
//                       "Continue",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//             const SizedBox(height: 15),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//           child: Container(
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                   leading: const Icon(Icons.photo_library),
//                   title: const Text('Gallery'),
//                   onTap: () {
//                     imgFromGallery();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.photo_camera),
//                   title: const Text('Camera'),
//                   onTap: () {
//                     imgFromCamera();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
