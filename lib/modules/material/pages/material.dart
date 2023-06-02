import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/home/widgets/common_widgets.dart';
import 'package:ready_made_4_trade/modules/material/bloc/material_cubit.dart';
import 'package:ready_made_4_trade/widgets/bottom_bar_for_all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MaterialHomePage extends StatefulWidget {
  const MaterialHomePage({Key? key}) : super(key: key);

  @override
  State<MaterialHomePage> createState() => _MaterialHomePageState();
}

class _MaterialHomePageState extends State<MaterialHomePage> {
  final TextEditingController _search = TextEditingController();

  launchUrlInChrome(String url) async {
    final chromeUrl = 'googlechrome://$url';
    if (await canLaunch(chromeUrl)) {
      await launch(chromeUrl);
    } else {
      // Chrome is not installed. Fall back to the default URL launcher.
      await launch(url);
    }
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<MaterialCubit>(context).getMaterials();
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double oneLogicalPixelInPhysicalPixels = 1 / devicePixelRatio;
    return Scaffold(
      backgroundColor: CustomColors.bodyColor,
      appBar: AppBar(
        toolbarHeight: 200 * oneLogicalPixelInPhysicalPixels,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 8 * oneLogicalPixelInPhysicalPixels,
            ),
            SizedBox(
              width: 160,
              height: 75,
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
                _search.clear();
                BlocProvider.of<MaterialCubit>(context).getMaterials();
              }
            : null,
      ),
      body: BlocBuilder<MaterialCubit, MaterialPageState>(
        builder: (context, state) {
          if (state is MaterialSuccess) {
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
                            BlocProvider.of<MaterialCubit>(context)
                                .getMaterialSearch(_search.text);
                          },
                          hintText: 'Search Stockist',
                          theme: Theme.of(context),
                          controller: _search,
                        ))
                      ],
                    ),
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
                            launchUrlInChrome(state.model!.data[index].url!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    child: Image.network(
                                      '${state.model!.data[index].filePath}/${state.model!.data[index].materialImage}',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.model!.data[index].materialName!,
                                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.primeColour),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )

                        );
                      })
                ],
              ),
            );
          }

          if (state is MaterialSearchSuccess) {
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
                            BlocProvider.of<MaterialCubit>(context)
                                .getMaterialSearch(_search.text);
                          },
                          hintText: 'Search Stockist',
                          theme: Theme.of(context),
                          controller: _search,
                        ))
                      ],
                    ),
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
                            launchUrlString(state.model!.data[index].url!,
                                mode: LaunchMode.externalApplication);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    child: Image.network(
                                      '${state.model!.data[index].filePath}/${state.model!.data[index].materialImage}',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.model!.data[index].materialName!,
                                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.primeColour),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )

                        );
                      })
                ],
              ),
            );
          }

          if (state is MaterialLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MaterialFailure) {
            return const Center(child: Text('Something went Wrong'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
