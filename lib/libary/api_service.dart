import 'dart:convert';
import 'dart:developer';
import 'package:arya/ladies/add_new_lady_response.dart';
import 'package:arya/model/caste_category.dart';
import 'package:arya/model/child_category_gs.dart';
import 'package:arya/model/child_dashboard.dart';
import 'package:arya/model/child_dashboard_model.dart';
import 'package:arya/model/child_nutritional_intervention.dart';
import 'package:arya/model/child_nutritional_suppliments.dart';
import 'package:arya/model/child_vaccination_gs.dart';
import 'package:arya/model/lady_health_model.dart';
import 'package:arya/model/lady_intervention_model.dart';
import 'package:arya/model/lady_nutritional_model.dart';
import 'package:arya/model/login_gs.dart';
import 'package:arya/model/particular_child_data_gs.dart';
import 'package:arya/model/self_help_group_list_view.dart';
import 'package:arya/model/self_help_group_model.dart';
import 'package:arya/model/self_help_group_view.dart';
import 'package:arya/model/suckle_lady_model.dart';
import 'package:arya/model/women_dashboard_model.dart';
import 'package:arya/registration/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../children/child_home_page.dart';
import '../model/category_of_cast.dart';
import '../model/get_child_gs.dart';
import '../model/ladies_list_model.dart';
import '../model/vaccination.dart';
import '../util/appcontants.dart';

class ApiService {
   static const String API_LINK = "http://34.125.174.14";
  // static const String API_LINK = "http://34.125.95.71";
  late SharedPreferences _sharedPreferences;

  late BuildContext context;

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
        //Fluttertoast.showToast(msg: response.body);
        return LoginResponse.fromJson(jsonDecode(response.body));
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

      print(response.statusCode);
      print(response.body);

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


  Future<List<FoodReference>?> getChildNutritionalInterventionList(String user_id) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/nutritional-intervention/$user_id");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        ChildNutritionalIntervention food = ChildNutritionalIntervention.fromJson(jsonDecode(response.body));

        return food.data?.foodReference;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<MedicineReference>?> getChildNutritionalSupplements(String user_id) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/children/medicine/$user_id");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        ChildNutritionalSupplements medicine = ChildNutritionalSupplements.fromJson(jsonDecode(response.body));

        return medicine.data?.medicineReference;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<WomenVaccinationReference>?> getWomenVaccinationList(String user_id) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

