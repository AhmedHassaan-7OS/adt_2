import 'package:adt2/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess(credential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'An error occurred. Please try again.'));
    } catch (e) {
      emit(AuthFailure('An error occurred: $e'));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.sendEmailVerification();
      emit(AuthSuccess(credential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'An error occurred. Please try again.'));
    } catch (e) {
      emit(AuthFailure('An error occurred: $e'));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(AuthFailure('Google sign-in aborted by user.'));
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      emit(AuthSuccess(userCredential.user!));
    } catch (e) {
      emit(AuthFailure('Google sign-in failed: $e'));
    }
  }
}

