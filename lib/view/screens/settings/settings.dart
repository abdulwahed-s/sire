import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sire/controller/setting/settingcontroller.dart';
import 'package:sire/core/constant/color.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    SettingControllerImp controller = Get.put(SettingControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(160),
                    image: DecorationImage(
                        image: NetworkImage(
                          "https://i.pinimg.com/736x/ac/76/4c/ac764cb8541c8d73e039fba4c3d4df40.jpg",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Text(
                    controller.services.sharedPreferences
                        .getString("username")!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Get.height / 2.1,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(245, 245, 245, 245),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SwitchListTile(
                      value: true,
                      onChanged: (value) {},
                      title: Text("Notification"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      splashColor: Appcolor.rosePompadour,
                      title: Text("Addres"),
                      trailing: CircleAvatar(
                        backgroundColor: Appcolor.white,
                        child: Icon(
                          Icons.location_on_rounded,
                          color: Appcolor.amaranthpink,
                        ),
                      ),
                      onTap: () {
                        controller.goToAddress();
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      splashColor: Appcolor.rosePompadour,
                      title: Text("About Us"),
                      trailing: CircleAvatar(
                        backgroundColor: Appcolor.white,
                        child: Icon(
                          Icons.question_mark_rounded,
                          color: Appcolor.deepPurple,
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                        splashColor: Appcolor.rosePompadour,
                        title: Text("Contact Us"),
                        trailing: CircleAvatar(
                          backgroundColor: Appcolor.white,
                          child: Icon(
                            Icons.phone_rounded,
                            color: Appcolor.indigoBlue,
                          ),
                        ),
                        onTap: () {
                          Get.defaultDialog(
                            title: "Contact Us",
                            titleStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.indigoBlue,
                            ),
                            middleText: "How would you like to contact us?",
                            middleTextStyle: TextStyle(color: Colors.grey[600]),
                            backgroundColor: Colors.white,
                            radius: 10,
                            contentPadding: EdgeInsets.all(20),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        FaIcon(FontAwesomeIcons.whatsapp,
                                            color: Colors.white),
                                        SizedBox(width: 5),
                                        Text("WhatsApp",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    onPressed: () {
                                      Get.back();
                                      controller.contactus(0);
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolor.indigoBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.sms, color: Colors.white),
                                        SizedBox(width: 5),
                                        Text("SMS",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    onPressed: () {
                                      Get.back();
                                      controller.contactus(1);
                                    },
                                  ),
                                ],
                              ),
                            ],
                            confirm: TextButton(
                              child: Text("Cancel",
                                  style: TextStyle(color: Colors.grey)),
                              onPressed: () => Get.back(),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      splashColor: Appcolor.rosePompadour,
                      title: Text("Logout"),
                      trailing: CircleAvatar(
                        backgroundColor: Appcolor.white,
                        child: Icon(
                          Icons.logout_rounded,
                          color: Appcolor.deepPink,
                        ),
                      ),
                      onTap: () {
                        controller.logout();
                      },
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
