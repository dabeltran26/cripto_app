import 'package:bloc_test/bloc_test.dart';
import 'package:cripto_app/login/presentation/cubit/login_cubit.dart';
import 'package:cripto_app/resources/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mock_login_repository.mocks.dart';

class MockUser extends Mock implements UserModel {}

class MockNavigator extends Mock {
  void call();
}

void main() {
  group('login user test', () {
    late LoginCubit loginCubit;
    late MockLoginApiRepository mockApiRepository;
    late MockNavigator mockNavigate;

    setUp(() {
      mockApiRepository = MockLoginApiRepository();
      loginCubit = LoginCubit(mockApiRepository);
      mockNavigate = MockNavigator();
    });

    tearDown(() {
      loginCubit.close();
    });

    blocTest<LoginCubit, LoginState>(
      'login todo bien',
      build: () {
        final mockUser = MockUser();
        when(mockApiRepository.getUserInfo(any)).thenAnswer((_) async => mockUser);
        return loginCubit;
      },
      act: (cubit) {
        cubit.loginWitchCredentials(() {}, 'email', 'password');
        print('Estados emitidos: ${cubit.state.errorMessage}');
      },
      expect: () => [
        const LoginLoading(),
        const LoginInitial('Todo melo'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'login fallo',
      build: () {
        when(mockApiRepository.signInWithCredentials(any, any))
            .thenThrow(FirebaseAuthException(code: 'user-not-found'));
        return loginCubit;
      },
      act: (cubit) => cubit.loginWitchCredentials(() {}, 'email', 'password'),
      expect: () => [
        const LoginLoading(),
        const LoginInitial('No se encontró usuario.'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'login contraseña incorrecta',
      build: () {
        when(mockApiRepository.signInWithCredentials(any, any))
            .thenThrow(FirebaseAuthException(code: 'wrong-password'));
        return loginCubit;
      },
      act: (cubit) => cubit.loginWitchCredentials(() {}, 'email', 'password'),
      expect: () => [
        const LoginLoading(),
        const LoginInitial('Credenciales incorrectas.'),
      ],
    );
  });
}
