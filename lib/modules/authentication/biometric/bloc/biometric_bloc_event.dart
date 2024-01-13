abstract class BiometricEvent {}

class FetchBiometric extends BiometricEvent {
  String? email;
  String? password;
  FetchBiometric({required this.email, required this.password});

  List<Object> get props => [email!, password!];
}
