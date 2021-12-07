// To parse this JSON data, do
//
//     final shippingModel = shippingModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<ShippingModel> shippingModelFromJson(String str) =>
    List<ShippingModel>.from(
        json.decode(str).map((x) => ShippingModel.fromJson(x)));

String shippingModelToJson(List<ShippingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShippingModel {
  ShippingModel({
    this.id,
    this.instanceId,
    this.title,
    this.order,
    this.enabled,
    this.methodId,
    this.methodTitle,
    this.methodDescription,
    this.settings,
    this.links,
  });

  int? id;
  int? instanceId;
  String? title;
  int? order;
  bool? enabled;
  String? methodId;
  String? methodTitle;
  String? methodDescription;
  Settings? settings;
  Links? links;

  factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
        id: json["id"],
        instanceId: json["instance_id"],
        title: json["title"],
        order: json["order"],
        enabled: json["enabled"],
        methodId: json["method_id"],
        methodTitle: json["method_title"],
        methodDescription: json["method_description"],
        settings: Settings.fromJson(json["settings"]),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instance_id": instanceId,
        "title": title,
        "order": order,
        "enabled": enabled,
        "method_id": methodId,
        "method_title": methodTitle,
        "method_description": methodDescription,
        "settings": settings!.toJson(),
        "_links": links!.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.describes,
  });

  List<Collection>? self;
  List<Collection>? collection;
  List<Collection>? describes;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        describes: List<Collection>.from(
            json["describes"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
        "describes": List<dynamic>.from(describes!.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Settings {
  Settings({
    this.title,
    this.taxStatus,
    this.cost,
    this.requires,
    this.minAmount,
    this.ignoreDiscounts,
  });

  Title? title;
  Title? taxStatus;
  Title? cost;
  Title? requires;
  Title? minAmount;
  Title? ignoreDiscounts;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        title: Title.fromJson(json["title"]),
        taxStatus: json["tax_status"] == null
            ? null
            : Title.fromJson(json["tax_status"]),
        cost: json["cost"] == null ? null : Title.fromJson(json["cost"]),
        requires:
            json["requires"] == null ? null : Title.fromJson(json["requires"]),
        minAmount: json["min_amount"] == null
            ? null
            : Title.fromJson(json["min_amount"]),
        ignoreDiscounts: json["ignore_discounts"] == null
            ? null
            : Title.fromJson(json["ignore_discounts"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title!.toJson(),
        "tax_status": taxStatus == null ? null : taxStatus!.toJson(),
        "cost": cost == null ? null : cost!.toJson(),
        "requires": requires == null ? null : requires!.toJson(),
        "min_amount": minAmount == null ? null : minAmount!.toJson(),
        "ignore_discounts":
            ignoreDiscounts == null ? null : ignoreDiscounts!.toJson(),
      };
}

class Title {
  Title({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.titleDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String? id;
  String? label;
  String? description;
  String? type;
  String? value;
  String? titleDefault;
  String? tip;
  String? placeholder;
  Options? options;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        id: json["id"],
        label: json["label"],
        description: json["description"],
        type: json["type"],
        value: json["value"],
        titleDefault: json["default"],
        tip: json["tip"],
        placeholder: json["placeholder"],
        options:
            json["options"] == null ? null : Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "description": description,
        "type": type,
        "value": value,
        "default": titleDefault,
        "tip": tip,
        "placeholder": placeholder,
        "options": options == null ? null : options!.toJson(),
      };
}

class Options {
  Options({
    this.empty,
    this.coupon,
    this.minAmount,
    this.either,
    this.both,
    this.taxable,
    this.none,
  });

  String? empty;
  String? coupon;
  String? minAmount;
  String? either;
  String? both;
  String? taxable;
  String? none;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        empty: json[""],
        coupon: json["coupon"] == null ? null : json["coupon"],
        minAmount: json["min_amount"] == null ? null : json["min_amount"],
        either: json["either"] == null ? null : json["either"],
        both: json["both"] == null ? null : json["both"],
        taxable: json["taxable"] == null ? null : json["taxable"],
        none: json["none"] == null ? null : json["none"],
      );

  Map<String, dynamic> toJson() => {
        "": empty == null ? null : empty,
        "coupon": coupon == null ? null : coupon,
        "min_amount": minAmount == null ? null : minAmount,
        "either": either == null ? null : either,
        "both": both == null ? null : both,
        "taxable": taxable == null ? null : taxable,
        "none": none == null ? null : none,
      };
}
