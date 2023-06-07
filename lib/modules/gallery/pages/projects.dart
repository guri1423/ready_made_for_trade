import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/gallery/models/get_all_projects.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/create_project.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/projects_details.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../../home/widgets/common_widgets.dart';

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({Key? key}) : super(key: key);

  @override
  State<AllProjectsPage> createState() => _AllProjectsPageState();
}

RemoteApi _api = RemoteApi();

class _AllProjectsPageState extends State<AllProjectsPage> {
  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 200 * oneLogicalPixelInPhysicalPixels,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 8 * oneLogicalPixelInPhysicalPixels,
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
          ],
        ),
      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: FutureBuilder<GetAllProjects?>(
          future: _api.getAllProjects(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectsDetailsPage(
                                    model: snapshot.data!.data[index],
                                  ),
                                ),
                              );
                            },
                            child: extraLongButton(
                              context,
                              snapshot.data!.data[index].projectTitle!,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateProject(
                                  projctName:
                                  snapshot.data!.data[index].projectTitle,
                                  projectId: snapshot.data!.data[index].id.toString(),
                                  isComingFromEditProject: true,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 40,

                            decoration: BoxDecoration(
                              color: CustomColors.primeColour,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset('assets/images/small_icons/019-edit.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong--${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        ),
      )

    );
  }
}
