part of 'app_cubit.dart';

@immutable
sealed class AppStates {}

final class AppIntaialState extends AppStates {}

final class AppChangeBottomNavBarState extends AppStates {}
final class AppCreateDatabaseState extends AppStates{}
final class AppInsertDatabaseState extends AppStates{}
final class AppGetDataFromDatabaseState extends AppStates{}
final class AppGetDataFromDatabaseLoadingState extends AppStates{}
final class AppUpdateDatabaseState extends AppStates{}
final class AppDeleteDatabaseState extends AppStates{}
final class AppChangeBottomSheetState extends AppStates{}


