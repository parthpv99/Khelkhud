import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xff2e3754),
        appBarTheme: AppBarTheme(elevation: 0),
        primaryColor: Color(0xff2e3754),
        accentColor: Color(0xfffe8b0e),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Coach(),
        ),
      ),
    );
  }
}

class Coach extends StatefulWidget {
  @override
  _CoachState createState() => _CoachState();
}

class _CoachState extends State<Coach> {
  final addCoachFormKey = GlobalKey<FormState>();
  bool addCoachFormAutoValidation = false;

//   DYNAMICALLY FETCH SPORTS
  List<String> sportsList = [
    "Football",
    "Kabaddi",
    "Cricket",
    "Badminton",
    "Volleyball"
  ];
//   FOR STORING THE COACH PREFERENCE
  List<bool> sportsTick = [false, false, false, false, false];

  final coachFormKey = GlobalKey<FormState>();
  bool coachFormAutoValidation = true;
  int i = 0, sportsCount = 0;

  String email, description, address, area, city;
  String img1, imgname1, sports = "";

// //   FOR IMAGE FILE
// List<File> _imageFile = [];

  void validateForm() {
    if (addCoachFormKey.currentState.validate()) {
      addCoachFormKey.currentState.save();
//       addCoach();
    } else {
      setState(() {
        addCoachFormAutoValidation = true;
      });
    }
  }

//  void addCoach() async {
//     try {
//       var response = await Requests.post(
//         'Insert HEROKU URL',
//         json: {
//           "user_id": (await User.fromSharedPreference).email,
//           "book_description": description,
//           "address": address,
//           "area": area,
//           "city": city,
//           "img_path1": img1,
//           "img_name1": imgname1,
//           "sports": sports,
//         },
//       );
//       response.raiseForStatus();

//       if (response.statusCode == 200) {
//         var coachJson = response.json();

//         if (!coachJson["is_error"]) {
//           Fluttertoast.showToast(
//               msg: 'You are now a Coach !',
//               toastLength: Toast.LENGTH_LONG,
//               backgroundColor: Colors.green,
//               textColor: Colors.white,
//               fontSize: 16.0);
//           Navigator.pop(context);
//         } else {
//           Fluttertoast.showToast(
//               msg: coachJson["message"],
//               toastLength: Toast.LENGTH_LONG,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0);
//         }
//       }
//     } on Exception catch (e) {
//       Fluttertoast.showToast(
//           msg: 'Error. Please try again later',
//           toastLength: Toast.LENGTH_LONG,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//   }

//     Future<List<int>> testCompressFile(File file) async {
//     var result = await FlutterImageCompress.compressWithFile(
//       file.absolute.path,
//       minWidth: 240,
//       minHeight: 300,
//       quality: 80,
//       rotate: 0,
//     );
//     return result;
//   }

// //   IMAGE TO BASE64 IF REQUIRED
//     void imageToBase64(File image, int i) async {
//    img1 = base64Encode(Uint8List.fromList(await testCompressFile(image)));
//       imgname1 = '1.jpg';
//     }

// //   TO GET THE IMAGE FROM THE USER MOBILE
//     void _getImage(ImageSource source) {
//     ImagePicker.pickImage(
//       source: source,
//       maxWidth: 400.0,
//     ).then((File image) {
//       if(image != null) {
//         setState(() {
//         imageToBase64(image, i);
//         _imageFile.add(image);
//       });
//       }
//     });
//   }

// //   FETCH ALL SPORTS LIST TO STORE THE COACH PREFERENCE
//     void fetchSports() async {
//     try {
//       var response = await Requests.post(
//         'INSERT HEROKU URL',
//       );
//       response.raiseForStatus();

//       if (response.statusCode == 200) {
//         var sportsJson = response.json();

//         if (sportsJson['count'] > 0) {
//           sportsCount = sportsJson['count'];
//           for (int i = 0; i < sportsCount; i++) {
//             sportsList.add(sportsJson['sports$i']);
//             sportsTick.add(false);
//           }

//           setState(() {});
//         } else {
//           Fluttertoast.showToast(
//               msg: 'Unable to fetch Sports. Please try again later',
//               toastLength: Toast.LENGTH_LONG,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0);
//           Navigator.pushReplacementNamed(context, 'TODO');
//         }
//       }
//     } on Exception catch (e) {
//       Fluttertoast.showToast(
//           msg: 'Unable to fetch Sports. Please try again later',
//           toastLength: Toast.LENGTH_LONG,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//       Navigator.pushReplacementNamed(context, 'TODO');
//     }
//   }

