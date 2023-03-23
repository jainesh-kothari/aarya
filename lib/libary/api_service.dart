import 'dart:convert';
import 'dart:developer';
import 'package:arya/model/caste_category.dart';
import 'package:arya/model/child_category_gs.dart';
import 'package:arya/model/child_dashboard.dart';
import 'package:arya/model/child_vaccination_gs.dart';
import 'package:arya/model/login_gs.dart';
import 'package:arya/model/particular_child_data_gs.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category_of_cast.dart';
import '../model/get_child_gs.dart';
import '../util/appcontants.dart';

class ApiService {
   static const String API_LINK = "http://34.125.107.40";
  // static const String API_LINK = "http://34.125.95.71";
  late SharedPreferences _sharedPreferences;

  Future<LoginResponse?> getLoginDetails(String mobile, String mpin) async {
    try {
      var url = Uri.parse("$API_LINK/user/login");
      final headers = {"Content-type": "application/json"};
      final json = '{"mobile": "$mobile", "mpin": "$mpin"}';
      var response = await post(url, headers: headers, body: json);
      print(response);
      if (response.statusCode == 201) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<LoginResponse?> addChildDetails(
      String name,
      String childAadhaar,
      String dob,
      String motherAadhaar,
      String fatherName,
      String motherName,
      String mobileNUmber,
      String mother_associate,
      String gender,
      String fatherOccupation,
      String minority,
      String category,
      String caste) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/register");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      final json =
          '{ "name":"$name","aadhar":"$childAadhaar","DOB":"$dob", "motherAdhar":"$motherAadhaar",'
          '"fatherOccupation":"$fatherOccupation", "motherSelfHelpGroup":"$mother_associate",'
          '"gender":"$gender", "fatherName":"$fatherName","motherName":"$motherName", "mobileNumber":$mobileNUmber,"categoryId":"$category",'
          '"cast":"$caste"}';

      var response = await post(url, headers: headers, body: json);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ChildData>?> getChildList() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/register");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        ChildResponse child_list = ChildResponse.fromJson(jsonDecode(response.body));

        return child_list.data;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


  Future<SingleChildData?> getSingleChildDetails(String? childId) async {
    try {

      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/register/$childId");
      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return SingleChildData.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


  Future<String?> updateChildDetails(
      String? id,
      String name,
      String childAadhaar,
      String dob,
      String motherAadhaar,
      String fatherName,
      String motherName,
      String mobileNUmber,
      String mother_associate,
      String gender,
      String fatherOccupation,
      String minority,
      String category,
      String caste) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/register/$id");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      final json =
          '{ "name":"$name","aadhar":"$childAadhaar","DOB":"$dob", "motherAdhar":"$motherAadhaar",'
          '"fatherOccupation":"$fatherOccupation", "motherSelfHelpGroup":"$mother_associate",'
          '"gender":"$gender", "fatherName":"$fatherName","motherName":"$motherName", "mobileNumber":$mobileNUmber,"categoryId":"$category",'
          '"cast":"$caste","weightOnBirth":0.0, "heightOnBbirth":0, "profileImage":"image"}';

      var response = await patch(url, headers: headers, body: json);

      if (response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


  Future<List<VaccinationReference>?> getVaccinationList(String user_id) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/vaccination/$user_id");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        Vaccination vaccination = Vaccination.fromJson(jsonDecode(response.body));

        return vaccination.data?.vaccinationReference;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


  Future<ChildDashBoardDetils?> getChildDashBoard() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/user/dashboard");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      print(response.statusCode);


      if (response.statusCode == 200) {
        ChildDashBoardDetils child_dashboard = ChildDashBoardDetils.fromJson(jsonDecode(response.body));


        return child_dashboard;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


  Future<List<CastCategoryData>?> getCategory() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/admin/category");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        CastCategory cast = CastCategory.fromJson(jsonDecode(response.body));

        return cast.data;


      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<CastCategoryDetailsData>?> getCastCategory(String category, bool lang) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;
      var url = Uri.parse("$API_LINK/common/cast/$category");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };
      String la = "";
      if(lang) {
        la ="en";
      } else {
        la ="hi";
      }

      final json ='{ "lang":"$la"}';

      var response = await http.post(url, headers: headers, body: json);
      print(jsonDecode(response.body));
      if (response.statusCode == 201) {
        CastCategoryDetails cast = CastCategoryDetails.fromJson(jsonDecode(response.body));

        return cast.data;


      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


  Future<List<ChildCategoryData>?> getChildListCategory(String user_id) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/children-list/$user_id");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      print(user_id);
      print(response.statusCode);
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        ChildCategory child_list = ChildCategory.fromJson(jsonDecode(response.body));

        return child_list.data;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> addGrowthMonitoring(String childrenId, double height, double weight, String date) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/health/growth-monitoring");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      print(childrenId);
      print(height);
      print(weight);
      print(date);

      final json = '{ "childrenId":"$childrenId","height":$height,"weight":$weight, "date":"$date"}';

      print(json);

      var response = await post(url, headers: headers, body: json);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        return response.statusCode.toString();
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

}
