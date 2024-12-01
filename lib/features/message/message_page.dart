import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/models/contants.dart';
import 'package:study_app/common/models/message.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/date.dart';
import 'package:study_app/features/message/message_logic.dart';
import 'package:study_app/features/message/notifiers/message_notifier.dart';






class Message_Page extends ConsumerStatefulWidget {
  const Message_Page({super.key});


  @override
  ConsumerState<Message_Page> createState() => _MessagePage();
}

class _MessagePage extends ConsumerState<Message_Page> {
  late MessageLogic messageLogic;
  @override
  void initState() {
    super.initState();
    messageLogic = MessageLogic(ref: ref);
    Future.delayed(Duration.zero,(){
      messageLogic.init();
    });
  }


  @override
  void didUpdateWidget(covariant Message_Page oldWidget) {
    print("didUpdateWidget-------");
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    // TODO: implement dispose

    print("dispose-------");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(messageProvider);

    return WillPopScope(
      onWillPop: () async {
        print("onWillPop----");
        return false;
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg4.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            state.loadStatus
                ? const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.black26,
                  strokeWidth: 2,
                ),
              ),
            )
                : (state.message.isEmpty
                ? Center(
              child: Text(
                "Bạn chưa nhắn với ai",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.h,
                    horizontal: 25.w,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (content, index) {
                        var item = state.message.elementAt(index);
                        return _buildListItem(content, item);
                      },
                      childCount: state.message.length,
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
        backgroundColor: Colors.transparent, // Đặt nền `Scaffold` trong suốt để nhìn thấy ảnh nền
      ),
    );
  }



  AppBar _buildAppBar() {
    return AppBar(
        title: Container(
          margin: EdgeInsets.only(left: 7.w, right: 7.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 18.w,
                height: 12.h,
                child: Image.asset("assets/icons/menu.png"),
              ),
              Text(
                "Message",
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
          GestureDetector(
            child:SizedBox(
                width: 24.w,
                height: 24.h,
                child: Image.asset("assets/icons/bell.png"),
              ),
              onTap:(){

        },
        )
            ],
          ),
        ));
  }


  Widget _buildListItem(BuildContext context, Message item) {

    return Padding(
      padding: const EdgeInsets.only( bottom: 8.0),
      child: Container(
        width: 325.w,
        height: 80.h,
        color: Color(0xFFF9F9FC),
        margin: EdgeInsets.only(bottom: 0.h,),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
        child: InkWell(
            onTap: () {
              messageLogic.goChat(item);
            },
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 60.h,
                          width: 60.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${AppConstants.IMAGE_UPLOADS_PATH}${item.avatar}"),  //image: NetworkImage("${AppConstants.IMAGE_UPLOADS_PATH}${state.to_avatar}"),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.h)),
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 210.w,
                            margin: EdgeInsets.only(left:10.w),
                            child: Text(
                              "${item.name}",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 210.w,
                            margin: EdgeInsets.only(left:10.w,top: 10.h),
                            child: Text(
                              "${item.last_msg}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],)
                    ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment:Alignment.center,
                      child: Text(
                        item.last_time == null
                              ? ""
                              : duTimeLineFormat(
                              (item.last_time as Timestamp).toDate()),
                        style: TextStyle(
                          color: Color(0xFF3C3C43),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    item.msg_num==0?Container():Container(
                      height: 15.h,
                      constraints: BoxConstraints(minWidth: 15.w),
                      decoration: BoxDecoration(
                          color: Color(0xFF3C3C43),
                          borderRadius: BorderRadius.all(Radius.circular(6.h)),),
                      alignment:Alignment.center,
                      child: Text(
                        "${item.msg_num}",
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

}
