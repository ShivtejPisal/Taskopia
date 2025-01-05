import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskoopia/common/widgets/appstyle.dart';
import 'package:taskoopia/common/widgets/custom_otn_btn.dart';
import 'package:taskoopia/common/widgets/custom_text.dart';
import 'package:taskoopia/common/widgets/height_spacer.dart';
import 'package:taskoopia/features/todo/controllers/dates/dates_provider.dart';
import 'package:taskoopia/features/todo/controllers/todo/todo_provider.dart';
import '../../../common/models/task_model.dart';
import '../../../common/utils/constants.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var start = ref.watch(startTimeStateProvider);
    var finish = ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HeightSpacer(value: 20),

            CustomTextField(
                hintText: "Add title",
                controller: title,
                hintStyle: appstyle(16, AppConst.kGreen, FontWeight.w600),
            ),

            const HeightSpacer(value: 20),

            CustomTextField(
              hintText: "Add description",
              controller: desc,
              hintStyle: appstyle(16, AppConst.kGreen, FontWeight.w600),
            ),

            const HeightSpacer(value: 20),

            CustomOtlnBtn(
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2023, 6, 1),
                    maxTime: DateTime(2024, 6, 1),
                    theme: const picker.DatePickerTheme(

                        doneStyle:
                        TextStyle(color: AppConst.kGreen, fontSize: 16)),
                     onConfirm: (date) {
                      ref
                          .read(dateStateProvider.notifier)
                          .setDate(date.toString());
                    }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kBlueLight,
                text: scheduleDate == "" ?  "Set Date" : scheduleDate.substring(0,10)),

            const HeightSpacer(value: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtlnBtn(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        /*minTime: DateTime(2020, 5, 5, 20, 50),
                        maxTime: DateTime(2020, 6, 7, 05, 09),*/
                         onConfirm: (date) {
                           ref
                               .read(startTimeStateProvider.notifier)
                               .setStart(date.toString());
                        }, locale: picker.LocaleType.en);
                  },
                    width: AppConst.kWidth*0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: start == "" ? "Start Time" : start.substring(10,16)),

                CustomOtlnBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          /*minTime: DateTime(2020, 5, 5, 20, 50),
                        maxTime: DateTime(2020, 6, 7, 05, 09),*/
                          onConfirm: (date) {
                            ref
                                .read(finishTimeStateProvider.notifier)
                                .setStart(date.toString());
                          }, locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth*0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: finish == "" ? "Finish Time" : finish.substring(10,16)),
              ],
            ),

            const HeightSpacer(value: 20),

            CustomOtlnBtn(
              onTap: (){
                if(
                    title.text.isNotEmpty&&
                    desc.text.isNotEmpty&&
                    scheduleDate.isNotEmpty&&
                    start.isNotEmpty&&
                    finish.isNotEmpty
                ){
                  Task task = Task(
                    title: title.text,
                    desc : desc.text,
                    isCompleted: 0,
                    date: scheduleDate,
                    startTime: start.substring(10,16),
                    endTime: finish.substring(10,16),
                    remind: 0,
                    repeat: "yes",);
                  ref.read(todoStateProvider.notifier).addItem(task);
                  ref.read(finishTimeStateProvider.notifier).setStart('');
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(dateStateProvider.notifier).setDate('');
                  Navigator.pop(context);
                }else{
                  print("failed to add Task");
                }
              },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kGreen,
                text: "Submit"),
          ],
        ),
      ),
    );
  }
}