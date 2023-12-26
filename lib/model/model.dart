class MomentsModel {
  String? sId;
  String? title;
  String? description; 
  String? imageUrl;
  int? likes;
  List<String>? tags;

  MomentsModel(
      {this.sId,
      this.title,
      this.description,
      this.imageUrl,
      this.likes,
      this.tags});

  MomentsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    likes = json['likes'];
    tags = json['tags'].cast<String>();
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['likes'] = likes;
    data['tags'] = tags;
    return data;
  }
}
