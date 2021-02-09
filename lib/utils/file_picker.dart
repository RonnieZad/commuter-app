// class FilePickerUtil{

//   Future<String> uploadFile(File imageFile) async {
//     FirebaseUser user = await FirebaseAuth.instance.currentUser();
//     var uid = user.uid;
//     StorageReference storageReference =
//         FirebaseStorage.instance.ref().child('clientBase/$uid}');
//     StorageUploadTask uploadTask = storageReference.putFile(imageFile);
//     await uploadTask.onComplete;
//     print('File Uploaded');
//     storageReference.getDownloadURL().then((fileURL) {
//       setState(() {
//         _uploadedFileURL = fileURL;
//       });
//     });
//     return _uploadedFileURL;
//   }

//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     String imagePath = await uploadFile(File(pickedFile.path));
//     uploadFile(File(pickedFile.path));

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         _uploadedFileURL = imagePath;
//         // thumbnail = Img.copyResize(Img.decodeImage(_image.readAsBytesSync()),
//         //     width: 120);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
  
// }