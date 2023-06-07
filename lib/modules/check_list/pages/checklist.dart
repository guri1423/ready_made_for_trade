import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/check_list/cubit/check_list_cubit.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/youtube/pages/video_player.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class ChecklistPage extends StatefulWidget {
   ChecklistPage({Key? key}) : super(key: key);

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
    BlocProvider.of<CheckListCubit>(context).getAllChecklist();
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 200 * oneLogicalPixelInPhysicalPixels,
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: BlocBuilder<CheckListCubit, CheckListState>(
          builder: (context, CheckListState state) {
            if (state is CheckListLoaded) {
              return loadedBody(state.data);
            }
            if (state is CheckListUpdateLoading) {
              return Stack(
                children: [
                  loadedBody(state.data),
                  const Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.white,
                    ),
                  )
                ],
              );
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

  Widget loadedBody(GetChecklist data) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.data.length,
        itemBuilder: (BuildContext context, int index) {
          Map<int, String> map = {};
          for (int i = 0; i < data.data.length; i++) {
            int key = data.data[i].id!;
            String value = data.data[i].status!;
            map[key] = value;
          }
          _isCheckedList[index] =
              map[data.data[index].id!] == "1" ? true : false;
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>
                                videoPage(videolink: data,description: data,)));
                      },
                      child: extraLongButton(
                          context, data.data[index].checklistName!),
                    )),
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
                        _isCheckedList[index] = !_isCheckedList[index];
                        if (userId != null) {
                          BlocProvider.of<CheckListCubit>(context)
                              .updateCheckListStatus(userId: userId!, status: {
                            "$index": getStatus(_isCheckedList[index])
                          });
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
