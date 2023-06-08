import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/trainings/bloc/training_cubit.dart';
import 'package:ready_made_4_trade/modules/trainings/models/get_trainings_model.dart';
import 'package:ready_made_4_trade/modules/youtube/pages/video_player.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TrainingsPage extends StatefulWidget {
  const TrainingsPage({Key? key}) : super(key: key);

  @override
  State<TrainingsPage> createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
   //GetChecklist model = GetChecklist(data: [], message: '', status: true);
  late GetAllTrainings data;
  bool isChecked = false;
  String? userId;
  final StorageServices _storageServices = StorageServices();

  final List<bool> _isCheckedList = List.generate(1000, (_) => false);

  getUserId() async {
    userId = await _storageServices.getUserId();
    BlocProvider.of<TrainingCubit>(context)
        .getAllTrainings(userID: userId ?? '');
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
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
                      String jsonString =
                          state.trainingStatus!.data.checkTrainingstatus;

                      Map<int, int> map = {};

                      jsonString =
                          jsonString.substring(1, jsonString.length - 1);

                      List<String> keyValuePairs = jsonString.split(':');

                      for (int i = 0; i < keyValuePairs.length; i += 2) {
                        int key = int.parse(keyValuePairs[i].trim());
                        int value = int.parse(keyValuePairs[i + 1].trim());
                        map[key] = value;
                      }
                      if (map.containsKey(index) && map[index] == 1) {
                        _isCheckedList[index] = _isCheckedList[index];
                      }
                      _isCheckedList[index] = map[index] == 1 ? true : false;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  /*Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context)=>
                                              videoPage(videolink: state,description: state,)));*/
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
                        ),
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
