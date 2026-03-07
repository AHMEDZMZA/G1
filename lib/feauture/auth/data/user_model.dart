class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? role;
  final String? gender;
  final int? yearsOfExperience;
  final List<String>? profileImage;
  final List<String>? portfolio;

  // Additional fields from API response
  final String? userName;
  final String? token;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.role,
    this.gender,
    this.yearsOfExperience,
    this.profileImage,
    this.portfolio,
    this.userName,
    this.token,
  });

  // Convert UserModel to JSON (for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      'Role': role,
      'Gender': gender,
      'YearsOfExperience': yearsOfExperience,
      if (profileImage != null) 'ProfileImage': profileImage,
      if (portfolio != null) 'Portfolio': portfolio,
    };
  }

  // Create UserModel from JSON (when receiving data from API)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['FirstName'] ?? json['firstName'],
      lastName: json['LastName'] ?? json['lastName'],
      email: json['Email'] ?? json['email'],
      password: json['Password'] ?? json['password'],
      confirmPassword: json['ConfirmPassword'] ?? json['confirmPassword'],
      role: json['Role'] ?? json['role'],
      gender: json['Gender'] ?? json['gender'],
      // yearsOfExperience:
      //     json['YearsOfExperience'] ?? json['yearsOfExperience'] ?? 0,
      yearsOfExperience: json['yearsOfExperience'] is int
          ? json['yearsOfExperience']
          : int.tryParse(json['yearsOfExperience']?.toString() ?? ''),

      profileImage: json['ProfileImage'] != null
          ? (json['ProfileImage'] is List
                ? List<String>.from(json['ProfileImage'])
                : null)
          : null,
      portfolio: json['Portfolio'] != null
          ? (json['Portfolio'] is List
                ? List<String>.from(json['Portfolio'])
                : null)
          : null,
      userName: json['userName'] ?? json['UserName'],
      token: json['token'] ?? json['Token'],
    );
  }

  // Create a copy with modified fields
  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    String? role,
    String? gender,
    int? yearsOfExperience,
    List<String>? profileImage,
    List<String>? portfolio,
    String? userName,
    String? token,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      profileImage: profileImage ?? this.profileImage,
      portfolio: portfolio ?? this.portfolio,
      userName: userName ?? this.userName,
      token: token ?? this.token,
    );
  }
}
