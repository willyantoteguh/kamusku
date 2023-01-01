class DataResponse {
  DataResponse({
    required this.word,
    required this.phonetics,
    required this.meanings,
    // required this.license,
    required this.sourceUrls,
  });

  final String word;
  final List<dynamic> phonetics;
  final List<Meaning> meanings;
  // final License license;
  final List<String> sourceUrls;

  factory DataResponse.fromMap(Map<String, dynamic> json) => DataResponse(
        word: json["word"],
        phonetics: List<dynamic>.from(json["phonetics"].map((x) => x)),
        meanings: List<Meaning>.from(json["meanings"].map((x) => Meaning.fromMap(x))),
        // license: License.fromMap(json["license"]),
        sourceUrls: List<String>.from(json["sourceUrls"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "word": word,
        "phonetics": List<dynamic>.from(phonetics.map((x) => x)),
        "meanings": List<dynamic>.from(meanings.map((x) => x.toMap())),
        // "license": license.toMap(),
        "sourceUrls": List<dynamic>.from(sourceUrls.map((x) => x)),
      };
}

class License {
  License({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory License.fromMap(Map<String, dynamic> json) => License(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class Meaning {
  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  final String partOfSpeech;
  final List<Definition> definitions;
  final List<dynamic> synonyms;
  final List<dynamic> antonyms;

  factory Meaning.fromMap(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: List<Definition>.from(json["definitions"].map((x) => Definition.fromMap(x))),
        synonyms: List<dynamic>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "partOfSpeech": partOfSpeech,
        "definitions": List<dynamic>.from(definitions.map((x) => x.toMap())),
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms.map((x) => x)),
      };
}

class Definition {
  Definition({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
    required this.example,
  });

  final String definition;
  final List<dynamic> synonyms;
  final List<dynamic> antonyms;
  final String example;

  factory Definition.fromMap(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        synonyms: List<dynamic>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
        example: json["example"] == null ? '' : json["example"],
      );

  Map<String, dynamic> toMap() => {
        "definition": definition,
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms.map((x) => x)),
        "example": example == null ? '' : example,
      };
}
