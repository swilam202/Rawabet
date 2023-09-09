import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setup({required String id}){
  getIt.registerSingleton<String>(id);
}