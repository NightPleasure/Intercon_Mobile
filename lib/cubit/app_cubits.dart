import 'package:bloc/bloc.dart';
import 'package:master_class_travel_app/cubit/app_cubit_states.dart';
import 'package:master_class_travel_app/model/data_model.dart';
import 'package:master_class_travel_app/services/data_services.dart';

class AppCubits extends Cubit<CubitStates>{
  AppCubits({required this.data}) : super(InitialState()){
    emit(WelcomeState());
  }

  final DataServices data;
  late final places;
  Future<void> getData() async {
    try{
      emit(LoadingState());
      places =await data.getInfo();
      print(places);
      emit(LoadedState(places));



    }catch(e){

    }
  }

  detailPge(DataModel data){
    emit(DetailState(data));
  }

  goHome(){
    emit(LoadedState(places));
  }
}