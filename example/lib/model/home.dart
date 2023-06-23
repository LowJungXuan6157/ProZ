class Home {
  String? name;
  String? path;

  Home({
    this.name,
    this.path,
  });

  Home.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    return data;
  }

  static final shared = Home();

  @override
  fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Home.fromJson(json);
  }

  @override
  List<Home> listFromJson(List? json) {
    if (json == null) return [];
    List<Home> list = [];
    for (var item in json) {
      list.add(Home.fromJson(item));
    }
    return list;
  }
}
