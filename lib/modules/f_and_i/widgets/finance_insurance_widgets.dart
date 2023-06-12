import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';
import 'package:ready_made_4_trade/modules/f_and_i/model/finance_insurnace_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget viewFinanceAndInsurance(context, List<Datum> data) {
  ThemeData theme = Theme.of(context);
  return Expanded(
    child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            launchUrlString(data[index].link,
                mode: LaunchMode.externalApplication);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.white,
                              ),
                              child: Image.network(
                                  '${data[index].filePath}/${data[index].image}'),
                          ),
                        ),
                       /* Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Text(data[index].category,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: CustomColors.primeColour),
                          ),
                        ),*/
                        Column(
                          children: [
                             Padding(
                              padding: const EdgeInsets.only(top: 40, left: 20),
                              child: Text(data[index].category,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: CustomColors.primeColour),
                          ),
                        ),
                            Padding(
                              padding: EdgeInsets.only(top: 8, left: 20),
                              child: Text(data[index].categoryTwo,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                    color: CustomColors.primeColour,fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        data[index].description,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: CustomColors.textFieldTextColour,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
