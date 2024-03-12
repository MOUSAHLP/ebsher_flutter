import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:absher/data/repos/user_repository.dart';
import 'package:absher/models/params/forget_password_params.dart';
import 'package:absher/models/params/sign_up_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/otp_verify_response.dart';
import '../../models/params/otp_confirm_params.dart';
import '../../models/params/reset_password_params.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;
  OtpVerifyResponse? otpVerifyResponse;
  OtpConfirmParams otpConfirmParams = OtpConfirmParams();
  SignUpParams signUpParams = SignUpParams();

  SignUpBloc(
    this.userRepository,
  ) : super(SignUpInit()) {
    on<SignUpEvent>((event, emit) async {
      if (event is RequestOtp) {
        emit(SignUpLoading());
        var response =
            await userRepository.signUpPhoneNumber(event.phoneNumber);
        response.fold((l) {
          emit(SignUpError(error: l));
        }, (r) {
          otpVerifyResponse = r;
          emit(SignUpOtpRequested());
        });
      }

      if (event is ConfirmOtp) {
        emit(SignUpLoading());
        otpConfirmParams.phone = otpVerifyResponse?.phone;
        otpConfirmParams.code = event.code;
        var response = await userRepository.confirmOtp(otpConfirmParams);
        response.fold((l) {
          emit(SignUpError(error: l));
        }, (r) {
          signUpParams.phone = otpConfirmParams.phone;
          emit(SignUpOtpConfirmed());
        });
      }

      if (event is SignUp) {
        emit(SignUpLoading());
        var response = await userRepository.signUp(signUpParams);
        response.fold((l) {
          emit(SignUpError(error: l));
        }, (r) {
          emit(SignUpCompleted());
        });
      }

      if (event is ForgetPasswordGenerateOtp) {
        emit(SignUpLoading());
        var response =
            await userRepository.forgetPasswordGenerateOtp(event.phoneNumber);
        response.fold((l) {
          emit(SignUpError(error: l));
        }, (r) {
          otpVerifyResponse = r;
          emit(SignUpOtpRequested());
        });
      }

      if (event is ForgetPassword) {
        emit(SignUpLoading());
        ForgetPasswordParams forgetPasswordParams = ForgetPasswordParams(
          phone: otpVerifyResponse?.phone,
          password: event.password,
          repeatPassword: event.repeatPassword,
        );
        var response =
            await userRepository.forgetPassword(forgetPasswordParams);
        response.fold((l) {
          emit(SignUpError(error: l));
        }, (r) {
          emit(ForgetPasswordCompleted());
        });
      }
      if (event is ResetPassword) {
        emit(SignUpLoading());

        ResetPasswordParams forgetPasswordParams = ResetPasswordParams(
            phone: DataStore.instance.userInfo?.phone,
            password: event.password,
            repeatPassword: event.repeatPassword,
            oldPassword: event.oldPassword);
        var response = await userRepository.resetPassword(forgetPasswordParams);
        response.fold((l) {
          emit(SignUpError(error: l));
        }, (r) {
          emit(ResetPasswordCompleted());
        });
      }
    });
  }
}
