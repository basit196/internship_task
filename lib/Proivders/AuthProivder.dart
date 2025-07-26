// auth_providers.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_task/Repo/AuthRepo.dart';

//=====================================================//
//                SignUpProvider
//=====================================================//

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRepository(firebaseAuth);
});

final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges().handleError((error) {
    debugPrint('Auth state error: $error');
    return null;
  });
});

class SignUpState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  SignUpState({this.isLoading = false, this.error, this.isSuccess = false});

  SignUpState copyWith({bool? isLoading, String? error, bool? isSuccess}) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class SignUpController extends StateNotifier<SignUpState> {
  final Ref ref;

  SignUpController(this.ref) : super(SignUpState());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      await ref
          .read(authRepositoryProvider)
          .signUpWithEmailAndPassword(
            name: name,
            email: email,
            password: password,
          );

      // Success case
      state = state.copyWith(isLoading: false, isSuccess: true);

      // Navigate after successful signup
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        GoRouter.of(
          context,
        ).pop(); // Or navigate to home: GoRouter.of(context).go('/home');
      }
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _getErrorMessage(e.code),
        isSuccess: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
        isSuccess: false,
      );
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already in use';
      case 'invalid-email':
        return 'Invalid email address';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'Signup failed. Please try again';
    }
  }

  void resetState() {
    state = SignUpState();
  }
}

final signUpControllerProvider =
    StateNotifierProvider<SignUpController, SignUpState>((ref) {
      return SignUpController(ref);
    });

//=====================================================//
//                SignUpProvider
//=====================================================//

//=====================================================//
//                LoginProvider
//=====================================================//

// auth_providers.dart
class LoginState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  LoginState({this.isLoading = false, this.error, this.isSuccess = false});

  LoginState copyWith({bool? isLoading, String? error, bool? isSuccess}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  final Ref ref;

  LoginController(this.ref) : super(LoginState());

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      await ref
          .read(authRepositoryProvider)
          .loginWithEmailAndPassword(email: email, password: password);

      // Success case
      state = state.copyWith(isLoading: false, isSuccess: true);

      // Show success snackbar and navigate
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged in successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        GoRouter.of(context).go('/HomeScreen');
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: _getErrorMessage(e.code));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_getErrorMessage(e.code)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  Future<void> sendPasswordResetEmail({
    required String email,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_getErrorMessage(e.code)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
        return 'Invalid email or password';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Try again later';
      default:
        return 'Login failed. Please try again';
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
      return LoginController(ref);
    });

//=====================================================//
//                LoginProvider               
//=====================================================//