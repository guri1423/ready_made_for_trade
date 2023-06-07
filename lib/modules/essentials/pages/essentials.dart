import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/essentials/bloc/essential_bloc_cubit.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EssentialsPage extends StatefulWidget {
  const EssentialsPage({Key? key}) : super(key: key);

  @override
  State<EssentialsPage> createState() => _EssentialsPageState();
}

class _EssentialsPageState extends State<EssentialsPage> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<EssentialBlocCubit>(context).getAllMaterials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
    return Scaffold(
        backgroundColor: CustomColors.bodyColor,
        appBar: AppBar(
          toolbarHeight: 150 * oneLogicalPixelInPhysicalPixels,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 8 * oneLogicalPixelInPhysicalPixels,
              ),
              SizedBox(
                width: 135,
                height: 45,
                child: Image.asset(
                  'assets/images/final Logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: Image.asset('assets/images/updated_images/012-bell.png'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomToolsForInsidePage(
          onBackPress: _search.text.isNotEmpty
              ? () {
                  BlocProvider.of<EssentialBlocCubit>(context)
                      .getAllMaterials();
                }
              : null,
        ),
        body: BlocBuilder<EssentialBlocCubit, EssentialBlocState>(
          builder: (context, state) {
            if (state is EssentialBlocSuccess) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: customerSearchBarWidget(
                            context,
                            onTap: () {
                              BlocProvider.of<EssentialBlocCubit>(context)
                                  .getSearchEssential(_search.text);
                            },
                            hintText: 'Search Stockist',
                            theme: Theme.of(context),
                            controller: _search,
                          ))
                        ],
                      ),
                    ),
                    /*Row(
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                isDense: true,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              buttonHeight: 49,
                              buttonWidth: MediaQuery.of(context).size.width,
                              buttonDecoration: BoxDecoration(
                                color: CustomColors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: CustomColors.textFieldBorderColor,
                                  width: 1,
                                ),
                              ),
                              itemPadding: EdgeInsets.symmetric(horizontal: 15),
                              itemHeight:
                                  MediaQuery.of(context).size.height * 0.056,
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: CustomColors.primeColour,
                                ),
                              ),
                              iconOnClick: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: CustomColors.primeColour,
                                ),
                              ),
                              hint: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'Trade',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color:
                                              CustomColors.textFieldTextColour),
                                ),
                              ),
                              items: [],
                            ),
                          ),
                        ),
                      ],
                    ),*/
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: state.model!.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 3,
                                mainAxisExtent: 160,
                            ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              launchUrlString(state.model!.data[index].link!,
                                  mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 14),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: Image.network(
                                        '${state.model!.data[index].filePath!}/${state.model!.data[index].image}',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Text(
                                        state.model!.data[index].name!,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: CustomColors.primeColour),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              );
            }

            if (state is EssentialBlocLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is EssentialBlocFailure) {
              return const Text('Something went wrong');
            }
            if (state is EssentialSearchSuccess) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: customerSearchBarWidget(
                            context,
                            onTap: () {
                              BlocProvider.of<EssentialBlocCubit>(context)
                                  .getSearchEssential(_search.text);
                            },
                            hintText: 'Search Stockist',
                            theme: Theme.of(context),
                            controller: _search,
                          ))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                isDense: true,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              buttonHeight: 49,
                              buttonWidth: MediaQuery.of(context).size.width,
                              buttonDecoration: BoxDecoration(
                                color: CustomColors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: CustomColors.textFieldBorderColor,
                                  width: 1,
                                ),
                              ),
                              itemPadding: EdgeInsets.symmetric(horizontal: 15),
                              itemHeight:
                                  MediaQuery.of(context).size.height * 0.056,
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: CustomColors.primeColour,
                                ),
                              ),
                              iconOnClick: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: CustomColors.primeColour,
                                ),
                              ),
                              hint: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'Trade',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color:
                                              CustomColors.textFieldTextColour),
                                ),
                              ),
                              items: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: state.model!.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 3,
                                mainAxisExtent: 160),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              launchUrlString(state.model!.data[index].link!);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: GestureDetector(
                                        onTap: () async{
                                          final chromeUrl = state.model!.data[index].link!;
                                          if (await canLaunch(chromeUrl)) {
                                            await launch(chromeUrl);
                                          } else {
                                            // Chrome is not installed. Fall back to the default URL launcher.
                                            throw 'Could not launch $chromeUrl';
                                          }
                                          /* launchUrlInChrome(state.model!.data[index].url!);*/
                                          /*launchUrlString(state.model!.data[index].url!);*/
                                        },
                                        child: Image.network(
                                            '${state.model!.data[index].filePath!}/${state.model!.data[index].image}',
                                          fit: BoxFit.fitHeight,),
                                      ),
                                    ),
                                    Text(
                                      state.model!.data[index].name!,
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: CustomColors.primeColour,fontSize: 7),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              );
            }

            if (state is EssentialSearchLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is EssentialSearchFailure) {
              return const Center(child: Text('Something went wrong'));
            }

            if (state is EssentialSearchEmpty) {
              return const Center(child: Text('No result Found'));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
