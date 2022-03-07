// To parse this JSON data, do
//
//     final bannerAd = bannerAdFromJson(jsonString);

import 'dart:convert';

/// this is Model Define for BannerApi

BannerAd bannerAdFromJson(String str) => BannerAd.fromJson(json.decode(str));

String bannerAdToJson(BannerAd data) => json.encode(data.toJson());

class BannerAd {
  BannerAd({
    this.post1,
    this.post2,
  });

  Post? post1;
  Post? post2;

  factory BannerAd.fromJson(Map<String, dynamic> json) => BannerAd(
        post1: Post.fromJson(json["post_1"]),
        post2: Post.fromJson(json["post_2"]),
      );

  Map<String, dynamic> toJson() => {
        "post_1": post1!.toJson(),
        "post_2": post2!.toJson(),
      };
}

class Post {
  Post({
    this.banner,
    this.bannerLink,
    this.offerCategory,
  });

  String? banner;
  String? bannerLink;
  List<int>? offerCategory;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        banner: json["banner"],
        bannerLink: json["banner_link"],
        offerCategory: List<int>.from(json["offer_category"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "banner": banner,
        "banner_link": bannerLink,
        "offer_category": List<dynamic>.from(offerCategory!.map((x) => x)),
      };
}
