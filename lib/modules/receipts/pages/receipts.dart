import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/gallery/models/project_response_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/home/widgets/home_widgets.dart';
import 'package:ready_made_4_trade/modules/receipts/bloc/receipts_cubit.dart';
import 'package:ready_made_4_trade/modules/receipts/pages/add_receipts.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class ReceiptsPage extends StatefulWidget {
  const ReceiptsPage({Key? key}) : super(key: key);

  @override
  State<ReceiptsPage> createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<ReceiptsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReceiptsCubit>(context).getReceipts();
  }

  File? _image1;
  final RemoteApi apiServices = RemoteApi();
  final StorageServices _servicesStorage = StorageServices();

  List<bool> _isCheckedList = List.generate(1000, (_) => false);

  List<String>? _imageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 180,
              height: 90,
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            BlocBuilder<ReceiptsCubit, ReceiptsState>(
              builder: (context, state) {
                if (state is ReceiptsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ReceiptsSuccess) {
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.model!.data.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final reversedIndex = state.model!.data.length - 1 - index;

                                return GestureDetector(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Image.network(
                                            '${state.model!.data[reversedIndex].filePath}/${state.model!.data[reversedIndex].image}',
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Image.network(
                                    '${state.model!.data[reversedIndex].filePath}/${state.model!.data[reversedIndex].image}',
                                  ),
                                );
                              },
                            ),
                          ),
                        ),


                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<ReceiptsCubit>(context).sendReceipts();
                          },
                          child: extraLongButton(context, 'SEND RECEIPTS'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await getImage(ImageSource.camera).then((value) {
                              setState(() {
                                if (_image1 == null) {
                                  setState(() {
                                    _image1 = File(value!.path);
                                  });
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddReceipts(image: _image1, )));
                              });
                            });
                          },
                          child: extraLongButton(context, 'ADD RECEIPTS'),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  );

                }
                if (state is ReceiptsFailure) {
                  return const Text('Something went wrong');
                }
                if (state is SendReceiptsInitial) {
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.model!.data.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isCheckedList[index] =
                                      !_isCheckedList[index];
                                      if (_isCheckedList[index]) {
                                        _imageList!
                                            .add(state.model!.data[index].image!);
                                      } else {
                                        int? indexVal = _imageList?.indexOf(
                                            state.model!.data[index].image!);
                                        if (indexVal != null) {
                                          _imageList!.removeAt(indexVal);
                                        }
                                      }
                                    });
                                  },
                                  child: Stack(children: <Widget>[
                                    Image.network(
                                        '${state.model!.data[index].filePath}/${state.model!.data[index].image}'),
                                    Checkbox(
                                      value: _isCheckedList[index],
                                      onChanged: (bool? value) {},
                                    ),
                                  ]),
                                );
                              }),
                        ),
                        GestureDetector(
                          onTap: () async {
                            AddProjectResponse? response = await apiServices
                                .sendReceipt(imageList: _imageList!);

                            if (response!.status!) {
                              Fluttertoast.showToast(
                                  msg: response.message!,
                                  backgroundColor: CustomColors.main,
                                  textColor: CustomColors.white,
                                  gravity: ToastGravity.CENTER);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ReceiptsPage()),
                                  (route) => false);
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Something went wrong, please try again',
                                  backgroundColor: CustomColors.main,
                                  textColor: CustomColors.white,
                                  gravity: ToastGravity.CENTER);
                            }
                          },
                          child: extraLongButton(context, 'SEND RECEIPTS'),
                        ),
                        SizedBox(height: 25,),
                      ],
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  void uploadReceipts() async {
    var uri = Uri.parse(
      "https://readymade4trade.omkatech.in/api/ReceiptAddImage",
    );

    var request = http.MultipartRequest("POST", uri);

    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');

    request.fields["user_id"] = userId!;


    final file = await http.MultipartFile.fromPath('image', _image1!.path);
    request.files.add(file);

    await request.send().then((response) async {
      debugPrint(response.statusCode.toString());
      debugPrint(response.toString());
      response.stream.transform(utf8.decoder).listen((value) async {
        debugPrint(value);
        /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        ));*/
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
