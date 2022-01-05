// // To parse this JSON data, do
// //
// //     final orderHist = orderHistFromJson(jsonString);

import 'dart:convert';

List<OrderHist> orderHistFromJson(String str) =>
    List<OrderHist>.from(json.decode(str).map((x) => OrderHist.fromJson(x)));

String orderHistToJson(List<OrderHist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderHist {
  OrderHist({
    this.id,
    this.parentId,
    this.number,
    this.orderKey,
    this.createdVia,
    this.version,
    this.status,
    this.currency,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.pricesIncludeTax,
    this.customerId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.customerNote,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.datePaid,
    this.datePaidGmt,
    this.dateCompleted,
    this.dateCompletedGmt,
    this.cartHash,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.refunds,
    this.links,
  });

  int? id;
  int? parentId;
  String? number;
  String? orderKey;
  String? createdVia;
  String? version;
  String? status;
  String? currency;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  bool? pricesIncludeTax;
  int? customerId;
  String? customerIpAddress;
  String? customerUserAgent;
  String? customerNote;
  Ing? billing;
  Ing? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? transactionId;
  DateTime? datePaid;
  DateTime? datePaidGmt;
  DateTime? dateCompleted;
  DateTime? dateCompletedGmt;
  String? cartHash;
  List<MetaDatum>? metaData;
  List<LineItem>? lineItems;
  List<TaxLine>? taxLines;
  List<ShippingLine>? shippingLines;
  List<dynamic>? feeLines;
  List<dynamic>? couponLines;
  List<Refund>? refunds;
  Links? links;

  factory OrderHist.fromJson(Map<String, dynamic> json) => OrderHist(
        id: json["id"],
        parentId: json["parent_id"],
        number: json["number"],
        orderKey: json["order_key"],
        createdVia: json["created_via"],
        version: json["version"],
        status: json["status"],
        currency: json["currency"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null
            ? null
            : DateTime.parse(json["date_modified_gmt"]),
        discountTotal: json["discount_total"],
        discountTax: json["discount_tax"],
        shippingTotal: json["shipping_total"],
        shippingTax: json["shipping_tax"],
        cartTax: json["cart_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        pricesIncludeTax: json["prices_include_tax"],
        customerId: json["customer_id"],
        customerIpAddress: json["customer_ip_address"],
        customerUserAgent: json["customer_user_agent"],
        customerNote: json["customer_note"],
        billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
        shipping:
            json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        transactionId: json["transaction_id"],
        datePaid: json["date_paid"] == null
            ? null
            : DateTime.parse(json["date_paid"]),
        datePaidGmt: json["date_paid_gmt"] == null
            ? null
            : DateTime.parse(json["date_paid_gmt"]),
        dateCompleted: json["date_completed"] == null
            ? null
            : DateTime.parse(json["date_completed"]),
        dateCompletedGmt: json["date_completed_gmt"] == null
            ? null
            : DateTime.parse(json["date_completed_gmt"]),
        cartHash: json["cart_hash"],
        metaData: json["meta_data"] == null
            ? null
            : List<MetaDatum>.from(
                json["meta_data"].map((x) => MetaDatum.fromJson(x))),
        lineItems: json["line_items"] == null
            ? null
            : List<LineItem>.from(
                json["line_items"].map((x) => LineItem.fromJson(x))),
        taxLines: json["tax_lines"] == null
            ? null
            : List<TaxLine>.from(
                json["tax_lines"].map((x) => TaxLine.fromJson(x))),
        shippingLines: json["shipping_lines"] == null
            ? null
            : List<ShippingLine>.from(
                json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
        feeLines: json["fee_lines"] == null
            ? null
            : List<dynamic>.from(json["fee_lines"].map((x) => x)),
        couponLines: json["coupon_lines"] == null
            ? null
            : List<dynamic>.from(json["coupon_lines"].map((x) => x)),
        refunds: json["refunds"] == null
            ? null
            : List<Refund>.from(json["refunds"].map((x) => Refund.fromJson(x))),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "number": number,
        "order_key": orderKey,
        "created_via": createdVia,
        "version": version,
        "status": status,
        "currency": currency,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "discount_total": discountTotal,
        "discount_tax": discountTax,
        "shipping_total": shippingTotal,
        "shipping_tax": shippingTax,
        "cart_tax": cartTax,
        "total": total,
        "total_tax": totalTax,
        "prices_include_tax": pricesIncludeTax,
        "customer_id": customerId,
        "customer_ip_address": customerIpAddress,
        "customer_user_agent": customerUserAgent,
        "customer_note": customerNote,
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "transaction_id": transactionId,
        "date_paid": datePaid?.toIso8601String(),
        "date_paid_gmt": datePaidGmt?.toIso8601String(),
        "date_completed": dateCompleted?.toIso8601String(),
        "date_completed_gmt": dateCompletedGmt?.toIso8601String(),
        "cart_hash": cartHash,
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x.toJson())),
        "line_items": lineItems == null
            ? null
            : List<dynamic>.from(lineItems!.map((x) => x.toJson())),
        "tax_lines": taxLines == null
            ? null
            : List<dynamic>.from(taxLines!.map((x) => x.toJson())),
        "shipping_lines": shippingLines == null
            ? null
            : List<dynamic>.from(shippingLines!.map((x) => x.toJson())),
        "fee_lines": feeLines == null
            ? null
            : List<dynamic>.from(feeLines!.map((x) => x)),
        "coupon_lines": couponLines == null
            ? null
            : List<dynamic>.from(couponLines!.map((x) => x)),
        "refunds": refunds == null
            ? null
            : List<dynamic>.from(refunds!.map((x) => x.toJson())),
        "_links": links?.toJson(),
      };
}

class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email,
        "phone": phone,
      };
}

