import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/check_list/cubit/check_list_cubit.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_model.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_status_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/youtube/pages/video_player.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({Key? key}) : super(key: key);

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

RemoteApi _remoteApi = RemoteApi();
String? userId;
final StorageServices _storageServices = StorageServices();
bool isChecked = false;

List<bool> _isCheckedList = List.generate(1000, (_) => false);

class _ChecklistPageState extends State<ChecklistPage> {
  getUserId() async {
    userId = await _storageServices.getUserId();
    BlocProvider.of<CheckListCubit>(context)
        .getAllChecklist(userID: userId ?? "");
  }

  @override
  void initState() {
    getUserId();
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: BlocBuilder<CheckListCubit, CheckListState>(
          builder: (context, CheckListState state) {
            if (state is CheckListLoaded) {
              return loadedBody(state.data, state.checklistStatus);
            }

            if (state is CheckListFailure) {
              return const Center(
                child: Text("something went wrong!"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget loadedBody(GetChecklist data, UserChecklistStatus checklistStatus) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.data.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, String> map = {};
          String jsonString = checklistStatus.data.checkliststatus;
          jsonString = jsonString.replaceAll('{', '').replaceAll('}', '');

          List<String> keyValuePairs = jsonString.split(',');
          for (var keyValuePair in keyValuePairs) {
            List<String> parts = keyValuePair.trim().split(':');
            if (parts.length == 2) {
              String key = parts[0].trim();
              String value = parts[1].trim();
              map[key] = value;
            }
          }
          if (map.containsKey(data.data[index].id.toString()) &&
              map[data.data[index].id.toString()] != null &&
              map[data.data[index].id.toString()] == "1") {
            _isCheckedList[data.data[index].id!] = true;
          } else {
            _isCheckedList[data.data[index].id!] = false;
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoPage(
                                  videoLink: data.data[index].videolink ?? '',
                                  description:
                                      data.data[index].description ?? "",
                                  url: data.data[index].url ?? '',
                                )));
                    setState(() {
                      _isCheckedList[data.data[index].id!] = true;
                      map[data.data[index].id!.toString()] =
                          getStatus(_isCheckedList[data.data[index].id!]);
                      if (userId != null) {
                        BlocProvider.of<CheckListCubit>(context)
                            .updateCheckListStatus(
                          status: map,
                          userId: userId!,
                        );
                      }
                    });
                  },
                  child:
                      extraLongButton(context, data.data[index].checklistName!),
                )),
                const SizedBox(
                  width: 12,
                ),
                Transform.scale(
                  scale: 2.35,
                  child: Checkbox(
                    checkColor: CustomColors.primeColour,
                    activeColor: CustomColors.white,
                    value: _isCheckedList[data.data[index].id!],
                    onChanged: (bool? value) {
                      setState(() {
                        _isCheckedList[data.data[index].id!] =
                            !_isCheckedList[data.data[index].id!];
                        map[data.data[index].id!.toString()] =
                            getStatus(_isCheckedList[data.data[index].id!]);
                        if (userId != null) {
                          BlocProvider.of<CheckListCubit>(context)
                              .updateCheckListStatus(
                            status: map,
                            userId: userId!,
                          );
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

String getStatus(bool status) {
  if (status) {
    return "1";
  } else {
    return "0";
  }
}
