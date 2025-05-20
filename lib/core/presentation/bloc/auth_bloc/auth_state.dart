part of 'auth_cubit.dart';

enum AuthenticationStatus { unknown, authenticated, unAuthenticated, tokenExpired, serverError }

class AuthenticationState extends Equatable {
  const AuthenticationState._({this.status = AuthenticationStatus.unknown});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated() : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unAuthenticated);

  const AuthenticationState.serverError() : this._(status: AuthenticationStatus.serverError);
  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}
