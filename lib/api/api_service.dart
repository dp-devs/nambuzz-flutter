import 'dart:convert';
import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class ApiService {
  var env = envs['stag'];
  final client = http.Client();

  var db = Hive.box('profileDetails');

  Uri getUri(String endPoint, String path,
      [Map<String, dynamic>? queryParameters]) {
    var uri = env!.secured
        ? Uri.https(endPoint, env!.additionalPath + path, queryParameters)
        : Uri.http(endPoint, env!.additionalPath + path, queryParameters);
    log(uri.toString());
    return uri;
  }

  sendOtp(String number) async {
    try {
      final uri = getUri(env!.endPointUrl, '/user/sendOTP');
      final body = {
        "number": number,
      };
      log('sendOTPbody as $body');
      final response = await client.post(uri,
          body: jsonEncode(body),
          headers: ({
            'Content-type': 'application/json',
          }));
      log('Response : RegisterUser : ${response.body}');
      Map<String, dynamic> json = jsonDecode(response.body);

      return json['otp'];
    } catch (er) {
      log('Exception : Register :  $er');
      return;
    }
  }

  addUser(String username, String password, String firstName, String lastName,
      String phoneNo, String email) async {
    try {
      final uri = getUri(env!.endPointUrl, '/user/addUser');
      final body = {
        "username": username,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "phoneno": phoneNo,
        "email": email,
      };
      log('body as $body');
      final response = await client.post(uri,
          body: jsonEncode(body),
          headers: ({
            'Content-type': 'application/json',
          }));
      log('Response : loginUser : ${response.body}');
      Map<String, dynamic> json = jsonDecode(response.body);
      return json['msg'];
    } catch (er) {
      log('Exception : loginUser :  $er');
      return;
    }
  }

  loginUser(String email, String password) async {
    try {
      final uri = getUri(env!.endPointUrl, '/user/loginUser');
      final body;
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);

      if (emailValid == true) {
        body = {
          "email": email,
          "password": password,
        };
      } else {
        body = {
          "username": email,
          "password": password,
        };
      }

      log('body as $body');
      final response = await client.post(uri,
          body: jsonEncode(body),
          headers: ({
            'Content-type': 'application/json',
          }));
      log('Response : loginUser : ${response.body}');
      Map<String, dynamic> json = jsonDecode(response.body);
      db.put('userId', json['user']['id']);
      db.put('newUSer', json['user']['flag_new_User']);
      db.put('userLoggedIn', true);
      return json['msg'];
    } catch (er) {
      log('Exception : loginUser :  $er');
      return;
    }
  }

  checkPhone(String value) async {
    try {
      final uri = getUri(env!.endPointUrl, '/user/check/number');
      final body = {
        "value": value,
      };
      log('body as $body');
      final response = await client.post(
        uri,
        body: jsonEncode(body),
        headers: ({
          'Content-type': 'application/json',
        }),
      );
      log('Response : loginUser : ${response.body}');
      Map<String, dynamic> json = jsonDecode(response.body);
      return json['msg'];
    } catch (er) {
      log('Exception : loginUser :  $er');
      return;
    }
  }

  checkEmail(String value) async {
    try {
      final uri = getUri(env!.endPointUrl, '/user/check/email');
      final body = {
        "value": value,
      };
      log('body as $body');
      final response = await client.post(uri,
          body: jsonEncode(body),
          headers: ({
            'Content-type': 'application/json',
          }));
      log('Response : loginUser : ${response.body}');
      Map<String, dynamic> json = jsonDecode(response.body);
      return json['msg'];
    } catch (er) {
      log('Exception : loginUser :  $er');
      return;
    }
  }

  checkUsername(String value) async {
    try {
      final uri = getUri(env!.endPointUrl, '/user/check/username');
      final body = {
        "value": value,
      };
      log('body as $body');
      final response = await client.post(uri,
          body: jsonEncode(body),
          headers: ({
            'Content-type': 'application/json',
          }));
      log('Response : loginUser : ${response.body}');
      Map<String, dynamic> json = jsonDecode(response.body);
      return json['msg'];
    } catch (er) {
      log('Exception : loginUser :  $er');
      return;
    }
  }

  ///////////////
  // Auth Cred //
  ///////////////
  // registerUser(String first, String last, String email, String password) async {
  //   try {
  //     final uri = getUri(env!.endPointUrl, '/user/signup');
  //     final body = {
  //       "name": {"first": first, "last": last},
  //       "email": email,
  //       "password": password,
  //     };
  //     log('body as $body');
  //     final response = await client.post(uri,
  //         body: jsonEncode(body),
  //         headers: ({
  //           'Content-type': 'application/json',
  //         }));
  //     log('Response : RegisterUser : ${response.body}');
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     return json['message'];
  //   } catch (er) {
  //     log('Exception : Register :  $er');
  //     return;
  //   }
  // }

//   loginUser(String email, String password) async {
//     try {
//       final uri = getUri(env!.endPointUrl, '/user/login');
//       final body = {
//         "email": email,
//         "password": password,
//       };
//       log('body as $body');
//       final response = await client.post(
//         uri,
//         body: body,
//         headers: ({
//           'Accept': 'application/json',
//         }),
//       );
//       log('Response : loginUser : ${response.body}');
//       Map<String, dynamic> json = jsonDecode(response.body);
//       return json['message'];
//     } catch (er) {
//       log('Exception : loginUser :  $er');
//       return;
//     }
//   }

//   ///////////////
//   //   Feeds   //
//   ///////////////

//   getFeeds(String limit) async {
//     try {
//       final uri = getUri(env!.endPointUrl, 'feed/$limit');

//       final response = await client.get(uri, headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         // 'Authorization': 'Bearer $accessToken',
//       });
//       log('Response : getFeeds : ${response.body}');

//       Map<String, dynamic> json = jsonDecode(response.body);
//       // AllFeeds allFeedsList = AllFeeds.fromJson(json);

//       // return allFeedsList.content;
//     } catch (er) {
//       log('Exception : getFeeds :  $er');
//     }
//   }
}
