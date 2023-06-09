import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/dairy/bloc/dairy_cubit.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({Key? key}) : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  String? userPickTime;
  late PickupTimeCubit _pickupTimeCubit;

  @override
  void initState() {
    super.initState();
    _pickupTimeCubit = BlocProvider.of<PickupTimeCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          String formattedTime =
          DateFormat.Hm().format(DateTime.now().toLocal().add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute)));
          BlocProvider.of<PickupTimeCubit>(context).setPickupTime(formattedTime);
          setState(() {
            userPickTime = formattedTime;
            debugPrint('bloc called');
            BlocProvider.of<DairyCubit>(context).getDiaryFilterData('', formattedTime);
          });
        }
      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: CustomColors.textFieldBorderColor, width: 1),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userPickTime ?? 'Select Time',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: userPickTime != null ? CustomColors.black : CustomColors.textFieldTextColour,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '*',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}

class PickupTimeCubit extends Cubit<String> {
  PickupTimeCubit() : super("n");

  setPickupTime(String pickupTime) {
    emit(pickupTime);
  }

  String getPickupTime() {
    return state;
  }
}
