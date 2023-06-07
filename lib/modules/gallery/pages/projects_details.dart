

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/gallery/models/get_all_projects.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../../home/widgets/common_widgets.dart';

class ProjectsDetailsPage extends StatefulWidget {

  ProjectsData? model;
   ProjectsDetailsPage({Key? key, this.model}) : super(key: key);

  @override
  State<ProjectsDetailsPage> createState() => _ProjectsDetailsPageState();
}

class _ProjectsDetailsPageState extends State<ProjectsDetailsPage> {

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
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.model!.projectImages!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ), itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder:  (BuildContext context){
                          return Dialog(
                            child: Image.network(
                                'https://readymade4trade.omkatech.in/images/cameraimage/${widget.model!.projectImages![index]}'),
                          );
                        },
                    );
                  },
                  child: Image.network(
                      'https://readymade4trade.omkatech.in/images/cameraimage/${widget.model!.projectImages![index]}'),
                );
              }),
            ),
            const Spacer(),
            extraLongButton(context, 'PROJECTS'),
            const SizedBox(height: 15,),
            Text(widget.model!.projectTitle!, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.primeColour),),
            const SizedBox(height: 10,),
          ],
        ),
      ),

    );
  }
}

