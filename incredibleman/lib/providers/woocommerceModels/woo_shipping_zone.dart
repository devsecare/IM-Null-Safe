class WooShippingZone {
  int? id;
  String? name;
  int? order;
  WooShippingZoneLinks? links;

  WooShippingZone({this.id, this.name, this.order, this.links});

  WooShippingZone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    links = json['_links'] != null
        ? WooShippingZoneLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }

  @override
  toString() => toJson().toString();
}

class WooShippingZoneLinks {
  List<WooShippingZoneSelf>? self;
  List<WooShippingZoneCollection>? collection;
  List<Describedby>? describedby;

  WooShippingZoneLinks({this.self, this.collection, this.describedby});

  WooShippingZoneLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <WooShippingZoneSelf>[];
      json['self'].forEach((v) {
        self!.add(WooShippingZoneSelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <WooShippingZoneCollection>[];
      json['collection'].forEach((v) {
        collection!.add(WooShippingZoneCollection.fromJson(v));
      });
    }
    if (json['describedby'] != null) {
      describedby = <Describedby>[];
      json['describedby'].forEach((v) {
        describedby!.add(Describedby.fromJson(v));
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
    if (describedby != null) {
      data['describedby'] = describedby!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooShippingZoneSelf {
  String? href;

  WooShippingZoneSelf({this.href});

  WooShippingZoneSelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class WooShippingZoneCollection {
  String? href;

  WooShippingZoneCollection({this.href});

  WooShippingZoneCollection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class Describedby {
  String? href;

  Describedby({this.href});

  Describedby.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}
