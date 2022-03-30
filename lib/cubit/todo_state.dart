part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class SplashLoading extends TodoState {}

class SplashLoaded extends TodoState {}

class SplashValue extends TodoState {
  final bool auth;

  SplashValue({required this.auth});
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel>? todo;

  TodoLoaded({this.todo});
}

class TodoAdd extends TodoState {}

class TodoAddLoading extends TodoState {}

class TodoAddLoaded extends TodoState {}

class TodoAddError extends TodoState {
  final String? errorMessage;

  TodoAddError({this.errorMessage});
}

class TodoAddSuccess extends TodoState {
  final String errorMessage;

  TodoAddSuccess({required this.errorMessage});
}

class RegisterLoading extends TodoState {}

class RegisterLoaded extends TodoState {}

class RegisterError extends TodoState {
  final dynamic error;

  RegisterError({this.error});
}

class RegisterMessage extends TodoState {
  final String? message;

  RegisterMessage({this.message});
}

class LoginLoading extends TodoState {}

class LoginLoaded extends TodoState {}

class LoginError extends TodoState {
  final dynamic error;

  LoginError({this.error});
}

class LoginMessage extends TodoState {
  final String? message;

  LoginMessage({this.message});
}
