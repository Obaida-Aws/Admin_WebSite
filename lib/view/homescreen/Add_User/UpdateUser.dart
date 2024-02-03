import 'dart:io';

import 'package:adminsite/controller/homescreen_controller/Add/Update_controller.dart';
import 'package:adminsite/function/alterBox.dart';
import 'package:adminsite/function/validInput.dart';
import 'package:adminsite/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/models/chip_config.dart';
import 'package:multi_dropdown/models/network_config.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:multi_dropdown/widgets/selection_chip.dart';
import 'package:multi_dropdown/widgets/single_selected_item.dart';

class ProfileSettings extends StatelessWidget {
  ProfileSettings(
      {super.key, required this.userData, required this.availableFields}) {
    _controller1.text = userData[0]["firstname"];
    _controller2.text = userData[0]["lastname"];
    _controller3.text =
        (userData[0]["address"] == null) ? "" : userData[0]["address"];
    _controllergender.text =
        (userData[0]["Gender"] == null) ? "" : userData[0]["Gender"];

    _controller4.text =
        (userData[0]["country"] == null) ? "" : userData[0]["country"];
    controller.startDateController.text = userData[0]["dateOfBirth"];
    _controller6.text = userData[0]["phone"];
    username = userData[0]["username"];
    _controller7.text = (userData[0]["bio"] == null) ? "" : userData[0]["bio"];
    profileImage = (userData[0]["photo"] == null) ? "" : userData[0]["photo"];
    coverImage =
        (userData[0]["coverImage"] == null) ? "" : userData[0]["coverImage"];
    // Set initial values in the controller
    controller.textFieldText.value = _controller1.text;
    controller.textFieldText2.value = _controller2.text;
    controller.textFieldText3.value = _controller3.text;
    controller.country.value = _controller4.text;
    controller.gender.value = _controllergender.text;
    controller.textFieldText5.value = controller.startDateController.text;
    controller.textFieldText6.value = _controller6.text;
    controller.textFieldText7.value = _controller7.text;
    controller.items = RxList<String>.from(
      availableFields.map<String>((map) => map['Field'].toString()),
    );
    controller.selectedItems = RxList<String>.from(
      (userData[0]["Fields"] as String?)?.split(',') ?? [],
    );

    controller.update();
  }

  final AssetImage defultprofileImage =
      const AssetImage("images/profileImage.jpg");
  String? profileImageBytes;
  String? profileImageBytesName;
  String? profileImageExt;
  String? coverImageBytes;
  String? coverImageBytesName;
  String? coverImageExt;
  String? cvBytes;
  String? cvName;
  String? cvExt;
  String? profileImage;
  String? coverImage;
  ImageProvider<Object>? profileBackgroundImage;
  late ImageProvider<Object> coverBackgroundImage;

  final AssetImage defultcoverImage = const AssetImage("images/coverImage.jpg");
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controllergender = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  final List<Map<String, dynamic>> userData;
  final List<Map<String, dynamic>> availableFields;
  String? Firstname;
  String? Lastname;
  String? Address;
  String? Country;
  String? Gender;
  String? DateOfBirth;
  String? Phone;
  String? Bio;
  String? email;
  String? username;

  ProfileSettingsControllerImp controller =
      Get.put(ProfileSettingsControllerImp());

