import 'package:flutter_tagging/flutter_tagging.dart';

class InstituteFiltersSModel {
  static Future<List<InstituteFilter>> getFilters(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    List<InstituteFilter> filters = [
      InstituteFilter(name: 'IIT Kanpur'),
      InstituteFilter(name: 'IIT Delhi'),
      InstituteFilter(name: 'IIT Kharagpur'),
      InstituteFilter(name: 'IIT Chennai'),
      InstituteFilter(name: 'IIT Mumbai'),
      InstituteFilter(name: 'IIIT'),
      InstituteFilter(name: 'DTU'),
      InstituteFilter(name: 'NSUT'),
      InstituteFilter(name: 'Bharati Vidyapeeth (BVP)'),
    ]
        .where(
            (filter) => filter.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filters;
  }
}

class InstituteFilter extends Taggable {
  String name;

  InstituteFilter({this.name});

  @override
  List<Object> get props => [name];

  String toJson() => '''
  {
    "name" : ${this.name},
  }''';
}
