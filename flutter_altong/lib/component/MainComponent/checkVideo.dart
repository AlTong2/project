import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CheckVideo extends StatefulWidget {
  const CheckVideo({super.key, required this.name, required this.img});
  final String name;
  final String img;
  @override
  State<CheckVideo> createState() => _CheckVideoState();
}

class _CheckVideoState extends State<CheckVideo> {
  Future <void> onControllerChange () async {
    if (_controller == null) { //if current controller is null
      initState(); //method to initialize your video controller
    } else {
      final oldController = _controller;
      await oldController.dispose();
      initState();
    }
  }

  late VideoPlayerController _controller;
  late VideoPlayerController _videoPlayerController;
  initializeController () {
    String url = 'http://172.30.1.46:3333/'+widget.name;
    print(url);
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {}); //here you could use Provider or any other state management approach. I use bloc
      });
  }



  @override
  void initState() {
    super.initState();
    String url = 'http://172.30.1.46:3333/'+widget.name;
    print(url);
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: MaterialApp(
                title: 'Video Demo',
                home: Scaffold(
                  body: Center(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : Container(),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(widget.img,),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

