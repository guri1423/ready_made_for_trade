import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_model.dart';
import 'package:ready_made_4_trade/modules/trainings/models/get_trainings_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class videoPlayer extends StatefulWidget {
  final GetAllTrainings  videolink,description;
 videoPlayer({Key? key,required this.videolink, required this.description}) : super(key: key);

  @override
  State<videoPlayer> createState() => _videoPlayerState();
}

class _videoPlayerState extends State<videoPlayer> {

  String? videoID;
  //final videoUrl = 'https://www.youtube.com/watch?v=tblbY2qvwIo';
  late YoutubePlayerController _controller;
  @override
  void initState(){
    final videoID = YoutubePlayer.convertUrlToId(widget.videolink.toString());
    _controller = YoutubePlayerController(
      initialVideoId: videoID.toString(),
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 235, 235),
      appBar: AppBar(
        toolbarHeight: 160 * oneLogicalPixelInPhysicalPixels,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40,
            ),
            SizedBox(
              width: 160,
              height: 75,
              child: Image.asset(
                'assets/images/final Logo.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/images/updated_images/012-bell.png'),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top:10.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 260.0,
                color: Color.fromARGB(255, 39, 69, 89),
                margin: EdgeInsets.all(25),
                padding: EdgeInsets.all(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    YoutubePlayer(
                      controller: _controller,
                      onReady: (){
                        print('Player is ready.');
                      },
                      showVideoProgressIndicator: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 350.0,
                margin: EdgeInsets.all(25),
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(widget.description.toString(),
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
