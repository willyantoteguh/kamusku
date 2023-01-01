import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_kamusku/infrastructure/models/dto/not_found_response.dart';
import 'package:flutter_kamusku/infrastructure/repository/dictionary_repository/dictionary_repository.dart';
import 'package:get/get.dart';

import '../../../infrastructure/models/dto/data_response.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  AudioPlayer audioPlayer = AudioPlayer();

  //// Search Bar
  final searchController = TextEditingController();
  final GlobalKey keySearch = GlobalKey();

  // Rx<DataResponse> dataResponse = DataResponse(word: '', phonetics: [], meanings: [], sourceUrls: []).obs;
  RxList<DataResponse> listDefinition = RxList.empty();
  Rx<NotFoundResponse> notFoundResponse = NotFoundResponse(title: '', message: '', resolution: '').obs;
  DictionaryRepository dictionaryRepository = DictionaryRepository();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getDataDefinition(String query) async {
    await dictionaryRepository.searchQuery(query).then((value) async {
      if (value == listDefinition) {
        listDefinition.value = value;
      } else if (value == NotFoundResponse) {
        notFoundResponse.value = value;
        log(notFoundResponse.value.toMap().toString());
      }
    });
  }
}
