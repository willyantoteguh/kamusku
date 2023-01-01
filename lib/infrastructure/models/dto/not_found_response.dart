class NotFoundResponse {
  NotFoundResponse({
    required this.title,
    required this.message,
    required this.resolution,
  });

  final String title;
  final String message;
  final String resolution;

  factory NotFoundResponse.fromMap(Map<String, dynamic> json) => NotFoundResponse(
        title: json["title"],
        message: json["message"],
        resolution: json["resolution"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "message": message,
        "resolution": resolution,
      };
}
