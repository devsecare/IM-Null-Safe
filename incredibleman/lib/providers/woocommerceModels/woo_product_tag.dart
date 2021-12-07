class WooProductTag {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? count;
  WooProductTagLinks? lLinks;

  WooProductTag(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.count,
      this.lLinks});

  WooProductTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    count = json['count'];
    lLinks = json['_links'] != null
        ? WooProductTagLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['count'] = count;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }

  @override
  toString() => toJson().toString();
}

class WooProductTagLinks {
  List<WooProductTagSelf>? self;
  List<WooProductTagCollection>? collection;

  WooProductTagLinks({this.self, this.collection});

  WooProductTagLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <WooProductTagSelf>[];
      json['self'].forEach((v) {
        self!.add(WooProductTagSelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <WooProductTagCollection>[];
      json['collection'].forEach((v) {
        collection!.add(WooProductTagCollection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.map((v) => v.toJson()).toList();
    }
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooProductTagSelf {
  String? href;

  WooProductTagSelf({this.href});

  WooProductTagSelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class WooProductTagCollection {
  String? href;

  WooProductTagCollection({this.href});

  WooProductTagCollection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}
