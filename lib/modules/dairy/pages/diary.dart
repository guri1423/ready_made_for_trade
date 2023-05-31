import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/dairy/bloc/dairy_cubit.dart';
import 'package:ready_made_4_trade/modules/dairy/model/get_diary_data_model.dart';
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
        bottomNavigationBar:  BottomToolsForInsidePage(
          onBackPress: (){
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
                            iconColor: CustomColors.white,
                            isDense: true,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          buttonHeight: 50,
                          buttonWidth: 40,
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColors.textFldBorder,
                                width: 1,
                              ),
                              color: CustomColors.white),
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemHeight:
                              MediaQuery.of(context).size.height * 0.056,
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          iconOnClick: const Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: CustomColors.primeColour,
                            ),
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Filter',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: CustomColors.textFieldTextColour),
                            ),
                          ),
                          value: filterValue,
                          onChanged: (value) {
                            BlocProvider.of<DairyCubit>(context).getDiaryFilterData(value, BlocProvider.of<PickupDateCubit>(context).getPickupDate());
                            setState(() {
                              filterValue = value;
                            });
                          },
                          items: dairyFilterList
                              .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      item.toString(),
                                      style: TextStyle(
                                          color: CustomColors.blackText),
                                    ),
                                  )))
                              .toList(),
                          validator: (value) {
                            return validationDropField(value);
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                          'assets/images/updated_images/029-list.png'))
                ],
              ),
              CustomDatePicker(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('01/05/22',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: CustomColors.primeColour)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<DairyCubit, DairyState>(

                builder: (context, state) {

                  if(state is DairySuccess){
                    return Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.model!.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: diaryWidget(
                                  context, state.model!.data, index),
                            );
                          },
                        ),
                      ),
                    );
                  }

                  if(state is DairyLoading){
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
