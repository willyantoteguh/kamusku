import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_kamusku/infrastructure/models/dto/data_response.dart';
import 'package:flutter_kamusku/infrastructure/models/dto/not_found_response.dart';
import 'package:flutter_kamusku/infrastructure/source/remote/dictionary/dictionary_remote_source.dart';
import 'package:uuid/uuid.dart';

class DictionaryRepository {
  var uuid = Uuid();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DictionaryRemoteSource dictionaryRemoteSource = DictionaryRemoteSource();

  Future<dynamic> searchQuery(String query) async {
    List<DataResponse>? data = [];
    Response response = await dictionaryRemoteSource.getDefinitions(query);

    log(response.toString());

    if (response.statusCode == 200) {
      var listResult = response.data;
      for (var item in listResult) {
        DataResponse dataResponse = DataResponse.fromMap(item);
        data.add(dataResponse);
      }
      storeToFirebase(data);
      return data;
    } else if (response.statusCode == 404) {
      NotFoundResponse notFound = NotFoundResponse.fromMap(response.data);
      return notFound;
    }
    // log(data.map((e) => e.meanings.map((e) => e.definitions).toList()).toList().toString());
  }

  void storeToFirebase(List<DataResponse> data) async {
    if (data.first.meanings.isNotEmpty) {
      String uuid_firestore = uuid.v4();

      await firestore
          .collection('result')
          .doc(uuid_firestore)
          .set(
            data.first.toMap(),
          )
          .then((value) => log('==== Successfully Stored... ===='));
    }
  }
}