class LineItem {
  LineItem({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
    this.sku,
    this.price,
  });

  int? id;
  String? name;
  int? productId;
  int? variationId;
  int? quantity;
  String? taxClass;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  List<Tax>? taxes;
  List<MetaDatum>? metaData;
  String? sku;
  int? price;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        name: json["name"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        taxClass: json["tax_class"],
        subtotal: json["subtotal"],
        subtotalTax: json["subtotal_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        taxes: json["taxes"] == null
            ? null
            : List<Tax>.from(json["taxes"].map((x) => Tax.fromJson(x))),
        metaData: json["meta_data"] == null
            ? null
            : List<MetaDatum>.from(
                json["meta_data"].map((x) => MetaDatum.fromJson(x))),
        sku: json["sku"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "tax_class": taxClass,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "taxes": taxes == null
            ? null
            : List<dynamic>.from(taxes!.map((x) => x.toJson())),
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x.toJson())),
        "sku": sku,
        "price": price,
      };
}

class MetaDatum {
  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int? id;
  String? key;
  String? value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}

class Tax {
  Tax({
    this.id,
    this.total,
    this.subtotal,
  });

  int? id;
  String? total;
  String? subtotal;

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        total: json["total"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "subtotal": subtotal,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.customer,
  });

  List<Collection>? self;
  List<Collection>? collection;
  List<Collection>? customer;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<Collection>.from(
                json["self"].map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null
            ? null
            : List<Collection>.from(
                json["collection"].map((x) => Collection.fromJson(x))),
        customer: json["customer"] == null
            ? null
            : List<Collection>.from(
                json["customer"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection!.map((x) => x.toJson())),
        "customer": customer == null
            ? null
            : List<dynamic>.from(customer!.map((x) => x.toJson())),
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

class Refund {
  Refund({
    this.id,
    this.refund,
    this.total,
  });

  int? id;
  String? refund;
  String? total;

  factory Refund.fromJson(Map<String, dynamic> json) => Refund(
        id: json["id"],
        refund: json["refund"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "refund": refund,
        "total": total,
      };
}

class ShippingLine {
  ShippingLine({
    this.id,
    this.methodTitle,
    this.methodId,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
  });

  int? id;
  String? methodTitle;
  String? methodId;
  String? total;
  String? totalTax;
  List<dynamic>? taxes;
  List<MetaDatum>? metaData;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        id: json["id"],
        methodTitle: json["method_title"],
        methodId: json["method_id"],
        total: json["total"],
        totalTax: json["total_tax"],
        taxes: json["taxes"] == null
            ? null
            : List<dynamic>.from(json["taxes"].map((x) => x)),
        metaData: json["meta_data"] == null
            ? null
            : List<MetaDatum>.from(
                json["meta_data"].map((x) => MetaDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method_title": methodTitle,
        "method_id": methodId,
        "total": total,
        "total_tax": totalTax,
        "taxes":
            taxes == null ? null : List<dynamic>.from(taxes!.map((x) => x)),
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x.toJson())),
      };
}

class TaxLine {
  TaxLine({
    this.id,
    this.rateCode,
    this.rateId,
    this.label,
    this.compound,
    this.taxTotal,
    this.shippingTaxTotal,
    this.metaData,
  });

  int? id;
  String? rateCode;
  int? rateId;
  String? label;
  bool? compound;
  String? taxTotal;
  String? shippingTaxTotal;
  List<dynamic>? metaData;

  factory TaxLine.fromJson(Map<String, dynamic> json) => TaxLine(
        id: json["id"],
        rateCode: json["rate_code"],
        rateId: json["rate_id"],
        label: json["label"],
        compound: json["compound"],
        taxTotal: json["tax_total"],
        shippingTaxTotal: json["shipping_tax_total"],
        metaData: json["meta_data"] == null
            ? null
            : List<dynamic>.from(json["meta_data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rate_code": rateCode,
        "rate_id": rateId,
        "label": label,
        "compound": compound,
        "tax_total": taxTotal,
        "shipping_tax_total": shippingTaxTotal,
        "meta_data": metaData == null
            ? null
            : List<dynamic>.from(metaData!.map((x) => x)),
      };
}

// class OrderGet {
//   final int? id;
//   final int? parentId;
//   final String? status;
//   final String? currency;
//   final String? version;
//   final bool? pricesIncludeTax;
//   final String? dateCreated;
//   final String? dateModified;
//   final String? discountTotal;
//   final String? discountTax;
//   final String? shippingTotal;
//   final String? shippingTax;
//   final String? cartTax;
//   final String? total;
//   final String? totalTax;
//   final int? customerId;
//   final String? orderKey;
//   final Billing? billing;
//   final Shipping? shipping;
//   final String? paymentMethod;
//   final String? paymentMethodTitle;
//   final String? transactionId;
//   final String? customerIpAddress;
//   final String? customerUserAgent;
//   final String? createdVia;
//   final String? customerNote;
//   final dynamic dateCompleted;
//   final String? datePaid;
//   final String? cartHash;
//   final String? number;
//   final List<MetaData>? metaData;
//   final List<LineItems>? lineItems;
//   final List<dynamic>? taxLines;
//   final List<ShippingLines>? shippingLines;
//   final List<dynamic>? feeLines;
//   final List<dynamic>? couponLines;
//   final List<dynamic>? refunds;
//   final String? dateCreatedGmt;
//   final String? dateModifiedGmt;
//   final dynamic dateCompletedGmt;
//   final String? datePaidGmt;
//   final String? currencySymbol;
//   final Links? links;

//   OrderGet({
//     this.id,
//     this.parentId,
//     this.status,
//     this.currency,
//     this.version,
//     this.pricesIncludeTax,
//     this.dateCreated,
//     this.dateModified,
//     this.discountTotal,
//     this.discountTax,
//     this.shippingTotal,
//     this.shippingTax,
//     this.cartTax,
//     this.total,
//     this.totalTax,
//     this.customerId,
//     this.orderKey,
//     this.billing,
//     this.shipping,
//     this.paymentMethod,
//     this.paymentMethodTitle,
//     this.transactionId,
//     this.customerIpAddress,
//     this.customerUserAgent,
//     this.createdVia,
//     this.customerNote,
//     this.dateCompleted,
//     this.datePaid,
//     this.cartHash,
//     this.number,
//     this.metaData,
//     this.lineItems,
//     this.taxLines,
//     this.shippingLines,
//     this.feeLines,
//     this.couponLines,
//     this.refunds,
//     this.dateCreatedGmt,
//     this.dateModifiedGmt,
//     this.dateCompletedGmt,
//     this.datePaidGmt,
//     this.currencySymbol,
//     this.links,
//   });

//   OrderGet.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         parentId = json['parent_id'] as int?,
//         status = json['status'] as String?,
//         currency = json['currency'] as String?,
//         version = json['version'] as String?,
//         pricesIncludeTax = json['prices_include_tax'] as bool?,
//         dateCreated = json['date_created'] as String?,
//         dateModified = json['date_modified'] as String?,
//         discountTotal = json['discount_total'] as String?,
//         discountTax = json['discount_tax'] as String?,
//         shippingTotal = json['shipping_total'] as String?,
//         shippingTax = json['shipping_tax'] as String?,
//         cartTax = json['cart_tax'] as String?,
//         total = json['total'] as String?,
//         totalTax = json['total_tax'] as String?,
//         customerId = json['customer_id'] as int?,
//         orderKey = json['order_key'] as String?,
//         billing = (json['billing'] as Map<String, dynamic>?) != null
//             ? Billing.fromJson(json['billing'] as Map<String, dynamic>)
//             : null,
//         shipping = (json['shipping'] as Map<String, dynamic>?) != null
//             ? Shipping.fromJson(json['shipping'] as Map<String, dynamic>)
//             : null,
//         paymentMethod = json['payment_method'] as String?,
//         paymentMethodTitle = json['payment_method_title'] as String?,
//         transactionId = json['transaction_id'] as String?,
//         customerIpAddress = json['customer_ip_address'] as String?,
//         customerUserAgent = json['customer_user_agent'] as String?,
//         createdVia = json['created_via'] as String?,
//         customerNote = json['customer_note'] as String?,
//         dateCompleted = json['date_completed'],
//         datePaid = json['date_paid'] as String?,
//         cartHash = json['cart_hash'] as String?,
//         number = json['number'] as String?,
//         metaData = (json['meta_data'] as List?)
//             ?.map((dynamic e) => MetaData.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         lineItems = (json['line_items'] as List?)
//             ?.map((dynamic e) => LineItems.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         taxLines = json['tax_lines'] as List?,
//         shippingLines = (json['shipping_lines'] as List?)
//             ?.map((dynamic e) =>
//                 ShippingLines.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         feeLines = json['fee_lines'] as List?,
//         couponLines = json['coupon_lines'] as List?,
//         refunds = json['refunds'] as List?,
//         dateCreatedGmt = json['date_created_gmt'] as String?,
//         dateModifiedGmt = json['date_modified_gmt'] as String?,
//         dateCompletedGmt = json['date_completed_gmt'],
//         datePaidGmt = json['date_paid_gmt'] as String?,
//         currencySymbol = json['currency_symbol'] as String?,
//         links = (json['_links'] as Map<String, dynamic>?) != null
//             ? Links.fromJson(json['_links'] as Map<String, dynamic>)
//             : null;

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'parent_id': parentId,
//         'status': status,
//         'currency': currency,
//         'version': version,
//         'prices_include_tax': pricesIncludeTax,
//         'date_created': dateCreated,
//         'date_modified': dateModified,
//         'discount_total': discountTotal,
//         'discount_tax': discountTax,
//         'shipping_total': shippingTotal,
//         'shipping_tax': shippingTax,
//         'cart_tax': cartTax,
//         'total': total,
//         'total_tax': totalTax,
//         'customer_id': customerId,
//         'order_key': orderKey,
//         'billing': billing?.toJson(),
//         'shipping': shipping?.toJson(),
//         'payment_method': paymentMethod,
//         'payment_method_title': paymentMethodTitle,
//         'transaction_id': transactionId,
//         'customer_ip_address': customerIpAddress,
//         'customer_user_agent': customerUserAgent,
//         'created_via': createdVia,
//         'customer_note': customerNote,
//         'date_completed': dateCompleted,
//         'date_paid': datePaid,
//         'cart_hash': cartHash,
//         'number': number,
//         'meta_data': metaData?.map((e) => e.toJson()).toList(),
//         'line_items': lineItems?.map((e) => e.toJson()).toList(),
//         'tax_lines': taxLines,
//         'shipping_lines': shippingLines?.map((e) => e.toJson()).toList(),
//         'fee_lines': feeLines,
//         'coupon_lines': couponLines,
//         'refunds': refunds,
//         'date_created_gmt': dateCreatedGmt,
//         'date_modified_gmt': dateModifiedGmt,
//         'date_completed_gmt': dateCompletedGmt,
//         'date_paid_gmt': datePaidGmt,
//         'currency_symbol': currencySymbol,
//         '_links': links?.toJson()
//       };
// }

// class Billing {
//   final String? firstName;
//   final String? lastName;
//   final String? company;
//   final String? address1;
//   final String? address2;
//   final String? city;
//   final String? state;
//   final String? postcode;
//   final String? country;
//   final String? email;
//   final String? phone;

//   Billing({
//     this.firstName,
//     this.lastName,
//     this.company,
//     this.address1,
//     this.address2,
//     this.city,
//     this.state,
//     this.postcode,
//     this.country,
//     this.email,
//     this.phone,
//   });

//   Billing.fromJson(Map<String, dynamic> json)
//       : firstName = json['first_name'] as String?,
//         lastName = json['last_name'] as String?,
//         company = json['company'] as String?,
//         address1 = json['address_1'] as String?,
//         address2 = json['address_2'] as String?,
//         city = json['city'] as String?,
//         state = json['state'] as String?,
//         postcode = json['postcode'] as String?,
//         country = json['country'] as String?,
//         email = json['email'] as String?,
//         phone = json['phone'] as String?;

//   Map<String, dynamic> toJson() => {
//         'first_name': firstName,
//         'last_name': lastName,
//         'company': company,
//         'address_1': address1,
//         'address_2': address2,
//         'city': city,
//         'state': state,
//         'postcode': postcode,
//         'country': country,
//         'email': email,
//         'phone': phone
//       };
// }

// class Shipping {
//   final String? firstName;
//   final String? lastName;
//   final String? company;
//   final String? address1;
//   final String? address2;
//   final String? city;
//   final String? state;
//   final String? postcode;
//   final String? country;
//   final String? phone;

//   Shipping({
//     this.firstName,
//     this.lastName,
//     this.company,
//     this.address1,
//     this.address2,
//     this.city,
//     this.state,
//     this.postcode,
//     this.country,
//     this.phone,
//   });

//   Shipping.fromJson(Map<String, dynamic> json)
//       : firstName = json['first_name'] as String?,
//         lastName = json['last_name'] as String?,
//         company = json['company'] as String?,
//         address1 = json['address_1'] as String?,
//         address2 = json['address_2'] as String?,
//         city = json['city'] as String?,
//         state = json['state'] as String?,
//         postcode = json['postcode'] as String?,
//         country = json['country'] as String?,
//         phone = json['phone'] as String?;

//   Map<String, dynamic> toJson() => {
//         'first_name': firstName,
//         'last_name': lastName,
//         'company': company,
//         'address_1': address1,
//         'address_2': address2,
//         'city': city,
//         'state': state,
//         'postcode': postcode,
//         'country': country,
//         'phone': phone
//       };
// }

// class MetaData {
//   final int? id;
//   final String? key;
//   final String? value;

//   MetaData({
//     this.id,
//     this.key,
//     this.value,
//   });

//   MetaData.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         key = json['key'] as String?,
//         value = json['value'] as String?;

//   Map<String, dynamic> toJson() => {'id': id, 'key': key, 'value': value};
// }

// class LineItems {
//   final int? id;
//   final String? name;
//   final int? productId;
//   final int? variationId;
//   final int? quantity;
//   final String? taxClass;
//   final String? subtotal;
//   final String? subtotalTax;
//   final String? total;
//   final String? totalTax;
//   final List<dynamic>? taxes;
//   final List<MetaData>? metaData;
//   final String? sku;
//   final int? price;
//   final dynamic parentName;

//   LineItems({
//     this.id,
//     this.name,
//     this.productId,
//     this.variationId,
//     this.quantity,
//     this.taxClass,
//     this.subtotal,
//     this.subtotalTax,
//     this.total,
//     this.totalTax,
//     this.taxes,
//     this.metaData,
//     this.sku,
//     this.price,
//     this.parentName,
//   });

//   LineItems.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         productId = json['product_id'] as int?,
//         variationId = json['variation_id'] as int?,
//         quantity = json['quantity'] as int?,
//         taxClass = json['tax_class'] as String?,
//         subtotal = json['subtotal'] as String?,
//         subtotalTax = json['subtotal_tax'] as String?,
//         total = json['total'] as String?,
//         totalTax = json['total_tax'] as String?,
//         taxes = json['taxes'] as List?,
//         metaData = (json['meta_data'] as List?)
//             ?.map((dynamic e) => MetaData.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         sku = json['sku'] as String?,
//         price = json['price'] as int?,
//         parentName = json['parent_name'];

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'product_id': productId,
//         'variation_id': variationId,
//         'quantity': quantity,
//         'tax_class': taxClass,
//         'subtotal': subtotal,
//         'subtotal_tax': subtotalTax,
//         'total': total,
//         'total_tax': totalTax,
//         'taxes': taxes,
//         'meta_data': metaData?.map((e) => e.toJson()).toList(),
//         'sku': sku,
//         'price': price,
//         'parent_name': parentName
//       };
// }

// class MetaData1 {
//   final int? id;
//   final String? key;
//   final String? value;
//   final String? displayKey;
//   final String? displayValue;

//   MetaData1({
//     this.id,
//     this.key,
//     this.value,
//     this.displayKey,
//     this.displayValue,
//   });

//   MetaData1.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         key = json['key'] as String?,
//         value = json['value'] as String?,
//         displayKey = json['display_key'] as String?,
//         displayValue = json['display_value'] as String?;

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'key': key,
//         'value': value,
//         'display_key': displayKey,
//         'display_value': displayValue
//       };
// }

// class ShippingLines {
//   final int? id;
//   final String? methodTitle;
//   final String? methodId;
//   final String? instanceId;
//   final String? total;
//   final String? totalTax;
//   final List<dynamic>? taxes;
//   final List<dynamic>? metaData;

//   ShippingLines({
//     this.id,
//     this.methodTitle,
//     this.methodId,
//     this.instanceId,
//     this.total,
//     this.totalTax,
//     this.taxes,
//     this.metaData,
//   });

//   ShippingLines.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         methodTitle = json['method_title'] as String?,
//         methodId = json['method_id'] as String?,
//         instanceId = json['instance_id'] as String?,
//         total = json['total'] as String?,
//         totalTax = json['total_tax'] as String?,
//         taxes = json['taxes'] as List?,
//         metaData = json['meta_data'] as List?;

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'method_title': methodTitle,
//         'method_id': methodId,
//         'instance_id': instanceId,
//         'total': total,
//         'total_tax': totalTax,
//         'taxes': taxes,
//         'meta_data': metaData
//       };
// }

// class Links {
//   final List<Self>? self;
//   final List<Collection>? collection;
//   final List<Customer>? customer;

//   Links({
//     this.self,
//     this.collection,
//     this.customer,
//   });

//   Links.fromJson(Map<String, dynamic> json)
//       : self = (json['self'] as List?)
//             ?.map((dynamic e) => Self.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         collection = (json['collection'] as List?)
//             ?.map((dynamic e) => Collection.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         customer = (json['customer'] as List?)
//             ?.map((dynamic e) => Customer.fromJson(e as Map<String, dynamic>))
//             .toList();

//   Map<String, dynamic> toJson() => {
//         'self': self?.map((e) => e.toJson()).toList(),
//         'collection': collection?.map((e) => e.toJson()).toList(),
//         'customer': customer?.map((e) => e.toJson()).toList()
//       };
// }

// class Self {
//   final String? href;

//   Self({
//     this.href,
//   });

//   Self.fromJson(Map<String, dynamic> json) : href = json['href'] as String?;

//   Map<String, dynamic> toJson() => {'href': href};
// }

// class Collection {
//   final String? href;

//   Collection({
//     this.href,
//   });

//   Collection.fromJson(Map<String, dynamic> json)
//       : href = json['href'] as String?;

//   Map<String, dynamic> toJson() => {'href': href};
// }

// class Customer {
//   final String? href;

//   Customer({
//     this.href,
//   });

//   Customer.fromJson(Map<String, dynamic> json) : href = json['href'] as String?;

//   Map<String, dynamic> toJson() => {'href': href};
// }
