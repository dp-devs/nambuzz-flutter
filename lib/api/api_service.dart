import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class ApiService {
  var env = envs['stag'];
  var envPost = envs['post'];
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

  Uri getUriPost(String endPoint, String path,
      [Map<String, dynamic>? queryParameters]) {
    var uri = envPost!.secured
        ? Uri.https(endPoint, envPost!.additionalPath + path, queryParameters)
        : Uri.http(endPoint, envPost!.additionalPath + path, queryParameters);
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
      log('message of json as === $json');
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

  postUpload(Uint8List? postFile, String title, String caption, String hashtag,
      String category) async {
    try {
      var uid = db.get("userId");
      var request = http.MultipartRequest(
          "POST", Uri.parse("https://postnamebuzz.herokuapp.com/post/upload"));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      log('message as $uid');
      log('message as $title');
      log('message as $caption');
      log('message as $hashtag');
      log('message as $category');

      request.files.add(
        await http.MultipartFile.fromBytes('file', postFile!),
      );
      request.fields['uid'] = uid == null ? "nameb1007" : uid;
      request.fields['title'] = title;
      request.fields['caption'] = caption;
      request.fields['hashtag'] = hashtag;
      request.fields['catego'] = category;
      try {
        var response = await request.send();
        final respStr = await response.stream.bytesToString();
        log('response : $respStr');
        Map<String, dynamic> json = jsonDecode(respStr);
        log('Json resp $json');
        return json;
      } catch (e) {
        log('Exception : postUpload :  $e');
      }
    } catch (er) {
      log('Exception : postUpload :  $er');
      return;
    }
  }

  getAllPost() async {
    try {
      var uid = db.get("userId");

      final uri = getUriPost(envPost!.endPointUrl, '/post/get');

      var body = jsonEncode(
        {
          'uid': uid,
        },
      );

      final response = await client.post(
        uri,
        body: body,
      );
      log('Response : userStatus : ${response.body}');

      Map<String, dynamic> json = jsonDecode(response.body);

      return json;
    } catch (er) {
      log('Exception : userStatus :  $er');
    }
  }
}
