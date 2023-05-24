

import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/dairy/model/get_diary_data_model.dart';

Widget diaryWidget(context, List<DairyData> data, int index) {
  ThemeData theme = Theme.of(context);

  return Container(
    decoration: BoxDecoration(
        color: CustomColors.blueButton,
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: CustomColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/support.png'),
              )),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  data[index].projectTitle ?? 'No Title' ,
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 18)),
              const SizedBox(
                height: 2,
              ),
              Text(data[index].projectDescription ?? 'No Description',
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 18)),

            ],
          ),

          Spacer(),

          Column(
            children: [
              Text(data[index].date.toString(),
              style: theme.textTheme.titleSmall,),
            ],
          )
        ],
      ),
    ),
  );
}