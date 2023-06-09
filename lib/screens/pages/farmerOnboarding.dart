import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/providers/profile_data.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../services/firebase_api_methods.dart';

class FarmerOnboarding extends StatefulWidget {
  @override
  _FarmerOnboardingState createState() => _FarmerOnboardingState();
}

class _FarmerOnboardingState extends State<FarmerOnboarding> {

  int _activeStepIndex = 0;
  TextEditingController name = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController holder_name = TextEditingController();
  TextEditingController acc_number = TextEditingController();
  TextEditingController ifs_code= TextEditingController();
  TextEditingController bank_name= TextEditingController();
  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Your Details'),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: phone_number,
              //obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    ),
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Bank Details'),
        content: Container(
          child: Column(
            children: [

              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: holder_name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'A/c Holder Name',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: acc_number,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'A/c Number',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: ifs_code,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'IFS Code',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: bank_name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bank Name',
                ),
              ),
            ],
          ),
        )),
    Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 2,
        title: const Text('Confirm'),
        content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Phone Number: ${phone_number.text}'),
                Text('A/c Holder Name: ${holder_name.text}'),
                Text('A/c Number : ${acc_number.text}'),
                Text('IFS Code: ${ifs_code.text}'),
                Text('Bank Name : ${bank_name.text}'),
              ],
            )))
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    FarmProvider farmerData =Provider.of<FarmProvider>(context, listen: false);

    ProfileData  profile =Provider.of<ProfileData>(context, listen: false);
    return Scaffold(
      appBar:DefaultAppBar(title: "Farmer Onboarding"),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            farmer_onboarding(user.uid,name.text,
                phone_number.text,holder_name.text,acc_number.text,ifs_code.text,bank_name.text,false)
                .then((value) => profile.FarmerFormFillCheck(user.uid))
                .then((value) => {
              Navigator.pop(context)
            });
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final isLastStep = _activeStepIndex == stepList().length - 1;
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: details.onStepContinue,
                    child: (isLastStep)
                        ? const Text('Submit')
                        : const Text('Next'),
                  ),
                ),
                if (_activeStepIndex > 0)
                  const SizedBox(
                    width: 10,
                  ),
                if (_activeStepIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}