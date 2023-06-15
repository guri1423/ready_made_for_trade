import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/dairy/bloc/dairy_cubit.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key, this.isMandate = true, this.isDiary = true})
      : super(key: key);
  final bool isMandate;
  final bool isDiary;

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
              firstDate: DateTime(2023),
              lastDate: DateTime(2050));
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
            BlocProvider.of<PickupDateCubit>(context)
                .setPickupDate(formattedDate);
            setState(() {
              userPickDate = formattedDate;
            });
            if (widget.isDiary) {
              BlocProvider.of<DairyCubit>(context)
                  .getDiaryFilterData('', formattedDate);
            }
          }
        },
        child: SizedBox(
          height: 40,
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: CustomColors.textFieldBorderColor, width: 1),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  userPickDate ?? 'Select Date',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: userPickDate != null
                            ? CustomColors.black
                            : CustomColors.textFieldTextColour,
                      ),
                ),
                Spacer(),
                Visibility(
                  visible: widget.isMandate,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '*',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String changeDateToString(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }
}

class PickupDateCubit extends Cubit<String> {
  PickupDateCubit() : super("n");

  setPickupDate(String pickupDate) {
    emit(pickupDate);
  }

  String getPickupDate() {
    return state;
  }
}
/*class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key, this.isMandate = true, this.isDiary = true})
      : super(key: key);
  final bool isMandate;
  final bool isDiary;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {*/
class CustomDatePicker2 extends StatefulWidget {
  const CustomDatePicker2(
      {Key? key, this.isMandate = true, this.isDiary = true})
      : super(key: key);
  final bool isMandate;
  final bool isDiary;

  @override
  _CustomDatePicker2State createState() => _CustomDatePicker2State();
}

class _CustomDatePicker2State extends State<CustomDatePicker2> {
  String? userPickDate;
  late PickupDateCubit2 _pickupDateCubit;

  @override
  void initState() {
    super.initState();
    _pickupDateCubit = BlocProvider.of<PickupDateCubit2>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(Duration(days: 2)),
              firstDate: DateTime(2023),
              lastDate: DateTime(2050));
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
            BlocProvider.of<PickupDateCubit2>(context)
                .setPickupDate(formattedDate);

            setState(() {
              userPickDate = formattedDate;
            });
            if (widget.isDiary) {
              BlocProvider.of<DairyCubit>(context)
                  .getDiaryFilterData('', formattedDate);
            }
          }
        },
        child: SizedBox(
          height: 40,
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: CustomColors.textFieldBorderColor, width: 1),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  userPickDate ?? 'Select Date',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: userPickDate != null
                            ? CustomColors.black
                            : CustomColors.textFieldTextColour,
                      ),
                ),
                Spacer(),
                Visibility(
                  visible: widget.isMandate,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '*',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String changeDateToString(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }
}

class PickupDateCubit2 extends Cubit<String> {
  PickupDateCubit2() : super("n");

  setPickupDate(String pickupDate) {
    emit(pickupDate);
  }

  String getPickupDate() {
    return state;
  }
}
