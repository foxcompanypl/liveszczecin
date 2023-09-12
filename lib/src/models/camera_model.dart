class CameraModel {
  final int id;
  final String name;
  final String image;
  final String url;

  CameraModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.url});

  CameraModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        url = json['url'];

  CameraModel CopyWith({int? id, String? name, String? image, String? url}) {
    return CameraModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        url: url ?? this.url);
  }
}
