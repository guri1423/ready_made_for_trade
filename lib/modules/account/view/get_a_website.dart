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
  Getwebsite? model;
   GetWebsitePage({Key? key}) : super(key: key);

  @override
  State<GetWebsitePage> createState() => _GetWebsitePageState();
}

class _GetWebsitePageState extends State<GetWebsitePage> {
  String? videoID;

  late YoutubePlayerController _controller;
  late Future<Getwebsite> website;
  Future<Getwebsite> getWebsite() async {
    /* SharedPreferences prefs = await SharedPreferences.getInstance();*/
    http.Response response;
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYTYyNGI4N2Y3YzdkMzk2ODhiMDEwNDNmMWMxMTQ2M2Y5ZmIzOWU5ZGEwNjM3YzIxMmYwNThlZTMyNzE0NGU5MzBkNGIxOWIwNTVmZDM4MTAiLCJpYXQiOjE2NjY4NTE0OTAuNTc4MjY4LCJuYmYiOjE2NjY4NTE0OTAuNTc4MjcxLCJleHAiOjE2OTgzODc0OTAuNTc1OTAxLCJzdWIiOiIyNiIsInNjb3BlcyI6W119.CsnH3UcsDzFWIlc5Ya6kENJX9YZN4Ae-f6YtOg5dcLnIwf5vkzmYOJfH4WKiiU-yP9WDaYSi2kJGhAMaLlV-aKf3BnfLKgGetEiTab47cxWWgkN8DiGDJYL9GKdHoUP9gSuPAV-hlBa15SmxIP08zeJ_3jpHFArKG5sWwRFDbjlEzbHiRYRqoJeI9WcxUVWwTHj9CmgcGVuq1-57RylBNwM_kNSbWMxuwy8mrvKLJeUR641gclVq0WuCwIPFaIZxZqJnnrcqIlocFtSr8pk6zRj1-hgYn3t-Xfgd6GcvX9PC-JzRCJJeQLkYRuCS1o7QwEeoYwicHnvc7njT03TwWdw_mxy7TFef-lD1c5KRXxXNZFXGv4n5WgJlNnDii0pCKA7GtzQnWhlD1Jr5GTZUHPCkrBoS3gsljTSzaqAJryTAnrqV2AP3gdd_oFd9NxpGE-ON0HyveK1HaG9p_idRzD_oZ_tqORZINp4O6X-We06-0glvbJLocDGOc-L5mGP5_gwmt_hwT2xZFt--veodAdcpV2-qymTW1dL20ZiBhhdL6F6WC_F1kb8AfsJiW5IuBApVkqjQHZmai1Biw0FYK5MvW8fSLQIKVnsplFAItDlKzZzoZP4UdWV_IsFWUGOKIZuZNh2QKplsupcOZJ82MID8esJRcvNl4FcubW0gEPE";
    response = await http.get(
        Uri.parse('https://readymade4trade.omkatech.in/api/GetAWebsite'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        });
    if (response.statusCode == 200) {
      return getwebsiteFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.model!.data[0].videoLink);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.model!.data[0].id.toString(),
                        style: TextStyle(color: Colors.grey[600], fontSize: 10),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              if (widget.model!.data[0].url != null)
                InkWell(
                  onTap: () {
                    launchUrlString(widget.model!.data[0].url ?? '',
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
