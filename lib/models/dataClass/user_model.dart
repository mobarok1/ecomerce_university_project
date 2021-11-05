class UserModel{
  int id;
  String firstName;
  String lastName;
  String phoneNo;
  String email;

  UserModel({required this.id, required this.firstName, required this.lastName, required this.phoneNo, required this.email});
  factory UserModel.fromJSON(Map data){
    return UserModel(
        id: data["id"],
        firstName: data["first_name"],
        lastName: data["last_name"],
        phoneNo: data["phone_no"],
        email: data["email"]
    );
  }


}