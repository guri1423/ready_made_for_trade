


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/dairy/bloc/dairy_cubit.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String? userPickDate;
  late PickupDateCubit _pickupDateCubit;

  @override
  void initState() {
    super.initState();
    _pickupDateCubit = BlocProvider.of<PickupDateCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now().add(Duration(days: 2)),
            firstDate: DateTime(2023), lastDate: DateTime(2050)
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy/MM/dd').format(
              pickedDate);
          BlocProvider.of<PickupDateCubit>(context).setPickupDate(formattedDate);
          setState(() {
            userPickDate = formattedDate;
            BlocProvider.of<DairyCubit>(context).getDiaryFilterData('', formattedDate);
          });
        }

      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: CustomColors.textFldBorder, width: 1,
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(userPickDate??'Select Date (mm/dd/yyyy)',
              style: TextStyle(
                  fontSize: 16,
                  color: CustomColors.black
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('*',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.red,
                ),),
            ),
          ],
        ),
      ),
    );
  }
  String changeDateToString(DateTime dateTime){
    return  DateFormat('yyyy/MM/dd').format(dateTime);
  }
}


class PickupDateCubit extends Cubit<String>{
  PickupDateCubit() : super("n");

  setPickupDate(String pickupDate){
    emit(pickupDate);


  }
  String getPickupDate(){
    return state;
  }

}