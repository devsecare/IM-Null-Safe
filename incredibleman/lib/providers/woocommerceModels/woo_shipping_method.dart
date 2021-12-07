class WooShippingMethod {
  int? parentId;
  String? name;
  List<WooShippingMethodLocations>? locations;
  WooShippingMethodMethods? methods;

  WooShippingMethod({this.parentId, this.name, this.locations, this.methods});

  WooShippingMethod.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    name = json['name'];
    if (json['locations'] != null) {
      locations = <WooShippingMethodLocations>[];
      json['locations'].forEach((v) {
        locations!.add(WooShippingMethodLocations.fromJson(v));
      });
    }
    methods = json['methods'] != null
        ? WooShippingMethodMethods.fromJson(json['methods'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent_id'] = parentId;
    data['name'] = name;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    if (methods != null) {
      data['methods'] = methods!.toJson();
    }
    return data;
  }

  @override
  toString() => toJson().toString();
}

class WooShippingMethodLocations {
  String? code;
  String? type;

  WooShippingMethodLocations({this.code, this.type});

  WooShippingMethodLocations.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['type'] = type;
    return data;
  }
}

class WooShippingMethodMethods {
  List<WooShippingMethodFreeShipping>? freeShipping;
  List<WooShippingMethodFlatRate>? flatRate;
  List<WooShippingMethodLocalPickup>? localPickup;

  WooShippingMethodMethods(
      {this.freeShipping, this.flatRate, this.localPickup});

  WooShippingMethodMethods.fromJson(Map<String, dynamic> json) {
    if (json['free_shipping'] != null) {
      freeShipping = <WooShippingMethodFreeShipping>[];
      json['free_shipping'].forEach((v) {
        freeShipping!.add(WooShippingMethodFreeShipping.fromJson(v));
      });
    }
    if (json['flat_rate'] != null) {
      flatRate = <WooShippingMethodFlatRate>[];
      json['flat_rate'].forEach((v) {
        flatRate!.add(WooShippingMethodFlatRate.fromJson(v));
      });
    }
    if (json['local_pickup'] != null) {
      localPickup = <WooShippingMethodLocalPickup>[];
      json['local_pickup'].forEach((v) {
        localPickup!.add(WooShippingMethodLocalPickup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (freeShipping != null) {
      data['free_shipping'] = freeShipping!.map((v) => v.toJson()).toList();
    }
    if (flatRate != null) {
      data['flat_rate'] = flatRate!.map((v) => v.toJson()).toList();
    }
    if (localPickup != null) {
      data['local_pickup'] = localPickup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooShippingMethodFreeShipping {
  int? id;
  String? title;
  String? methodId;
  String? cost;

  WooShippingMethodFreeShipping(
      {this.id, this.title, this.methodId, this.cost});

  WooShippingMethodFreeShipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    methodId = json['method_id'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['method_id'] = methodId;
    data['cost'] = cost;
    return data;
  }
}

class WooShippingMethodFlatRate {
  int? id;
  String? title;
  String? methodId;
  String? cost;
  String? classCost;
  String? calculationType;
  bool? taxable;
  List<WooShippingMethodShippingClasses>? shippingClasses;

  WooShippingMethodFlatRate(
      {this.id,
      this.title,
      this.methodId,
      this.cost,
      this.classCost,
      this.calculationType,
      this.taxable,
      this.shippingClasses});

  WooShippingMethodFlatRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    methodId = json['method_id'];
    cost = json['cost'];
    classCost = json['class_cost'];
    calculationType = json['calculation_type'];
    taxable = json['taxable'];
    if (json['shipping_classes'] != null) {
      shippingClasses = <WooShippingMethodShippingClasses>[];
      json['shipping_classes'].forEach((v) {
        shippingClasses!.add(WooShippingMethodShippingClasses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['method_id'] = methodId;
    data['cost'] = cost;
    data['class_cost'] = classCost;
    data['calculation_type'] = calculationType;
    data['taxable'] = taxable;
    if (shippingClasses != null) {
      data['shipping_classes'] =
          shippingClasses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooShippingMethodShippingClasses {
  String? id;
  String? cost;

  WooShippingMethodShippingClasses({this.id, this.cost});

  WooShippingMethodShippingClasses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cost'] = cost;
    return data;
  }
}

class WooShippingMethodLocalPickup {
  int? id;
  String? title;
  String? methodId;
  bool? taxable;
  String? cost;

  WooShippingMethodLocalPickup(
      {this.id, this.title, this.methodId, this.taxable, this.cost});

  WooShippingMethodLocalPickup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    methodId = json['method_id'];
    taxable = json['taxable'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['method_id'] = methodId;
    data['taxable'] = taxable;
    data['cost'] = cost;
    return data;
  }
}
