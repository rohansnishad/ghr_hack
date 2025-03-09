// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
//
//
// class HomeScreen1 extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen1> {
//   File? _videoFile;
//   final String backendUrl = 'http://your_local_ip:5000'; // Replace with your local IP
//
//   // Function to pick a video
//   Future<void> _pickVideo() async {
//     final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _videoFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   // Function to upload video to Flask (Firebase Storage)
//   Future<void> _uploadVideo() async {
//     if (_videoFile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No video selected')));
//       return;
//     }
//
//     var request = http.MultipartRequest('POST', Uri.parse('$backendUrl/upload_video'));
//     request.files.add(await http.MultipartFile.fromPath('file', _videoFile!.path));
//
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       var responseData = await response.stream.bytesToString();
//       var jsonData = jsonDecode(responseData);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload successful: ${jsonData["video_url"]}')));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed')));
//     }
//   }
//
//   // Function to fetch videos from Firestore
//   Future<void> _getVideos() async {
//     var response = await http.get(Uri.parse('$backendUrl/get_videos'));
//
//     if (response.statusCode == 200) {
//       var videoList = jsonDecode(response.body);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Videos: ${videoList.toString()}')));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch videos')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Flutter Video Uploader')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _videoFile != null
//                 ? Text("Selected Video: ${_videoFile!.path}")
//                 : Text("No video selected"),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickVideo,
//               child: Text("Pick Video"),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _uploadVideo,
//               child: Text("Upload Video"),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _getVideos,
//               child: Text("Fetch Videos from Firestore"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'employee_list_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: HomeScreen1()));
// }
//
// class HomeScreen1 extends StatefulWidget {
//   @override
//   _HomeScreen1State createState() => _HomeScreen1State();
// }
//
// class _HomeScreen1State extends State<HomeScreen1> {
//   File? _videoFile;
//   bool _isUploading = false;
//   String? _downloadUrl;
//
//   // Function to pick a video
//   Future<void> _pickVideo() async {
//     final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _videoFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   // Function to upload video to Firebase Storage
//   Future<void> _uploadVideo() async {
//     if (_videoFile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No video selected')),
//       );
//       return;
//     }
//
//     setState(() {
//       _isUploading = true;
//     });
//
//     try {
//       String fileName = "videos/${DateTime.now().millisecondsSinceEpoch}.mp4";
//       Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
//       UploadTask uploadTask = storageRef.putFile(_videoFile!);
//
//       // Monitor Upload Progress
//       uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//         double progress = snapshot.bytesTransferred / snapshot.totalBytes;
//         print("Upload Progress: ${(progress * 100).toStringAsFixed(2)}%");
//       });
//
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//       setState(() {
//         _downloadUrl = downloadUrl;
//         _isUploading = false;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Upload successful!")),
//       );
//
//     } catch (error) {
//       setState(() {
//         _isUploading = false;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Upload failed: $error")),
//       );
//     }
//   }
//
//   // Navigate to the next page
//   void _skipToNextScreen() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => EmployeeListScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Upload Video to Firebase')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _videoFile != null
//                 ? Text("Selected Video: ${_videoFile!.path}")
//                 : Text("No video selected"),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickVideo,
//               child: Text("Pick Video"),
//             ),
//             SizedBox(height: 10),
//             _isUploading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: _uploadVideo,
//               child: Text("Upload Video"),
//             ),
//             SizedBox(height: 10),
//             _downloadUrl != null
//                 ? Text("Download URL:\n$_downloadUrl", textAlign: TextAlign.center)
//                 : Container(),
//             SizedBox(height: 20),
//             // Skip Button
//             ElevatedButton(
//               onPressed: _skipToNextScreen,
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
//               child: Text("Skip"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Next Screen Page
// class NextScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Next Page")),
//       body: Center(
//         child: Text(
//           "Welcome to the next screen!",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'analyzed_videos.dart';
import 'employee_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: HomeScreen1()));
}

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  File? _videoFile;
  bool _isUploading = false;
  String? _downloadUrl;

  // Function to pick a video
  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  // Function to upload video to Firebase Storage
  Future<void> _uploadVideo() async {
    if (_videoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No video selected')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      String fileName = "videos/${DateTime.now().millisecondsSinceEpoch}.mp4";
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(_videoFile!);

      // Monitor Upload Progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        print("Upload Progress: ${(progress * 100).toStringAsFixed(2)}%");
      });

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _downloadUrl = downloadUrl;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload successful!")),
      );

    } catch (error) {
      setState(() {
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $error")),
      );
    }
  }

  // Navigate to the next page
  void _goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmployeeListScreen()),
    );
  }

  void _goToskipScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Video to Firebase')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _videoFile != null
                ? Text("Selected Video: ${_videoFile!.path}")
                : Text("No video selected"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text("Pick Video"),
            ),
            SizedBox(height: 10),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _uploadVideo,
              child: Text("Upload Video"),
            ),
            SizedBox(height: 10),
            _downloadUrl != null
                ? Text("Download URL:\n$_downloadUrl", textAlign: TextAlign.center)
                : Container(),
            SizedBox(height: 20),

            // Skip Button
            ElevatedButton(
              onPressed: _goToskipScreen,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Text("Skip"),
            ),
            SizedBox(height: 10),

            // Next Page Button (Similar to Skip)
            ElevatedButton(
              onPressed: _goToNextScreen,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}
