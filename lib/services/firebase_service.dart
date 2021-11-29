import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/services/utility_service.dart';

class FirebaseService extends GetxService {
  static FirebaseService get to => Get.find();
  //SharedPreferences local storage instance
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final util = UtilityService.to;
  FirebaseApp? twitterApp;
  FirebaseAuth? auth;
  FirebaseFirestore? firestore;
  Stream<QuerySnapshot>? tweetStream;
  CollectionReference? users;
  CollectionReference? tweets;
  bool loading = false;

  //Logout
  void logOut() async {
    await auth!.signOut();
    Get.rootDelegate.offAndToNamed(Routes.login);
  }

  //Nav home
  void homeNav(data) async {
    await Get.rootDelegate.offAndToNamed(Routes.home, arguments: data);
  }

  //Firebase Initialize & login check
  void initFirebase() async {
    twitterApp = await Firebase.initializeApp();
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    tweets = firestore!.collection('tweets');
    tweetStream = tweets!.orderBy('created_at', descending: true).snapshots();
    users = firestore!.collection('users');
    Future.delayed(Duration.zero, () {
      auth!.authStateChanges().listen((User? user) {
        if (user != null) {
          homeNav(
              {'tweets': tweetStream, 'users': users, 'addTweet': addTweet});
        }
      });
    });
  }

  //Firebase Add Tweet
  Future<void> addTweet(data) {
    // Call the tweet's CollectionReference to add a new tweet
    return tweets!
        .add(data)
        .then((value) => util.snack('Tweet Added'))
        .catchError((error) => util.snack('Something went wrong'));
  }

  //Get tweet user
  getUser(data) {
    return users!
        .where('user_id', isEqualTo: data['user_id'])
        .get()
        .then((value) => value.docs.first);
  }

  //Create new user entry on login with firebase user id
  addUser(data) {
    return users!.add(data).then((value) => {}).catchError((error) => {});
  }

  //Firebase Email Login
  void firebaseLogin(email, password) async {
    final SharedPreferences pref = await prefs;
    try {
      //Firebase login attempt with given email & pass
      UserCredential userCredential = await auth!
          .signInWithEmailAndPassword(email: email!, password: password!);
      var name = email.split('@');
      //create/copy user to firestore
      addUser({'name': name[0], 'user_id': userCredential.user!.uid});
      util.snack('Logged In');
      //Local storage basic data set
      pref.setString('userId', userCredential.user!.uid);
      pref.setString('email', userCredential.user!.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        util.snack('No user found for that email');
      } else if (e.code == 'wrong-password') {
        util.snack('Wrong password provided for that user.');
      }
    }
  }
}
