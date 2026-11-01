import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('FoodRow')
class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seedKey => text().nullable().unique()();
  TextColumn get nameEn => text()();
  TextColumn get nameHi => text().nullable()();
  TextColumn get nameKn => text().nullable()();
  TextColumn get aliases => text()(); // pipe-separated
  TextColumn get category => text()();
  TextColumn get diet => text()(); // vegan, veg, egg, nonveg
  RealColumn get kcalPer100 => real()();
  RealColumn get proteinPer100 => real()();
  RealColumn get carbsPer100 => real()();
  RealColumn get fatPer100 => real()();
  RealColumn get fibrePer100 => real()();
  TextColumn get allergens => text()(); // comma-separated ids
  TextColumn get tags => text()(); // comma-separated tags
  BoolColumn get isSample => boolean().withDefault(const Constant(true))();
  TextColumn get source => text().withDefault(const Constant('sample'))();
  TextColumn get barcode => text().nullable()();
}

@DataClassName('PortionRow')
class Portions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get foodId => integer().references(Foods, #id, onDelete: KeyAction.cascade)();
  TextColumn get label => text()();
  RealColumn get grams => real()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}

@DataClassName('FoodLogRow')
class FoodLogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get foodId =>
      integer().nullable().references(Foods, #id, onDelete: KeyAction.setNull)();
  TextColumn get foodName => text()();
  TextColumn get meal => text()();
  DateTimeColumn get loggedAt => dateTime()();
  RealColumn get quantity => real()();
  TextColumn get portionLabel => text()();
  RealColumn get portionGrams => real()();
  RealColumn get kcal => real()();
  RealColumn get proteinG => real()();
  RealColumn get carbsG => real()();
  RealColumn get fatG => real()();
  RealColumn get fibreG => real()();
}

@DriftDatabase(tables: [Foods, Portions, FoodLogEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? driftDatabase(name: 'nutri_sense'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );
}
