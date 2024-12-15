import 'package:get_it/get_it.dart';
import 'package:psychology_app/features/test/data/category_loader.dart';
import 'package:psychology_app/features/test/data/json_reader.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Регистрация зависимостей
  getIt.registerLazySingleton<JsonReader>(() => JsonReader());
  getIt.registerLazySingleton<CategoryLoader>(() => CategoryLoader());
  //getIt.registerLazySingleton<TestRepository>(() => TestRepository());
  // Добавляйте другие сервисы/репозитории по мере необходимости
}

