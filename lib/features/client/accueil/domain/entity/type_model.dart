class TypeModel {
  String service;

  TypeModel({
    required this.service,
  });

  void setService(String service){
    this.service = service;
  }

  String getService(){
    return this.service;
  }
  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      service: json['service'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service'] = service;
    return data;
  }
}
