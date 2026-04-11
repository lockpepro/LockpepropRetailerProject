import 'package:get/get.dart';

class FAQController extends GetxController {
  var searchQuery = "".obs;

  var generalQuestions = <Map<String, dynamic>>[
    {
      "icon": "assets/accounts/account.svg",
      "title": "How do I create an account?",
      "desc":
      "Click \"Sign Up\" on the homepage, enter your details, and follow the prompts."
    },
    {
      "icon": "assets/icons/lock.svg",
      "title": "Forgot password?",
      "desc":
      "Select \"Forgot Password\" on the login screen, and follow the steps to reset it."
    },
    // {
    //   "icon": "assets/icons/help.svg",
    //   "title": "How do I update profile?",
    //   "desc":
    //   "Go to profile settings and update your information easily."
    // },
  ].obs;

  var helpTopics = <Map<String, dynamic>>[
    {
      "icon": "assets/icons/money_recive.svg",
      "title": "Budgeting Tools",
    },
    {
      "icon": "assets/icons/shield_security.svg",
      "title": "Security Settings",
    },
  ].obs;

  List<Map<String, dynamic>> get filteredGeneralQuestions {
    if (searchQuery.isEmpty) {
      return generalQuestions;
    }
    return generalQuestions
        .where((q) =>
    q["title"].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        q["desc"].toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }
}
