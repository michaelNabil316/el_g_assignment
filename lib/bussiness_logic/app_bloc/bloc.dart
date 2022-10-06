import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Data/services/api/countries.dart';
import '../../Data/services/api/currency_api.dart';
import '../../Data/sqlite_helper/sqflite_helper.dart';
import '../../presentation/models/country.dart';
import 'state.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());
  static AppBloc get(context) => BlocProvider.of(context);
  DbHelper dBHelper = DbHelper();
  SharedPreferences? preferences;
  CurrencyApi currencyApi = CurrencyApi();
  CountriesApi countriesApi = CountriesApi();
  double convertedValue = 0.0;
  Map<String, dynamic>? availlableCountriesState;
  List<Country> countries = [];

  void createDB() async {
    emit(LoadingDatabaseState());
    preferences = await SharedPreferences.getInstance();
    await dBHelper.createDataBase();
    dBHelper.getRoomsDatabase().then((value) {
      // rooms = value;
      // for (var r in rooms) {
      // }
      emit(SuccessfulLoadDatabaseState());
    }).catchError((error) {
      emit(ErrorLoadDatabaseState(error.toString()));
    });
  }

  Future convertCurrency() async {
    emit(StartConverteValueState());
    try {
      final response = await currencyApi.getCurrencyFromTo(10, "USD", "PHP");
      if (!response['error']) {
        convertedValue = response['value'];
        emit(UpdateConverteValueState());
      }
    } catch (error) {
      log("convertCurrency error: $error");
      emit(ErrorLoadConvertCurrencyState(error.toString()));
    }
  }

  Future getCountriesCodes() async {
    emit(StartConverteValueState());
    try {
      final response = await countriesApi.getCountriesNames();
      log("response value: ${response!['value']}");
      if (!response!['error']) {
        availlableCountriesState = response;
        countries = response!['value'].map((element) {
          log("element: ${element.key}");
          Country(name: "egypt", code: "cc");
        }).toList();

        emit(UpdateConverteValueState());
      }
    } catch (error) {
      log("getCountriesCodes error: $error");
      emit(ErrorLoadConvertCurrencyState(error.toString()));
    }
  }

  reSetConvertedValue() {
    convertedValue = 0.0;
    emit(ResetConvertedValueState());
  }

/*
  //save guest who booked only in the datatbase
  saveNewGuestDatabase() {
    // dBHelper.insertNewGuest(currentGuest).then((value) {
    //   rooms = value;
    //   emit(SuccessfulInsertUserState());
    // }).catchError((error) {
    //   emit(ErrorInsertUserState(error.toString()));
    // });
  }


  //keep guest logged in also if closed the app
  getCurrentGuest() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getString('guest') != null) {
      //   currentGuest = preferences.getString('guest');
      //   changeLoggedIn();
      emit(ChangeGuestState());
    }
    if (preferences.getBool('currentGuestSale') != null) {
      guestHaveSale();
    }
    // log("name: $currentGuest, isLoggedIn: $isLoggedIn, have a sale: $haveSale");
  }

  setCurrentGuest(String guest) {
    //   preferences.setString('guest', "$guest");
    //  currentGuest = guest;
    emit(ChangeGuestState());
  }

  getBranchRooms(String branchName) {
    // branchRooms = [];
    // for (Room room in rooms) {
    //   if (room.branch == branchName) {
    //     branchRooms.add(room);
    //   }
    // }
    emit(GetBranchRoomsState());
  }

  //this guest have a sale
  guestHaveSale() {
    // haveSale = true;
    // emit(HaveSaleState());
  }

  //update statues of the task
  void updateRoom(String branchName) async {
    // for (BookedRoomData r in bookedRooms) {
    //   String allGuests = r.guests[0];
    //   for (int i = 1; i < r.guests.length; i++) {
    //     allGuests += ",${r.guests[i]}";
    //   }
    //   await dBHelper.updateRoom(r.databaseId, true, allGuests);
    //   allGuests = "";
    // }
    dBHelper.getRoomsDatabase().then((value) {
      getBranchRooms(branchName);
      emit(SuccessfulRoomDatabaseState());
    }).catchError((error) {
      emit(ErrorRoomDatabaseState(error.toString()));
    });
  }

  //update the list of booked rooms
  // updateBookedList(BookedRoomData room) {
  //   bookedRooms.add(room);
  //   emit(UpdateBookedListState());
  // }

  clearBookedList() {
    // bookedRooms = [];
    emit(ClearBookedListState());
  }

  sumAllCost() {
    // allCost = 0;
    // for (BookedRoomData i in bookedRooms) {
    //   allCost += i.cost;
    // }
    emit(UpdateAllCost());
  }
  */
}
