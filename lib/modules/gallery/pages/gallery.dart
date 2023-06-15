import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/gallery/models/get_gallery_images.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/create_project.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/delete_images.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/projects.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import '../../home/widgets/common_widgets.dart';

class GalleryPage extends StatefulWidget {
   String? id;
   GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final RemoteApi apiServices = RemoteApi();


  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 8 ,
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
      bottomNavigationBar: const BottomToolsForInsidePage(),
      body: Padding(
        padding:  EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DeletePage()));
                  },
                    child: Icon(Icons.delete,
                      color: CustomColors.primeColour,
                      size: 25),
                ),
              ],
            ),
            SizedBox(height: 8),
            FutureBuilder<GetGalleryImages?>(
                future: apiServices.getGalleryImages(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.data.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 120
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          int reversedIndex = snapshot.data!.data.length - 1 - index;
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Image.network(
                                      '${snapshot.data!.data[reversedIndex].filePath}/${snapshot.data!.data[reversedIndex].image}',
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.network(
                              '${snapshot.data!.data[reversedIndex].
                              filePath}/${snapshot.data!.data[reversedIndex].image}', fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),

                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went Wrong'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(height: 10,),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllProjectsPage()));
                },
                child: extraLongButton(context, 'PROJECTS')),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateProject()));
                },
                child: extraLongButton(context, 'CREATE PROJECT')),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