  void _showModal() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setCheckboxState) {
            return Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Wrap(
                children: <Widget>[
                  SizedBox(
                    height: 350.0,
                    child: ListView.builder(
                        itemCount: sportsList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Checkbox(
                                value: sportsTick[index],
                                onChanged: (value) {
                                  setCheckboxState(() {
                                    sportsTick[index] = value;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(sportsList[index]),
                            ],
                          );
                        }),
                  ),
                  Center(
                    child: RaisedButton(
                      child: Text('SUBMIT SPORTS'),
                      onPressed: popModal,
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  void popModal() {
    for (i = 0; i < sportsCount; i++) {
      if (sportsTick[i]) {
        sports += "${sportsList[i]},";
      }
    }
    Navigator.pop(context);
  }

// // TO FETCH THE SPORTS
//   void initState() {
//     fetchSports();
//   }

//
//
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Join as Coach'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: addCoachFormKey,
              autovalidate: addCoachFormAutoValidation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          obscureText: true,
                          onSaved: (value) => email = value,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Email Address',
                            hintText: 'Enter your Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          onSaved: (value) => email = value,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Mobile Number',
                            hintText: 'Enter your Mobile Number',
                            prefixIcon: Icon(Icons.phone_iphone),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: validateDescription,
                          onSaved: (value) => description = value,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Description',
                            hintText: 'Enter description of Achievements',
                            prefixIcon: Icon(Icons.short_text),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          maxLines: 4,
                          validator: validateAddress,
                          onSaved: (value) => address = value,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Address',
                            hintText: 'Enter your address',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.redAccent, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          enabled: false,
                          validator: validateCity,
                          onSaved: (value) => city = 'Rajkot',
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Rajkot',
                            prefixIcon: Icon(Icons.location_city),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        OutlineButton(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 2.0,
                          ),
                          onPressed: () {
//                                   _getImage(ImageSource.camera);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Add Your Identity Proof',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
//                         _imageFile.length == 0
//                             ? Text('Add atleast one Image')
//                             : SizedBox(
//                                 height: 180.0,
//                                 child: ListView.builder(
//                                   shrinkWrap: true,
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: _imageFile.length,
//                                   itemBuilder: (context, index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Image.file(
//                                         _imageFile[index],
//                                         fit: BoxFit.cover,
//                                         height: 160.0,
//                                         width: 100.0,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
                        RaisedButton(
                          child: Text('SPORTS'),
                          color: Color(0xfffe8b0e),
                          shape: kRoundedBorder,
                          textColor: Colors.white,
                          onPressed: _showModal,
                        ),
                        RaisedButton(
                          child: Text('JOIN US AS COACH'),
                          color: Color(0xfffe8b0e),
                          shape: kRoundedBorder,
                          textColor: Colors.white,
                          onPressed: validateForm,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//For TextTitle Decoration
const kTextTitle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.w300,
);

//For TextField Decoration
const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xfffe8b0e), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

//For Round Border
const kRoundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)));

//For heading of Container
const kContainerHeadingText = TextStyle(
  fontWeight: FontWeight.bold,
);

// -----------------------------------------------------------------
//              VALIDATION FUNCTIONS
// -----------------------------------------------------------------

String validateAddress(String value) {
  if (value.isEmpty) {
    return 'Address is required';
  }
  return null;
}

String validateArea(String value) {
  if (value.isEmpty) {
    return 'Area is required';
  }
  return null;
}

String validateCity(String value) {
  return null;
}

String validateDescription(String value) {
  return null;
}

String validateSports(String value) {
  return null;
}
