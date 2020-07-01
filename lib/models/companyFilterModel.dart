import 'package:flutter_tagging/flutter_tagging.dart';

class CompanyFiltersSModel {
  static Future<List<CompanyFilter>> getFilters(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    List<CompanyFilter> filters = [
      CompanyFilter(name: 'Google'),
      CompanyFilter(name: 'Amazon'),
      CompanyFilter(name: 'Facebook'),
      CompanyFilter(name: 'Adobe'),
      CompanyFilter(name: 'Nagarro'),
      CompanyFilter(name: 'Apple'),
      CompanyFilter(name: 'Top Brain'),
    ]
        .where(
            (filter) => filter.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filters;
  }
}

class CompanyFilter extends Taggable {
  String name;

  CompanyFilter({this.name});

  @override
  List<Object> get props => [name];

  String toJson() => '''
  {
    "name" : ${this.name},
  }''';
}
