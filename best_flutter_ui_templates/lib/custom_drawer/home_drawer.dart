import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:best_flutter_ui_templates/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:best_flutter_ui_templates/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Help',
        isAssetsImage: true,
        imageName: 'assets/images/supportIcon.png',
      ),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'FeedBack',
        icon: Icon(Icons.help),
      ),
      DrawerList(
        index: DrawerIndex.Invite,
        labelName: 'Invite Friend',
        icon: Icon(Icons.group),
      ),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: 'Rate the app',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'About Us',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
        listener: (context, state) {
          if (state is UploadPictureSuccess) {
            setState(() {
              context.read<MyUserBloc>().state.user!.picture = state.userImage;
            });
          }
        },
        child: Scaffold(
          backgroundColor: AppTheme.notWhite.withOpacity(0.5),
          body: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            AnimatedBuilder(
                              animation: widget.iconAnimationController!,
                              builder: (BuildContext context, Widget? child) {
                                return ScaleTransition(
                                  scale: AlwaysStoppedAnimation<double>(1.0 -
                                      (widget.iconAnimationController!.value) *
                                          0.2),
                                  child: RotationTransition(
                                    turns: AlwaysStoppedAnimation<
                                        double>(Tween<double>(
                                                begin: 0.0, end: 24.0)
                                            .animate(CurvedAnimation(
                                                parent: widget
                                                    .iconAnimationController!,
                                                curve: Curves.fastOutSlowIn))
                                            .value /
                                        360),
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.grey
                                                  .withOpacity(0.6),
                                              offset: const Offset(2.0, 4.0),
                                              blurRadius: 8),
                                        ],
                                      ),
                                      child: state.user!.picture == ""
                                          ? GestureDetector(
                                              onTap: () async {
                                                final ImagePicker picker =
                                                    ImagePicker();
                                                final XFile? image =
                                                    await picker.pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        maxHeight: 500,
                                                        maxWidth: 500,
                                                        imageQuality: 40);
                                                if (image != null) {
                                                  CroppedFile? croppedFile =
                                                      await ImageCropper()
                                                          .cropImage(
                                                    sourcePath: image.path,
                                                    aspectRatio:
                                                        const CropAspectRatio(
                                                            ratioX: 1,
                                                            ratioY: 1),
                                                    aspectRatioPresets: [
                                                      CropAspectRatioPreset
                                                          .square
                                                    ],
                                                    uiSettings: [
                                                      AndroidUiSettings(
                                                          toolbarTitle:
                                                              'Cropper',
                                                          toolbarColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          toolbarWidgetColor:
                                                              Colors.white,
                                                          initAspectRatio:
                                                              CropAspectRatioPreset
                                                                  .original,
                                                          lockAspectRatio:
                                                              false),
                                                      IOSUiSettings(
                                                        title: 'Cropper',
                                                      ),
                                                    ],
                                                  );
                                                  if (croppedFile != null) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              UpdateUserInfoBloc>()
                                                          .add(UploadPicture(
                                                              croppedFile.path,
                                                              context
                                                                  .read<
                                                                      MyUserBloc>()
                                                                  .state
                                                                  .user!
                                                                  .id));
                                                    });
                                                  }
                                                }
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(60.0)),
                                                child: Icon(
                                                    CupertinoIcons.person,
                                                    size: 75.0,
                                                    color: Colors.white70),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(60.0)),
                                              child: Image.network(
                                                state.user!.picture!,
                                              ),
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 4),
                              child: Text(
                                '${state.user!.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isLightMode
                                      ? AppTheme.grey
                                      : AppTheme.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Divider(
                      height: 1,
                      color: AppTheme.grey.withOpacity(0.6),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(0.0),
                        itemCount: drawerList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return inkwell(drawerList![index]);
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AppTheme.grey.withOpacity(0.6),
                    ),
                    //Thêm nút Sign Out
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            'Sign Out',
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppTheme.darkText,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          trailing: Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                          ),
                          onTap: () {
                            onTapped();
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom,
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  void onTapped() {
    context
        .read<SignInBloc>()
        .add(const SignOutRequired()); // Print to console.
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.black
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
