abstract class AppCubitModeStates {}

class AppCubitModeInitialState extends AppCubitModeStates {}

class AppCubitModeChangeModeState extends AppCubitModeStates {}

class AppCubitModeChangeModeErrorState extends AppCubitModeStates {
  final String error;

  AppCubitModeChangeModeErrorState(this.error);
}
