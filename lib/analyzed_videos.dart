// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// // 🔹 Your Flask backend URL
// const String backendUrl = 'http://192.168.147.174:5000/get_analyzed_videos';
//
// class AnalyzedVideosScreen extends StatefulWidget {
//   @override
//   _AnalyzedVideosScreenState createState() => _AnalyzedVideosScreenState();
// }
//
// class _AnalyzedVideosScreenState extends State<AnalyzedVideosScreen> {
//   List<String> videoUrls = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchAnalyzedVideos();
//   }
//
//   Future<void> fetchAnalyzedVideos() async {
//     try {
//       final response = await http.get(Uri.parse(backendUrl));
//
//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         setState(() {
//           videoUrls = data.map((video) => video["video_url"].toString()).toList();
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load videos');
//       }
//     } catch (e) {
//       print("Error fetching analyzed videos: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void navigateToVideoPlayer(String videoUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: videoUrl)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Analyzed Videos")),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : videoUrls.isEmpty
//           ? Center(child: Text("No analyzed videos available."))
//           : ListView.builder(
//         itemCount: videoUrls.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text("Analyzed Video ${index + 1}"),
//             subtitle: Text(videoUrls[index]),
//             onTap: () => navigateToVideoPlayer(videoUrls[index]),
//           );
//         },
//       ),
//     );
//   }
// }
//
// // 🔹 Video Player Screen
// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;
//   VideoPlayerScreen({required this.videoUrl});
//
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           isLoading = false;
//         });
//         _controller.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Analyzed Video")),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying ? _controller.pause() : _controller.play();
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
// }























import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

final String backendUrl = 'http://192.168.147.174:5000';

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VideoListScreen(),
    );
  }
}

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<String> videoUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAnalyzedVideos();
  }

  Future<void> fetchAnalyzedVideos() async {
    try {
      final response = await http.get(Uri.parse('$backendUrl/get_analyzed_videos'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          videoUrls = data.map((video) => video["video_url"].toString()).toList();
          isLoading = false;
        });

        print("Fetched Videos: $videoUrls");
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print("Error fetching analyzed videos: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analyzed Videos")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : videoUrls.isEmpty
          ? Center(child: Text("No analyzed videos found"))
          : ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Analyzed Video ${index + 1}"),
            subtitle: Text(videoUrls[index]),
            onTap: () {
              // Open the video URL
              print("Opening video: ${videoUrls[index]}");
            },
          );
        },
      ),
    );
  }
}