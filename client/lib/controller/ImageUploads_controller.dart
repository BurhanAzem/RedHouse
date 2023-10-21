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

//   final ImagePicker _picker = ImagePicker();

//   Future<List<XFile>?> imgFromGallery() async {
//     final pickedFiles = await _picker.pickMultiImage();

//     if (pickedFiles != null && pickedFiles.isNotEmpty) {
//       _photos = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
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
//         _photos.add(File(pickedFile.path)); // Append selected image to the list
//         uploadFiles(); // Upload the new image immediately
//       });
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
//   }



//   void _showPicker(context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//           child: Container(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                   leading: new Icon(Icons.photo_library),
//                   title: new Text('Gallery'),
//                   onTap: () {
//                     imgFromGallery();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 new ListTile(
//                   leading: new Icon(Icons.photo_camera),
//                   title: new Text('Camera'),
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