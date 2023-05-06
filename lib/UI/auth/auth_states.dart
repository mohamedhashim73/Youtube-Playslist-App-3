abstract class AuthStates{}

class InitialAppState extends AuthStates{}
class LoginSuccessState extends AuthStates{}
class LoginLoadingState extends AuthStates{}
class FailedToLoginState extends AuthStates{}
class RegisterLoadingState extends AuthStates{}
class FailedToSaveUserDataOnFirestoreState extends AuthStates{}
class SaveUserDataOnFirestoreSuccessState extends AuthStates{}
class UserImageSelectedSuccessState extends AuthStates{}
class FailedToGeUserImageSelectedState extends AuthStates{}
class UserCreatedSuccessState extends AuthStates{}
class FailedToCreateUserState extends AuthStates{
  String message;
  FailedToCreateUserState({required this.message});
}