import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String videoLink;
  final String? url;
  final String description;

  const VideoPage(
      {Key? key, required this.videoLink, required this.description, this.url})
      : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String? videoID;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.videoLink);
    _controller = YoutubePlayerController(
      initialVideoId: videoID.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 130,
              height: 60,
              child: Image.asset(
                'assets/images/final Logo.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/images/02 Notification.png'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomToolsForInsidePage(
          onBackPress: (){
            Navigator.pop(context);
            /*BlocProvider.of<SearchTradesCubit>(context).getTrades();*/
          }
        // _searchTrades.text.isNotEmpty
        //     ? () {
        //         _searchTrades.clear();
        //
        //       }
        //     : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              width: double.infinity,
              height: 260.0,
              color: CustomColors.primeColour,
              padding: const EdgeInsets.all(35),
              child: Center(
                child: YoutubePlayer(
                  controller: _controller,
                  onReady: () {},
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            if (widget.url != null)
              InkWell(
                onTap: () {
                  launchUrlString(widget.url ?? '',
                      mode: LaunchMode.externalApplication);
                },
                child: extraLongButton(context, "VISIT SITE"),
              )
          ],
        ),
      ),
    );
  }
}
