import 'package:firebase_core/firebase_core.dart';
import 'package:mynotesapp/firebase_options.dart';
import 'package:mynotesapp/services/auth/auth_exeptions.dart';
import 'package:mynotesapp/services/auth/auth_user.dart';
import 'package:mynotesapp/services/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExeption();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthExeption();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthExeption();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthExeption();
      } else {
        throw GenericAuthExeption();
      }
    } catch (_) {
      throw GenericAuthExeption();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExeption();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthExeption();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthExeption();
      } else {
        throw GenericAuthExeption();
      }
    } catch (_) {
      throw GenericAuthExeption();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthExeption();
    }
  }

  @override
  Future<void> sentEmailVerification() {
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthExeption();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthExeption();
        default:
          throw GenericAuthExeption();
      }
    } catch (_) {
      throw GenericAuthExeption();
    }
  }
}