  @override
  Widget build(BuildContext context) {
    Firstname = userData[0]["name"];
    Lastname = userData[0]["lastname"];
    Address = userData[0]["address"];
    Country = userData[0]["country"];
    Gender = userData[0]["Gender"];
    DateOfBirth = userData[0]["dateOfBirth"];
    Phone = userData[0]["phone"];
    Bio = userData[0]["bio"];
    email = userData[0]["email"];

    profileBackgroundImage = (profileImage != null && profileImage != "")
        ? Image.network("$urlStarter/${profileImage!}").image
        : defultprofileImage;

    coverBackgroundImage = (coverImage != null && coverImage != "")
        ? Image.network("$urlStarter/${coverImage!}").image
        : defultcoverImage;
    return WillPopScope(
      onWillPop: () async {
        // Your custom logic here
        // For example, show a confirmation dialog
        controller.isTextFieldEnabled.value = false;
        controller.isTextFieldEnabled2.value = false;
        controller.isTextFieldEnabled3.value = false;
        controller.isTextFieldEnabled5.value = false;
        controller.isTextFieldEnabled6.value = false;
        controller.isTextFieldEnabled7.value = false;
        controller.isTextFieldEnabled11.value = false;
        controller.isTextFieldEnabledGender.value = false;
        controller.isTextFieldEnabledFields.value = false;
        print("obaida");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile Settings",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formstate,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                     
                      Obx(
                        () => Row(
                          children: [
                             if (kIsWeb)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    controller: _controller1,
                                    enabled: controller.isTextFieldEnabled.value,
                                    onChanged: (value) {
                                      controller.textFieldText.value = value;
                                    },
                                    validator: (Value) {
                                      return validInput(
                                          Value!, 50, 1, "username");
                                    },
                                    decoration: InputDecoration(
                                      hintText: controller.textFieldText.value,
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 30),
                                      label: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 9),
                                          child: const Text("Firstname")),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit the enable of the textfiled
                                controller.isTextFieldEnabled.toggle();
                                _controller1.text =
                                    controller.textFieldText.value;
                                controller.update();
                              },
                              icon: const Icon(Icons.edit),
                              color: controller.isTextFieldEnabled.value
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                             if (kIsWeb)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      Obx(
                        () => Row(
                          children: [
                             if (kIsWeb)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    controller: _controller2,
                                    enabled: controller.isTextFieldEnabled2.value,
                                    onChanged: (text) {
                                      controller.textFieldText2.value = text;
                                    },
                                    validator: (Value) {
                                      return validInput(
                                          Value!, 50, 1, "username");
                                    },
                                    decoration: InputDecoration(
                                      hintText: controller.textFieldText2.value,
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 30),
                                      label: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 9),
                                          child: const Text("Lastname")),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit the enable of the textfiled
                                controller.isTextFieldEnabled2.toggle();
                                _controller2.text =
                                    controller.textFieldText2.value;
                                controller.update();
                              },
                              icon: const Icon(Icons.edit),
                              color: controller.isTextFieldEnabled2.value
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                             if (kIsWeb)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),

                      //////////////////
                      const SizedBox(height: 20),
                      Obx(
                        () => Row(
                          children: [
                             if (kIsWeb)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    controller: _controller3,
                                    enabled: controller.isTextFieldEnabled3.value,
                                    onChanged: (text) {
                                      controller.textFieldText3.value = text;
                                    },
                                    validator: (Value) {
                                      return validInput(Value!, 50, 1, "length");
                                    },
                                    decoration: InputDecoration(
                                      hintText: controller.textFieldText3.value,
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 30),
                                      label: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 9),
                                          child: const Text("Address")),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit the enable of the textfiled
                                controller.isTextFieldEnabled3.toggle();
                                _controller3.text =
                                    controller.textFieldText3.value;
                                controller.update();
                              },
                              icon: const Icon(Icons.edit),
                              color: controller.isTextFieldEnabled3.value
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                             if (kIsWeb)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      //////////////////

                      const SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Obx(
                          () => Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 230),
                                  child: Text(
                                    "Your Fields",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                              Row(
                                children: [
                                  if (kIsWeb)
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                  Expanded(
                                    flex: 1,
                                    child: AbsorbPointer(
                                      absorbing: !controller
                                          .isTextFieldEnabledFields.value,
                                      child: MultiSelectDropDown(
                                        searchEnabled: true,
                                        onOptionSelected:
                                            (List<ValueItem> selectedOptions) {
                                          controller.finalselectedItems
                                              .assignAll(selectedOptions
                                                  .map((item) => item.value));
                                        },
                                        options: controller.items
                                            .map((item) => ValueItem(
                                                label: item, value: item))
                                            .toList(),
                                        selectionType: SelectionType.multi,
                                        chipConfig: const ChipConfig(
                                            wrapType: WrapType.scroll),
                                        dropdownHeight: 300,
                                        optionTextStyle:
                                            const TextStyle(fontSize: 16),
                                        selectedOptionIcon:
                                            const Icon(Icons.check_circle),
                                        selectedOptions: controller
                                            .selectedItems
                                            .map((item) => ValueItem(
                                                label: item, value: item))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.isTextFieldEnabledFields
                                          .toggle();
                                      controller.update();
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: controller
                                            .isTextFieldEnabledFields.value
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  if (kIsWeb)
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Obx(
                        () => Row(
                          children: [
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 30),
                                      label: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: const Text("Your Country"),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: const Text('Select Country',
                                        style: TextStyle(color: Colors.grey)),
                                    items: controller.countryList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: controller.country.value.isEmpty
                                        ? null
                                        : controller.country.value,
                                    onChanged: controller
                                            .isTextFieldEnabled11.value
                                        ? (value) {
                                            controller.country.value =
                                                value.toString();
                                            print(controller.country.value);
                                          }
                                        : null, // Disable the dropdown when not enabled
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select country';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Toggle the enable state of the dropdown
                                controller.isTextFieldEnabled11.toggle();
                              },
                              icon: const Icon(Icons.edit),
                              color: controller.isTextFieldEnabled11.value
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Obx(
                        () => Row(
                          children: [
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 30),
                                      label: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: const Text("Your Gender"),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: const Text('Select Gender',
                                        style: TextStyle(color: Colors.grey)),
                                    items: controller.genderList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: controller.gender.value.isEmpty
                                        ? null
                                        : controller.gender.value,
                                    onChanged: controller
                                            .isTextFieldEnabledGender.value
                                        ? (value) {
                                            controller.gender.value =
                                                value.toString();
                                            print(controller.gender.value);
                                          }
                                        : null, // Disable the dropdown when not enabled
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select gender';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Toggle the enable state of the dropdown
                                controller.isTextFieldEnabledGender.toggle();
                              },
                              icon: const Icon(Icons.edit),
                              color: controller.isTextFieldEnabledGender.value
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                          ],
                        ),
                      ),

                      
                      const SizedBox(height: 20),
                      Obx(
                        () => Row(
                          children: [
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    // controller: _controller5,
                                    controller: controller.startDateController,
                                    readOnly: true,
                                    enabled:
                                        controller.isTextFieldEnabled5.value,
                                    onChanged: (text) {
                                      controller.textFieldText5.value = text;
                                    },

                                    validator: (Value) {
                                      return validInput(
                                          Value!, 10, 8, "dateOfBirth");
                                    },
                                    decoration: InputDecoration(
                                      hintText: controller.textFieldText5.value,
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 30),
                                      label: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 9),
                                          child: const Text("DateOfBirth")),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.date_range),
                                        onPressed: () =>
                                            controller.pickStartDate(context),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit the enable of the textfiled
                                controller.isTextFieldEnabled5.toggle();
                                controller.startDateController.text =
                                    controller.textFieldText5.value;
                                controller.update();
                              },
                              icon: const Icon(Icons.edit),
                              color: controller.isTextFieldEnabled5.value
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                          ],
                        ),
                      ),

                      //////////////////
                      const SizedBox(height: 20),
                      Obx(
                        () => Row(
                          children: [
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    controller: _controller6,
                                    enabled:
                                        controller.isTextFieldEnabled6.value,
                                    onChanged: (text) {
                                      controller.textFieldText6.value = text;
                                    },
                                    validator: (Value) {
                                      return validInput(
                                          Value!, 15, 10, "phone");
                                    },
                                    decoration: InputDecoration(
                                      hintText: controller.textFieldText6.value,
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 30),
                                      label: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 9),
                                          child: const Text("Phone")),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit the enable of the textfiled
                                controller.isTextFieldEnabled6.toggle();
                                _controller6.text =
                                    controller.textFieldText6.value;
                                controller.update();
                              },
                              icon: const Icon(Icons.edit),
                              color: controller.isTextFieldEnabled6.value
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                          ],
                        ),
                      ),

