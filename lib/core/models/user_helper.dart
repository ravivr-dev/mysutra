enum UserRole {
  doctor(name: 'DOCTOR'),
  patient(name: 'PATIENT'),
  influencer(name: 'INFLUENCER');
  // guest(name: 'GUEST');

  final String name;

  const UserRole({required this.name});

  static UserRole getUserRole(String role) {
    if (role == UserRole.doctor.name) {
      return UserRole.doctor;
    } else if (role == UserRole.patient.name) {
      return UserRole.patient;
    } else if (role == UserRole.influencer.name) {
      return UserRole.influencer;
    }
    /*else if (role == UserRole.guest.name) {
      return UserRole.guest;
    }*/
    throw Exception('There is no User Role matched with this role $role');
  }
}

class UserHelper {
  late UserRole userRole;
  static final UserHelper _instance = UserHelper._();

  UserHelper._();

  static void init({required String role}) {
    _instance.userRole = UserRole.getUserRole(role);
  }

  static UserRole get role => _instance.userRole;
}
