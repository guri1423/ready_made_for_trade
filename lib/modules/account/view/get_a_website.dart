import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/account/model/get_website_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class GetWebsitePage extends StatefulWidget {
   Datum? videoLink,url;
   GetWebsitePage({Key? key}) : super(key: key);

  @override
  State<GetWebsitePage> createState() => _GetWebsitePageState();
}

class _GetWebsitePageState extends State<GetWebsitePage> {
  String? videoID;

  late YoutubePlayerController _controller;
  late Future<Getwebsite> website;
  Future<Getwebsite> getWebsite() async {
    http.Response response;
    response = await http.get(
        Uri.parse('https://readymade4trade.omkatech.in/api/GetAWebsite'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          /*HttpHeaders.authorizationHeader: "Bearer $token"*/
        });
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return getwebsiteFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.videoLink.toString());
    _controller = YoutubePlayerController(
      initialVideoId: videoID.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
   website = getWebsite();
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
              ),
              const SizedBox(height: 40),
              if (widget.url != null)
                InkWell(
                  onTap: () {
                    launchUrlString(widget.url.toString(),
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
