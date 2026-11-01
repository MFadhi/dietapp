// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FoodsTable extends Foods with TableInfo<$FoodsTable, FoodRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seedKeyMeta =
      const VerificationMeta('seedKey');
  @override
  late final GeneratedColumn<String> seedKey = GeneratedColumn<String>(
      'seed_key', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameHiMeta = const VerificationMeta('nameHi');
  @override
  late final GeneratedColumn<String> nameHi = GeneratedColumn<String>(
      'name_hi', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameKnMeta = const VerificationMeta('nameKn');
  @override
  late final GeneratedColumn<String> nameKn = GeneratedColumn<String>(
      'name_kn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aliasesMeta =
      const VerificationMeta('aliases');
  @override
  late final GeneratedColumn<String> aliases = GeneratedColumn<String>(
      'aliases', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dietMeta = const VerificationMeta('diet');
  @override
  late final GeneratedColumn<String> diet = GeneratedColumn<String>(
      'diet', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kcalPer100Meta =
      const VerificationMeta('kcalPer100');
  @override
  late final GeneratedColumn<double> kcalPer100 = GeneratedColumn<double>(
      'kcal_per100', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _proteinPer100Meta =
      const VerificationMeta('proteinPer100');
  @override
  late final GeneratedColumn<double> proteinPer100 = GeneratedColumn<double>(
      'protein_per100', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _carbsPer100Meta =
      const VerificationMeta('carbsPer100');
  @override
  late final GeneratedColumn<double> carbsPer100 = GeneratedColumn<double>(
      'carbs_per100', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatPer100Meta =
      const VerificationMeta('fatPer100');
  @override
  late final GeneratedColumn<double> fatPer100 = GeneratedColumn<double>(
      'fat_per100', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fibrePer100Meta =
      const VerificationMeta('fibrePer100');
  @override
  late final GeneratedColumn<double> fibrePer100 = GeneratedColumn<double>(
      'fibre_per100', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _allergensMeta =
      const VerificationMeta('allergens');
  @override
  late final GeneratedColumn<String> allergens = GeneratedColumn<String>(
      'allergens', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSampleMeta =
      const VerificationMeta('isSample');
  @override
  late final GeneratedColumn<bool> isSample = GeneratedColumn<bool>(
      'is_sample', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_sample" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('sample'));
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        seedKey,
        nameEn,
        nameHi,
        nameKn,
        aliases,
        category,
        diet,
        kcalPer100,
        proteinPer100,
        carbsPer100,
        fatPer100,
        fibrePer100,
        allergens,
        tags,
        isSample,
        source,
        barcode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'foods';
  @override
  VerificationContext validateIntegrity(Insertable<FoodRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seed_key')) {
      context.handle(_seedKeyMeta,
          seedKey.isAcceptableOrUnknown(data['seed_key']!, _seedKeyMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_hi')) {
      context.handle(_nameHiMeta,
          nameHi.isAcceptableOrUnknown(data['name_hi']!, _nameHiMeta));
    }
    if (data.containsKey('name_kn')) {
      context.handle(_nameKnMeta,
          nameKn.isAcceptableOrUnknown(data['name_kn']!, _nameKnMeta));
    }
    if (data.containsKey('aliases')) {
      context.handle(_aliasesMeta,
          aliases.isAcceptableOrUnknown(data['aliases']!, _aliasesMeta));
    } else if (isInserting) {
      context.missing(_aliasesMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('diet')) {
      context.handle(
          _dietMeta, diet.isAcceptableOrUnknown(data['diet']!, _dietMeta));
    } else if (isInserting) {
      context.missing(_dietMeta);
    }
    if (data.containsKey('kcal_per100')) {
      context.handle(
          _kcalPer100Meta,
          kcalPer100.isAcceptableOrUnknown(
              data['kcal_per100']!, _kcalPer100Meta));
    } else if (isInserting) {
      context.missing(_kcalPer100Meta);
    }
    if (data.containsKey('protein_per100')) {
      context.handle(
          _proteinPer100Meta,
          proteinPer100.isAcceptableOrUnknown(
              data['protein_per100']!, _proteinPer100Meta));
    } else if (isInserting) {
      context.missing(_proteinPer100Meta);
    }
    if (data.containsKey('carbs_per100')) {
      context.handle(
          _carbsPer100Meta,
          carbsPer100.isAcceptableOrUnknown(
              data['carbs_per100']!, _carbsPer100Meta));
    } else if (isInserting) {
      context.missing(_carbsPer100Meta);
    }
    if (data.containsKey('fat_per100')) {
      context.handle(_fatPer100Meta,
          fatPer100.isAcceptableOrUnknown(data['fat_per100']!, _fatPer100Meta));
    } else if (isInserting) {
      context.missing(_fatPer100Meta);
    }
    if (data.containsKey('fibre_per100')) {
      context.handle(
          _fibrePer100Meta,
          fibrePer100.isAcceptableOrUnknown(
              data['fibre_per100']!, _fibrePer100Meta));
    } else if (isInserting) {
      context.missing(_fibrePer100Meta);
    }
    if (data.containsKey('allergens')) {
      context.handle(_allergensMeta,
          allergens.isAcceptableOrUnknown(data['allergens']!, _allergensMeta));
    } else if (isInserting) {
      context.missing(_allergensMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('is_sample')) {
      context.handle(_isSampleMeta,
          isSample.isAcceptableOrUnknown(data['is_sample']!, _isSampleMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seedKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seed_key']),
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      nameHi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_hi']),
      nameKn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_kn']),
      aliases: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}aliases'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      diet: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}diet'])!,
      kcalPer100: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}kcal_per100'])!,
      proteinPer100: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein_per100'])!,
      carbsPer100: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_per100'])!,
      fatPer100: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_per100'])!,
      fibrePer100: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fibre_per100'])!,
      allergens: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}allergens'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      isSample: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_sample'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
    );
  }

  @override
  $FoodsTable createAlias(String alias) {
    return $FoodsTable(attachedDatabase, alias);
  }
}

class FoodRow extends DataClass implements Insertable<FoodRow> {
  final int id;
  final String? seedKey;
  final String nameEn;
  final String? nameHi;
  final String? nameKn;
  final String aliases;
  final String category;
  final String diet;
  final double kcalPer100;
  final double proteinPer100;
  final double carbsPer100;
  final double fatPer100;
  final double fibrePer100;
  final String allergens;
  final String tags;
  final bool isSample;
  final String source;
  final String? barcode;
  const FoodRow(
      {required this.id,
      this.seedKey,
      required this.nameEn,
      this.nameHi,
      this.nameKn,
      required this.aliases,
      required this.category,
      required this.diet,
      required this.kcalPer100,
      required this.proteinPer100,
      required this.carbsPer100,
      required this.fatPer100,
      required this.fibrePer100,
      required this.allergens,
      required this.tags,
      required this.isSample,
      required this.source,
      this.barcode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || seedKey != null) {
      map['seed_key'] = Variable<String>(seedKey);
    }
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameHi != null) {
      map['name_hi'] = Variable<String>(nameHi);
    }
    if (!nullToAbsent || nameKn != null) {
      map['name_kn'] = Variable<String>(nameKn);
    }
    map['aliases'] = Variable<String>(aliases);
    map['category'] = Variable<String>(category);
    map['diet'] = Variable<String>(diet);
    map['kcal_per100'] = Variable<double>(kcalPer100);
    map['protein_per100'] = Variable<double>(proteinPer100);
    map['carbs_per100'] = Variable<double>(carbsPer100);
    map['fat_per100'] = Variable<double>(fatPer100);
    map['fibre_per100'] = Variable<double>(fibrePer100);
    map['allergens'] = Variable<String>(allergens);
    map['tags'] = Variable<String>(tags);
    map['is_sample'] = Variable<bool>(isSample);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    return map;
  }

  FoodsCompanion toCompanion(bool nullToAbsent) {
    return FoodsCompanion(
      id: Value(id),
      seedKey: seedKey == null && nullToAbsent
          ? const Value.absent()
          : Value(seedKey),
      nameEn: Value(nameEn),
      nameHi:
          nameHi == null && nullToAbsent ? const Value.absent() : Value(nameHi),
      nameKn:
          nameKn == null && nullToAbsent ? const Value.absent() : Value(nameKn),
      aliases: Value(aliases),
      category: Value(category),
      diet: Value(diet),
      kcalPer100: Value(kcalPer100),
      proteinPer100: Value(proteinPer100),
      carbsPer100: Value(carbsPer100),
      fatPer100: Value(fatPer100),
      fibrePer100: Value(fibrePer100),
      allergens: Value(allergens),
      tags: Value(tags),
      isSample: Value(isSample),
      source: Value(source),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
    );
  }

  factory FoodRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodRow(
      id: serializer.fromJson<int>(json['id']),
      seedKey: serializer.fromJson<String?>(json['seedKey']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameHi: serializer.fromJson<String?>(json['nameHi']),
      nameKn: serializer.fromJson<String?>(json['nameKn']),
      aliases: serializer.fromJson<String>(json['aliases']),
      category: serializer.fromJson<String>(json['category']),
      diet: serializer.fromJson<String>(json['diet']),
      kcalPer100: serializer.fromJson<double>(json['kcalPer100']),
      proteinPer100: serializer.fromJson<double>(json['proteinPer100']),
      carbsPer100: serializer.fromJson<double>(json['carbsPer100']),
      fatPer100: serializer.fromJson<double>(json['fatPer100']),
      fibrePer100: serializer.fromJson<double>(json['fibrePer100']),
      allergens: serializer.fromJson<String>(json['allergens']),
      tags: serializer.fromJson<String>(json['tags']),
      isSample: serializer.fromJson<bool>(json['isSample']),
      source: serializer.fromJson<String>(json['source']),
      barcode: serializer.fromJson<String?>(json['barcode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seedKey': serializer.toJson<String?>(seedKey),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameHi': serializer.toJson<String?>(nameHi),
      'nameKn': serializer.toJson<String?>(nameKn),
      'aliases': serializer.toJson<String>(aliases),
      'category': serializer.toJson<String>(category),
      'diet': serializer.toJson<String>(diet),
      'kcalPer100': serializer.toJson<double>(kcalPer100),
      'proteinPer100': serializer.toJson<double>(proteinPer100),
      'carbsPer100': serializer.toJson<double>(carbsPer100),
      'fatPer100': serializer.toJson<double>(fatPer100),
      'fibrePer100': serializer.toJson<double>(fibrePer100),
      'allergens': serializer.toJson<String>(allergens),
      'tags': serializer.toJson<String>(tags),
      'isSample': serializer.toJson<bool>(isSample),
      'source': serializer.toJson<String>(source),
      'barcode': serializer.toJson<String?>(barcode),
    };
  }

  FoodRow copyWith(
          {int? id,
          Value<String?> seedKey = const Value.absent(),
          String? nameEn,
          Value<String?> nameHi = const Value.absent(),
          Value<String?> nameKn = const Value.absent(),
          String? aliases,
          String? category,
          String? diet,
          double? kcalPer100,
          double? proteinPer100,
          double? carbsPer100,
          double? fatPer100,
          double? fibrePer100,
          String? allergens,
          String? tags,
          bool? isSample,
          String? source,
          Value<String?> barcode = const Value.absent()}) =>
      FoodRow(
        id: id ?? this.id,
        seedKey: seedKey.present ? seedKey.value : this.seedKey,
        nameEn: nameEn ?? this.nameEn,
        nameHi: nameHi.present ? nameHi.value : this.nameHi,
        nameKn: nameKn.present ? nameKn.value : this.nameKn,
        aliases: aliases ?? this.aliases,
        category: category ?? this.category,
        diet: diet ?? this.diet,
        kcalPer100: kcalPer100 ?? this.kcalPer100,
        proteinPer100: proteinPer100 ?? this.proteinPer100,
        carbsPer100: carbsPer100 ?? this.carbsPer100,
        fatPer100: fatPer100 ?? this.fatPer100,
        fibrePer100: fibrePer100 ?? this.fibrePer100,
        allergens: allergens ?? this.allergens,
        tags: tags ?? this.tags,
        isSample: isSample ?? this.isSample,
        source: source ?? this.source,
        barcode: barcode.present ? barcode.value : this.barcode,
      );
  FoodRow copyWithCompanion(FoodsCompanion data) {
    return FoodRow(
      id: data.id.present ? data.id.value : this.id,
      seedKey: data.seedKey.present ? data.seedKey.value : this.seedKey,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameHi: data.nameHi.present ? data.nameHi.value : this.nameHi,
      nameKn: data.nameKn.present ? data.nameKn.value : this.nameKn,
      aliases: data.aliases.present ? data.aliases.value : this.aliases,
      category: data.category.present ? data.category.value : this.category,
      diet: data.diet.present ? data.diet.value : this.diet,
      kcalPer100:
          data.kcalPer100.present ? data.kcalPer100.value : this.kcalPer100,
      proteinPer100: data.proteinPer100.present
          ? data.proteinPer100.value
          : this.proteinPer100,
      carbsPer100:
          data.carbsPer100.present ? data.carbsPer100.value : this.carbsPer100,
      fatPer100: data.fatPer100.present ? data.fatPer100.value : this.fatPer100,
      fibrePer100:
          data.fibrePer100.present ? data.fibrePer100.value : this.fibrePer100,
      allergens: data.allergens.present ? data.allergens.value : this.allergens,
      tags: data.tags.present ? data.tags.value : this.tags,
      isSample: data.isSample.present ? data.isSample.value : this.isSample,
      source: data.source.present ? data.source.value : this.source,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodRow(')
          ..write('id: $id, ')
          ..write('seedKey: $seedKey, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameHi: $nameHi, ')
          ..write('nameKn: $nameKn, ')
          ..write('aliases: $aliases, ')
          ..write('category: $category, ')
          ..write('diet: $diet, ')
          ..write('kcalPer100: $kcalPer100, ')
          ..write('proteinPer100: $proteinPer100, ')
          ..write('carbsPer100: $carbsPer100, ')
          ..write('fatPer100: $fatPer100, ')
          ..write('fibrePer100: $fibrePer100, ')
          ..write('allergens: $allergens, ')
          ..write('tags: $tags, ')
          ..write('isSample: $isSample, ')
          ..write('source: $source, ')
          ..write('barcode: $barcode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      seedKey,
      nameEn,
      nameHi,
      nameKn,
      aliases,
      category,
      diet,
      kcalPer100,
      proteinPer100,
      carbsPer100,
      fatPer100,
      fibrePer100,
      allergens,
      tags,
      isSample,
      source,
      barcode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodRow &&
          other.id == this.id &&
          other.seedKey == this.seedKey &&
          other.nameEn == this.nameEn &&
          other.nameHi == this.nameHi &&
          other.nameKn == this.nameKn &&
          other.aliases == this.aliases &&
          other.category == this.category &&
          other.diet == this.diet &&
          other.kcalPer100 == this.kcalPer100 &&
          other.proteinPer100 == this.proteinPer100 &&
          other.carbsPer100 == this.carbsPer100 &&
          other.fatPer100 == this.fatPer100 &&
          other.fibrePer100 == this.fibrePer100 &&
          other.allergens == this.allergens &&
          other.tags == this.tags &&
          other.isSample == this.isSample &&
          other.source == this.source &&
          other.barcode == this.barcode);
}

class FoodsCompanion extends UpdateCompanion<FoodRow> {
  final Value<int> id;
  final Value<String?> seedKey;
  final Value<String> nameEn;
  final Value<String?> nameHi;
  final Value<String?> nameKn;
  final Value<String> aliases;
  final Value<String> category;
  final Value<String> diet;
  final Value<double> kcalPer100;
  final Value<double> proteinPer100;
  final Value<double> carbsPer100;
  final Value<double> fatPer100;
  final Value<double> fibrePer100;
  final Value<String> allergens;
  final Value<String> tags;
  final Value<bool> isSample;
  final Value<String> source;
  final Value<String?> barcode;
  const FoodsCompanion({
    this.id = const Value.absent(),
    this.seedKey = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameHi = const Value.absent(),
    this.nameKn = const Value.absent(),
    this.aliases = const Value.absent(),
    this.category = const Value.absent(),
    this.diet = const Value.absent(),
    this.kcalPer100 = const Value.absent(),
    this.proteinPer100 = const Value.absent(),
    this.carbsPer100 = const Value.absent(),
    this.fatPer100 = const Value.absent(),
    this.fibrePer100 = const Value.absent(),
    this.allergens = const Value.absent(),
    this.tags = const Value.absent(),
    this.isSample = const Value.absent(),
    this.source = const Value.absent(),
    this.barcode = const Value.absent(),
  });
  FoodsCompanion.insert({
    this.id = const Value.absent(),
    this.seedKey = const Value.absent(),
    required String nameEn,
    this.nameHi = const Value.absent(),
    this.nameKn = const Value.absent(),
    required String aliases,
    required String category,
    required String diet,
    required double kcalPer100,
    required double proteinPer100,
    required double carbsPer100,
    required double fatPer100,
    required double fibrePer100,
    required String allergens,
    required String tags,
    this.isSample = const Value.absent(),
    this.source = const Value.absent(),
    this.barcode = const Value.absent(),
  })  : nameEn = Value(nameEn),
        aliases = Value(aliases),
        category = Value(category),
        diet = Value(diet),
        kcalPer100 = Value(kcalPer100),
        proteinPer100 = Value(proteinPer100),
        carbsPer100 = Value(carbsPer100),
        fatPer100 = Value(fatPer100),
        fibrePer100 = Value(fibrePer100),
        allergens = Value(allergens),
        tags = Value(tags);
  static Insertable<FoodRow> custom({
    Expression<int>? id,
    Expression<String>? seedKey,
    Expression<String>? nameEn,
    Expression<String>? nameHi,
    Expression<String>? nameKn,
    Expression<String>? aliases,
    Expression<String>? category,
    Expression<String>? diet,
    Expression<double>? kcalPer100,
    Expression<double>? proteinPer100,
    Expression<double>? carbsPer100,
    Expression<double>? fatPer100,
    Expression<double>? fibrePer100,
    Expression<String>? allergens,
    Expression<String>? tags,
    Expression<bool>? isSample,
    Expression<String>? source,
    Expression<String>? barcode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seedKey != null) 'seed_key': seedKey,
      if (nameEn != null) 'name_en': nameEn,
      if (nameHi != null) 'name_hi': nameHi,
      if (nameKn != null) 'name_kn': nameKn,
      if (aliases != null) 'aliases': aliases,
      if (category != null) 'category': category,
      if (diet != null) 'diet': diet,
      if (kcalPer100 != null) 'kcal_per100': kcalPer100,
      if (proteinPer100 != null) 'protein_per100': proteinPer100,
      if (carbsPer100 != null) 'carbs_per100': carbsPer100,
      if (fatPer100 != null) 'fat_per100': fatPer100,
      if (fibrePer100 != null) 'fibre_per100': fibrePer100,
      if (allergens != null) 'allergens': allergens,
      if (tags != null) 'tags': tags,
      if (isSample != null) 'is_sample': isSample,
      if (source != null) 'source': source,
      if (barcode != null) 'barcode': barcode,
    });
  }

  FoodsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? seedKey,
      Value<String>? nameEn,
      Value<String?>? nameHi,
      Value<String?>? nameKn,
      Value<String>? aliases,
      Value<String>? category,
      Value<String>? diet,
      Value<double>? kcalPer100,
      Value<double>? proteinPer100,
      Value<double>? carbsPer100,
      Value<double>? fatPer100,
      Value<double>? fibrePer100,
      Value<String>? allergens,
      Value<String>? tags,
      Value<bool>? isSample,
      Value<String>? source,
      Value<String?>? barcode}) {
    return FoodsCompanion(
      id: id ?? this.id,
      seedKey: seedKey ?? this.seedKey,
      nameEn: nameEn ?? this.nameEn,
      nameHi: nameHi ?? this.nameHi,
      nameKn: nameKn ?? this.nameKn,
      aliases: aliases ?? this.aliases,
      category: category ?? this.category,
      diet: diet ?? this.diet,
      kcalPer100: kcalPer100 ?? this.kcalPer100,
      proteinPer100: proteinPer100 ?? this.proteinPer100,
      carbsPer100: carbsPer100 ?? this.carbsPer100,
      fatPer100: fatPer100 ?? this.fatPer100,
      fibrePer100: fibrePer100 ?? this.fibrePer100,
      allergens: allergens ?? this.allergens,
      tags: tags ?? this.tags,
      isSample: isSample ?? this.isSample,
      source: source ?? this.source,
      barcode: barcode ?? this.barcode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seedKey.present) {
      map['seed_key'] = Variable<String>(seedKey.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameHi.present) {
      map['name_hi'] = Variable<String>(nameHi.value);
    }
    if (nameKn.present) {
      map['name_kn'] = Variable<String>(nameKn.value);
    }
    if (aliases.present) {
      map['aliases'] = Variable<String>(aliases.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (diet.present) {
      map['diet'] = Variable<String>(diet.value);
    }
    if (kcalPer100.present) {
      map['kcal_per100'] = Variable<double>(kcalPer100.value);
    }
    if (proteinPer100.present) {
      map['protein_per100'] = Variable<double>(proteinPer100.value);
    }
    if (carbsPer100.present) {
      map['carbs_per100'] = Variable<double>(carbsPer100.value);
    }
    if (fatPer100.present) {
      map['fat_per100'] = Variable<double>(fatPer100.value);
    }
    if (fibrePer100.present) {
      map['fibre_per100'] = Variable<double>(fibrePer100.value);
    }
    if (allergens.present) {
      map['allergens'] = Variable<String>(allergens.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (isSample.present) {
      map['is_sample'] = Variable<bool>(isSample.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsCompanion(')
          ..write('id: $id, ')
          ..write('seedKey: $seedKey, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameHi: $nameHi, ')
          ..write('nameKn: $nameKn, ')
          ..write('aliases: $aliases, ')
          ..write('category: $category, ')
          ..write('diet: $diet, ')
          ..write('kcalPer100: $kcalPer100, ')
          ..write('proteinPer100: $proteinPer100, ')
          ..write('carbsPer100: $carbsPer100, ')
          ..write('fatPer100: $fatPer100, ')
          ..write('fibrePer100: $fibrePer100, ')
          ..write('allergens: $allergens, ')
          ..write('tags: $tags, ')
          ..write('isSample: $isSample, ')
          ..write('source: $source, ')
          ..write('barcode: $barcode')
          ..write(')'))
        .toString();
  }
}

class $PortionsTable extends Portions
    with TableInfo<$PortionsTable, PortionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PortionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gramsMeta = const VerificationMeta('grams');
  @override
  late final GeneratedColumn<double> grams = GeneratedColumn<double>(
      'grams', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, foodId, label, grams, isDefault];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'portions';
  @override
  VerificationContext validateIntegrity(Insertable<PortionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('grams')) {
      context.handle(
          _gramsMeta, grams.isAcceptableOrUnknown(data['grams']!, _gramsMeta));
    } else if (isInserting) {
      context.missing(_gramsMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PortionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PortionRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      grams: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}grams'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
    );
  }

  @override
  $PortionsTable createAlias(String alias) {
    return $PortionsTable(attachedDatabase, alias);
  }
}

class PortionRow extends DataClass implements Insertable<PortionRow> {
  final int id;
  final int foodId;
  final String label;
  final double grams;
  final bool isDefault;
  const PortionRow(
      {required this.id,
      required this.foodId,
      required this.label,
      required this.grams,
      required this.isDefault});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_id'] = Variable<int>(foodId);
    map['label'] = Variable<String>(label);
    map['grams'] = Variable<double>(grams);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  PortionsCompanion toCompanion(bool nullToAbsent) {
    return PortionsCompanion(
      id: Value(id),
      foodId: Value(foodId),
      label: Value(label),
      grams: Value(grams),
      isDefault: Value(isDefault),
    );
  }

  factory PortionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PortionRow(
      id: serializer.fromJson<int>(json['id']),
      foodId: serializer.fromJson<int>(json['foodId']),
      label: serializer.fromJson<String>(json['label']),
      grams: serializer.fromJson<double>(json['grams']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodId': serializer.toJson<int>(foodId),
      'label': serializer.toJson<String>(label),
      'grams': serializer.toJson<double>(grams),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  PortionRow copyWith(
          {int? id,
          int? foodId,
          String? label,
          double? grams,
          bool? isDefault}) =>
      PortionRow(
        id: id ?? this.id,
        foodId: foodId ?? this.foodId,
        label: label ?? this.label,
        grams: grams ?? this.grams,
        isDefault: isDefault ?? this.isDefault,
      );
  PortionRow copyWithCompanion(PortionsCompanion data) {
    return PortionRow(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      label: data.label.present ? data.label.value : this.label,
      grams: data.grams.present ? data.grams.value : this.grams,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PortionRow(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('label: $label, ')
          ..write('grams: $grams, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, foodId, label, grams, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PortionRow &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.label == this.label &&
          other.grams == this.grams &&
          other.isDefault == this.isDefault);
}

class PortionsCompanion extends UpdateCompanion<PortionRow> {
  final Value<int> id;
  final Value<int> foodId;
  final Value<String> label;
  final Value<double> grams;
  final Value<bool> isDefault;
  const PortionsCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.label = const Value.absent(),
    this.grams = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  PortionsCompanion.insert({
    this.id = const Value.absent(),
    required int foodId,
    required String label,
    required double grams,
    this.isDefault = const Value.absent(),
  })  : foodId = Value(foodId),
        label = Value(label),
        grams = Value(grams);
  static Insertable<PortionRow> custom({
    Expression<int>? id,
    Expression<int>? foodId,
    Expression<String>? label,
    Expression<double>? grams,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (label != null) 'label': label,
      if (grams != null) 'grams': grams,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  PortionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? foodId,
      Value<String>? label,
      Value<double>? grams,
      Value<bool>? isDefault}) {
    return PortionsCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      label: label ?? this.label,
      grams: grams ?? this.grams,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (grams.present) {
      map['grams'] = Variable<double>(grams.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PortionsCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('label: $label, ')
          ..write('grams: $grams, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

class $FoodLogEntriesTable extends FoodLogEntries
    with TableInfo<$FoodLogEntriesTable, FoodLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodLogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _foodNameMeta =
      const VerificationMeta('foodName');
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
      'food_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mealMeta = const VerificationMeta('meal');
  @override
  late final GeneratedColumn<String> meal = GeneratedColumn<String>(
      'meal', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _loggedAtMeta =
      const VerificationMeta('loggedAt');
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
      'logged_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _portionLabelMeta =
      const VerificationMeta('portionLabel');
  @override
  late final GeneratedColumn<String> portionLabel = GeneratedColumn<String>(
      'portion_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _portionGramsMeta =
      const VerificationMeta('portionGrams');
  @override
  late final GeneratedColumn<double> portionGrams = GeneratedColumn<double>(
      'portion_grams', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _kcalMeta = const VerificationMeta('kcal');
  @override
  late final GeneratedColumn<double> kcal = GeneratedColumn<double>(
      'kcal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _proteinGMeta =
      const VerificationMeta('proteinG');
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
      'protein_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
      'carbs_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
      'fat_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fibreGMeta = const VerificationMeta('fibreG');
  @override
  late final GeneratedColumn<double> fibreG = GeneratedColumn<double>(
      'fibre_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        foodId,
        foodName,
        meal,
        loggedAt,
        quantity,
        portionLabel,
        portionGrams,
        kcal,
        proteinG,
        carbsG,
        fatG,
        fibreG
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_log_entries';
  @override
  VerificationContext validateIntegrity(Insertable<FoodLogRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    }
    if (data.containsKey('food_name')) {
      context.handle(_foodNameMeta,
          foodName.isAcceptableOrUnknown(data['food_name']!, _foodNameMeta));
    } else if (isInserting) {
      context.missing(_foodNameMeta);
    }
    if (data.containsKey('meal')) {
      context.handle(
          _mealMeta, meal.isAcceptableOrUnknown(data['meal']!, _mealMeta));
    } else if (isInserting) {
      context.missing(_mealMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(_loggedAtMeta,
          loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta));
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('portion_label')) {
      context.handle(
          _portionLabelMeta,
          portionLabel.isAcceptableOrUnknown(
              data['portion_label']!, _portionLabelMeta));
    } else if (isInserting) {
      context.missing(_portionLabelMeta);
    }
    if (data.containsKey('portion_grams')) {
      context.handle(
          _portionGramsMeta,
          portionGrams.isAcceptableOrUnknown(
              data['portion_grams']!, _portionGramsMeta));
    } else if (isInserting) {
      context.missing(_portionGramsMeta);
    }
    if (data.containsKey('kcal')) {
      context.handle(
          _kcalMeta, kcal.isAcceptableOrUnknown(data['kcal']!, _kcalMeta));
    } else if (isInserting) {
      context.missing(_kcalMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(_proteinGMeta,
          proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta));
    } else if (isInserting) {
      context.missing(_proteinGMeta);
    }
    if (data.containsKey('carbs_g')) {
      context.handle(_carbsGMeta,
          carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta));
    } else if (isInserting) {
      context.missing(_carbsGMeta);
    }
    if (data.containsKey('fat_g')) {
      context.handle(
          _fatGMeta, fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta));
    } else if (isInserting) {
      context.missing(_fatGMeta);
    }
    if (data.containsKey('fibre_g')) {
      context.handle(_fibreGMeta,
          fibreG.isAcceptableOrUnknown(data['fibre_g']!, _fibreGMeta));
    } else if (isInserting) {
      context.missing(_fibreGMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodLogRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id']),
      foodName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_name'])!,
      meal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal'])!,
      loggedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}logged_at'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      portionLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}portion_label'])!,
      portionGrams: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}portion_grams'])!,
      kcal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}kcal'])!,
      proteinG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein_g'])!,
      carbsG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_g'])!,
      fatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_g'])!,
      fibreG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fibre_g'])!,
    );
  }

  @override
  $FoodLogEntriesTable createAlias(String alias) {
    return $FoodLogEntriesTable(attachedDatabase, alias);
  }
}

class FoodLogRow extends DataClass implements Insertable<FoodLogRow> {
  final int id;
  final int? foodId;
  final String foodName;
  final String meal;
  final DateTime loggedAt;
  final double quantity;
  final String portionLabel;
  final double portionGrams;
  final double kcal;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double fibreG;
  const FoodLogRow(
      {required this.id,
      this.foodId,
      required this.foodName,
      required this.meal,
      required this.loggedAt,
      required this.quantity,
      required this.portionLabel,
      required this.portionGrams,
      required this.kcal,
      required this.proteinG,
      required this.carbsG,
      required this.fatG,
      required this.fibreG});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || foodId != null) {
      map['food_id'] = Variable<int>(foodId);
    }
    map['food_name'] = Variable<String>(foodName);
    map['meal'] = Variable<String>(meal);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['quantity'] = Variable<double>(quantity);
    map['portion_label'] = Variable<String>(portionLabel);
    map['portion_grams'] = Variable<double>(portionGrams);
    map['kcal'] = Variable<double>(kcal);
    map['protein_g'] = Variable<double>(proteinG);
    map['carbs_g'] = Variable<double>(carbsG);
    map['fat_g'] = Variable<double>(fatG);
    map['fibre_g'] = Variable<double>(fibreG);
    return map;
  }

  FoodLogEntriesCompanion toCompanion(bool nullToAbsent) {
    return FoodLogEntriesCompanion(
      id: Value(id),
      foodId:
          foodId == null && nullToAbsent ? const Value.absent() : Value(foodId),
      foodName: Value(foodName),
      meal: Value(meal),
      loggedAt: Value(loggedAt),
      quantity: Value(quantity),
      portionLabel: Value(portionLabel),
      portionGrams: Value(portionGrams),
      kcal: Value(kcal),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatG: Value(fatG),
      fibreG: Value(fibreG),
    );
  }

  factory FoodLogRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodLogRow(
      id: serializer.fromJson<int>(json['id']),
      foodId: serializer.fromJson<int?>(json['foodId']),
      foodName: serializer.fromJson<String>(json['foodName']),
      meal: serializer.fromJson<String>(json['meal']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      quantity: serializer.fromJson<double>(json['quantity']),
      portionLabel: serializer.fromJson<String>(json['portionLabel']),
      portionGrams: serializer.fromJson<double>(json['portionGrams']),
      kcal: serializer.fromJson<double>(json['kcal']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      carbsG: serializer.fromJson<double>(json['carbsG']),
      fatG: serializer.fromJson<double>(json['fatG']),
      fibreG: serializer.fromJson<double>(json['fibreG']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodId': serializer.toJson<int?>(foodId),
      'foodName': serializer.toJson<String>(foodName),
      'meal': serializer.toJson<String>(meal),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'quantity': serializer.toJson<double>(quantity),
      'portionLabel': serializer.toJson<String>(portionLabel),
      'portionGrams': serializer.toJson<double>(portionGrams),
      'kcal': serializer.toJson<double>(kcal),
      'proteinG': serializer.toJson<double>(proteinG),
      'carbsG': serializer.toJson<double>(carbsG),
      'fatG': serializer.toJson<double>(fatG),
      'fibreG': serializer.toJson<double>(fibreG),
    };
  }

  FoodLogRow copyWith(
          {int? id,
          Value<int?> foodId = const Value.absent(),
          String? foodName,
          String? meal,
          DateTime? loggedAt,
          double? quantity,
          String? portionLabel,
          double? portionGrams,
          double? kcal,
          double? proteinG,
          double? carbsG,
          double? fatG,
          double? fibreG}) =>
      FoodLogRow(
        id: id ?? this.id,
        foodId: foodId.present ? foodId.value : this.foodId,
        foodName: foodName ?? this.foodName,
        meal: meal ?? this.meal,
        loggedAt: loggedAt ?? this.loggedAt,
        quantity: quantity ?? this.quantity,
        portionLabel: portionLabel ?? this.portionLabel,
        portionGrams: portionGrams ?? this.portionGrams,
        kcal: kcal ?? this.kcal,
        proteinG: proteinG ?? this.proteinG,
        carbsG: carbsG ?? this.carbsG,
        fatG: fatG ?? this.fatG,
        fibreG: fibreG ?? this.fibreG,
      );
  FoodLogRow copyWithCompanion(FoodLogEntriesCompanion data) {
    return FoodLogRow(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      foodName: data.foodName.present ? data.foodName.value : this.foodName,
      meal: data.meal.present ? data.meal.value : this.meal,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      portionLabel: data.portionLabel.present
          ? data.portionLabel.value
          : this.portionLabel,
      portionGrams: data.portionGrams.present
          ? data.portionGrams.value
          : this.portionGrams,
      kcal: data.kcal.present ? data.kcal.value : this.kcal,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      fibreG: data.fibreG.present ? data.fibreG.value : this.fibreG,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogRow(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('foodName: $foodName, ')
          ..write('meal: $meal, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('quantity: $quantity, ')
          ..write('portionLabel: $portionLabel, ')
          ..write('portionGrams: $portionGrams, ')
          ..write('kcal: $kcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('fibreG: $fibreG')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      foodId,
      foodName,
      meal,
      loggedAt,
      quantity,
      portionLabel,
      portionGrams,
      kcal,
      proteinG,
      carbsG,
      fatG,
      fibreG);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodLogRow &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.foodName == this.foodName &&
          other.meal == this.meal &&
          other.loggedAt == this.loggedAt &&
          other.quantity == this.quantity &&
          other.portionLabel == this.portionLabel &&
          other.portionGrams == this.portionGrams &&
          other.kcal == this.kcal &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatG == this.fatG &&
          other.fibreG == this.fibreG);
}

class FoodLogEntriesCompanion extends UpdateCompanion<FoodLogRow> {
  final Value<int> id;
  final Value<int?> foodId;
  final Value<String> foodName;
  final Value<String> meal;
  final Value<DateTime> loggedAt;
  final Value<double> quantity;
  final Value<String> portionLabel;
  final Value<double> portionGrams;
  final Value<double> kcal;
  final Value<double> proteinG;
  final Value<double> carbsG;
  final Value<double> fatG;
  final Value<double> fibreG;
  const FoodLogEntriesCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.foodName = const Value.absent(),
    this.meal = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.quantity = const Value.absent(),
    this.portionLabel = const Value.absent(),
    this.portionGrams = const Value.absent(),
    this.kcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.fibreG = const Value.absent(),
  });
  FoodLogEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    required String foodName,
    required String meal,
    required DateTime loggedAt,
    required double quantity,
    required String portionLabel,
    required double portionGrams,
    required double kcal,
    required double proteinG,
    required double carbsG,
    required double fatG,
    required double fibreG,
  })  : foodName = Value(foodName),
        meal = Value(meal),
        loggedAt = Value(loggedAt),
        quantity = Value(quantity),
        portionLabel = Value(portionLabel),
        portionGrams = Value(portionGrams),
        kcal = Value(kcal),
        proteinG = Value(proteinG),
        carbsG = Value(carbsG),
        fatG = Value(fatG),
        fibreG = Value(fibreG);
  static Insertable<FoodLogRow> custom({
    Expression<int>? id,
    Expression<int>? foodId,
    Expression<String>? foodName,
    Expression<String>? meal,
    Expression<DateTime>? loggedAt,
    Expression<double>? quantity,
    Expression<String>? portionLabel,
    Expression<double>? portionGrams,
    Expression<double>? kcal,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatG,
    Expression<double>? fibreG,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (foodName != null) 'food_name': foodName,
      if (meal != null) 'meal': meal,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (quantity != null) 'quantity': quantity,
      if (portionLabel != null) 'portion_label': portionLabel,
      if (portionGrams != null) 'portion_grams': portionGrams,
      if (kcal != null) 'kcal': kcal,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatG != null) 'fat_g': fatG,
      if (fibreG != null) 'fibre_g': fibreG,
    });
  }

  FoodLogEntriesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? foodId,
      Value<String>? foodName,
      Value<String>? meal,
      Value<DateTime>? loggedAt,
      Value<double>? quantity,
      Value<String>? portionLabel,
      Value<double>? portionGrams,
      Value<double>? kcal,
      Value<double>? proteinG,
      Value<double>? carbsG,
      Value<double>? fatG,
      Value<double>? fibreG}) {
    return FoodLogEntriesCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      foodName: foodName ?? this.foodName,
      meal: meal ?? this.meal,
      loggedAt: loggedAt ?? this.loggedAt,
      quantity: quantity ?? this.quantity,
      portionLabel: portionLabel ?? this.portionLabel,
      portionGrams: portionGrams ?? this.portionGrams,
      kcal: kcal ?? this.kcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      fibreG: fibreG ?? this.fibreG,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (foodName.present) {
      map['food_name'] = Variable<String>(foodName.value);
    }
    if (meal.present) {
      map['meal'] = Variable<String>(meal.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (portionLabel.present) {
      map['portion_label'] = Variable<String>(portionLabel.value);
    }
    if (portionGrams.present) {
      map['portion_grams'] = Variable<double>(portionGrams.value);
    }
    if (kcal.present) {
      map['kcal'] = Variable<double>(kcal.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<double>(fatG.value);
    }
    if (fibreG.present) {
      map['fibre_g'] = Variable<double>(fibreG.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('foodName: $foodName, ')
          ..write('meal: $meal, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('quantity: $quantity, ')
          ..write('portionLabel: $portionLabel, ')
          ..write('portionGrams: $portionGrams, ')
          ..write('kcal: $kcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('fibreG: $fibreG')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodsTable foods = $FoodsTable(this);
  late final $PortionsTable portions = $PortionsTable(this);
  late final $FoodLogEntriesTable foodLogEntries = $FoodLogEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [foods, portions, foodLogEntries];
}

typedef $$FoodsTableCreateCompanionBuilder = FoodsCompanion Function({
  Value<int> id,
  Value<String?> seedKey,
  required String nameEn,
  Value<String?> nameHi,
  Value<String?> nameKn,
  required String aliases,
  required String category,
  required String diet,
  required double kcalPer100,
  required double proteinPer100,
  required double carbsPer100,
  required double fatPer100,
  required double fibrePer100,
  required String allergens,
  required String tags,
  Value<bool> isSample,
  Value<String> source,
  Value<String?> barcode,
});
typedef $$FoodsTableUpdateCompanionBuilder = FoodsCompanion Function({
  Value<int> id,
  Value<String?> seedKey,
  Value<String> nameEn,
  Value<String?> nameHi,
  Value<String?> nameKn,
  Value<String> aliases,
  Value<String> category,
  Value<String> diet,
  Value<double> kcalPer100,
  Value<double> proteinPer100,
  Value<double> carbsPer100,
  Value<double> fatPer100,
  Value<double> fibrePer100,
  Value<String> allergens,
  Value<String> tags,
  Value<bool> isSample,
  Value<String> source,
  Value<String?> barcode,
});

class $$FoodsTableFilterComposer extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get seedKey => $composableBuilder(
      column: $table.seedKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameHi => $composableBuilder(
      column: $table.nameHi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameKn => $composableBuilder(
      column: $table.nameKn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aliases => $composableBuilder(
      column: $table.aliases, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get diet => $composableBuilder(
      column: $table.diet, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get kcalPer100 => $composableBuilder(
      column: $table.kcalPer100, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinPer100 => $composableBuilder(
      column: $table.proteinPer100, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsPer100 => $composableBuilder(
      column: $table.carbsPer100, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatPer100 => $composableBuilder(
      column: $table.fatPer100, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fibrePer100 => $composableBuilder(
      column: $table.fibrePer100, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get allergens => $composableBuilder(
      column: $table.allergens, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSample => $composableBuilder(
      column: $table.isSample, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));
}

class $$FoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get seedKey => $composableBuilder(
      column: $table.seedKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameHi => $composableBuilder(
      column: $table.nameHi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameKn => $composableBuilder(
      column: $table.nameKn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aliases => $composableBuilder(
      column: $table.aliases, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get diet => $composableBuilder(
      column: $table.diet, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get kcalPer100 => $composableBuilder(
      column: $table.kcalPer100, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinPer100 => $composableBuilder(
      column: $table.proteinPer100,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsPer100 => $composableBuilder(
      column: $table.carbsPer100, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatPer100 => $composableBuilder(
      column: $table.fatPer100, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fibrePer100 => $composableBuilder(
      column: $table.fibrePer100, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get allergens => $composableBuilder(
      column: $table.allergens, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSample => $composableBuilder(
      column: $table.isSample, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));
}

class $$FoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get seedKey =>
      $composableBuilder(column: $table.seedKey, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameHi =>
      $composableBuilder(column: $table.nameHi, builder: (column) => column);

  GeneratedColumn<String> get nameKn =>
      $composableBuilder(column: $table.nameKn, builder: (column) => column);

  GeneratedColumn<String> get aliases =>
      $composableBuilder(column: $table.aliases, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get diet =>
      $composableBuilder(column: $table.diet, builder: (column) => column);

  GeneratedColumn<double> get kcalPer100 => $composableBuilder(
      column: $table.kcalPer100, builder: (column) => column);

  GeneratedColumn<double> get proteinPer100 => $composableBuilder(
      column: $table.proteinPer100, builder: (column) => column);

  GeneratedColumn<double> get carbsPer100 => $composableBuilder(
      column: $table.carbsPer100, builder: (column) => column);

  GeneratedColumn<double> get fatPer100 =>
      $composableBuilder(column: $table.fatPer100, builder: (column) => column);

  GeneratedColumn<double> get fibrePer100 => $composableBuilder(
      column: $table.fibrePer100, builder: (column) => column);

  GeneratedColumn<String> get allergens =>
      $composableBuilder(column: $table.allergens, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<bool> get isSample =>
      $composableBuilder(column: $table.isSample, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);
}

class $$FoodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodsTable,
    FoodRow,
    $$FoodsTableFilterComposer,
    $$FoodsTableOrderingComposer,
    $$FoodsTableAnnotationComposer,
    $$FoodsTableCreateCompanionBuilder,
    $$FoodsTableUpdateCompanionBuilder,
    (FoodRow, BaseReferences<_$AppDatabase, $FoodsTable, FoodRow>),
    FoodRow,
    PrefetchHooks Function()> {
  $$FoodsTableTableManager(_$AppDatabase db, $FoodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> seedKey = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String?> nameHi = const Value.absent(),
            Value<String?> nameKn = const Value.absent(),
            Value<String> aliases = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> diet = const Value.absent(),
            Value<double> kcalPer100 = const Value.absent(),
            Value<double> proteinPer100 = const Value.absent(),
            Value<double> carbsPer100 = const Value.absent(),
            Value<double> fatPer100 = const Value.absent(),
            Value<double> fibrePer100 = const Value.absent(),
            Value<String> allergens = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<bool> isSample = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
          }) =>
              FoodsCompanion(
            id: id,
            seedKey: seedKey,
            nameEn: nameEn,
            nameHi: nameHi,
            nameKn: nameKn,
            aliases: aliases,
            category: category,
            diet: diet,
            kcalPer100: kcalPer100,
            proteinPer100: proteinPer100,
            carbsPer100: carbsPer100,
            fatPer100: fatPer100,
            fibrePer100: fibrePer100,
            allergens: allergens,
            tags: tags,
            isSample: isSample,
            source: source,
            barcode: barcode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> seedKey = const Value.absent(),
            required String nameEn,
            Value<String?> nameHi = const Value.absent(),
            Value<String?> nameKn = const Value.absent(),
            required String aliases,
            required String category,
            required String diet,
            required double kcalPer100,
            required double proteinPer100,
            required double carbsPer100,
            required double fatPer100,
            required double fibrePer100,
            required String allergens,
            required String tags,
            Value<bool> isSample = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
          }) =>
              FoodsCompanion.insert(
            id: id,
            seedKey: seedKey,
            nameEn: nameEn,
            nameHi: nameHi,
            nameKn: nameKn,
            aliases: aliases,
            category: category,
            diet: diet,
            kcalPer100: kcalPer100,
            proteinPer100: proteinPer100,
            carbsPer100: carbsPer100,
            fatPer100: fatPer100,
            fibrePer100: fibrePer100,
            allergens: allergens,
            tags: tags,
            isSample: isSample,
            source: source,
            barcode: barcode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodsTable,
    FoodRow,
    $$FoodsTableFilterComposer,
    $$FoodsTableOrderingComposer,
    $$FoodsTableAnnotationComposer,
    $$FoodsTableCreateCompanionBuilder,
    $$FoodsTableUpdateCompanionBuilder,
    (FoodRow, BaseReferences<_$AppDatabase, $FoodsTable, FoodRow>),
    FoodRow,
    PrefetchHooks Function()>;
typedef $$PortionsTableCreateCompanionBuilder = PortionsCompanion Function({
  Value<int> id,
  required int foodId,
  required String label,
  required double grams,
  Value<bool> isDefault,
});
typedef $$PortionsTableUpdateCompanionBuilder = PortionsCompanion Function({
  Value<int> id,
  Value<int> foodId,
  Value<String> label,
  Value<double> grams,
  Value<bool> isDefault,
});

class $$PortionsTableFilterComposer
    extends Composer<_$AppDatabase, $PortionsTable> {
  $$PortionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get grams => $composableBuilder(
      column: $table.grams, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));
}

class $$PortionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PortionsTable> {
  $$PortionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get grams => $composableBuilder(
      column: $table.grams, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));
}

class $$PortionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PortionsTable> {
  $$PortionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get grams =>
      $composableBuilder(column: $table.grams, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);
}

class $$PortionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PortionsTable,
    PortionRow,
    $$PortionsTableFilterComposer,
    $$PortionsTableOrderingComposer,
    $$PortionsTableAnnotationComposer,
    $$PortionsTableCreateCompanionBuilder,
    $$PortionsTableUpdateCompanionBuilder,
    (PortionRow, BaseReferences<_$AppDatabase, $PortionsTable, PortionRow>),
    PortionRow,
    PrefetchHooks Function()> {
  $$PortionsTableTableManager(_$AppDatabase db, $PortionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PortionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PortionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PortionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> foodId = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<double> grams = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
          }) =>
              PortionsCompanion(
            id: id,
            foodId: foodId,
            label: label,
            grams: grams,
            isDefault: isDefault,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int foodId,
            required String label,
            required double grams,
            Value<bool> isDefault = const Value.absent(),
          }) =>
              PortionsCompanion.insert(
            id: id,
            foodId: foodId,
            label: label,
            grams: grams,
            isDefault: isDefault,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PortionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PortionsTable,
    PortionRow,
    $$PortionsTableFilterComposer,
    $$PortionsTableOrderingComposer,
    $$PortionsTableAnnotationComposer,
    $$PortionsTableCreateCompanionBuilder,
    $$PortionsTableUpdateCompanionBuilder,
    (PortionRow, BaseReferences<_$AppDatabase, $PortionsTable, PortionRow>),
    PortionRow,
    PrefetchHooks Function()>;
typedef $$FoodLogEntriesTableCreateCompanionBuilder = FoodLogEntriesCompanion
    Function({
  Value<int> id,
  Value<int?> foodId,
  required String foodName,
  required String meal,
  required DateTime loggedAt,
  required double quantity,
  required String portionLabel,
  required double portionGrams,
  required double kcal,
  required double proteinG,
  required double carbsG,
  required double fatG,
  required double fibreG,
});
typedef $$FoodLogEntriesTableUpdateCompanionBuilder = FoodLogEntriesCompanion
    Function({
  Value<int> id,
  Value<int?> foodId,
  Value<String> foodName,
  Value<String> meal,
  Value<DateTime> loggedAt,
  Value<double> quantity,
  Value<String> portionLabel,
  Value<double> portionGrams,
  Value<double> kcal,
  Value<double> proteinG,
  Value<double> carbsG,
  Value<double> fatG,
  Value<double> fibreG,
});

class $$FoodLogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodLogEntriesTable> {
  $$FoodLogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodName => $composableBuilder(
      column: $table.foodName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meal => $composableBuilder(
      column: $table.meal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get portionLabel => $composableBuilder(
      column: $table.portionLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get kcal => $composableBuilder(
      column: $table.kcal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinG => $composableBuilder(
      column: $table.proteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsG => $composableBuilder(
      column: $table.carbsG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatG => $composableBuilder(
      column: $table.fatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fibreG => $composableBuilder(
      column: $table.fibreG, builder: (column) => ColumnFilters(column));
}

class $$FoodLogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodLogEntriesTable> {
  $$FoodLogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodName => $composableBuilder(
      column: $table.foodName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meal => $composableBuilder(
      column: $table.meal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get portionLabel => $composableBuilder(
      column: $table.portionLabel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get kcal => $composableBuilder(
      column: $table.kcal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinG => $composableBuilder(
      column: $table.proteinG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsG => $composableBuilder(
      column: $table.carbsG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatG => $composableBuilder(
      column: $table.fatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fibreG => $composableBuilder(
      column: $table.fibreG, builder: (column) => ColumnOrderings(column));
}

class $$FoodLogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodLogEntriesTable> {
  $$FoodLogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get foodName =>
      $composableBuilder(column: $table.foodName, builder: (column) => column);

  GeneratedColumn<String> get meal =>
      $composableBuilder(column: $table.meal, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get portionLabel => $composableBuilder(
      column: $table.portionLabel, builder: (column) => column);

  GeneratedColumn<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams, builder: (column) => column);

  GeneratedColumn<double> get kcal =>
      $composableBuilder(column: $table.kcal, builder: (column) => column);

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<double> get fibreG =>
      $composableBuilder(column: $table.fibreG, builder: (column) => column);
}

class $$FoodLogEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodLogEntriesTable,
    FoodLogRow,
    $$FoodLogEntriesTableFilterComposer,
    $$FoodLogEntriesTableOrderingComposer,
    $$FoodLogEntriesTableAnnotationComposer,
    $$FoodLogEntriesTableCreateCompanionBuilder,
    $$FoodLogEntriesTableUpdateCompanionBuilder,
    (
      FoodLogRow,
      BaseReferences<_$AppDatabase, $FoodLogEntriesTable, FoodLogRow>
    ),
    FoodLogRow,
    PrefetchHooks Function()> {
  $$FoodLogEntriesTableTableManager(
      _$AppDatabase db, $FoodLogEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodLogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodLogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodLogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> foodId = const Value.absent(),
            Value<String> foodName = const Value.absent(),
            Value<String> meal = const Value.absent(),
            Value<DateTime> loggedAt = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<String> portionLabel = const Value.absent(),
            Value<double> portionGrams = const Value.absent(),
            Value<double> kcal = const Value.absent(),
            Value<double> proteinG = const Value.absent(),
            Value<double> carbsG = const Value.absent(),
            Value<double> fatG = const Value.absent(),
            Value<double> fibreG = const Value.absent(),
          }) =>
              FoodLogEntriesCompanion(
            id: id,
            foodId: foodId,
            foodName: foodName,
            meal: meal,
            loggedAt: loggedAt,
            quantity: quantity,
            portionLabel: portionLabel,
            portionGrams: portionGrams,
            kcal: kcal,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            fibreG: fibreG,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> foodId = const Value.absent(),
            required String foodName,
            required String meal,
            required DateTime loggedAt,
            required double quantity,
            required String portionLabel,
            required double portionGrams,
            required double kcal,
            required double proteinG,
            required double carbsG,
            required double fatG,
            required double fibreG,
          }) =>
              FoodLogEntriesCompanion.insert(
            id: id,
            foodId: foodId,
            foodName: foodName,
            meal: meal,
            loggedAt: loggedAt,
            quantity: quantity,
            portionLabel: portionLabel,
            portionGrams: portionGrams,
            kcal: kcal,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            fibreG: fibreG,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodLogEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodLogEntriesTable,
    FoodLogRow,
    $$FoodLogEntriesTableFilterComposer,
    $$FoodLogEntriesTableOrderingComposer,
    $$FoodLogEntriesTableAnnotationComposer,
    $$FoodLogEntriesTableCreateCompanionBuilder,
    $$FoodLogEntriesTableUpdateCompanionBuilder,
    (
      FoodLogRow,
      BaseReferences<_$AppDatabase, $FoodLogEntriesTable, FoodLogRow>
    ),
    FoodLogRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodsTableTableManager get foods =>
      $$FoodsTableTableManager(_db, _db.foods);
  $$PortionsTableTableManager get portions =>
      $$PortionsTableTableManager(_db, _db.portions);
  $$FoodLogEntriesTableTableManager get foodLogEntries =>
      $$FoodLogEntriesTableTableManager(_db, _db.foodLogEntries);
}
