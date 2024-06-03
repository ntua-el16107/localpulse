class User {
  
  String email;
  String password;
  String fullName;

  User({
      required this.email,
      required this.password,
      required this.fullName
   });

   Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName
    };
  }
  User.fromMap(Map<String, dynamic> item): 
      email=item["email"], password= item["password"],
      fullName=item["fullName"];
  @override
  String toString() {
    return 'User{email: $email, password: $password, fullName: $fullName}';
  }
}
