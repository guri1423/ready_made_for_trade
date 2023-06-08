import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/modules/dairy/bloc/dairy_cubit.dart';
import 'package:ready_made_4_trade/modules/dairy/widgets/dairy_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

import '../../../widgets/date_picker.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final RemoteApi _remoteApi = RemoteApi();

  String? filterValue;

  @override
  void initState() {
    BlocProvider.of<DairyCubit>(context).getDiaryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
        bottomNavigationBar: BottomToolsForInsidePage(
          onBackPress: () {
            BlocProvider.of<DairyCubit>(context).getDiaryData();
          },
        ),
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
                            style: theme.textTheme.titleMedium!.copyWith(
                                color: CustomColors.textFieldTextColour),
                          ),
                        ),
                        items: dairyFilterList
                            .map((item) => DropdownMenuItem(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                item.toString(),
                                style:
                                TextStyle(color: CustomColors.blackText),
                              ),
                            )))
                            .toList(),
                        onChanged: (val){
                          BlocProvider.of<DairyCubit>(context).getDiaryFilterData(val.toString(), '');

                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 35,
                      width: 40,
                      child: Image.asset(
                          'assets/images/updated_images/029-list.png'))
                ],
              ),
              Row(
                children: [
                  Expanded(child: CustomDatePicker()),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 35,
                      width: 40,
                      child: Image.asset(
                          'assets/images/updated_images/diary.png'))
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              BlocBuilder<DairyCubit, DairyState>(
                builder: (context, state) {
                  if (state is DairySuccess) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.model!.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final sortedData = state.model!.data..sort((a, b) {
                              final dateA = DateTime.parse(a.date.toString());
                              final dateB = DateTime.parse(b.date.toString());
                              return dateB.compareTo(dateA);
                            });
                            final item = sortedData[index];
                            final currentDate = DateTime.parse(item.date.toString());
                            final formattedDate = '${currentDate.day}-${currentDate.month}-${currentDate.year}';

                            return Column(
                              children: [
                                if (index == 0 ||
                                    currentDate.day !=
                                        DateTime.parse(sortedData[index - 1].date.toString()).day ||
                                    currentDate.month !=
                                        DateTime.parse(sortedData[index - 1].date.toString()).month ||
                                    currentDate.year !=
                                        DateTime.parse(sortedData[index - 1].date.toString()).year)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        formattedDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: CustomColors.black),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 5),
                                  child: diaryWidget(context, sortedData, index),
                                ),
                              ],
                            );
                          },
                        ),

                      ),
                    );


                  }

                  if (state is DairyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(state is DairyFilterSuccess){
                    return Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.model!.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final sortedData = state.model!.data..sort((a, b) {
                              final dateA = DateTime.parse(a.date.toString());
                              final dateB = DateTime.parse(b.date.toString());
                              return dateB.compareTo(dateA);
                            });
                            final item = sortedData[index];
                            final currentDate = DateTime.parse(item.date.toString());
                            final formattedDate = '${currentDate.day}-${currentDate.month}-${currentDate.year}';

                            return Column(
                              children: [
                                if (index == 0 ||
                                    currentDate.day !=
                                        DateTime.parse(sortedData[index - 1].date.toString()).day ||
                                    currentDate.month !=
                                        DateTime.parse(sortedData[index - 1].date.toString()).month ||
                                    currentDate.year !=
                                        DateTime.parse(sortedData[index - 1].date.toString()).year)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        formattedDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: CustomColors.black),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 5),
                                  child: diaryWidget(context, sortedData, index),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }

                  if(state is DairyFilterLoading){
                    return const Center(child: CircularProgressIndicator());
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ));
  }
}
