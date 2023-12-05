// To parse this JSON data, do
//
//     final refundResponse = refundResponseFromJson(jsonString);

import 'dart:convert';

RefundResponse refundResponseFromJson(String str) => RefundResponse.fromJson(json.decode(str));

String refundResponseToJson(RefundResponse data) => json.encode(data.toJson());

class RefundResponse {
  List<RefundInfo> data;
  Links links;
  Meta meta;

  RefundResponse({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory RefundResponse.fromJson(Map<String, dynamic> json) => RefundResponse(
    data: List<RefundInfo>.from(json["data"].map((x) => RefundInfo.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class RefundInfo {
  int id;
  String orderCode;
  String amount;
  String productName;
  String status;
  dynamic reson;
  String date;

  RefundInfo({
    required this.id,
    required this.orderCode,
    required this.amount,
    required this.productName,
    required this.status,
    this.reson,
    required this.date,
  });

  factory RefundInfo.fromJson(Map<String, dynamic> json) => RefundInfo(
    id: json["id"],
    orderCode: json["order_code"],
    amount: json["amount"],
    productName: json["product_name"],
    status: json["status"],
    reson: json["reson"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_code": orderCode,
    "amount": amount,
    "product_name": productName,
    "status": status,
    "reson": reson,
    "date": date,
  };
}

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int? from;
  int lastPage;
  List<Link> links;
  String path;
  String perPage;
  int? to;
  int total;

  Meta({
    required this.currentPage,
     this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
     this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
