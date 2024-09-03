class Panoramica {
  final String url;
  final String pathFile;
  final int inventarioId;

  Panoramica({
    required this.url,
    required this.pathFile,
    required this.inventarioId,
  });

  factory Panoramica.fromJson(Map<String, dynamic> json) {
    return Panoramica(
      url: json['url'],
      pathFile: json['path_file'],
      inventarioId: json['inventario_id'],
    );
  }
}
