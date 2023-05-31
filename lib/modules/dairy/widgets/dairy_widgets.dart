

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/dairy/model/get_diary_data_model.dart';

import '../../trainings/models/training_status_model.dart';

Widget diaryWidget(context, List<DiaryData> data, int index) {

  Color resultColor;

  if (data[index].category == 'Appointment') {
    resultColor = CustomColors.blueButton;
  } else if (data[index].category == 'Reminder') {
    resultColor = CustomColors.yellow;
  } else {
    resultColor = CustomColors.skyblue;
  }
  ThemeData theme = Theme.of(context);

  return Container(
    decoration: BoxDecoration(

        color: resultColor,
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: CustomColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset('assets/images/updated_images/Materials 1.png'),
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  data[index].customerName ?? 'No Title' ,
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 18)),
              const SizedBox(
                height: 2,
              ),
              Text(
                  data[index].projectName ?? 'No Title' ,
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 18)),
              const SizedBox(
                height: 2,
              ),
              // Text(data[index].p ?? 'No Description',
              //     style: theme.textTheme.titleLarge!.copyWith(fontSize: 18)),

            ],
          ),

          Spacer(),

          // Column(
          //   children: [
          //     Text(data[index].date.toString(),
          //     style: theme.textTheme.titleSmall,),
          //   ],
          // )
        ],
      ),
    ),
  );
}