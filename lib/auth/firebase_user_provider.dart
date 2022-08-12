import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ToDoAppFirebaseUser {
  ToDoAppFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

ToDoAppFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ToDoAppFirebaseUser> toDoAppFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ToDoAppFirebaseUser>(
        (user) => currentUser = ToDoAppFirebaseUser(user));
