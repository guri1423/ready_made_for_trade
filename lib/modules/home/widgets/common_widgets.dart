import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/trades/search_cubit/search_trades_cubit.dart';


String extractNumericValue(String value) {
  // Remove any commas and pound signs from the value
  String numericValue = value.replaceAll(',', '').replaceAll('£', '');
  return numericValue;
}

Widget extraLongButton(context, String title,
    {bool isShowIcon = false, Color color = CustomColors.primeColour}) {
  return SizedBox(
    height: 44,
    width: MediaQuery.of(context).size.width,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Visibility(
        visible: !title.contains('ADD') || isShowIcon,
        replacement: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.event_note_sharp,
              color: CustomColors.white,
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            )
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    ),
  );
}

Widget textField(context, TextEditingController controller, String hint,
    double width, double height) {
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: CustomColors.black, fontWeight: FontWeight.normal),
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: CustomColors.textFieldTextColour),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final hint = 'DD/MM/YYYY';
    final hintLength = hint.length;

    if (newValue.text == hint && newValue.selection.baseOffset == hintLength + 1) {
      return newValue;
    }

    if (newValue.text.isNotEmpty && newValue.selection.baseOffset >= hintLength) {
      final formattedValue = _formatDate(newValue.text);
      return TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(
          offset: formattedValue.length,
        ),
      );
    }

    return newValue;
  }

  String _formatDate(String value) {
    final formattedValue = StringBuffer();
    final pattern = RegExp(r'^(\d{0,2})(\d{0,2})(\d{0,4})');

    pattern.allMatches(value).forEach((match) {
      final day = match.group(1);
      final month = match.group(2);
      final year = match.group(3);

      if (day != null && day.isNotEmpty) {
        formattedValue.write(day);
      }

      if (month != null && month.isNotEmpty) {
        formattedValue.write('/$month');
      }

      if (year != null && year.isNotEmpty) {
        formattedValue.write('/$year');
      }
    });

    return formattedValue.toString();
  }
}




Widget searchTextField(context, TextEditingController controller, String hint,
    double width, double height) {
  return SizedBox(
      height: height,
      width: width,
      child: Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: CustomColors.fieldBorderColour, // set primary color here
              secondary:
                  CustomColors.fieldBorderColour, // set secondary color here
            ),
            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.fieldBorderColour,
                  // set border color here
                  width: 2.0, // set border width here
                ),
              ),
            ),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 35,
                  color: CustomColors.blueText,
                ),
                onPressed: () {
                  // perform search here
                },
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: TextStyle(color: CustomColors.greyButton),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.fieldBorderColour,
                  // set border color here
                  width: 2.0, // set border width here
                ),
              ),
            ),
          )));
}

Widget smallButton(context, String title, Color borderColour, double width) {
  return Padding(
    padding:  EdgeInsets.only(right: 10.0),
    child: SizedBox(
      height: 40,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: borderColour,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    ),
  );
}

Widget searchBarWidget(context,
    {required String hintText,
    required ThemeData theme,
    required TextEditingController controller}) {
  return SizedBox(
    height: 40,
    child: TextFormField(
      onFieldSubmitted: (val) {
        BlocProvider.of<SearchTradesCubit>(context)
            .searchTrades(controller.text);
      },
      controller: controller,
      style: theme.textTheme.titleSmall!.copyWith(color: CustomColors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 2, left: 10),
        hintText: hintText,
        hintStyle: theme.textTheme.titleSmall!
            .copyWith(color: CustomColors.textFieldTextColour),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: CustomColors.greyButton),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            BlocProvider.of<SearchTradesCubit>(context)
                .searchTrades(controller.text);
          },
          child: const Icon(
            Icons.search,
            color: CustomColors.primeColour,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}

Widget customerSearchBarWidget(context,
    {required String hintText,
    required ThemeData theme,
    required TextEditingController controller,
    required VoidCallback onTap}) {
  return SizedBox(
    height: 40,
    child: TextFormField(
      onFieldSubmitted: (val) {
        onTap();
      },
      controller: controller,
      style: theme.textTheme.titleSmall!.copyWith(color: CustomColors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 2, left: 10),
        hintText: hintText,
        hintStyle: theme.textTheme.titleSmall!
            .copyWith(color: CustomColors.textFieldTextColour),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: CustomColors.greyButton),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: CustomColors.textFieldBorderColor),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            onTap();
          },
          child: const Icon(
            Icons.search,
            color: CustomColors.primeColour,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}
