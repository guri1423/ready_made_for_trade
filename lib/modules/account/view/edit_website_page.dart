import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/account/cubit/edit_website_text/edit_website_text_cubit.dart';
import 'package:ready_made_4_trade/modules/account/model/website_text_model.dart';
import 'package:ready_made_4_trade/modules/customer/pages/customer_page/add_customer.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';

class EditWebsitePage extends StatefulWidget {
  const EditWebsitePage({Key? key}) : super(key: key);

  @override
  State<EditWebsitePage> createState() => _EditWebsitePageState();
}

class _EditWebsitePageState extends State<EditWebsitePage> {
  TextEditingController homeTitle = TextEditingController();
  TextEditingController homeMsg = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController aboutMsg = TextEditingController();
  TextEditingController service = TextEditingController();
  TextEditingController serviceMsg = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<EditWebsiteTextCubit>(context).getWebsiteText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomToolsForInsidePage(
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocListener<EditWebsiteTextCubit, EditWebsiteTextState>(
          listener: (context, state) {
            if (state is EditWebsiteTextLoaded) {
              homeTitle =
                  TextEditingController(text: state.data.data!.homeTitle);
              homeMsg =
                  TextEditingController(text: state.data.data!.homeDescription);
              about = TextEditingController(text: state.data.data!.aboutTitle);
              aboutMsg = TextEditingController(
                  text: state.data.data!.aboutDescription);
              service =
                  TextEditingController(text: state.data.data!.servicesTitle);
              serviceMsg = TextEditingController(
                  text: state.data.data!.servicesDescription);
            }
          },
          child: BlocBuilder<EditWebsiteTextCubit, EditWebsiteTextState>(
            builder: (context, state) {
              if (state is EditWebsiteTextLoaded) {
                return loadedBody(state.data);
              }
              if (state is EditWebsiteTextUpdateLoading) {
                return Stack(
                  children: [
                    loadedBody(state.data),
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  loadedBody(GetWebsiteTextModel model) {
    ThemeData theme = Theme.of(context);
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                'HOME',
                style: theme.textTheme.titleLarge!
                    .copyWith(color: CustomColors.primeColour),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: SizedBox(
                  height: 40,
                  child: customTextFieldForm(
                    context,
                    controller: homeTitle,
                    hintText: 'Home Title',
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        customTextFieldForm(
          context,
          controller: homeMsg,
          isBig: true,
          hintText: '',
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                'ABOUT',
                style: theme.textTheme.titleLarge!
                    .copyWith(color: CustomColors.primeColour),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: SizedBox(
                  height: 40,
                  child: customTextFieldForm(
                    context,
                    controller: about,
                    hintText: 'About Title',
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        customTextFieldForm(
          context,
          controller: aboutMsg,
          isBig: true,
          hintText: '',
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                'SERVICES',
                style: theme.textTheme.titleLarge!
                    .copyWith(color: CustomColors.primeColour),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: SizedBox(
                  height: 40,
                  child: customTextFieldForm(
                    context,
                    controller: service,
                    hintText: 'Services Title',
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        customTextFieldForm(
          context,
          controller: serviceMsg,
          isBig: true,
          hintText: '',
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'THEME COLOURS',
              style: theme.textTheme.titleLarge!
                  .copyWith(color: CustomColors.primeColour),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.red),
            ),
          ],
        ),
        /* SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: themeColors.length,
            separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
            itemBuilder: (context, index) {
              return Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: themeColors[index]),
              );
            },
          ),
        ),*/
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<EditWebsiteTextCubit>(context)
                      .updateWebsiteText(
                          editData: EditWebsiteData(
                              userId: model.data!.userId,
                              homeTitle: homeTitle.text,
                              homeDescription: homeMsg.text,
                              aboutTitle: about.text,
                              aboutDescription: aboutMsg.text,
                              servicesTitle: service.text,
                              servicesDescription: serviceMsg.text,
                              themeColours: 'red'));
                },
                child: SizedBox(
                    height: 40,
                    child: smallButton(
                        context, 'SAVE', CustomColors.primeColour, 50)),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: SizedBox(
                    height: 40,
                    child: smallButton(
                        context, 'CLEAR', CustomColors.greyButton, 50)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {},
          child: SizedBox(
              height: 40,
              child: smallButton(context, 'GET A PROFESSIONAL WEBSITE',
                  CustomColors.primeColour, 50)),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

List<Color> themeColors = [
  const Color.fromRGBO(0, 29, 255, 1),
  const Color.fromRGBO(137, 4, 255, 1),
  const Color.fromRGBO(255, 0, 0, 1),
  const Color.fromRGBO(255, 98, 0, 1),
  const Color.fromRGBO(255, 235, 0, 1),
  const Color.fromRGBO(51, 216, 29, 1),
  const Color.fromRGBO(0, 0, 0, 1),
  const Color.fromRGBO(250, 13, 186, 1),
];
