// To parse this JSON data, do
//
//     final reviews = reviewsFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<Reviews> reviewsFromJson(String str) =>
    List<Reviews>.from(json.decode(str).map((x) => Reviews.fromJson(x)));

String reviewsToJson(List<Reviews> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reviews {
  Reviews({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.productId,
    this.status,
    this.reviewer,
    this.reviewerEmail,
    this.review,
    this.rating,
    this.verified,
    this.reviewerAvatarUrls,
    this.links,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  int? productId;
  String? status;
  String? reviewer;
  String? reviewerEmail;
  String? review;
  int? rating;
  bool? verified;
  Map<String, String>? reviewerAvatarUrls;
  Links? links;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        id: json["id"] == null ? null : json["id"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
        productId: json["product_id"] == null ? null : json["product_id"],
        status: json["status"] == null ? null : json["status"],
        reviewer: json["reviewer"] == null ? null : json["reviewer"],
        reviewerEmail:
            json["reviewer_email"] == null ? null : json["reviewer_email"],
        review: json["review"] == null ? null : json["review"],
        rating: json["rating"] == null ? null : json["rating"],
        verified: json["verified"] == null ? null : json["verified"],
        reviewerAvatarUrls: json["reviewer_avatar_urls"] == null
            ? null
            : Map.from(json["reviewer_avatar_urls"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date_created":
            dateCreated == null ? null : dateCreated!.toIso8601String(),
        "date_created_gmt":
            dateCreatedGmt == null ? null : dateCreatedGmt!.toIso8601String(),
        "product_id": productId == null ? null : productId,
        "status": status == null ? null : status,
        "reviewer": reviewer == null ? null : reviewer,
        "reviewer_email": reviewerEmail == null ? null : reviewerEmail,
        "review": review == null ? null : review,
        "rating": rating == null ? null : rating,
        "verified": verified == null ? null : verified,
        "reviewer_avatar_urls": reviewerAvatarUrls == null
            ? null
            : Map.from(reviewerAvatarUrls!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "_links": links == null ? null : links!.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.up,
    this.reviewer,
  });

  List<Collection>? self;
  List<Collection>? collection;
  List<Collection>? up;
  List<Reviewer>? reviewer;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<Collection>.from(
                json["self"].map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null
            ? null
            : List<Collection>.from(
                json["collection"].map((x) => Collection.fromJson(x))),
        up: json["up"] == null
            ? null
            : List<Collection>.from(
                json["up"].map((x) => Collection.fromJson(x))),
        reviewer: json["reviewer"] == null
            ? null
            : List<Reviewer>.from(
                json["reviewer"].map((x) => Reviewer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection!.map((x) => x.toJson())),
        "up":
            up == null ? null : List<dynamic>.from(up!.map((x) => x.toJson())),
        "reviewer": reviewer == null
            ? null
            : List<dynamic>.from(reviewer!.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href == null ? null : href,
      };
}

class Reviewer {
  Reviewer({
    this.embeddable,
    this.href,
  });

  bool? embeddable;
  String? href;

  factory Reviewer.fromJson(Map<String, dynamic> json) => Reviewer(
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() => {
        "embeddable": embeddable == null ? null : embeddable,
        "href": href == null ? null : href,
      };
}
