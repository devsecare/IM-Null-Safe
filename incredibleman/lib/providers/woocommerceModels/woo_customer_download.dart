class WooCustomerDownload {
  String? downloadId;
  String? downloadUrl;
  int? productId;
  String? productName;
  String? downloadName;
  int? orderId;
  String? orderKey;
  String? downloadsRemaining;
  String? accessExpires;
  String? accessExpiresGmt;
  WooCustomerDownloadFile? file;

  WooCustomerDownload(
      {this.downloadId,
      this.downloadUrl,
      this.productId,
      this.productName,
      this.downloadName,
      this.orderId,
      this.orderKey,
      this.downloadsRemaining,
      this.accessExpires,
      this.accessExpiresGmt,
      this.file});

  WooCustomerDownload.fromJson(Map<String, dynamic> json) {
    downloadId = json['download_id'];
    downloadUrl = json['download_url'];
    productId = json['product_id'];
    productName = json['product_name'];
    downloadName = json['download_name'];
    orderId = json['order_id'];
    orderKey = json['order_key'];
    downloadsRemaining = json['downloads_remaining'];
    accessExpires = json['access_expires'];
    accessExpiresGmt = json['access_expires_gmt'];
    file = json['file'] != null
        ? WooCustomerDownloadFile.fromJson(json['file'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['download_id'] = downloadId;
    data['download_url'] = downloadUrl;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['download_name'] = downloadName;
    data['order_id'] = orderId;
    data['order_key'] = orderKey;
    data['downloads_remaining'] = downloadsRemaining;
    data['access_expires'] = accessExpires;
    data['access_expires_gmt'] = accessExpiresGmt;
    if (file != null) {
      data['file'] = file!.toJson();
    }
    return data;
  }
}

class WooCustomerDownloadFile {
  String? name;
  String? file;

  WooCustomerDownloadFile({this.name, this.file});

  WooCustomerDownloadFile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['file'] = file;
    return data;
  }
}