                      //////////////////
                      const SizedBox(height: 20),
                      Obx(
                        () => Row(
                          children: [
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    controller: _controller7,
                                    enabled:
                                        controller.isTextFieldEnabled7.value,
                                    onChanged: (text) {
                                      controller.textFieldText7.value = text;
                                    },
                                    validator: (Value) {
                                      return validInput(
                                          Value!, 250, 1, "length");
                                    },
                                    decoration: InputDecoration(
                                      hintText: controller.textFieldText7.value,
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 30),
                                      label: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 9),
                                          child: const Text("Bio")),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Edit the enable of the textfiled
                                controller.isTextFieldEnabled7.toggle();
                                _controller7.text =
                                    controller.textFieldText7.value;
                                controller.update();
                              },
                              icon: const Icon(Icons.edit),
                              color: controller.isTextFieldEnabled7.value
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            if (kIsWeb)
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                          ],
                        ),
                      ),

                    

                      const SizedBox(height: 20),

                     

                      Row(
                        children: [
                          if (kIsWeb)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 135),
                              onPressed: () async {
                                print("oooooooooooooooooooo");
                                print(
                                    (controller.finalselectedItems.join(',')));
                                print("oooooooooooooooooooo");
                                var message = await controller.SaveChanges(email,username
                                
                                   );
                                (message != null)
                                    ? showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomAlertDialog(
                                            title: 'Error',
                                            icon: Icons.error,
                                            text: message,
                                            buttonText: 'OK',
                                          );
                                        },
                                      )
                                    : null;
                              },
                              color: const Color.fromARGB(255, 85, 191, 218),
                              textColor: Colors.white,
                              child: const Text("Save Changes"),
                            ),
                          ),
                          if (kIsWeb)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
