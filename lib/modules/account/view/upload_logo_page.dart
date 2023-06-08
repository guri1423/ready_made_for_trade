import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class UploadLogoPage extends StatefulWidget {
  const UploadLogoPage({Key? key}) : super(key: key);

  @override
  State<UploadLogoPage> createState() => _UploadLogoPageState();
}

class _UploadLogoPageState extends State<UploadLogoPage> {
  final RemoteApi remoteApi = RemoteApi();
  File? imageFile;
  bool isLoading = false;

  Future<File?> pickImageFromGallery() async {
    setState(() {
      isLoading = true;
    });
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      bool status = await remoteApi.uploadLogo(file: imageFile!);
      if (status) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }

      return imageFile;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
                onTap: () {},
                child: extraLongButton(context, 'GET A PROFESSIONAL LOGO')),
          ),
          BottomToolsForInsidePage(
            onBackPress: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: CustomColors.primeColour,
                      borderRadius: BorderRadius.circular(5)),
                  child: imageFile != null
                      ? Center(
                          child: Image.file(imageFile!),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          pickImageFromGallery();
                        },
                        child: SizedBox(
                            height: 40,
                            child: smallButton(context, 'UPLOAD',
                                CustomColors.primeColour, 50)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            imageFile = null;
                          });
                        },
                        child: SizedBox(
                            height: 40,
                            child: smallButton(context, 'DELETE',
                                CustomColors.greyButton, 50)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
            Visibility(
              visible: isLoading,
              child: const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
