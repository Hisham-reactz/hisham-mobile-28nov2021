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
    //Arrange
    final auth = MockFirebaseAuth(mockUser: user);
    //Act
    final result = await auth.signInWithCredential(credential);
    //Assert
    expect(result.user!.displayName, 'Bob');
  });

  test('Given user MockUser try AddUser to firestore', () async {
    //Arrange
    await firestore
        .collection('users')
        .add({'user_id': user.uid, 'name': user.displayName});
    //Act
    final users = await firestore.collection('users').get();
    //Assert
    expect(users.docs.length, 1);
  });

  test('Given user MockUser try addTweet to firestore', () async {
    //Arrange
    final tweetData = {
      'content': mockTweet.content,
      'createdAt': mockTweet.createdAt,
      'userId': user.uid
    };
    //Act
    await firestore
        .collection('tweets')
        .add(tweetData)
        .then((value) => tweet = value.id);
    //Assert
    expect(tweet, isNotNull);
  });

  test('Given user MockUser try getTweets from firestore', () async {
    //Arrange
    final userId = user.uid;
    //Act
    final allTweets = await firestore
        .collection('tweets')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
    //Assert
    expect(allTweets.docs.length, 1);
  });

  test('Given user MockUser try editTweet from firestore', () async {
    //Arrange
    final tweetId = tweet;
    //Act
    await firestore.collection('tweets').doc(tweetId).update({
      'content': mockTweet.content + '  edit',
    });
    //Assert
    final editedTweet = await firestore.collection('tweets').doc(tweetId).get();
    expect(editedTweet.data()!['content'], mockTweet.content + '  edit');
  });

  test('Given user MockUser try deleteTweet from firestore', () async {
    //Arrange
    final tweetId = tweet;
    //Act
    await firestore.collection('tweets').doc(tweetId).delete();
    //Assert
    final allTweets = await firestore
        .collection('tweets')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .get();
    expect(allTweets.docs.length, 0);
  });
}
