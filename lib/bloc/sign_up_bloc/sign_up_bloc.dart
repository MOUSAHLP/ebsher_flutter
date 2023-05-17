import 'package:absher/data/repos/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/otp_verify_response.dart';
import '../../models/params/otp_confirm_params.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;
  OtpVerifyResponse? otpVerifyResponse;
  OtpConfirmParams otpConfirmParams = OtpConfirmParams();

  SignUpBloc(
    this.userRepository,
  ) : super(SignUpInit()) {
    on<SignUpEvent>((event, emit) async {
      if (event is RequestOtp) {
        emit(SignUpLoading());
        var response =
            await userRepository.signUpPhoneNumber(event.phoneNumber);
        response.fold((l) {
          emit(SignUpError());
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
          emit(SignUpError());
        }, (r) {
          emit(SignUpOtpConfirmed());
        });
      }

      if (event is SignUp) {
        emit(SignUpLoading());

        var response = await userRepository.signUp(event.signUpParams);
        response.fold((l) {
          emit(SignUpError());
        }, (r) {
          emit(SignUpOtpConfirmed());
        });
      }
    });
  }
}
