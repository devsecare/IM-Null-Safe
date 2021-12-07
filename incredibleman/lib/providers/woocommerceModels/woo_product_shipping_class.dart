class WooProductShippingClass {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? count;
  WooProductShippingClassLinks? links;

  WooProductShippingClass(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.count,
      this.links});

  WooProductShippingClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    count = json['count'];
    links = json['_links'] != null
        ? WooProductShippingClassLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['count'] = count;
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }

  @override
  toString() => toJson().toString();
}

class WooProductShippingClassLinks {
  List<WooProductShippingClassSelf>? self;
  List<WooProductShippingClassCollection>? collection;

  WooProductShippingClassLinks({this.self, this.collection});

  WooProductShippingClassLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <WooProductShippingClassSelf>[];
      json['self'].forEach((v) {
        self!.add(WooProductShippingClassSelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <WooProductShippingClassCollection>[];
      json['collection'].forEach((v) {
        collection!.add(WooProductShippingClassCollection.fromJson(v));
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

class WooProductShippingClassSelf {
  String? href;

  WooProductShippingClassSelf({this.href});

  WooProductShippingClassSelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class WooProductShippingClassCollection {
  String? href;

  WooProductShippingClassCollection({this.href});

  WooProductShippingClassCollection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}
