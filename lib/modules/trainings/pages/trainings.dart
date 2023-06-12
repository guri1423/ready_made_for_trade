import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/trainings/bloc/training_cubit.dart';
import 'package:ready_made_4_trade/modules/youtube/pages/video_player.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class TrainingsPage extends StatefulWidget {
  const TrainingsPage({Key? key}) : super(key: key);

  @override
  State<TrainingsPage> createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
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
                      Map<String, String> map = {};
                      String jsonString =
                          state.trainingStatus!.data.checkTrainingstatus;
                      jsonString =
                          jsonString.replaceAll('{', '').replaceAll('}', '');

                      List<String> keyValuePairs = jsonString.split(',');
                      for (var keyValuePair in keyValuePairs) {
                        List<String> parts = keyValuePair.trim().split(':');
                        if (parts.length == 2) {
                          String key = parts[0].trim();
                          String value = parts[1].trim();
                          map[key] = value;
                        }
                      }
                      if (map.containsKey(
                              state.model!.data[index].id.toString()) &&
                          map[state.model!.data[index].id.toString()] != null &&
                          map[state.model!.data[index].id.toString()] == "1") {
                        _isCheckedList[state.model!.data[index].id!] = true;
                      } else {
                        _isCheckedList[state.model!.data[index].id!] = false;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoPage(
                                                videoLink: state
                                                        .model!
                                                        .data[index]
                                                        .videoLink ??
                                                    '',
                                                description: state
                                                        .model!
                                                        .data[index]
                                                        .description ??
                                                    "",
                                            url: state.model!.data[index].url ?? '',
                                              )));
                                  setState(() {
                                    _isCheckedList[
                                        state.model!.data[index].id!] = true;
                                    map[state.model!.data[index].id!
                                            .toString()] =
                                        getStatus(_isCheckedList[
                                            state.model!.data[index].id!]);
                                    if (userId != null) {
                                      BlocProvider.of<TrainingCubit>(context)
                                          .storeTrainingUpdate(
                                              status: map,
                                              userID: userId!,
                                              customerId: userId!);
                                    }
                                  });
                                },
                                child: extraLongButton(
                                    context, state.model!.data[index].title!),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Transform.scale(
                              scale: 2.3,
                              child: Checkbox(
                                checkColor: CustomColors.primeColour,
                                activeColor: CustomColors.white,
                                value: _isCheckedList[
                                    state.model!.data[index].id!],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isCheckedList[
                                            state.model!.data[index].id!] =
                                        !_isCheckedList[
                                            state.model!.data[index].id!];
                                    map[state.model!.data[index].id!
                                            .toString()] =
                                        getStatus(_isCheckedList[
                                            state.model!.data[index].id!]);
                                    if (userId != null) {
                                      BlocProvider.of<TrainingCubit>(context)
                                          .storeTrainingUpdate(
                                              status: map,
                                              userID: userId!,
                                              customerId: userId!);
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
