import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/gallery/models/get_gallery_images.dart';
import 'package:ready_made_4_trade/modules/gallery/models/project_response_model.dart';
import 'package:ready_made_4_trade/modules/gallery/pages/projects.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/services/storage.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class CreateProject extends StatefulWidget {
  CreateProject(
      {Key? key,
      this.projectId,
      this.projctName,
      this.isComingFromEditProject = false})
      : super(key: key);

  String? projectId;
  String? projctName;
  bool isComingFromEditProject;

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final RemoteApi apiServices = RemoteApi();

  List<bool> _isCheckedList = List.generate(1000, (_) => false);

  TextEditingController _projectName = TextEditingController();

  List<String>? _imageList = [];

  StorageServices _storageServices = StorageServices();

  getProjectName() {
    _projectName = TextEditingController()..text = widget.projctName ?? "";
  }

  @override
  void initState() {
    getProjectName();
    super.initState();
  }

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
            FutureBuilder<GetGalleryImages?>(
                future: apiServices.getGalleryImages(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.data.length,
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
                                        .add(snapshot.data!.data[index].image!);
                                  } else {
                                    int? indexVal = _imageList?.indexOf(
                                        snapshot.data!.data[index].image!);
                                    if (indexVal != null) {
                                      _imageList!.removeAt(indexVal);
                                    }
                                  }
                                });
                              },
                              child: Stack(children: <Widget>[
                                Image.network(
                                    '${snapshot.data!.data[index].filePath}/${snapshot.data!.data[index].image}'),
                                Checkbox(
                                  value: _isCheckedList[index],
                                  onChanged: (bool? value) {},
                                ),
                              ]),
                            );
                          }),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went Wrong'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            customTextFieldForm(context,
                controller: _projectName, hintText: 'Enter Project Name'),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () async {
                  if (widget.isComingFromEditProject) {
                    debugPrint('coming from edit project');

                    AddProjectResponse? response =
                        await apiServices.editProject(
                            imageList: _imageList!,
                            projectTitle: _projectName.text,
                            projectId: widget.projectId!.toString());

                    if (response!.status!) {
                      Fluttertoast.showToast(
                          msg: response.message!,
                          backgroundColor: CustomColors.main,
                          textColor: CustomColors.white,
                          gravity: ToastGravity.CENTER);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProjectsPage()),
                          (route) => false);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Something went wrong, please try again',
                          backgroundColor: CustomColors.main,
                          textColor: CustomColors.white,
                          gravity: ToastGravity.CENTER);
                    }
                  } else {
                    AddProjectResponse? response = await apiServices.addProject(
                        imageList: _imageList!,
                        projectTitle: _projectName.text);

                    if (response!.status!) {
                      Fluttertoast.showToast(
                          msg: response.message!,
                          backgroundColor: CustomColors.main,
                          textColor: CustomColors.white,
                          gravity: ToastGravity.CENTER);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProjectsPage()),
                          (route) => false);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Something went wrong, please try again',
                          backgroundColor: CustomColors.main,
                          textColor: CustomColors.white,
                          gravity: ToastGravity.CENTER);
                    }
                  }
                },
                child: extraLongButton(context, 'CREATE PROJECT')),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
