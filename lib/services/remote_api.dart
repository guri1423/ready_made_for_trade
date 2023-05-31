import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ready_made_4_trade/modules/account/model/website_text_model.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_model.dart';
import 'package:ready_made_4_trade/modules/customer/model/add_customer_model.dart';
import 'package:ready_made_4_trade/modules/dairy/model/get_diary_data_model.dart';
import 'package:ready_made_4_trade/modules/essentials/models/get_essentails_model.dart';
import 'package:ready_made_4_trade/modules/f_and_i/model/finance_insurnace_model.dart';
import 'package:ready_made_4_trade/modules/gallery/models/get_all_projects.dart';
import 'package:ready_made_4_trade/modules/gallery/models/get_gallery_images.dart';
import 'package:ready_made_4_trade/modules/gallery/models/project_response_model.dart';
import 'package:ready_made_4_trade/modules/home/model/get_user_data.dart';
import 'package:ready_made_4_trade/modules/jobs/models/add_quote.dart';
import 'package:ready_made_4_trade/modules/jobs/models/add_reminder.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_invoice.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_status.dart';
import 'package:ready_made_4_trade/modules/jobs/models/job_agreed_model.dart';
import 'package:ready_made_4_trade/modules/login/model/login_response.dart';
import 'package:ready_made_4_trade/modules/material/models/get_materials_model.dart';
import 'package:ready_made_4_trade/modules/receipts/models/receipts_model.dart';
import 'package:ready_made_4_trade/modules/trades/models/add_trades_model.dart';
import 'package:ready_made_4_trade/modules/trades/models/get_all_trades_model.dart';
import 'package:ready_made_4_trade/modules/trainings/models/get_trainings_model.dart';
import 'package:ready_made_4_trade/modules/trainings/models/training_status_model.dart';
import 'package:ready_made_4_trade/services/storage.dart';

import '../core/base_urls.dart';
import '../modules/home/pages/icon_models/customer_model.dart';
import '../modules/home/pages/icon_models/jobs_model.dart';
import '../modules/jobs/models/appointment_models.dart';
import '../modules/login/model/login_model.dart';

class RemoteApi {
  final StorageServices _servicesStorage = StorageServices();

