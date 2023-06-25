import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ready_made_4_trade/core/base_urls.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:http/http.dart' as http;
import 'package:ready_made_4_trade/modules/gallery/models/delete_camera_images_model.dart';
import 'dart:convert';
import 'package:ready_made_4_trade/modules/gallery/models/get_gallery_images.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:requests_inspector/requests_inspector.dart';
class DeletePage extends StatefulWidget {
  GetGalleryImages? id;
   DeletePage({Key? key}) : super(key: key);

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  final StorageServices _servicesStorage = StorageServices();
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
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
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
                              mainAxisExtent: 120
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
                                        .add(snapshot.data!.data[index].id!.toString());
                                  } else {
                                    int? indexVal = _imageList?.indexOf(
                                        snapshot.data!.data[index].id!.toString());
                                    if (indexVal != null) {
                                      _imageList!.removeAt(indexVal);
                                    }
                                  }
                                  print(_imageList.toString());
                                });
                              },
                              child: Stack(
                                  children: <Widget>[
                                Positioned.fill(
                                  child: Image.network(
                                      '${snapshot.data!.data[index].filePath}/${snapshot.data!.data[index].image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Checkbox(
                                  value: _isCheckedList[index],
                                  onChanged: (bool? value) {
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
              padding:  EdgeInsets.only(bottom: 25),
              child: GestureDetector(
                  onTap: () async{
                    await apiServices.deleteImages(
                        imageList: _imageList!);
                    CircularProgressIndicator(color: CustomColors.primeColour,);
                    setState(() {

                    });
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllProjectsPage()));*/
                  },
                  child: extraLongButton(context, 'DELETE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
