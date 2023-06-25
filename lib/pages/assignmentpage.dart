import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';

  @override
  Widget build(BuildContext context) {
    final deviceType =
        SizerUtil.deviceType; // Initialize the deviceType variable

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(deviceType == DeviceType.tablet
                      ? 40
                      : 20), // Use the initialized deviceType variable
                  topRight: Radius.circular(deviceType == DeviceType.tablet
                      ? 40
                      : 20), // Use the initialized deviceType variable
                ),
              ),
              child: ListView.builder(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  itemCount: assignment.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: kDefaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding),
                              color: kOtherColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: kTextLightColor,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor.withOpacity(0.4),
                                    borderRadius:
                                        BorderRadius.circular(kDefaultPadding),
                                  ),
                                  child: Center(
                                    child: Text(
                                      assignment[index].subjectName,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                kHalfSizedBox,
                                Text(
                                  assignment[index].topicName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: kTextBlackColor,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: 'Assign Date',
                                  statusValue: assignment[index].assignDate,
                                ),
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: 'Last Date',
                                  statusValue: assignment[index].lastDate,
                                ),
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: 'Status',
                                  statusValue: assignment[index].status,
                                ),
                                kHalfSizedBox,
//use condition here to display button
                                if (assignment[index].status == 'Pending')
//then show button
                                  AssignmentButton(
                                    onPress: () {
//submit here
                                    },
                                    title: 'To be Submitted',
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class AssignmentDetailRow extends StatelessWidget {
  const AssignmentDetailRow(
      {Key? key, required this.title, required this.statusValue})
      : super(key: key);
  final String title;
  final String statusValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: kTextBlackColor.withOpacity(0.6),
              ),
        ),
        Text(
          statusValue,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: kTextBlackColor,
              ),
        ),
      ],
    );
  }
}

class AssignmentButton extends StatelessWidget {
  const AssignmentButton({Key? key, required this.onPress, required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        title,
        style: Theme.of(context).textTheme.button!.copyWith(
              color: kSecondaryColor,
            ),
      ),
    );
  }
}

class AssignmentData {
  final String subjectName;
  final String topicName;
  final String assignDate;
  final String lastDate;
  final String status;

  AssignmentData(this.subjectName, this.topicName, this.assignDate,
      this.lastDate, this.status);
}

List<AssignmentData> assignment = [
  AssignmentData(
      'Biology', 'Red Blood Cells', '17 Nov 2021', '20 Nov 2021', 'Pending'),
  AssignmentData(
      'Physics', 'bohr theory', '11 Nov 2021', '20 Nov 2021', 'Submitted'),
  AssignmentData('Chemistry', 'Organic Chemistry', '21 Oct 2021', '27 Oct 2021',
      'Not Submitted'),
  AssignmentData(
      'Mathematics', 'Algebra', '17 Sep 2021', '30 Sep 2021', 'Pending'),
];

const Color kPrimaryColor = Color(0xFF345FB4);
const Color kSecondaryColor = Color(0xFF6789CA);
const Color kTextBlackColor = Color(0xFF313131);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kErrorBorderColor = Color(0xFFE74C3C);

final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  topRight:
      Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kDefaultPadding = 20.0;
