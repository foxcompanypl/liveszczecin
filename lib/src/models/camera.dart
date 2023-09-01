class Camera {
  final int id;
  final String name;
  final String image;
  final String url;

  Camera(
      {required this.id,
      required this.name,
      required this.image,
      required this.url});

  Camera.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        url = json['url'];
}
