import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cripto_app/home/presentation/cubit/home_cubit.dart';
import 'package:cripto_app/resources/models/coin_model.dart';
import 'package:cripto_app/home/domain/respositories/home_repository.dart';

@GenerateMocks([HomeApiRepository])
import 'home_cubit_test.dart';
