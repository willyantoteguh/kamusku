import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());

  String durasi = "00:00:00";
  _HomeScreenState() {
    controller.audioPlayer.onPositionChanged.listen((duration) {
      setState(() {
        durasi = duration.toString();
      });
    });

    controller.audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  void playSound(String url) async {
    await controller.audioPlayer.play(UrlSource(url));
  }

  void pauseSound() async {
    await controller.audioPlayer.pause();
  }

  void stopSound() async {
    await controller.audioPlayer.stop();
  }

  void resumeSound() async {
    controller.audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    String url = (controller.listDefinition.isNotEmpty) ? controller.listDefinition.first.phonetics.first["audio"] : '';

    return Container(
      color: Colors.red.shade900,
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40, bottom: 5, top: 10),
                height: 45,
                width: double.infinity,
                child: Form(
                  key: controller.keySearch,
                  child: TextFieldSearch(
                    label: 'Get meanings',
                    future: () async {
                      var query = controller.searchController.text;
                      await controller.getDataDefinition(query);
                    },
                    getSelectedValue: (item) {
                      log(item);
                    },
                    controller: controller.searchController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          size: 15,
                          color: Colors.red.shade900,
                        ),
                        prefixIconColor: Colors.red.shade900,
                        suffixIcon: (controller.searchController.text.toString() != '' || controller.searchController.text.isNotEmpty)
                            ? InkWell(
                                onTap: () {
                                  controller.searchController.clear();
                                  controller.listDefinition.clear();
                                  controller.update();
                                },
                                child: Icon(
                                  CupertinoIcons.clear_circled,
                                  size: 15,
                                  color: Colors.red.shade900,
                                ))
                            : null,
                        hintText: " Search",
                        hintStyle: TextStyle(fontSize: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade900,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade900,
                          ),
                        ),
                        focusColor: Colors.red.shade900,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red.shade900,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              Obx(() => (controller.listDefinition.isNotEmpty)
                  ? IconButton(
                      icon: Icon(
                        CupertinoIcons.play_circle,
                        size: 35,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        playSound(url);
                      },
                    )
                  : SizedBox()),
              SizedBox(height: 150),
              Obx(
                () => (controller.listDefinition.isNotEmpty)
                    ? Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.listDefinition.first.meanings.first.definitions.length,
                            itemBuilder: (context, index) {
                              var item = controller.listDefinition.first.meanings.first.definitions[index];

                              return Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(item.definition),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    : (controller.notFoundResponse.value.title != '')
                        ? Container(
                            width: MediaQuery.of(context).size.width - 150,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Text(controller.notFoundResponse.value.title),
                                SizedBox(height: 20),
                                Text(
                                  controller.notFoundResponse.value.message,
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: LottieBuilder.network('https://assets4.lottiefiles.com/packages/lf20_scgyykem.json'),
                                ),
                                Text(controller.notFoundResponse.value.resolution, textAlign: TextAlign.center),
                              ],
                            ),
                          )
                        : Lottie.network('https://assets1.lottiefiles.com/packages/lf20_xbf1be8x.json'),
              )
            ],
          ),
        )),
      ),
    );
  }
}
