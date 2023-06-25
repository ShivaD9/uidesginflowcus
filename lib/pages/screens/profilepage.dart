import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';

class SizerUtil {
  static late DeviceType deviceType = _calculateDeviceType();

  static DeviceType _calculateDeviceType() {
    // Add your logic here to calculate the device type
    // For example, you can use MediaQuery to determine the screen size
    // and return the appropriate DeviceType enum value

    // Return a default value for now
    return DeviceType.mobile;
  }
}

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      SizerUtil.deviceType = deviceType;

      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: kOtherColor,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      ListTile(
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        title: Text(
                          'Hello Ahad!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Good Morning',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white54),
                        ),
                        trailing: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/logo_flowcus.png'),
                        ),
                      ),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
                sizedBox,
                const ProfileDetailColumn(
                    title: 'Registration Number', value: '2020-ASDF-2021'),
                const ProfileDetailColumn(
                    title: 'Academic Year', value: '2020-2021'),
                const ProfileDetailColumn(
                    title: 'Admission Class', value: 'X-II'),
                const ProfileDetailColumn(
                    title: 'Admission Number', value: '000126'),
                const ProfileDetailColumn(
                    title: 'Date of Admission', value: '1 Aug, 2020'),
                const ProfileDetailColumn(
                    title: 'Date of Birth', value: '3 May 1998'),
                const ProfileDetailColumn(
                  title: 'Email',
                  value: 'aisha12@gmail.com',
                ),
                const ProfileDetailColumn(
                  title: 'Father Name',
                  value: 'John Mirza',
                ),
                const ProfileDetailColumn(
                  title: 'Mother Name',
                  value: 'Angelica Mirza',
                ),
                const ProfileDetailColumn(
                  title: 'Phone Number',
                  value: '+923066666666',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: kTextBlackColor,
                  fontSize: SizerUtil.deviceType == DeviceType.tablet
                      ? 7.sp
                      : 11.sp,
                ),
              ),
              SizedBox(height: 5,),
              Text(value, style: Theme.of(context).textTheme.caption),
              SizedBox(height: 2,),
              SizedBox(
                width: 92.w,
                child: const Divider(
                  thickness: 1.0,
                ),
              )
            ],
          ),
          Icon(
            Icons.lock_outline,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}

//colors
const Color kPrimaryColor = Color(0xFF345FB4);
const Color kSecondaryColor = Color(0xFF6789CA);
const Color kTextBlackColor = Color(0xFF313131);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kErrorBorderColor = Color(0xFFE74C3C);

//default value
const kDefaultPadding = 30.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 5,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  topRight:
  Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

final kBottomBorderRadius = BorderRadius.only(
  bottomRight:
  Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  bottomLeft:
  Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

final kInputTextStyle = GoogleFonts.poppins(
    color: kTextBlackColor, fontSize: 11.sp, fontWeight: FontWeight.w500);

//validation for mobile
const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
