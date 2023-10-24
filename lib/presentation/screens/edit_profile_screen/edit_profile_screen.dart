import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/launcher.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/edit_profile_screen/widgets/build_shimmer_profile.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../../bloc/bottom_bloc/bottom_event.dart';
import '../../../bloc/profile_bloc/pofile_bloc.dart';
import '../../../bloc/profile_bloc/profile_event.dart';
import '../../../bloc/profile_bloc/profile_state.dart';
import '../../../core/app_validators.dart';
import '../../../core/services/services_locator.dart';
import '../../widgets/accessories/cached_image.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_guest.dart';
import '../auth_screen/reset_password_screen.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (BuildContext context) => sl<ProfileBloc>(),
      child: EditProfileBody(),
    );
  }
}

class EditProfileBody extends StatelessWidget {
  EditProfileBody({super.key});
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
            if (state is ProfileFieldsValidationFailed) {
              if (state.validationError != null) {
                context.read<ProfileBloc>().add(IsEditingEvent(true));
                toast(state.validationError!);
              }
            }
          }, builder: (context, state) {
            if (state is ProfileLoading) {
              return const BuildShimmerProfile();
            } else if (state is ProfileError) {
              return CustomErrorScreen(
                onTap: () {
                  context.read<ProfileBloc>().add(GetProfile());
                },
              );
            } else {
              return sl<AuthenticationBloc>().loggedIn
                  ? Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 50),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                border: Border.all(
                                    color: ColorManager.softYellow, width: 3),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                          AppLocalizations.of(context)!.profile,
                                          style: getBoldStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomInputField(
                                        controller: context
                                            .read<ProfileBloc>()
                                            .nameController,
                                        textStyle: const TextStyle(
                                          color: ColorManager.primaryColor,
                                        ),
                                        readOnly: !context
                                            .read<ProfileBloc>()
                                            .isEditing,
                                        keyboardType: TextInputType.text,
                                        icon: Icons.person,
                                        validator: (value) {
                                          return AppValidators
                                              .validateNameFields(
                                                  context, value);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CustomInputField(
                                        textStyle: const TextStyle(
                                          color: ColorManager.primaryColor,
                                        ),
                                        controller: context
                                            .read<ProfileBloc>()
                                            .emailController,
                                        readOnly: !context
                                            .read<ProfileBloc>()
                                            .isEditing,
                                        keyboardType: TextInputType.text,
                                        icon: Icons.email_rounded,
                                        validator: (value) {
                                          return AppValidators
                                              .validateEmailFields(
                                                  context, value);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CustomInputField(
                                        textStyle: const TextStyle(
                                          color: ColorManager.primaryColor,
                                        ),
                                        initValue: context
                                            .read<AuthenticationBloc>()
                                            .loginResponse!
                                            .phone,
                                        readOnly: true,
                                        keyboardType: TextInputType.text,
                                        icon: Icons.phone_android,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          sl<BottomBloc>()
                                              .add(NewBottomChange(1));
                                        },
                                        child: CustomInputField(
                                          textStyle: const TextStyle(
                                            color: ColorManager.primaryColor,
                                          ),
                                          initValue:
                                              AppLocalizations.of(context)!
                                                  .favorite,
                                          readOnly: true,
                                          keyboardType: TextInputType.text,
                                          icon: Icons.favorite,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorManager.softYellow,
                                                width: 2)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  launchSocial(
                                                      "https://www.facebook.com/profile.php?id=100093574429633&mibextid=ZbWKwL");
                                                },
                                                child: Image.asset(
                                                    ImageManager.faceBook)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      CustomButton(
                                        label: AppLocalizations.of(context)!
                                            .changePassword,
                                        fillColor: ColorManager.softYellow,
                                        onTap: () {
                                          AppRouter.push(context,
                                              const ResetPasswordScreen());
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      CustomButton(
                                        label: context
                                                    .read<ProfileBloc>()
                                                    .isEditing ==
                                                false
                                            ? AppLocalizations.of(context)!.edit
                                            : AppLocalizations.of(context)!
                                                .save,
                                        fillColor: ColorManager.softYellow,
                                        onTap: () {
                                          if (context
                                                  .read<ProfileBloc>()
                                                  .isEditing ==
                                              false) {
                                            context
                                                .read<ProfileBloc>()
                                                .add(IsEditingEvent(true));
                                          } else {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<ProfileBloc>()
                                                  .add(IsEditingEvent(false));
                                              context
                                                      .read<ProfileBloc>()
                                                      .profileModel
                                                      .phone =
                                                  context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .loginResponse!
                                                      .phone;
                                              context
                                                  .read<ProfileBloc>()
                                                  .add(UpdateProfile());
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Stack(
                            children: [
                              const SizedBox(
                                height: 90,
                                width: 90,
                                child: CircularProgressIndicator(
                                  value: 0.65,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation(
                                      ColorManager.softYellow),
                                ),
                              ),
                              Positioned(
                                top: 1,
                                bottom: 1,
                                right: 1,
                                left: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: context
                                                    .read<ProfileBloc>()
                                                    .imagePick ==
                                                null
                                            ? CachedImage(
                                                imageUrl: context
                                                    .read<ProfileBloc>()
                                                    .image,
                                                imageSize: ImageSize.small,
                                              )
                                            : Image.file(
                                                context
                                                    .read<ProfileBloc>()
                                                    .imagePick!,
                                                fit: BoxFit.fill,
                                              )),
                                  ),
                                ),
                              ),
                              // context.read<ProfileBloc>().isEditing == true
                              //     ? Positioned(
                              //         bottom: 1,
                              //         child: InkWell(
                              //             onTap: () {
                              //               context
                              //                   .read<ProfileBloc>()
                              //                   .add(GetImageGallery());
                              //             },
                              //             child: const Icon(
                              //               Icons.camera_alt_outlined,
                              //               color: Colors.white,
                              //             )))
                              //     : const SizedBox.shrink()
                            ],
                          ),
                        )
                      ],
                    )
                  : const CustomGuest();
            }
          }),
        ),
      ),
    );
  }
}
