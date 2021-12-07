// ignore_for_file: prefer_collection_literals

class WooProductAttribute {
  int? id;
  String? name;
  String? slug;
  String? type;
  String? orderBy;
  bool? hasArchives;
  WooProductAttributeTermLinks? links;

  WooProductAttribute(
      {this.id,
      this.name,
      this.slug,
      this.type,
      this.orderBy,
      this.hasArchives,
      this.links});

  WooProductAttribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
    orderBy = json['order_by'];
    hasArchives = json['has_archives'];
    links = json['_links'] != null
        ? WooProductAttributeTermLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['type'] = type;
    data['order_by'] = orderBy;
    data['has_archives'] = hasArchives;
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }

  @override
  toString() => toJson().toString();
}

class WooProductAttributeTermLinks {
  List<WooProductAttributeTermSelf>? self;
  List<WooProductAttributeTermCollection>? collection;

  WooProductAttributeTermLinks({this.self, this.collection});

  WooProductAttributeTermLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <WooProductAttributeTermSelf>[];
      json['self'].forEach((v) {
        self!.add(WooProductAttributeTermSelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <WooProductAttributeTermCollection>[];
      json['collection'].forEach((v) {
        collection!.add(WooProductAttributeTermCollection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (self != null) {
      data['self'] = self!.map((v) => v.toJson()).toList();
    }
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooProductAttributeTermSelf {
  String? href;

  WooProductAttributeTermSelf({this.href});

  WooProductAttributeTermSelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['href'] = href;
    return data;
  }
}

class WooProductAttributeTermCollection {
  String? href;

  WooProductAttributeTermCollection({this.href});

  WooProductAttributeTermCollection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['href'] = href;
    return data;
  }
}
