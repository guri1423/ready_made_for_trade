import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/account/model/get_website_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class GetWebsitePage extends StatefulWidget {
  GetWebsitePage({Key? key}) : super(key: key);

  @override
  State<GetWebsitePage> createState() => _GetWebsitePageState();
}

class _GetWebsitePageState extends State<GetWebsitePage> {
  bool _loading = true;
  void playerHandling(String link){
    final videoID = YoutubePlayer.convertUrlToId(link);//
    _controller = YoutubePlayerController(
      initialVideoId: videoID.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    setState(() {
      _loading= false;
    });
  }
  String url = '';
  RemoteApi _remoteApi = RemoteApi();//
  String? videoID;
  late YoutubePlayerController _controller;
  @override
  void initState() {
        _remoteApi.getwebsite().then((value) {
          url = value!.data[0].url!;
      playerHandling(value!.data[0].videoLink!);
    });// yaha pr api call ki h
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  child: _loading?CircularProgressIndicator():YoutubePlayer(
                    controller: _controller,
                    onReady: () {},
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),
             SizedBox(height: 20),

              GestureDetector(
                  onTap: (){

                   /* launchUrlString(widget.model.url.toString());*/
                  },
                  child: extraLongButton(context, "VISIT SITE"),
              ),
             /* if (widget.url != null)
                InkWell(
                  onTap: () {
                    launchUrlString(widget.url ?? '',
                        mode: LaunchMode.externalApplication);
                  },
                  child: extraLongButton(context, "VISIT SITE"),
                ),*/
            ],
          ),
        ),
        /*body: Column(
          children: [

            Padding(
              padding:  EdgeInsets.only(left: 15,right: 15),
              child: extraLongButton(context, "VISIT SITE"),
            ),
          ],
        ),*/
      ),
    );
  }
}
