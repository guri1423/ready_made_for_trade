import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_model.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: FutureBuilder<GetChecklist?>(
          future: _remoteApi.getChecklist(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: extraLongButton(context,
                                  snapshot.data!.data[index].checklistName!)),
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
                                    _remoteApi.updateChecklistStatus(
                                        userID: userId!,
                                        status: {
                                          "$index":
                                              getStatus(_isCheckedList[index])
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

            if (snapshot.hasError) {
              Center(
                child: Text('Something went wrong--${snapshot.error}'),
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
}

String getStatus(bool status) {
  if (status) {
    return "1";
  } else {
    return "0";
  }
}
