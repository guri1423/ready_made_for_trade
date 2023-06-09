import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/modules/home/model/home_image_model.dart';
class HomePageImages extends StatefulWidget {
  HomePageImages({Key? key}) : super(key: key);

  @override
  State<HomePageImages> createState() => _HomePageImagesState();
}

class _HomePageImagesState extends State<HomePageImages> {

  Future<HomeImage> getImage() async {
    /* SharedPreferences prefs = await SharedPreferences.getInstance();*/
    http.Response response;
    /* String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmY1YTAyYjExMzJlZjM3NGQ1ZDZjYmQ1NDcxNmQwNjExN2U1MTBiYTA0NmRjZTI3YWZmOWJhNDZhZGQ2MmNmMzJiNjU0YmZjMDQ5ODU3NTEiLCJpYXQiOjE2NzMzMjc1ODkuMzE1NzY2LCJuYmYiOjE2NzMzMjc1ODkuMzE1Nzc1LCJleHAiOjE3MDQ4NjM1ODkuMzA2NjQxLCJzdWIiOiI3Iiwic2NvcGVzIjpbXX0.scoIUkh8dg0wpKe2dxedbZ1Rcny1iFLX5JjxKQd_To10bPfx6VGU0VafRDBRsXVP1GCwcRcsl0Aic2SP6cxVSW-CTeYSZHuT9WN0oacEG2p98QdXairyeObEBwDrgvi_65jss_sGcmcAOPdw0-JJBJnoub-haVpRqN7CbrDWT5rE3uF7afVuQJtvnagQH5MIKFsKsUXzmWAPtXqC1Q9iFYjYyTeVSpkeQ4wHp07_YiLsBFBuBekNbq-L3Ak2dW2bwpXybmsoN12-XPspT0AEjUGk_yGW8QWepbtDBArp2DaYjsYOSRw4Xu6AUuTL9rjFlhFZ-vPtXhGLCBROxz9VxcUoeCVsQqkYXLDrMO9isaB2C6zGSg6dNfuAtUzbLuwCb6zDkRqDYg8zD-vxcl9TD40HGQ21uoFRlcEeKykheNmp8hdvBvc2cSs8fPe8j0Y5MJLxE_KuZWpEm5kBUTY7FbFWCFSRWfiZbK--geKLfwc_1eyj14g8G9WcDG2exv_69lrKWbvdpRwHfBcq2jlg4DN7QZAbnI0fQUKGAzIqMI9T21OOiiOn3fhpOGwPzBDM6DnNrAidcadvnkdClHnWmBcAzcIpMc3kgD7S_xc9F9msq5rd2Xl6-BWuti_3nGkQpdvCvqAIm6S4telqc_cfcSDSYhdi04CGSPuJtouWCCA";*/
    response = await http.get(
        Uri.parse('https://readymade4trade.omkatech.in/api/GetHomeImage'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
    if (response.statusCode == 200) {
      return homeImageFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeImage?>(
      future: getImage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data!.status);
          return  SizedBox(
            height: MediaQuery.of(context).size.height * 0.16,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              snapshot.data!.data.url,
              fit: BoxFit.fill,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator()
        );
      },
    );
  }
}