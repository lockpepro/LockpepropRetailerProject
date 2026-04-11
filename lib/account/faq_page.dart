import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'faq_controller.dart';

class FAQPage extends StatelessWidget {
  final FAQController c = Get.put(FAQController());

  FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _header(),
          Expanded(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  _sectionTitle("General Question"),

                  // const SizedBox(height: 10),
                  Obx(() => _generalQuestionGrid()),

                  _sectionTitle("Help by Topic"),
                  const SizedBox(height: 12),
                  _helpTopicList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Header with Gradient ----------------
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffDDE7FF),
            Color(0xffF5F7FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(28),
        //   bottomRight: Radius.circular(28),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xffEEF3FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, size: 16),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "Frequently Asked Questions",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Find quick answers to common questions and\nsolutions to your concerns.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),

          _searchBar(),

        ],
      ),
    );
  }

  // ---------------- Search Bar ----------------
  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF6F7FB),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 6),
      child: TextField(
        onChanged: (value) => c.updateSearch(value),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Search faqs...",
          contentPadding: EdgeInsets.only(top: 11),
          prefixIcon: Icon(Icons.search, color: Colors.black54),
        ),
      ),
    );
  }

  // ---------------- Section Title ----------------
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // ---------------- General Question Cards ----------------
  Widget _generalQuestionGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: c.filteredGeneralQuestions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.82,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        final item = c.filteredGeneralQuestions[index];
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xffF6F7FB),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  item["icon"],
                  height: 26,
                  width: 26,color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                item["title"],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),

              // Description
              Text(
                item["desc"],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- Help by Topic Buttons ----------------
  Widget _helpTopicList() {
    return Column(
      children: List.generate(c.helpTopics.length, (index) {
        final item = c.helpTopics[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xffF6F7FB),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  item["icon"],
                  height: 22,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                item["title"],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
