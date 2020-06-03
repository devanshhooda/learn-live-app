import 'package:flutter_tagging/flutter_tagging.dart';

class ProfessionsFiltersModel {
  static Future<List<ProfessionsFilter>> getFilters(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    List<ProfessionsFilter> filters = [
      ProfessionsFilter(name: 'Software Development Engineer'),
      ProfessionsFilter(name: 'Data Scientist'),
      ProfessionsFilter(name: 'Chief Executive Officer'),
      ProfessionsFilter(name: 'Manager'),
      ProfessionsFilter(name: 'System Analyst'),
      ProfessionsFilter(name: 'Mobile App Developer'),
      ProfessionsFilter(name: 'System Analyst'),
    ]
        .where(
            (filter) => filter.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filters;
  }
}

class ProfessionsFilter extends Taggable {
  String name;

  ProfessionsFilter({this.name});

  @override
  List<Object> get props => [name];

  String toJson() => '''
  {
    "name" : ${this.name},
  }''';
}
