import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/trainings/bloc/training_cubit.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TrainingsPage extends StatefulWidget {
  const TrainingsPage({Key? key}) : super(key: key);

  @override
  State<TrainingsPage> createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
  bool isChecked = false;
  String? userId;
  final StorageServices _storageServices = StorageServices();

  List<bool> _isCheckedList = List.generate(1000, (_) => false);

  getUserId() async {
    userId = await _storageServices.getUserId();
  }

  @override
  void initState() {
    super.initState();
    getUserId();

    BlocProvider.of<TrainingCubit>(context).getAllTrainings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
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
      body: BlocBuilder<TrainingCubit, TrainingState>(
        builder: (context, state) {
          if (state is TrainingSuccess) {
            return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.model!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                launchUrlString(
                                    state.model!.data[index].videoLink!);
                              },
                              child: extraLongButton(
                                  context, state.model!.data[index].title!),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              checkColor: CustomColors.primeColour,
                              activeColor: CustomColors.white,
                              value: _isCheckedList[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedList[index] =
                                      !_isCheckedList[index];
                                  if (userId != null) {
                                    BlocProvider.of<TrainingCubit>(context)
                                        .storeTrainingUpdate(status: {
                                      "$index": getStatus(_isCheckedList[index])
                                    }, userID: userId!, customerId: userId!);
                                  }

                                  // print(_isCheckedList[index]);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }));
          }

          if (state is TrainingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TrainingFailure) {
            return const Center(child: Text('Something went wrong'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  String getStatus(bool status) {
    if (status) {
      return "1";
    } else {
      return "0";
    }
  }
}
