class AlphabetEntity {
  late String text;
  late String audio;

  AlphabetEntity({
    required this.text,
    required this.audio,
  });

  factory AlphabetEntity.fromJson(Map<String, dynamic> parsedJson) {
    return AlphabetEntity(
      text: parsedJson['text'],
      audio: parsedJson['audio'],
    );
  }
}
