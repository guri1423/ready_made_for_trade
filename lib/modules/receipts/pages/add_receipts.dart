import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/core/list/list.dart';
import 'package:ready_made_4_trade/core/utils.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/receipts/models/receipts_model.dart';
import 'package:ready_made_4_trade/modules/receipts/pages/receipts.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:http/http.dart' as http;
import 'package:ready_made_4_trade/widgets/date_picker.dart';
import '../../home/widgets/common_widgets.dart';



class AddReceipts extends StatefulWidget {
  File? image;
  AddReceipts({Key? key, required this.image}) : super(key: key);

  @override
  State<AddReceipts> createState() => _AddReceiptsState();
}

class _AddReceiptsState extends State<AddReceipts> {

  String? jobValue;
  String? categoryValue;

  List<String> jobList = [];

  TextEditingController _amount = TextEditingController();

  TextEditingController _date = TextEditingController();

  RemoteApi _remoteApi = RemoteApi();
  StorageServices _storageServices = StorageServices();



  Future<void> getJobs() async {
    GetJobList? model = await _remoteApi.getJobListReceipts();
    debugPrint('get Jobs call');
    jobList.addAll(model!.data);
  }

  @override
  void initState() {
    getJobs();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: CustomColors.backgroundColour,

      appBar: AppBar(
        toolbarHeight:55,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 130,
              height: 60,
              child: Image.asset(
                'assets/images/final Logo.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/images/02 Notification.png'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomToolsForInsidePage(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [

              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: FileImage(widget.image!)
                  ),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xffdbdbdb),
                    width: 1.50,),
                  color: const Color(0xfff6f6f6),
                ),
              ),

              SizedBox(
                  height: 60,
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
                        buttonHeight: 40,
                        buttonWidth: 40,
                        buttonDecoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(4),
                            border: Border.all(
                              color: CustomColors.textFldBorder,
                              width: 1,
                            ),
                            color: CustomColors.white),
                        itemPadding:
                        const EdgeInsets.symmetric(horizontal: 5),
                        itemHeight:
                        MediaQuery.of(context).size.height *
                            0.056,
                        icon: const Padding(
                          padding:
                          EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        iconOnClick: const Padding(
                          padding:
                          EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.arrow_drop_up,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Job',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                color: CustomColors
                                    .textFieldTextColour),
                          ),
                        ),
                        value: jobValue,
                        onChanged: (value) {
                          setState(() {
                            jobValue = value as String;
                          });
                        },
                        items: jobList
                            .map((item) => DropdownMenuItem(
                            value: item,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 5),
                              child: Text(
                                item.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                    color: CustomColors
                                        .black,fontSize: 10),
                              ),
                            )))
                            .toList(),
                        validator: (value) {
                          return validationDropField(value);
                        }),
                  )),

              SizedBox(
                  height: 60,
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
                        buttonHeight: 40,
                        buttonWidth: 40,
                        buttonDecoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(4),
                            border: Border.all(
                              color: CustomColors.textFldBorder,
                              width: 1,
                            ),
                            color: CustomColors.white),
                        itemPadding:
                        EdgeInsets.symmetric(horizontal: 5),
                        itemHeight:
                        MediaQuery.of(context).size.height *
                            0.056,
                        icon: const Padding(
                          padding:
                          EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        iconOnClick: const Padding(
                          padding:
                          EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.arrow_drop_up,
                            color: CustomColors.primeColour,
                          ),
                        ),
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Category',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                color: CustomColors
                                    .textFieldTextColour),
                          ),
                        ),
                        value: categoryValue,
                        onChanged: (value) {
                          setState(() {
                            categoryValue = value as String;
                          });
                        },
                        items: categoryList
                            .map((item) => DropdownMenuItem(
                            value: item,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 5),
                              child: Text(
                                item.toString(),
                                  style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                  color: CustomColors
                                      .black,fontSize: 10),
                              ),
                            )))
                            .toList(),
                        validator: (value) {
                          return validationDropField(value);
                        }),
                  )),

              SizedBox(
                  height: 40,
                  child: customTextFieldForm(context, controller: _amount, hintText: 'Amount')),

              SizedBox(height: 10,),

              CustomDatePicker(),

              SizedBox(height: 30,),

              GestureDetector(
                  onTap: (){
                    uploadReceipts();
                  },
                  child: extraLongButton(context, 'Submit Receipt',))






            ],
          ),
        ),
      ),


    );
  }

  void uploadReceipts() async {
    var uri = Uri.parse("https://readymade4trade.omkatech.in/api/ReceiptAddImage");
    var request = http.MultipartRequest("POST", uri);

    String? userId = await _storageServices.getUserId();

    debugPrint('User ID ${userId.toString()}');

    request.fields["user_id"] = userId!;
    request.fields["job"] = jobValue!;
    request.fields["category"] = categoryValue!;
    request.fields["amount"] = extractNumericValue(_amount.text);
    request.fields["date"] = BlocProvider.of<PickupDateCubit>(context).getPickupDate();

    final file = await http.MultipartFile.fromPath('image', widget.image!.path);
    request.files.add(file);

    request.headers["Accept"] = "application/json";
    request.headers["Content-Type"] = "application/json";

    await request.send().then((response) async {
      debugPrint(response.statusCode.toString());
      debugPrint(response.toString());
      response.stream.transform(utf8.decoder).listen((value) async {
        debugPrint(value);

         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Your response has been added successfully',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ));

         Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptsPage()));


      });
    }).catchError((e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Try again',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ));
    });
  }

}
