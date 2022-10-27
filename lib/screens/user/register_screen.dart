// ignore_for_file: no_leading_underscores_for_local_identifiers, depend_on_referenced_packages
import 'dart:io';

import 'package:atvee/bloc/models/professional_user.dart';
import 'package:atvee/themes/models/activity.dart';
import 'package:atvee/themes/models/occupation.dart';
import 'package:atvee/themes/widgets/activity_checkbox.dart';
import 'package:atvee/themes/widgets/city_selector.dart';
import 'package:atvee/themes/custom_widget.dart';
import 'package:atvee/themes/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenViewState createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late String picUrl;

  int _activeStepIndex = 0;
  ProfessionalUser? _professionalUser;
  Validation validation = Validation();
  CitySelector citySelector = const CitySelector();
  Occupation? occupation;

  File? _userImage;
  final picker = ImagePicker();

  dynamic imgURL;

  final List<String> cities = [
    "Sorocaba",
    "Votorantim",
    "Salto de Pirapora",
    "Araçoiaba da Serra",
    "Iperó",
    "Porto Feliz",
    "Itu",
    "Mairinque",
    "Alumínio"
  ];

  bool? isSelfEmployed;

  String? selectedValue;

  List<Activity> activities = <Activity>[
    Activity(value: 'Musculação'),
    Activity(value: 'Yoga'),
    Activity(value: 'Corrida'),
    Activity(value: 'Natação'),
    Activity(value: 'Crossfit'),
  ];

  List<String> selection = [];

  Future pickImage(BuildContext context, CustomWidget customWidget) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _userImage = File(pickedFile!.path);
        uploadImageToFirebase();
      });
    } on PlatformException catch (e) {
      customWidget.showSnack(context, e.message.toString());
    }
  }

  bool validFields(BuildContext context, CustomWidget customWidget, int step) {
    if (step == 0) {
      if (_userImage == null) {
        customWidget.showSnack(context, "Selecione uma foto.");
        return false;
      }
      if (occupation == null) {
        customWidget.showSnack(context, "Selecione uma profissão.");
        return false;
      }
      if (!validation.validTextLength(_descriptionController.text, 10, 250) ||
          _descriptionController.text.isEmpty) {
        customWidget.showSnack(
            context, "Minímo 10 caracteres, máximo 250 no campo Descrição.");
        return false;
      }
    } else if (step == 1) {
      if (!validation.validTextLength(_firstNameController.text, 2, 20) ||
          !validation.hasNoSpace(_firstNameController.text) ||
          _firstNameController.text.isEmpty) {
        customWidget.showSnack(context,
            "Minímo 2 caracteres, máximo 20 no campo Nome e sem espaço.");
        return false;
      }
      if (!validation.validTextLength(_lastNameController.text, 2, 20) ||
          !validation.hasNoSpace(_lastNameController.text) ||
          _lastNameController.text.isEmpty) {
        customWidget.showSnack(context,
            "Minímo 2 caracteres, máximo 20 no campo Sobrenome e sem espaço.");
        return false;
      }
      if (!validation.validPhoneNumber(_phoneNumberController.text)) {
        customWidget.showSnack(context,
            "Minímo 10, máximo 12 caracteres no campo Contato e número válido.");
        return false;
      }
      if (!validation.validEmail(_emailController.text)) {
        customWidget.showSnack(context, "Email inválido.");
        return false;
      }
      if (_passwordController.text.length < 6) {
        customWidget.showSnack(context,
            "Minímo 6 caracteres, máximo 20 no campo Senha e sem espaço.");
        return false;
      } else if (_passwordController.text.length >= 6) {
        if (_passwordController.text != _repasswordController.text) {
          customWidget.showSnack(context, "Senhas diferentes.");
          return false;
        }
      }
    } else {
      if (isSelfEmployed == null) {
        customWidget.showSnack(context,
            "Selecione uma das opções para o campo Profissional Autônomo.");
        return false;
      }
      if (selectedValue == null) {
        customWidget.showSnack(context, "Selecione uma cidade.");
        return false;
      }
    }

    return true;
  }

  bool saveActivities(BuildContext context, CustomWidget customWidget,
      List<Activity> activities) {
    selection = [];

    for (var activity in activities) {
      if (activity.isChecked == true) {
        selection.add(activity.value);
      }
    }

    if (selection.length > 3 || selection.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void _handleRegister(CustomWidget customWidget, BuildContext context) {
    if (saveActivities(context, customWidget, activities) == true) {
      _professionalUser = ProfessionalUser(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _phoneNumberController.text,
        picUrl,
        false,
        isSelfEmployed!,
        occupation!.name.toString(),
        _descriptionController.text,
        selectedValue.toString(),
        selection,
      );

      _registerUser(context, _professionalUser!, customWidget);
    } else {
      customWidget.showSnack(
          context, "Selecione no minímo uma atividade, no máximo três.");
    }
  }

  void _registerUser(BuildContext context, ProfessionalUser professionalUser,
      CustomWidget customWidget) async {
    try {
      CollectionReference userdata =
          FirebaseFirestore.instance.collection('professionals');
      await userdata.doc(professionalUser.email).set({
        'first_name': professionalUser.firstName,
        'last_name': professionalUser.lastName,
        'phone_number': professionalUser.phoneNumber,
        'profile_picture_url': professionalUser.profilePicUrl,
        'is_client': professionalUser.isClient,
        'is_self_employed': professionalUser.isSelfEmployed,
        'occupation': professionalUser.occupation,
        'description': professionalUser.description,
        'area_of_operation': professionalUser.areaOfOperation,
        'activities': professionalUser.activities
      }).then((value) =>
          {_createCredential(context, professionalUser, customWidget)});
    } catch (error) {
      customWidget.showSnack(context, error.toString());
    }
  }

  void _createCredential(BuildContext context,
      ProfessionalUser professionalUser, CustomWidget customWidget) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: professionalUser.email, password: _passwordController.text)
          .then((value) => {
                value.user!.sendEmailVerification(),
                customWidget.showSnack(context,
                    "Criando conta e redirecionando para a tela de login."),
                Future.delayed(const Duration(seconds: 5), () {
                  Navigator.of(context).pop();
                })
              });
    } on FirebaseAuthException catch (error) {
      customWidget.showSnack(context, error.message.toString());
    }
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(_userImage!.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference firebaseStorageRef = storage.ref().child('user-images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_userImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) => picUrl = value);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    CustomWidget _customWidget = CustomWidget(mediaQuery);

    final openGallery = IconButton(
      icon: const Icon(Icons.photo_camera, size: 40, color: Colors.white),
      onPressed: () {
        pickImage(context, _customWidget);
      },
    );

    final occupationDropDown = DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonWidth: width / 1.3,
        buttonDecoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        hint: Padding(
          padding: EdgeInsets.only(left: width / 20),
          child: const Text(
            'Selecione uma profisssão',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        items: Occupation.values
            .map((occupation) => DropdownMenuItem<Occupation>(
                value: occupation,
                child: Padding(
                  padding: EdgeInsets.only(left: width / 20),
                  child: Text(
                    occupation.name.toUpperCase() == 'PERSONAL'
                        ? 'PERSONAL TRAINER'
                        : occupation.name.toUpperCase(),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )))
            .toList(),
        value: occupation,
        onChanged: (value) {
          setState(() {
            occupation = value;
          });
        },
      ),
    );

    final radios = SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: width / 20),
            child: const Text('Profissional Autônomo?',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(left: width / 30),
            child: ListTile(
              title: const Text('Sim', style: TextStyle(color: Colors.white)),
              leading: Radio(
                fillColor: MaterialStateProperty.all(Colors.white),
                value: true,
                groupValue: isSelfEmployed,
                onChanged: (value) {
                  setState(() {
                    isSelfEmployed = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width / 30),
            child: ListTile(
              title: const Text('Não', style: TextStyle(color: Colors.white)),
              leading: Radio(
                fillColor: MaterialStateProperty.all(Colors.white),
                value: false,
                groupValue: isSelfEmployed,
                onChanged: (value) {
                  setState(() {
                    isSelfEmployed = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );

    final cityDropDown = DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonWidth: width / 1.3,
        buttonDecoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        hint: Padding(
          padding: EdgeInsets.only(left: width / 20),
          child: const Text(
            'Selecione uma cidade',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        items: cities
            .map((city) => DropdownMenuItem<String>(
                value: city,
                child: Padding(
                    padding: EdgeInsets.only(left: width / 20),
                    child: Text(
                      city,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ))))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
      ),
    );

    final activityList = Column(
      children: [
        ActivityCheckboxWidget(item: activities[0]),
        ActivityCheckboxWidget(item: activities[1]),
        ActivityCheckboxWidget(item: activities[2]),
        ActivityCheckboxWidget(item: activities[3]),
        ActivityCheckboxWidget(item: activities[4]),
      ],
    );

    final firstStepFields = SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_userImage != null)
            Padding(
                padding: EdgeInsets.only(bottom: height / 60),
                child: _customWidget.buildUserAvatar(_userImage,
                    mediaQuery.size.width / 2.5, mediaQuery.size.height / 5)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: openGallery),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: occupationDropDown),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: _customWidget.createTextFieldWithLabel(
                  _descriptionController,
                  "Descrição",
                  "Insira uma descrição",
                  Colors.white)),
        ],
      ),
    );

    final secondStepFields = SizedBox(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: _customWidget.createTextFieldWithLabel(
                  _firstNameController,
                  "Primeiro Nome",
                  "Insira o seu primeiro nome",
                  Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: _customWidget.createTextFieldWithLabel(_lastNameController,
                  "Último Nome", "Insira o seu último nome", Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: _customWidget.createTextFieldWithLabel(
                  _phoneNumberController,
                  "Número de Celular",
                  "Minímo 10 digitos",
                  Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: _customWidget.createTextFieldWithLabel(_emailController,
                  "E-mail", "Insira um email válido", Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: _customWidget.createPasswordFieldWithLabel(
                  _passwordController,
                  "Senha",
                  "Minímo 6 caracteres",
                  Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: _customWidget.createPasswordFieldWithLabel(
                  _repasswordController, "Senha novamente", "", Colors.white))
        ],
      ),
    );

    final thirdStepFields = SizedBox(
      width: width / 1.2,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: height / 30),
            child: radios,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height / 30),
            child: cityDropDown,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height / 30),
            child: activityList,
          ),
        ],
      ),
    );

    List<Step> registerSteps() => [
          Step(
              title: const Text(''),
              label: const Text('1ª Etapa'),
              state: _activeStepIndex <= 0
                  ? StepState.editing
                  : StepState.complete,
              isActive: _activeStepIndex >= 0,
              content: Center(
                child: firstStepFields,
              )),
          Step(
              title: const Text(''),
              label: const Text('2ª Etapa'),
              state: _activeStepIndex <= 1
                  ? StepState.editing
                  : StepState.complete,
              isActive: _activeStepIndex >= 1,
              content: Center(
                child: secondStepFields,
              )),
          Step(
              title: const Text(''),
              label: const Text('3ª Etapa'),
              state: _activeStepIndex <= 2
                  ? StepState.editing
                  : StepState.complete,
              isActive: _activeStepIndex >= 2,
              content: Center(
                child: thirdStepFields,
              )),
        ];

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro"),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        backgroundColor: Colors.amber,
        body: Stepper(
          controlsBuilder: (context, details) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 59, 82, 67)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    onPressed: details.onStepCancel,
                    child: Text(
                      "voltar".toUpperCase(),
                      style:
                          TextStyle(fontSize: width / 20, color: Colors.white),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 59, 82, 67)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    onPressed: () {
                      if (validFields(
                          context, _customWidget, details.currentStep)) {
                        if (details.currentStep < 2) {
                          setState(() {
                            _activeStepIndex += 1;
                          });
                        } else {
                          _handleRegister(_customWidget, context);
                        }
                      }
                    },
                    child: Text(
                      "continuar".toUpperCase(),
                      style:
                          TextStyle(fontSize: width / 20, color: Colors.white),
                    ))
              ],
            );
          },
          type: StepperType.horizontal,
          currentStep: _activeStepIndex,
          steps: registerSteps(),
          onStepContinue: () {
            if (_activeStepIndex < (registerSteps().length - 1)) {
              _activeStepIndex += 1;
            }
            setState(() {});
          },
          onStepCancel: () {
            _activeStepIndex == 0
                ? Navigator.of(context).pop()
                : _activeStepIndex -= 1;
            setState(() {});
          },
        ),
      ),
    );
  }
}
