class UserModel {
  String id,
      phoneNumber,
      name,
      bio,
      profession,
      company,
      institute,
      currentCity,
      homeCity;
  int age, graduationYear;
  List connects, sentRequests, receivedRequests;

  UserModel(
      {this.id,
      this.age,
      this.bio,
      this.currentCity,
      this.graduationYear,
      this.homeCity,
      this.name,
      this.company,
      this.institute,
      this.profession,
      this.phoneNumber,
      this.connects,
      this.sentRequests,
      this.receivedRequests});
}
