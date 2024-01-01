class AgentData {
  String id = "";
  String? resellerOf;
  int beans = 0;
  int diamonds = 0;
  List<String> paymentMethods = [];
  String? status;

  AgentData({
    this.id = "",
    this.resellerOf,
    this.beans = 0,
    this.diamonds = 0,
    this.paymentMethods = const [],
    this.status,
  });

  factory AgentData.fromJson(Map<String, dynamic> json) {
    return AgentData(
      id: json['id'] ?? "",
      resellerOf: json['resellerOf'],
      beans: json['beans'] ?? 0,
      diamonds: json['diamonds'] ?? 0,
      paymentMethods: json['paymentMethods'] == null
          ? []
          : List<String>.from(json['paymentMethods']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resellerOf': resellerOf,
      'beans': beans,
      'diamonds': diamonds,
      'paymentMethods': paymentMethods,
      'status': status,
    };
  }
}
