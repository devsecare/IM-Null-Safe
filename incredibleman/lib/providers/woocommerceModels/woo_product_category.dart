class WooProductCategory {
  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  WooProductCategoryImage? image;
  int? menuOrder;
  int? count;
  WooProductCategoryLinks? links;

  WooProductCategory(
      {this.id,
      this.name,
      this.slug,
      this.parent,
      this.description,
      this.display,
      this.image,
      this.menuOrder,
      this.count,
      this.links});

  WooProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null
        ? WooProductCategoryImage.fromJson(json['image'])
        : null;
    menuOrder = json['menu_order'];
    count = json['count'];
    links = json['_links'] != null
        ? WooProductCategoryLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['parent'] = parent;
    data['description'] = description;
    data['display'] = display;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['menu_order'] = menuOrder;
    data['count'] = count;
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }

  @override
  toString() => toJson().toString();
}

class WooProductCategoryImage {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  WooProductCategoryImage(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  WooProductCategoryImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = (json['src'] != null && json['src'] is String) ? json['src'] : "";
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
    data['src'] = src;
    data['name'] = name;
    data['alt'] = alt;
    return data;
  }
}

class WooProductCategoryLinks {
  List<WooProductCategorySelf>? self;
  List<WooProductCategoryCollection>? collection;

  WooProductCategoryLinks({this.self, this.collection});

  WooProductCategoryLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <WooProductCategorySelf>[];
      json['self'].forEach((v) {
        self!.add(WooProductCategorySelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <WooProductCategoryCollection>[];
      json['collection'].forEach((v) {
        collection!.add(WooProductCategoryCollection.fromJson(v));
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

class WooProductCategorySelf {
  String? href;

  WooProductCategorySelf({this.href});

  WooProductCategorySelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class WooProductCategoryCollection {
  String? href;

  WooProductCategoryCollection({this.href});

  WooProductCategoryCollection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}
