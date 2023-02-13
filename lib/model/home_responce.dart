class HomeResponse {
  int? status;
  String? message;
  List<Data>? data;

  HomeResponse({this.status, this.message, this.data});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? appId;
  int? position;
  String? name;
  String? thumbImage;
  String? appLink;
  String? packageName;
  String? fullThumbImage;
  int? splashActive;

  Data(
      {this.id,
        this.appId,
        this.position,
        this.name,
        this.thumbImage,
        this.appLink,
        this.packageName,
        this.fullThumbImage,
        this.splashActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    position = json['position'];
    name = json['name'];
    thumbImage = json['thumb_image'];
    appLink = json['app_link'];
    packageName = json['package_name'];
    fullThumbImage = json['full_thumb_image'];
    splashActive = json['splash_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['position'] = this.position;
    data['name'] = this.name;
    data['thumb_image'] = this.thumbImage;
    data['app_link'] = this.appLink;
    data['package_name'] = this.packageName;
    data['full_thumb_image'] = this.fullThumbImage;
    data['splash_active'] = this.splashActive;
    return data;
  }
}
