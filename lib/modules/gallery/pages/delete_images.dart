import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ready_made_4_trade/modules/gallery/models/get_gallery_images.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
class DeletePage extends StatefulWidget {

   DeletePage({Key? key}) : super(key: key);

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {


  postData( List<String> imageList,) async {
    var response = await http.post(
        Uri.parse("https://readymade4trade.omkatech.in/api/CameraImageDelete"),
        body: {
          "id":  _imageList,
        });
    dynamic response1 = jsonDecode(response.body.toString());
    debugPrint(response1.toString());
    if(response1['status']==true){
      debugPrint('Hello shubham');
     /* Navigator.push(context,MaterialPageRoute(builder: (context)=> Home()));*/
    }
    else{
     /* Fluttertoast.showToast(
          msg:response1['email'],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 12);*/
      debugPrint('Good By');
    }
  }
  final RemoteApi apiServices = RemoteApi();

  List<bool> _isCheckedList = List.generate(1000, (_) => false);

  TextEditingController _projectName = TextEditingController();

  List<String>? _imageList = [];

  StorageServices _storageServices = StorageServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomToolsForInsidePage(
          onBackPress: (){
            Navigator.pop(context);
            /*BlocProvider.of<SearchTradesCubit>(context).getTrades();*/
          }
      ),
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.white,
        elevation: 0,
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
              child: Image.asset('assets/images/updated_images/012-bell.png'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            FutureBuilder<GetGalleryImages?>(
                future: apiServices.getGalleryImages(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.data.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            int reversedIndex = snapshot.data!.data.length - 1 - index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isCheckedList[index] =
                                  !_isCheckedList[index];
                                  if (_isCheckedList[index]) {
                                    _imageList!
                                        .add(snapshot.data!.data[index].image!);
                                  } else {
                                    int? indexVal = _imageList?.indexOf(
                                        snapshot.data!.data[index].image!);
                                    if (indexVal != null) {
                                      _imageList!.removeAt(indexVal);
                                    }
                                  }
                                });
                              },
                              child: Stack(children: <Widget>[
                                Image.network(
                                    '${snapshot.data!.data[index].filePath}/${snapshot.data!.data[index].image}'),
                                Checkbox(
                                  value: _isCheckedList[index],
                                  onChanged: (bool? value) {
                                         postData(_imageList!);
                                  },
                                ),
                              ]),
                            );
                          }),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went Wrong'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            Padding(
              padding: EdgeInsets.only(top: 10.0, right: 35.0, left: 35.0,bottom: 5),
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(2, 141, 153, 1),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    postData(_imageList!);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
