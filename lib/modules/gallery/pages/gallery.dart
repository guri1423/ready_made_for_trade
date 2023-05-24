import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/gallery/models/get_gallery_images.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/create_project.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/projects.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../../home/widgets/common_widgets.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final RemoteApi apiServices = RemoteApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 180,
              height: 90,
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
      bottomNavigationBar: const BottomToolsForInsidePage(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                            return Image.network(
                                '${snapshot.data!.data[index].filePath}/${snapshot.data!.data[index].image}');
                          }),
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
