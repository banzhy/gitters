// To parse this JSON data, do
//
//     final repoDof = repoDofFromJson(jsonString);

import 'dart:convert';

List<RepoDof> repoDofFromJson(String str) =>
    List<RepoDof>.from(json.decode(str).map((x) => RepoDof.fromJson(x)));

String repoDofToJson(List<RepoDof> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepoDof {
  RepoDof({
    this.name,
    this.path,
    this.sha,
    this.size,
    this.url,
    this.htmlUrl,
    this.gitUrl,
    this.downloadUrl,
    this.type,
    this.links,
  });

  String name;
  String path;
  String sha;
  int size;
  String url;
  String htmlUrl;
  String gitUrl;
  String downloadUrl;
  Type type;
  Links links;

  factory RepoDof.fromJson(Map<String, dynamic> json) => RepoDof(
        name: json["name"],
        path: json["path"],
        sha: json["sha"],
        size: json["size"],
        url: json["url"],
        htmlUrl: json["html_url"],
        gitUrl: json["git_url"],
        downloadUrl: json["download_url"] == null ? null : json["download_url"],
        type: typeValues.map[json["type"]],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
        "sha": sha,
        "size": size,
        "url": url,
        "html_url": htmlUrl,
        "git_url": gitUrl,
        "download_url": downloadUrl == null ? null : downloadUrl,
        "type": typeValues.reverse[type],
        "_links": links.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.git,
    this.html,
  });

  String self;
  String git;
  String html;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        git: json["git"],
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "git": git,
        "html": html,
      };
}

enum Type { FILE, DIR }

final typeValues = EnumValues({"dir": Type.DIR, "file": Type.FILE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
