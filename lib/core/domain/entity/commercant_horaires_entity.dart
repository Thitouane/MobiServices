import 'package:mobideliv/core/utils/utils.dart' as utils;

class CommercantCreneauxEntity {
  String? id; // day
  List<Creneau>? horaires;

  CommercantCreneauxEntity({this.id, this.horaires});

  factory CommercantCreneauxEntity.fromJson(String id, Map<String, dynamic> json) {
    return CommercantCreneauxEntity(
      id: id,
      horaires: (json['horaires'] as List).map((element) {
        return Creneau.fromJson(element);
      }).toList(),
    );
  }
}

class Creneau {
  String? end;
  String? start;

  Creneau({this.end, this.start});

  Creneau.fromJson(Map<String, dynamic> json) {
    end = json['end'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['end'] = end;
    data['start'] = start;
    return data;
  }

  @override
  String toString() {
    String startString = utils.parseTime(start);
    String endString = utils.parseTime(end);
    return '$startString - $endString';
  }
}
