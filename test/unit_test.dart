import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:twitter_clone/models/tweet.dart';

void main() async {
  final googleSignIn = MockGoogleSignIn();
  final signinAccount = await googleSignIn.signIn();
  final googleAuth = await signinAccount!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );
  final mockTweet =
      Tweet(content: 'teet', createdAt: DateTime.now(), userId: user.uid);
  final firestore = FakeFirebaseFirestore();
  String? tweet;
  test('Given user MockUser try firebase email login', () async {
    final auth = MockFirebaseAuth(mockUser: user);
    final result = await auth.signInWithCredential(credential);
    print(result.user!.displayName);
  });

  test('Given user MockUser try AddUser to firestore', () async {
    await firestore
        .collection('users')
        .add({'user_id': user.uid, 'name': user.displayName});
    await firestore.collection('users').get();
    print(firestore.dump());
  });

  test('Given user MockUser try addTweet to firestore', () async {
    await firestore.collection('tweets').add({
      'content': mockTweet.content,
      'createdAt': mockTweet.createdAt,
      'userId': user.uid
    }).then((value) => tweet = value.id);
    print(firestore.dump());
  });

  test('Given user MockUser try getTweets from firestore', () async {
    await firestore
        .collection('tweets')
        .where('user_id', isEqualTo: user.uid)
        .orderBy('created_at', descending: true)
        .get();
    print(firestore.dump());
  });

  test('Given user MockUser try editTweet from firestore', () async {
    await firestore.collection('tweets').doc(tweet).update({
      'content': mockTweet.content + '  edit',
    });
    print(firestore.dump());
  });
  test('Given user MockUser try deleteTweet from firestore', () async {
    await firestore.collection('tweets').doc(tweet).delete();
  });
  print(firestore.dump());
}
