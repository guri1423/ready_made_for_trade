import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/customers.dart';
import 'package:ready_made_4_trade/modules/check_list/pages/checklist.dart';
import 'package:ready_made_4_trade/modules/home/bloc/bloc_home/home_cubit.dart';
import 'package:ready_made_4_trade/modules/dairy/pages/diary.dart';
import 'package:ready_made_4_trade/modules/essentials/pages/essentials.dart';
import 'package:ready_made_4_trade/modules/f_and_i/pages/fAndI.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/gallery.dart';
import 'package:ready_made_4_trade/modules/home/model/home_image_model.dart';
import 'package:ready_made_4_trade/modules/home/pages/home_image_page.dart';
import 'package:ready_made_4_trade/modules/jobs/pages/jobs.dart';
import 'package:ready_made_4_trade/modules/receipts/pages/receipts.dart';
import 'package:ready_made_4_trade/modules/material/pages/material.dart';
import 'package:ready_made_4_trade/modules/trades/pages/trades.dart';
import 'package:ready_made_4_trade/modules/trainings/pages/trainings.dart';
import 'package:ready_made_4_trade/modules/home/widgets/home_widgets.dart';
import '../../../services/remote_api.dart';
import '../../../services/storage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeImage? model;
  File? _image1;
  final RemoteApi apiServices = RemoteApi();
  final StorageServices _servicesStorage = StorageServices();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getUserData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _attachScrollController();
    });
  }

  void _attachScrollController() {
    _scrollController = ScrollController();
    setState(() {}); // Trigger a rebuild to attach the ScrollController
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;

    const SizedBox sizedBox = SizedBox(height: 8);

    ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: Colors.white,
          elevation: 0,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeSuccess) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            state.model?.data.fullName ?? '',
                                            softWrap: true,
                                            style: theme.textTheme.titleLarge!
                                                .copyWith(
                                              color: CustomColors.primeColour,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          sizedBox,
                                          Text(
                                            state.model?.data.businessName ??
                                                '',
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                              color: CustomColors.primeColour,
                                            ),
                                          ),
                                          sizedBox,
                                          Row(
                                            children: [
                                              Text(
                                                state.model?.data.currentMonth ??
                                                    '',
                                                style: theme.textTheme.titleMedium!
                                                    .copyWith(
                                                        color: CustomColors
                                                            .primeColour),
                                              ),
                                              Text(',', style: theme.textTheme.titleSmall!
                                                  .copyWith(
                                                color: CustomColors.primeColour,),
                                              ),
                                              Text(
                                                state.model?.data.currentYear ??
                                                    '',
                                                style: theme.textTheme.titleMedium!
                                                    .copyWith(
                                                    color: CustomColors
                                                        .primeColour),
                                              ),
                                            ],
                                          ),
                                          sizedBox,
                                          if (state.model?.data
                                                  .currentMonthPrice !=
                                              null)
                                            Row(
                                              children: [
                                                Text(
                                                  '£',
                                                  style: theme
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                          color: CustomColors
                                                              .skyblue),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  state.model!.data
                                                      .currentMonthPrice
                                                      .toString(),
                                                  style: theme
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                          color: CustomColors
                                                              .skyblue),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      width: 140,
                                      child: Container(
                                        child: state.model?.data.logo != null
                                            ? Image.network(
                                                '${state.model!.data.filePath}/${state.model!.data.logo}',
                                                fit: BoxFit.fill,
                                              )
                                            : SizedBox(),
                                        // Show an empty SizedBox if logo is null
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                Container(
                                  height: 60,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _scrollController.animateTo(
                                            _scrollController.offset - 150,
                                            // Adjust the scroll distance as needed
                                            curve: Curves.ease,
                                            duration:
                                                Duration(milliseconds: 300),
                                          );
                                        },
                                        child: Image.asset(
                                            'assets/images/Path 8242.png'),
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state
                                              .model!.data.statusCounts!.length,
                                          itemBuilder: (context, int index) {
                                            final item = state.model!.data
                                                .statusCounts![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: SizedBox(
                                                height: 65,
                                                width: 120,
                                                child: Container(

                                                  decoration: BoxDecoration(
                                                    color: CustomColors.primeColour,
                                                    border: Border.all(
                                                      color: CustomColors
                                                          .greyButton,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        item.noCount!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(),
                                                      ),
                                                      Text(
                                                        item.title!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _scrollController.animateTo(
                                            _scrollController.offset + 150,
                                            // Adjust the scroll distance as needed
                                            curve: Curves.ease,
                                            duration:
                                                Duration(milliseconds: 300),
                                          );
                                        },
                                        child: Image.asset(
                                            'assets/images/right direction.png'),
                                      ),
                                    ],
                                  ),
                                ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //   children: [
                                //     Image.asset('assets/images/Path 8242.png'),
                                //     SizedBox(
                                //       height: 65,
                                //       width: 150,
                                //       child: Container(
                                //         decoration: BoxDecoration(
                                //           border: Border.all(
                                //             color: CustomColors.greyButton,
                                //             width: 1.0,
                                //           ),
                                //           borderRadius: BorderRadius.circular(10),
                                //         ),
                                //         child: Column(
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             Text(
                                //               state.model!.data.statusCounts![0].noCount!,
                                //               style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                //                 color: CustomColors.primeColour,
                                //               ),
                                //             ),
                                //             Text(
                                //               state.model!.data.statusCounts![0].title!,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .titleSmall!
                                //                   .copyWith(color: CustomColors.primeColour),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       height: 65,
                                //       width: 150,
                                //       child: Container(
                                //         decoration: BoxDecoration(
                                //           border: Border.all(
                                //             color: CustomColors.greyButton,
                                //             width: 1.0,
                                //           ),
                                //           borderRadius: BorderRadius.circular(10),
                                //         ),
                                //         child: Column(
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             Text(
                                //               state.model!.data.statusCounts![1].noCount!,
                                //               style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                //                 color: CustomColors.primeColour,
                                //               ),
                                //             ),
                                //             Text(
                                //               state.model!.data.statusCounts![1].title!,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .titleSmall!
                                //                   .copyWith(color: CustomColors.primeColour),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //     Image.asset('assets/images/right direction.png'),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HomeFailure) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                    itemCount: images.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          await onTapHandling(index, context);
                        },
                        child: Container(
                          height: 45,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  height: 40,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Image.asset(images[index]),
                                  )),
                              Text(
                                iconNames[index],
                                style: const TextStyle(
                                  color: CustomColors.primeColour,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                HomePageImages(),
              ],
            ),
          ),
        ));
  }

  Future<void> onTapHandling(int index, BuildContext context) async {
    switch (index) {
      case 0:
        await getImage(ImageSource.camera).then((value) {
          setState(() {
            setState(() {
              if (_image1 == null) {
                setState(() {
                  _image1 = File(value!.path);
                });
              }
            });

            uploadCollectionData();
          });
        });

        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GalleryPage()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CustomersPage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => JobsPage()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryPage()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MaterialHomePage()));
        break;
      case 6:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TradesPage()));
        break;
      case 7:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChecklistPage()));
        break;
      case 8:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FAndIPage()));
        break;
      case 9:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReceiptsPage()));
        break;
      case 10:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EssentialsPage()));
        break;
      case 11:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TrainingsPage()));
        break;
    }
  }

  void uploadCollectionData() async {
    var uri = Uri.parse(
      "https://readymade4trade.omkatech.in/api/CameraImageAdd",
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
