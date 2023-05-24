

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/dairy/model/get_diary_data_model.dart';
import 'package:ready_made_4_trade/modules/dairy/widgets/dairy_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {

  final RemoteApi _remoteApi = RemoteApi();


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
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2(
                        decoration: const InputDecoration(
                          isDense: true,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        buttonHeight: 49,
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonDecoration: BoxDecoration(
                          color: CustomColors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: CustomColors.textFieldBorderColor,
                            width: 1,
                          ),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 15),
                        itemHeight:
                        MediaQuery.of(context).size.height * 0.056,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        iconOnClick: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        hint: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Filter',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: CustomColors.textFieldTextColour),
                          ),
                        ),
                        items: [],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  SizedBox(
                     height: 40, width: 40,
                      child: Image.asset('assets/images/updated_images/029-list.png'))
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2(
                        decoration: const InputDecoration(
                          isDense: true,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        buttonHeight: 49,
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonDecoration: BoxDecoration(
                          color: CustomColors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: CustomColors.textFieldBorderColor,
                            width: 1,
                          ),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 15),
                        itemHeight:
                        MediaQuery.of(context).size.height * 0.056,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        iconOnClick: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        hint: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Date',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: CustomColors.textFieldTextColour),
                          ),
                        ),
                        items: [],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  SizedBox(
                      height: 40, width: 40,
                      child: Image.asset('assets/images/updated_images/030-counting.png'))
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      '01/05/22',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.primeColour)),
                ],
              ),

              const SizedBox(height: 10,),

              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder<GetDairyData?>(
                    future: _remoteApi.getDiaryData(),
                    builder: (context, snapshot){
                     if(snapshot.hasData){
                       return ListView.builder(
                         physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         itemCount: snapshot.data!.data.length,
                         itemBuilder: (BuildContext context, int index) {
                           return Padding(
                             padding: const EdgeInsets.only(bottom: 25),
                             child: diaryWidget(context, snapshot.data!.data, index),
                           );
                         },

                       );
                     }
                     if(snapshot.hasError){
                       return const Center(child: CircularProgressIndicator());
                     }

                     return const Center(child: CircularProgressIndicator());
                    },

                  ),
                ),
              )
            ],
          ),
        ));
  }
}
