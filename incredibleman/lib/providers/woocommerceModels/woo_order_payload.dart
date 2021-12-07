class WooOrderPayload {
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  String? status;
  String? currency;
  int? customerId;
  String? customerNote;
  int? parentId;
  List<WooOrderPayloadMetaData>? metaData;
  List<WooOrderPayloadFeeLines>? feeLines;
  List<WooOrderPayloadCouponLines>? couponLines;
  WooOrderPayloadBilling? billing;
  WooOrderPayloadShipping? shipping;
  List<LineItems>? lineItems;
  List<ShippingLines>? shippingLines;

  WooOrderPayload(
      {this.paymentMethod,
      this.paymentMethodTitle,
      this.setPaid,
      this.status,
      this.currency,
      this.customerId,
      this.customerNote,
      this.parentId,
      this.metaData,
      this.feeLines,
      this.couponLines,
      this.billing,
      this.shipping,
      this.lineItems,
      this.shippingLines});

  WooOrderPayload.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    setPaid = json['set_paid'];
    status = json['status'];
    currency = json['currency'];
    customerId = json['customer_id'];
    customerNote = json['customer_note'];
    parentId = json['parent_id'];
    if (json['meta_data'] != null) {
      metaData = <WooOrderPayloadMetaData>[];
      json['meta_data'].forEach((v) {
        metaData!.add(WooOrderPayloadMetaData.fromJson(v));
      });
    }
    if (json['fee_lines'] != null) {
      feeLines = <WooOrderPayloadFeeLines>[];
      json['fee_lines'].forEach((v) {
        feeLines!.add(WooOrderPayloadFeeLines.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      couponLines = <WooOrderPayloadCouponLines>[];
      json['coupon_lines'].forEach((v) {
        couponLines!.add(WooOrderPayloadCouponLines.fromJson(v));
      });
    }
    billing = json['billing'] != null
        ? WooOrderPayloadBilling.fromJson(json['billing'])
        : null;
    shipping = json['shipping'] != null
        ? WooOrderPayloadShipping.fromJson(json['shipping'])
        : null;
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLines>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(ShippingLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_method'] = paymentMethod;
    data['payment_method_title'] = paymentMethodTitle;
    data['set_paid'] = setPaid;
    data['status'] = status;
    data['currency'] = currency;
    data['customer_id'] = customerId;
    data['customer_note'] = customerNote;
    data['parent_id'] = parentId;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    if (feeLines != null) {
      data['fee_lines'] = feeLines!.map((v) => v.toJson()).toList();
    }
    if (couponLines != null) {
      data['coupon_lines'] = couponLines!.map((v) => v.toJson()).toList();
    }
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    if (shippingLines != null) {
      data['shipping_lines'] = shippingLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  toString() => toJson().toString();
}

class WooOrderPayloadMetaData {
  String? key;
  String? value;

  WooOrderPayloadMetaData({this.key, this.value});

  WooOrderPayloadMetaData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class WooOrderPayloadFeeLines {
  String? name;
  String? taxClass;
  String? taxStatus;
  String? total;
  List<WooOrderPayloadMetaData>? metaData;

  WooOrderPayloadFeeLines(
      {this.name, this.taxClass, this.taxStatus, this.total, this.metaData});

  WooOrderPayloadFeeLines.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    taxClass = json['tax_class'];
    taxStatus = json['tax_status'];
    total = json['total'];
    if (json['meta_data'] != null) {
      metaData = <WooOrderPayloadMetaData>[];
      json['meta_data'].forEach((v) {
        metaData!.add(WooOrderPayloadMetaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tax_class'] = taxClass;
    data['tax_status'] = taxStatus;
    data['total'] = total;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooOrderPayloadCouponLines {
  String? code;
  List<WooOrderPayloadMetaData>? metaData;

  WooOrderPayloadCouponLines({this.code, this.metaData});

  WooOrderPayloadCouponLines.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['meta_data'] != null) {
      metaData = <WooOrderPayloadMetaData>[];
      json['meta_data'].forEach((v) {
        metaData!.add(WooOrderPayloadMetaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooOrderPayloadBilling {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  WooOrderPayloadBilling(
      {this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.email,
      this.phone});

  WooOrderPayloadBilling.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName ?? "";
    data['last_name'] = lastName ?? "";
    data['address_1'] = address1 ?? "";
    data['address_2'] = address2 ?? "";
    data['city'] = city ?? "";
    data['state'] = state ?? "";
    data['postcode'] = postcode ?? "";
    data['country'] = country ?? "";
    if (email != null) {
      data['email'] = email ?? "";
    }
    if (phone != null) {
      data['phone'] = phone ?? "";
    }
    return data;
  }
}

class WooOrderPayloadShipping {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  WooOrderPayloadShipping(
      {this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  WooOrderPayloadShipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName ?? "";
    data['last_name'] = lastName ?? "";
    data['address_1'] = address1 ?? "";
    data['address_2'] = address2 ?? "";
    data['city'] = city ?? "";
    data['state'] = state ?? "";
    data['postcode'] = postcode ?? "";
    data['country'] = country ?? "";
    return data;
  }
}

class LineItems {
  int? productId;
  String? name;
  int? variationId;
  String? taxClass;
  String? subtotal;
  String? total;
  int? quantity;

  LineItems(
      {this.productId,
      this.name,
      this.variationId,
      this.taxClass,
      this.subtotal,
      this.total,
      this.quantity});

  LineItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    variationId = json['variation_id'];
    taxClass = json['tax_class'];
    subtotal = json['subtotal'];
    total = json['total'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    if (name != null) {
      data['name'] = name;
    }

    if (variationId != null) {
      data['variation_id'] = variationId;
    }
    if (taxClass != null) {
      data['tax_class'] = taxClass;
    }
    if (subtotal != null) {
      data['subtotal'] = subtotal;
    }
    if (total != null) {
      data['total'] = total;
    }

    data['quantity'] = quantity;
    return data;
  }

  @override
  toString() => toJson().toString();
}

class ShippingLines {
  String? methodId;
  String? methodTitle;
  String? total;

  ShippingLines({this.methodId, this.methodTitle, this.total});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method_id'] = methodId;
    data['method_title'] = methodTitle;
    data['total'] = total;
    return data;
  }
}
