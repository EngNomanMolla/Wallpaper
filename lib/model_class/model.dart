

import 'dart:convert';

ModalClass modalClassFromJson(String str) => ModalClass.fromJson(json.decode(str));

String modalClassToJson(ModalClass data) => json.encode(data.toJson());

class ModalClass {
  ModalClass({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  String ?id;
  String? author;
  int ?width;
  int? height;
  String ?url;
  String? downloadUrl;

  factory ModalClass.fromJson(Map<String, dynamic> json) => ModalClass(
    id: json["id"],
    author: json["author"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
    downloadUrl: json["download_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "width": width,
    "height": height,
    "url": url,
    "download_url": downloadUrl,
  };
}
