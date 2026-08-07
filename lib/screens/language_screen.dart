import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/language_model.dart';
import '../view_models/languageVM.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,

        // leading: const Icon(
        //   Icons.menu,
        //   color: Color(0xff202A72),
        // ),

        title: const Text(
          "LinguaLearn",
          style: TextStyle(
            color: Color(0xff202A72),
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: false,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            // child: CircleAvatar(
            //   radius: 18,
            //   backgroundColor: Colors.grey.shade200,
            //   child: const Icon(
            //     Icons.person,
            //     color: Color(0xff202A72),
            //   ),
            // ),
          )
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.languages.isEmpty) {
          return const Center(
            child: Text("No Languages Found"),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              const SizedBox(height: 10),

              const Text(
                "I want to learn...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff202A72),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Select the gateway to your next\nacademic journey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: GridView.builder(
                  itemCount: controller.languages.length + 1,

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: .82,
                  ),

                  itemBuilder: (context, index) {

                    if (index == controller.languages.length) {
                      return _requestCard();
                    }

                    final language =
                    controller.languages[index];

                    return _languageCard(language);
                  },
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: const Text(
                  " SCHOLARLY PATHWAY",
                  style: TextStyle(
                    color: Color(0xff202A72),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff202A72),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: () {},

                  child: const Text(
                    "Start Learning",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      }),
    );
  }
  Widget _languageCard(LanguageModel language) {

    return Card(
      elevation: 4,

      shadowColor: Colors.black12,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        onTap: () {
          // TODO:
          // Save selected language
          // Navigate to Home Screen
        },

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              Container(
                width: 62,
                height: 62,

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: Center(
                  child: Text(
                    language.flag,
                    style: const TextStyle(
                      fontSize: 34,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                language.languageName,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff202A72),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                language.languageCode.toUpperCase(),

                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _requestCard() {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      color: const Color(0xffEAF4FF),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        onTap: () {
          Get.snackbar(
            "Coming Soon",
            "More languages will be added soon.",
            snackPosition: SnackPosition.BOTTOM,
          );
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 62,
              height: 62,

              decoration: BoxDecoration(
                color: const Color(0xffD5E8FF),
                borderRadius: BorderRadius.circular(14),
              ),

              child: const Icon(
                Icons.add,
                size: 34,
                color: Color(0xff202A72),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "Request More",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff202A72),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Coming Soon",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}