      var url = Uri.parse("$API_LINK/women/vaccination/$user_id");

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };

      var response = await http.get(url, headers: headers);

      print(response.body);

      if (response.statusCode == 200) {
        VaccinationModel vaccination = VaccinationModel.fromJson(jsonDecode(response.body));

        return vaccination.data?.womenVaccinationReference;
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
      print(jsonDecode(response.body));


      if (response.statusCode == 200) {
         ChildDashBoardDetils child_dashboard = ChildDashBoardDetils.fromJson(jsonDecode(response.body));
        return child_dashboard;
      }else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: "Please login again");
      } if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "No data found");
      }else {
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


   Future<AddNewLadyResponse?> addLadyDetails(
       String refId,
       String name,
       String husbandName,
       String aadhar,
       String svasthaId,
       String DOB,
       String mobileNumber,
       String categoryId,
       String cast,
       bool isReligiousMinority,
       String maritalStatus,
       String lastMenstrulPeriod,
       bool isFirstPregnancy,
       bool areYouPregnant,
       bool isBeneficiary,
       bool isAbortionBefore) async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;


       var url = Uri.parse("$API_LINK/women/register");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       final json =
           '{ "womenCategoryId":"$refId","name":"$name","husbandName":"$husbandName","DOB":"$DOB", "aadhar":"$aadhar",'
           '"svasthaId":"$svasthaId", "mobileNumber":$mobileNumber, "isBeneficiary":$isBeneficiary, "isAbortionBefore":$isAbortionBefore,'
           '"isFirstPregnancy":$isFirstPregnancy, "areYouPregnant":$areYouPregnant,'
           '"isReligiousMinority":$isReligiousMinority, "maritalStatus":"$maritalStatus","lastMenstrulPeriod":"$lastMenstrulPeriod","categoryId":"$categoryId",'
           '"cast":"$cast"}';

       print(json);

       var response = await post(url, headers: headers, body: json);
       print(response.statusCode);
       print(response.body);
       if (response.statusCode == 201) {
         return AddNewLadyResponse.fromJson(jsonDecode(response.body));
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<WomenHomePageModel?> getWomenDashBoard() async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/women-category");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       var response = await http.get(url, headers: headers);

       print(response.statusCode);
       print(response.body);


       if (response.statusCode == 200) {
         WomenHomePageModel women_dashboard = WomenHomePageModel.fromJson(jsonDecode(response.body));


         return women_dashboard;
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<List<LadiesListviewModelData>?> getWomenList(String id) async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       print("=====>>>>>>");
       print(id);
       // var url = Uri.parse("$API_LINK/women/register?page=1&limit=100");
       var url = Uri.parse("$API_LINK/women/women-category/$id");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       var response = await http.get(url, headers: headers);

       print(jsonDecode(response.body));

       if (response.statusCode == 200) {
         LadiesListviewModel _list = LadiesListviewModel.fromJson(jsonDecode(response.body));

         return _list.data;
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<SelfHelpViewModelData?> getSelfHelpGroupDetails(String user_id) async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/self-help-group/$user_id");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       var response = await http.get(url, headers: headers);

       print(jsonDecode(response.body));

       if (response.statusCode == 200) {
            SelfHelpViewModel _list = SelfHelpViewModel.fromJson(jsonDecode(response.body));

         return _list.data;
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<AddNewLadyResponse?> UpdateLadyDetails(
       String refId,
       String id,
       String name,
       String husbandName,
       String aadhar,
       String svasthaId,
       String DOB,
       String mobileNumber,
       String categoryId,
       String cast,
       bool isReligiousMinority,
       String maritalStatus,
       String lastMenstrulPeriod,
       bool isFirstPregnancy,
       bool areYouPregnant,
       bool isBeneficiary,
       bool isAbortionBefore) async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/register/$id");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       final json =
           '{ "womenCategoryId":"$refId", "name":"$name","husbandName":"$husbandName","DOB":"$DOB", "aadhar":"$aadhar",'
           '"svasthaId":"$svasthaId", "mobileNumber":$mobileNumber, "isBeneficiary":$isBeneficiary, "isAbortionBefore":$isAbortionBefore,'
           '"isFirstPregnancy":$isFirstPregnancy, "areYouPregnant":$areYouPregnant,'
           '"isReligiousMinority":$isReligiousMinority, "maritalStatus":"$maritalStatus","lastMenstrulPeriod":"$lastMenstrulPeriod","categoryId":"$categoryId",'
           '"cast":"$cast"}';

       var response = await patch(url, headers: headers, body: json);
       print(response.statusCode);
       print(response.body);
       if (response.statusCode == 200) {
         return AddNewLadyResponse.fromJson(jsonDecode(response.body));
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }

   Future<SuckleLadyModel?> addLadyScukleBodyDetails(
       String id,
       String deliver_date,
       bool abortion_after_20_week,
       bool abortion_before_20_week,
       bool is_abortion,
       bool is_stillborn) async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/stay-with-nursing");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       final json =
           '{ "womenId":"$id","deliver_date":"$deliver_date","is_stillborn":$is_stillborn, "is_abortion":$is_abortion,'
           '"abortion_before_20_week":$abortion_before_20_week, "abortion_after_20_week":"$abortion_after_20_week"}';

       var response = await post(url, headers: headers, body: json);

       if (response.statusCode == 201) {
         return SuckleLadyModel.fromJson(jsonDecode(response.body));
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<LadyHealthModelData?> addLadyHealthDetails(String id, String hemoglobin) async {

     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/health");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       final json = '{"womenId":"$id","height": 0,"weight": 0, "hemoglobin":$hemoglobin}';

       var response = await post(url, headers: headers, body: json);
       print(response.statusCode);
       print(response.body);
       if (response.statusCode == 201) {
         return LadyHealthModelData.fromJson(jsonDecode(response.body));
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<List<WomenMedicineReference>?> getNutritionalSupplement(String id) async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/nutritional-supplement/$id");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       var response = await http.get(url, headers: headers);

       if (response.statusCode == 200) {
         LadyNutritionalSupplement res = LadyNutritionalSupplement.fromJson(jsonDecode(response.body));

         return res.data!.womenMedicineReference;
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }

   Future<List<WomenFoodReference>?> getNutritionalIntervention(String id) async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/nutritional-intervention/$id");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       var response = await http.get(url, headers: headers);

       print(jsonDecode(response.body));

       if (response.statusCode == 200) {
         LadyNutritionalIntervention res = LadyNutritionalIntervention.fromJson(jsonDecode(response.body));

         return res.data!.womenfoodReference;
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<String?> addWomenSelfHelpGroup(String centerId,String ladyClubName, String joiningClubDate,
       List<SelfHelpGroupModel> memberDetails) async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/self-help-group");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };


       final json = '{"centerId":"$centerId","ladyClubName":"$ladyClubName","joiningClubDate":"$joiningClubDate","memberDetails":$memberDetails}';
       print(json);

       var response = await post(url, headers: headers, body: json);

       print(jsonDecode(response.body));
       print(response.statusCode);


       return response.statusCode.toString();

     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<List<SelfHelpGroupListViewModelData>?> getSelfHelpGroupListViewModel() async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/self-help-group");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       var response = await http.get(url, headers: headers);

       if (response.statusCode == 200) {
         SelfHelpGroupListViewModel club = SelfHelpGroupListViewModel.fromJson(jsonDecode(response.body));

         return club!.data;
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }



   Future<List<ChildDashBoardUserAgeRef>?> getChildDashBoardUserAgeRef() async {
     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/user/dashboard");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       var response = await http.get(url, headers: headers);

       if (response.statusCode == 200) {
         ChildDashBoardData club = ChildDashBoardData.fromJson(jsonDecode(response.body));

         return club!.data!.userAgeRef;
       } else {
         return null;
       }
     } catch (e) {
       log(e.toString());
     }
     return null;
   }


   Future<String?> addSupplementsDetails(String womenId, String medicineIDs) async {
      print(womenId);
      print(medicineIDs);

     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/nutritional-supplement");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       final json ='{"womenId":"$womenId","medicineIDs": $medicineIDs }';

       print(json);

       var response = await post(url, headers: headers, body: json);
       print(response.statusCode);
       print(response.body);

       return response.statusCode.toString();

     } catch (e) {
       log(e.toString());
     }
     return null;
   }

   Future<String?> addVaccinationDetails(String womenId, String vaccinationIDs) async {
      print(womenId);
      print(vaccinationIDs);

     try {
       _sharedPreferences = await SharedPreferences.getInstance();
       String token = _sharedPreferences.getString(AppConstants.TOKEN)!;

       var url = Uri.parse("$API_LINK/women/vaccination");

       final headers = <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
       };

       final json ='{"womenId":"$womenId","vaccinationIDs": $vaccinationIDs }';

       print(json);

       var response = await post(url, headers: headers, body: json);
       print(response.statusCode);
       print(response.body);

       return response.statusCode.toString();

     } catch (e) {
       log(e.toString());
     }
     return null;
   }
}
