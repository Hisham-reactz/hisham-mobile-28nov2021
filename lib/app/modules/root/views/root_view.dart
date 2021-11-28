import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/modules/root/controllers/root_controller.dart';
import 'package:twitter_clone/app/modules/root/views/drawer.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/services/firebase_service.dart';
import 'package:twitter_clone/services/utility_service.dart';
import 'package:sized_context/sized_context.dart';

class RootView extends GetView<RootController> {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final util = UtilityService.to;
    double height(double px) => util.height(context, px);
    double width(double px) => util.width(context, px);

    return Obx(() => Visibility(
        visible: controller.splash.value,
        //Splash
        child: Container(
          color: Colors.lightBlue,
          child: Center(
            child: Icon(
              Icons.coronavirus,
              color: Colors.white,
              size: context.diagonalPx / 10,
            ),
          ),
        ),
        //Root Wrapper
        replacement: GetRouterOutlet.builder(
          builder: (context, delegate, current) {
            return Scaffold(
              key: controller.scaffoldKey,
              appBar: PreferredSize(
                  preferredSize: Size(width(1000), height(44)),
                  child: Visibility(
                      visible: ['/home'].contains(current?.location),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        toolbarHeight: height(44),
                        backgroundColor: Colors.white,
                        elevation: 0.1,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () => controller.openDrawer(),
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.lightBlueAccent,
                                )),
                            const IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.trending_up,
                                  color: Colors.black54,
                                )),
                            const IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.stars,
                                  color: Colors.black54,
                                )),
                          ],
                        ),
                      ))),
              persistentFooterButtons: !['/home'].contains(current?.location)
                  ? null
                  : [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.home_outlined,
                                  color: Colors.lightBlue,
                                )),
                            IconButton(
                                onPressed: null,
                                icon: Icon(Icons.search_outlined)),
                            IconButton(
                                onPressed: null,
                                icon: Icon(Icons.notifications_outlined)),
                            IconButton(
                                onPressed: null, icon: Icon(Icons.mail_outline))
                          ])
                    ],
              drawer: ['/home'].contains(current?.location)
                  ? DrawerWidget(
                      height: height, logOut: FirebaseService.to.logOut)
                  : null,
              body:
                  SafeArea(child: GetRouterOutlet(initialRoute: Routes.login)),
            );
          },
        )));
  }
}
