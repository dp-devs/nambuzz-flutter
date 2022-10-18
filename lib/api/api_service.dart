import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'config.dart';

class ApiService {
  var env = envs['stag'];
  final client = http.Client();

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
      final uri = getUri(env!.endPointUrl, '/sendOTP');
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
      return json['message'];
    } catch (er) {
      log('Exception : Register :  $er');
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
