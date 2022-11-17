import 'dart:io';

import 'package:atvee/backend/service/professional_service.dart';
import 'package:atvee/backend/models/professional_user.dart';
import 'package:atvee/backend/models/activity.dart';
import 'package:atvee/frontend/themes/routes.dart';
import 'package:atvee/frontend/themes/widgets/activity_checkbox.dart';
import 'package:atvee/frontend/themes/utils.dart';
import 'package:atvee/frontend/themes/widgets/fields/cellphone_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/city_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/description_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/email_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/first_name_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/last_name_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/occupation_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/password_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/repassword_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/self_employed_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreen> {
  // Variáveis da primeira etapa do cadastro
  final firstStepFormKey = GlobalKey<FormState>();
  final TextEditingController pictureController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? userImage;
  String? url;

  // Variáveis da segunda etapa do cadastro
  final secondStepFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  // Variáveis da terceira etapa do cadastro
  final TextEditingController selfEmployedController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  List<Activity> activities = [
    Activity(value: 'Musculação'),
    Activity(value: 'Yoga'),
    Activity(value: 'Corrida'),
    Activity(value: 'Natação'),
    Activity(value: 'Crossfit'),
  ];

  // Variáveis para as validações dos campos da terceira etapa
  late bool isSelfEmployed;
  List<String> selected = [];

  // Usuário que será criado ao final do cadastro
  late ProfessionalUser professionalUser;

  // Variável para o controle do Stepper
  int activeStepIndex = 0;

  // Variáveis auxiliares
  late Utils utils;
  late double width;
  late double height;

  ProfessionalService professionalService = ProfessionalService();

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    height = mediaQuery.size.height;
    width = mediaQuery.size.width;
    utils = Utils(context: context);

    // Campos da primeira etapa de cadastro
    final pictureField = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        userImage == null ? defaultPicture() : pickedPicture(),
        createIcon(),
      ],
    );
    final occupationField = OccupationField(controller: occupationController);
    final descriptionField =
        DescriptionField(controller: descriptionController);

    // Campos da segunda etapa de cadastro
    final firstNameField = FirstNameField(controller: firstNameController);
    final lastNameField = LastNameField(controller: lastNameController);
    final cellphoneField = CellphoneField(controller: cellphoneController);
    final emailField = EmailField(controller: emailController);
    final passwordField = PasswordField(controller: passwordController);
    final repasswordField = RepasswordField(controller: repasswordController);

    // Campos da terceira etapa de cadastro
    final selfEmployedField =
        SelfEmployedField(controller: selfEmployedController);
    final cityField = CityField(controller: cityController);
    final activitiesField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Atividades', style: appTheme.textTheme.subtitle2),
        ActivityCheckboxWidget(item: activities[0]),
        ActivityCheckboxWidget(item: activities[1]),
        ActivityCheckboxWidget(item: activities[2]),
        ActivityCheckboxWidget(item: activities[3]),
        ActivityCheckboxWidget(item: activities[4]),
      ],
    );

    final firstStepFields = SizedBox(
      child: Column(
        children: <Widget>[
          pictureField,
          occupationField,
          Form(
            key: firstStepFormKey,
            child: descriptionField,
          ),
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: height / 40),
                  child: widget,
                ))
            .toList(),
      ),
    );

    final secondStepFields = SizedBox(
      child: Column(
        children: <Widget>[
          firstNameField,
          lastNameField,
          cellphoneField,
          emailField,
          passwordField,
          repasswordField,
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: height / 40),
                  child: widget,
                ))
            .toList(),
      ),
    );

    final thirdStepFields = SizedBox(
      width: width / 1.2,
      child: Column(
        children: <Widget>[
          selfEmployedField,
          cityField,
          activitiesField,
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: height / 40),
                  child: widget,
                ))
            .toList(),
      ),
    );

    List<Step> registerSteps() => [
          Step(
              title: const Text(''),
              label: Text('1ª Etapa', style: appTheme.textTheme.headline2),
              state:
                  activeStepIndex <= 0 ? StepState.editing : StepState.complete,
              isActive: activeStepIndex >= 0,
              content: Center(
                child: firstStepFields,
              )),
          Step(
              title: const Text(''),
              label: Text('2ª Etapa', style: appTheme.textTheme.headline2),
              state:
                  activeStepIndex <= 1 ? StepState.editing : StepState.complete,
              isActive: activeStepIndex >= 1,
              content: Center(
                child: Form(
                  key: secondStepFormKey,
                  child: secondStepFields,
                ),
              )),
          Step(
              title: const Text(''),
              label: Text('3ª Etapa', style: appTheme.textTheme.headline2),
              state:
                  activeStepIndex <= 2 ? StepState.editing : StepState.complete,
              isActive: activeStepIndex >= 2,
              content: Center(
                child: thirdStepFields,
              )),
          Step(
            title: const Text(''),
            label: Text('Fim', style: appTheme.textTheme.headline2),
            state:
                activeStepIndex <= 3 ? StepState.editing : StepState.complete,
            isActive: activeStepIndex >= 3,
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Text(
                      'Após ser redirecionado(a) para a tela de login, acesse o link de verificação que foi enviado ao email de cadastro antes de iniciar sessão.',
                      style: appTheme.textTheme.subtitle2),
                ),
              ],
            ),
          ),
        ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      backgroundColor: appTheme.backgroundColor,
      body: Stepper(
        elevation: 4,
        controlsBuilder: (context, details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: details.onStepCancel,
                  child: Text(
                    "VOLTAR",
                    style: TextStyle(fontSize: width / 20, color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    if (details.currentStep == 0) {
                      if (firstStepValidate()) {
                        setState(() {
                          activeStepIndex += 1;
                        });
                      }
                    }
                    if (details.currentStep == 1) {
                      if (secondStepFormKey.currentState!.validate() &&
                          secondStepValidate()) {
                        setState(() {
                          activeStepIndex += 1;
                        });
                      }
                    } else if (details.currentStep == 2) {
                      isSelfEmployed =
                          selfEmployedController.text == "sim" ? true : false;
                      selected = professionalService.saveActivities(activities);
                      if (thirdStepValidate()) {
                        setState(() {
                          activeStepIndex += 1;
                        });
                      }
                    } else if (details.currentStep == 3) {
                      handleRegistration();
                      Navigator.of(context).maybePop();
                    }
                  },
                  child: Text(
                    "AVANÇAR",
                    style: TextStyle(fontSize: width / 20, color: Colors.white),
                  ))
            ],
          );
        },
        type: StepperType.horizontal,
        currentStep: activeStepIndex,
        steps: registerSteps(),
        onStepContinue: () {
          if (activeStepIndex < (registerSteps().length - 1)) {
            activeStepIndex += 1;
          }
          setState(() {});
        },
        onStepCancel: () {
          activeStepIndex == 0
              ? Navigator.of(context).pop()
              : activeStepIndex -= 1;
          setState(() {});
        },
      ),
    );
  }

  IconButton createIcon() => IconButton(
        icon: const Icon(Icons.photo_camera,
            size: 40, color: Color.fromARGB(255, 59, 82, 67)),
        onPressed: () {
          pickImage();
        },
      );

  ClipOval defaultPicture() => ClipOval(
          child: Image.asset(
        "lib/resources/icon-atvee.jpeg",
        width: width / 2,
        height: height / 4,
        fit: BoxFit.cover,
      ));

  ClipOval pickedPicture() => ClipOval(
        child: Image.file(
          userImage!,
          width: width / 2,
          height: height / 4,
          fit: BoxFit.cover,
        ),
      );

  Future pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        userImage = File(pickedFile!.path);
      });
    } catch (error) {
      utils.alert("pickImage: $error");
    }
  }

  bool firstStepValidate() {
    if (userImage == null) {
      utils.snack("Selecione uma imagem");
      return false;
    }
    if (occupationController.text.isEmpty) {
      utils.snack("Selecione uma das opções para Profissão");
      return false;
    }
    if (!firstStepFormKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  bool secondStepValidate() {
    if (passwordController.text != repasswordController.text) {
      utils.snack("Senhas diferentes");
      return false;
    }

    return true;
  }

  bool thirdStepValidate() {
    if (selfEmployedController.text.isEmpty) {
      utils.snack("Selecione uma das opções para Profissional Autônomo");
      return false;
    }
    if (cityController.text.isEmpty) {
      utils.snack("Selecione uma das opções para Cidade");
      return false;
    }
    if (selected.isEmpty) {
      utils.snack("Selecione de uma a três atividades");
      return false;
    }
    return true;
  }

  Future uploadImage() async {
    String fileName = basename(userImage!.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference firebaseStorageRef = storage.ref().child('user-images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(userImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) => url = value);
  }

  void handleRegistration() async {
    try {
      await uploadImage();
      await professionalService.createCredential(
          emailController.text, passwordController.text);

      professionalUser = ProfessionalUser(
        firstNameController.text.toUpperCase(),
        lastNameController.text.toUpperCase(),
        emailController.text,
        cellphoneController.text,
        url!,
        false,
        isSelfEmployed,
        occupationController.text,
        descriptionController.text,
        cityController.text,
        selected,
      );

      await professionalService
          .createData(professionalUser)
          .then((void value) => {utils.alert('Criando conta, aguarde...')});
    } catch (error) {
      utils.alert("$error");
    }
  }
}
