abstract class AuthenticationEvent {}

class FetchLogin extends AuthenticationEvent {
  final String email;
  final String password;
  FetchLogin({required this.email, required this.password});
  List<Object> get props => [email, password];
}