  Future<LoginResponseModel?> userLogin(LoginRequestModal model) async {
    try {
      final response =
          await http.post(Uri.parse(Urls.login),
              body: model.toJson());

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json respONSE ${jsonResponse}');
      return loginResponseModelFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AddCustomerResponse?> changePassword(ChangePasswordModal model) async {
    try {
      final response =
      await http.post(Uri.parse(Urls.changePassword),
          body: model.toJson());

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json respONSE ${jsonResponse}');
      return addCustomerResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<GetUserData?> fetchUserInfo() async {
    String? email = await _servicesStorage.getEmail();
    debugPrint(email);
    try {
      Response response =
          await http.post(Uri.parse(Urls.fetchUser), body: {'email': email});

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getUserDataFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetCustomerModel?> getCustomers() async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');

    try {
      Response response = await http
          .post(Uri.parse(Urls.fetchCustomer), body: {'user_id': userId});
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['message'].toString().contains('Not Found')) {
        return null;
      } else {
        return getCustomerModelFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<JobsModel?> getJobs() async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');
    try {
      Response response =
          await http.post(Uri.parse(Urls.fetchJobs), body: {'user_id': userId});
      print(response.body);
      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return jobsModelFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<AddCustomerResponse?> addCustomer(AddCustomerModel model) async {
    debugPrint(model.toJson().toString());
    try {
      final response = await http.post(Uri.parse(Urls.addCustomer),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: json.encode(model.toJson()));

      var jsonResponse = json.decode(response.body);
      debugPrint('json respONSE ${jsonResponse}');

      if (jsonResponse['status'] == true) {
        return addCustomerResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetAllTrades?> getAllTrades() async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');
    try {
      Response response =
          await http.post(Uri.parse(Urls.getTrades), body: {'user_id': userId});
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['message'].toString().contains('Not Found')) {
        return null;
      } else {
        return getAllTradesFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<PostTradesResponse?> addTrades(AddTradesModel model) async {
    debugPrint(model.toString());
    try {
      final response = await http.post(Uri.parse(Urls.addTrades),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: json.encode(model.toJson()));

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json respONSE ${jsonResponse}');
      return postTradesResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<GetGalleryImages?> getGalleryImages() async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');
    try {
      Response response = await http
          .post(Uri.parse(Urls.getGalleryImages), body: {'user_id': userId});
      print(response.body);
      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getGalleryImagesFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetAllTrades?> getSearchTrades(String? search) async {
    String? userId = await _servicesStorage.getUserId();
    try {
      Response response = await http
          .post(Uri.parse(Urls.getSearchTrades),
        body: {'key': search,
            'user_id': userId
          });
      print(response.body);
      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getAllTradesFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetAllTrades?> filterTrades(String? value) async {
    String? userId = await _servicesStorage.getUserId();
    try {
      Response response = await http.post(Uri.parse(Urls.filterTrades),
          body: {'user_id': userId, 'trade': value});
      print(response.body);
      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getAllTradesFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetCustomerModel?> getSearchCustomer(String? search) async {
    try {
      Response response = await http
          .post(Uri.parse(Urls.getSearchCustomer), body: {'key': search});

      var jsonResponse = json.decode(response.body);
      if (jsonResponse['message'].toString().contains('Not Found')) {
        return null;
      } else {
        return getCustomerModelFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetAllProjects?> getAllProjects() async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');

    try {
      Response response = await http
          .post(Uri.parse(Urls.getAllProjects), body: {'user_id': userId});
      print(response.body);
      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getAllProjectsFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetAllMaterials?> getAllMaterials() async {
    try {
      Response response = await http.get(Uri.parse(Urls.getAllMaterials));

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getAllMaterialsFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetAllMaterials?> getSearchMaterials(String? search) async {
    try {
      Response response = await http
          .post(Uri.parse(Urls.searchMaterials), body: {'key': search});

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getAllMaterialsFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetChecklist?> getChecklist() async {
    try {
      Response response = await http.get(Uri.parse(Urls.getChecklist));

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getChecklistFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> updateChecklistStatus(
      {required String userID, required Map<String, dynamic> status}) async {
    try {
      Response response = await http.post(Uri.parse(Urls.updateChecklist),
          body: {"user_id": userID, "checkliststatus": status.toString()});

      var jsonResponse = response.body;
      debugPrint(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<GetFinanceAndInsurance?> getFinanceAndInsurance(String? type) async {
    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };
      Response response = await http.post(
        Uri.parse(Urls.getFinanceInsuranceList),
        body: {'type': type},
        // headers: headers
      );
      debugPrint(response.body, wrapWidth: 1024);
      return getFinanceAndInsuranceFromJson(response.body);
    } catch (e) {
      print('dnf da${e.toString()}');
      return null;
    }
  }

  Future<GetFinanceAndInsurance?> searchFinanceAndInsurance(
      String? search, String? type) async {
    try {
      Response response = await http.post(
          Uri.parse(Urls.searchFinanceInsurance),
          body: {'key': search, 'type': type});

      var jsonResponse = json.decode(response.body);
      if (jsonResponse['message'].toString().contains('Not Found')) {
        return null;
      } else {
        return getFinanceAndInsuranceFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<AddProjectResponse?> addProject(
      {required List<String> imageList, required String projectTitle}) async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');

    debugPrint(imageList.toString());

    try {
      Map<String, dynamic> requestBody = {
        'projecttitle': projectTitle,
        'user_id': userId,
      };

      for (int i = 0; i < imageList.length; i++) {
        requestBody['project_images[$i]'] = imageList[i];
      }

      Response response =
          await http.post(Uri.parse(Urls.createProject), body: requestBody);

      // InspectorController().addNewRequest(
      //   RequestDetails(
      //     // requestName: 'Posts', //Optional
      //     requestMethod: RequestMethod.POST,
      //     url: 'https://readymade4trade.omkatech.in/api/CreateProject',
      //     // queryParameters: params,
      //     statusCode: response.statusCode,
      //     responseBody: response.toString(),
      //     // headers: {'language': 'en'},
      //   ),
      // );

      var jsonResponse = response.body;

      debugPrint(jsonResponse);

      return addProjectResponseFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<AddCustomerResponse?> editCustomer(AddCustomerModel model) async {
    try {
      final response = await http.post(Uri.parse(Urls.editCustomer),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: json.encode(model));

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json respONSE ${jsonResponse}');
      return addCustomerResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AddCustomerResponse?> deleteCustomer(String customerId) async {
    try {
      final response = await http.post(Uri.parse(Urls.deleteCustomer),
          body: {"customerid": customerId});

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json respONSE ${jsonResponse}');
      return addCustomerResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<PostTradesResponse?> editTrades(AddTradesModel model) async {
    try {
      final response = await http.post(Uri.parse(Urls.editTrade),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: json.encode(model));

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json respONSE ${jsonResponse}');
      return postTradesResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AddProjectResponse?> editProject(
      {required List<String> imageList,
      required String projectTitle,
      required String projectId}) async {
    debugPrint(imageList.toString());

    try {
      Map<String, dynamic> requestBody = {
        'projecttitle': projectTitle,
        'project_id': projectId,
      };

      for (int i = 0; i < imageList.length; i++) {
        requestBody['project_images[$i]'] = imageList[i];
      }

      Response response =
          await http.post(Uri.parse(Urls.editProject), body: requestBody);

      // InspectorController().addNewRequest(
      //   RequestDetails(
      //     // requestName: 'Posts', //Optional
      //     requestMethod: RequestMethod.POST,
      //     url: 'https://readymade4trade.omkatech.in/api/CreateProject',
      //     // queryParameters: params,
      //     statusCode: response.statusCode,
      //     responseBody: response.toString(),
      //     // headers: {'language': 'en'},
      //   ),
      // );

      var jsonResponse = response.body;

      debugPrint(jsonResponse);

      return addProjectResponseFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<AddAppointmentResponse?> addAppointment(
      AddAppointmentModel model) async {
    debugPrint('TESt Id customer ${model.toJson().toString()}');

    try {
      final response = await http.post(
        Uri.parse(Urls.addAppointment),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode(model.toJson()), // Encode the model to JSON string
      );

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json response $jsonResponse');
      return addAppointmentResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AddProjectResponse?> addReminder(AddReminderModel model) async {
    try {
      final response = await http.post(
        Uri.parse(Urls.setReminder),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode(model.toJson()), // Encode the model to JSON string
      );

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json response $jsonResponse');
      return addProjectResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<GetEssentialsData?> getAllEssentials() async {
    try {
      Response response = await http.get(Uri.parse(Urls.getEssentials));

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getEssentialsDataFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetEssentialsData?> getSearchEssentials(String? search) async {
    try {
      Response response = await http
          .post(Uri.parse(Urls.getSearchEssentials), body: {'key': search});

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getEssentialsDataFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetAllTrainings?> getAllTrainings() async {
    try {
      Response response = await http.get(Uri.parse(Urls.getTraining));

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getAllTrainingsFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<UserTrainingStatus?> getTrainingsStatus({
    required String userID,
  }) async {
    try {
      Response response =
          await http.post(Uri.parse(Urls.getTrainingsStatus), body: {
        "user_id": userID,
      });

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return userTrainingStatusFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> saveTrainingStatus(
      {required String customerId,
      required String userID,
      required Map<String, dynamic> status}) async {
    try {
      Response response = await http.post(Uri.parse(Urls.saveTrainingStatus),
          body: {
            "user_id": userID,
            "Trainingcheckliststatus": status.toString()
          });

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<GetDairyData?> getDiaryData() async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');

    try {
      Response response = await http
          .post(Uri.parse(Urls.getDiaryData), body: {'user_id': userId});

      var jsonResponse = response.body;

      debugPrint(jsonResponse);

      return getDairyDataFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetDairyData?> getDiaryFilterData(String? status, String? date) async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');

    try {
      Response response = await http
          .post(Uri.parse(Urls.getDiaryData), body: {
            'user_id': userId,
            'status': status,
             'date' : date

      });


      var jsonResponse = response.body;

      debugPrint(jsonResponse);

      return getDairyDataFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetJobList?> getJobListReceipts() async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');

    try {
      Response response = await http
          .post(Uri.parse(Urls.getJobList), body: {'user_id': userId});

      var jsonResponse = response.body;

      debugPrint(jsonResponse);

      return getJobListFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<AddQuoteResponse?> addQuote(AddQuoteModel model) async {
    try {
      final response = await http.post(
        Uri.parse(Urls.addQuote),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode(model.toJson()), // Encode the model to JSON string
      );

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json response $jsonResponse');
      return addQuoteResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<GetGalleryImages?> getReceiptsImages() async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');
    try {
      Response response = await http
          .post(Uri.parse(Urls.getReceiptImages), body: {'user_id': userId});
      print(response.body);
      var jsonResponse = response.body;

      debugPrint(jsonResponse);
      return getGalleryImagesFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<AddProjectResponse?> sendReceipt(
      {required List<String> imageList}) async {
    String? userId = await _servicesStorage.getUserId();

    debugPrint('User ID ${userId.toString()}');

    debugPrint(imageList.toString());

    try {
      Map<String, dynamic> requestBody = {
        'user_id': userId,
      };

      for (int i = 0; i < imageList.length; i++) {
        requestBody['receipt_images[$i]'] = imageList[i];
      }

      Response response =
          await http.post(Uri.parse(Urls.sendReceipt), body: requestBody);

      var jsonResponse = response.body;

      debugPrint(jsonResponse);

      return addProjectResponseFromJson(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetJobInvoiceData?> getJobInvoice(int? jobId) async {
    try {
      final response = await http.post(
        Uri.parse(Urls.getJobInvoice),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode({"job_id": jobId}), // Encode the model to JSON string
      );

      debugPrint(response.body);
      var jsonResponse = json.decode(response.body);
      debugPrint('json response $jsonResponse');
      return getJobInvoiceDataFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<GetJobData?> getJobData(String? jobId) async {
    try {
      final response = await http.post(
        Uri.parse(Urls.getJobData),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode({"job_id": jobId}), // Encode the model to JSON string
      );

      debugPrint(response.body);

      return getJobDataFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<JobAgreeResponse?> jobAgreed(JobAgreedModel model) async {
    debugPrint(model.toJson().toString());

    try {
      final response = await http.post(
        Uri.parse(Urls.jobAgreed),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode(model.toJson()),
      );

      var jsonResponse = json.decode(response.body);
      debugPrint('json response $jsonResponse');

      JobAgreeResponse returnResponse = JobAgreeResponse.fromJson(jsonResponse);

      return returnResponse;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<JobAgreeResponse?> confirmJob(JobAgreedModel model) async {
    debugPrint(model.toJson().toString());

    try {
      final response = await http.post(
        Uri.parse(Urls.jobAgreed),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode(model.toJson()),
      );

      var jsonResponse = json.decode(response.body);
      debugPrint('json response $jsonResponse');

      JobAgreeResponse returnResponse = JobAgreeResponse.fromJson(jsonResponse);

      return returnResponse;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AddProjectResponse?> addPayment(
      String payment, String jobId, String status, String date) async {
    try {
      final response = await http.post(Uri.parse(Urls.addPayment),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: json.encode({
            "job_id": jobId,
            "deposit_amount": payment,
            "status": status,
            "deposit_amount_date": date
          }));

      var jsonResponse = json.decode(response.body);
      debugPrint('json response $jsonResponse');

      return addProjectResponseFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<bool> uploadLogo({
    required File file,
  }) async {
    String? userId = await _servicesStorage.getUserId();

    var request = http.MultipartRequest('POST', Uri.parse(Urls.addLogo));

    request.files.add(await http.MultipartFile.fromPath('logo', file.path));

    request.fields['user_id'] = userId ?? '';

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        debugPrint('File uploaded successfully');
        return true;
      } else {
        debugPrint('File upload failed with status ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error occurred while uploading file: $e');
      return false;
    }
  }

  Future<GetJobStatus?> getJobStatus() async {

    String? userId = await _servicesStorage.getUserId();

    try {
      Response response = await http
          .post(Uri.parse(Urls.getJobStatus), body: {'user_id': userId});

      var jsonResponse = response.body;

      debugPrint(jsonResponse);

      return getJobStatusFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetWebsiteTextModel?> getWebsiteText() async {
    String? userId = await _servicesStorage.getUserId();

    try {
      Response response = await http
          .post(Uri.parse(Urls.getWebsiteText), body: {'user_id': userId});

      var jsonResponse = response.body;

      debugPrint(jsonResponse);

      return getWebsiteTextModelFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> updateWebsiteText({required EditWebsiteData textModel}) async {
    try {
      Response response = await http.post(Uri.parse(Urls.updateWebsiteText),
          body: textModel.toJson());

      var jsonResponse = response.body;

      debugPrint(jsonResponse);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
