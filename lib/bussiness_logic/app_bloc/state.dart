abstract class AppStates {}

class AppInitialState extends AppStates {}

class LoadingDatabaseState extends AppStates {}

class SuccessfulLoadDatabaseState extends AppStates {}

class ErrorLoadDatabaseState extends AppStates {
  String error;
  ErrorLoadDatabaseState(this.error);
}

class StartConverteValueState extends AppStates {}

class UpdateConverteValueState extends AppStates {}

class ErrorLoadConvertCurrencyState extends AppStates {
  String error;
  ErrorLoadConvertCurrencyState(this.error);
}

class ResetConvertedValueState extends AppStates {}
