import 'package:flutter_tagging/flutter_tagging.dart';

class SkillsService {
  static Future<List<Skills>> getSkills(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    List<Skills> skills = [
      Skills(name: 'Machine Learning'),
      Skills(name: 'Java'),
      Skills(name: 'C++'),
      Skills(name: 'MongoDB'),
      Skills(name: 'Android'),
      Skills(name: 'iOS'),
      Skills(name: 'Data Science'),
      Skills(name: 'Python'),
      Skills(name: 'Django'),
      Skills(name: 'Matlab'),
      Skills(name: 'MySQL'),
      Skills(name: 'Dart'),
      Skills(name: 'NodeJS'),
      Skills(name: 'AngularJS'),
      Skills(name: 'ReactJS'),
      Skills(name: 'React Native'),
      Skills(name: 'VueJS'),
      Skills(name: 'HTML'),
      Skills(name: 'Swift'),
      Skills(name: 'Flutter'),
    ]
        .where(
            (skill) => skill.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return skills;
  }
}

class Skills extends Taggable {
  String name;

  Skills({this.name});

  @override
  List<Object> get props => [name];

  String toJson() => '''
  {
    "name" : ${this.name},
  }''';
}
