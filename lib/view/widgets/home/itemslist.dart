import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/databasetranslation.dart';
import 'package:sire/data/model/itemsmodel.dart';

class ItemsList extends GetView<HomeControllerImp> {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: controller.items.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.524,
        ),
        itemBuilder: (context, index) =>
            Items(itemsModel: ItemsModel.fromJson(controller.items[index])));
  }
}

class Items extends StatelessWidget {
  final ItemsModel itemsModel;
  const Items({super.key, required this.itemsModel});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Appcolor.hotPink,
      Appcolor.pink,
      Appcolor.purple,
      Appcolor.deepPurple,
      Appcolor.indigo,
      Appcolor.blue,
      Appcolor.cyan,
      Appcolor.teal,
      Appcolor.green,
      Appcolor.lightGreen,
      Appcolor.deepOrange,
      Appcolor.amber,
      Appcolor.yellow,
      Appcolor.brown,
      Appcolor.greyShade,
      Appcolor.charcoalGray,
      Appcolor.indigoBlue,
      Appcolor.skyBlue,
      Appcolor.blueGray,
    ];
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 300,
              width: 180,
              decoration: BoxDecoration(
                  color: Color(0xff3b2a2c),
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 300,
              width: 180,
              child: Center(
                child: Image.network(AppLink.itemimage + itemsModel.itemImg!),
              ),
            )
          ],
        ),
        SizedBox(
            width: 180,
            child: Text(databaseTranslation(itemsModel.itemName!,
                itemsModel.itemNameAr!, itemsModel.itemNameEs!))),
        SizedBox(
            width: 180,
            child: Row(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                        speed: Duration(seconds: 20),
                        ("\$${itemsModel.itemFinalPrice}"),
                        textStyle: TextStyle(fontSize: 20.0, fontFamily: "Sw"),
                        colors: colors),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
                SizedBox(width: 5),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    "\$${itemsModel.itemPrice}",
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "Sw"),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
