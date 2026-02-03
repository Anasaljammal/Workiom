import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/utils/validators.dart';
import 'password_entry_event.dart';
import 'password_entry_state.dart';

@injectable
class PasswordEntryBloc extends Bloc<PasswordEntryEvent, PasswordEntryState> {
  PasswordEntryBloc() : super(const PasswordEntryState()) {
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<ClearEmailEvent>(_onClearEmail);
    on<SubmitPasswordEvent>(_onSubmitPassword);
    on<ResetSubmissionEvent>(_onResetSubmission);
    on<SetPasswordComplexityEvent>(_onSetPasswordComplexity);
  }

  void _onEmailChanged(
    EmailChangedEvent event,
    Emitter<PasswordEntryState> emit,
  ) {
    final isEmailValid = Validators.validateEmail(event.email) == null;
    emit(state.copyWith(email: event.email, isEmailValid: isEmailValid));
  }

  void _onSetPasswordComplexity(
    SetPasswordComplexityEvent event,
    Emitter<PasswordEntryState> emit,
  ) {
    emit(
      state.copyWith(
        requiredLength: event.requiredLength,
        requireDigitRule: event.requireDigit,
        requireLowercaseRule: event.requireLowercase,
        requireUppercaseRule: event.requireUppercase,
        requireSpecialRule: event.requireNonAlphanumeric,
      ),
    );
  }

  void _onPasswordChanged(
    PasswordChangedEvent event,
    Emitter<PasswordEntryState> emit,
  ) {
    final password = event.password;
    final len = state.requiredLength;
    final hasMinLength = password.length >= len;
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasSpecial = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\;/]'),
    );

    final requiredCount = [
      state.requireDigitRule,
      state.requireLowercaseRule,
      state.requireUppercaseRule,
      state.requireSpecialRule,
    ].where((r) => r).length;
    int metCount = 0;
    if (state.requireDigitRule && hasDigit) metCount++;
    if (state.requireLowercaseRule && hasLowercase) metCount++;
    if (state.requireUppercaseRule && hasUppercase) metCount++;
    if (state.requireSpecialRule && hasSpecial) metCount++;
    final strength = requiredCount == 0
        ? (hasMinLength ? 1.0 : (password.isNotEmpty ? 0.5 : 0.0))
        : (hasMinLength
              ? (metCount / requiredCount)
              : (password.isNotEmpty ? 0.2 : 0.0));

    emit(
      state.copyWith(
        password: password,
        hasMinLength: hasMinLength,
        hasDigit: hasDigit,
        hasLowercase: hasLowercase,
        hasUppercase: hasUppercase,
        hasSpecial: hasSpecial,
        passwordStrength: strength.clamp(0.0, 1.0),
      ),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<PasswordEntryState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onClearEmail(ClearEmailEvent event, Emitter<PasswordEntryState> emit) {
    emit(state.copyWith(email: ''));
  }

  void _onSubmitPassword(
    SubmitPasswordEvent event,
    Emitter<PasswordEntryState> emit,
  ) {
    if (state.isValid) {
      emit(state.copyWith(isSubmitting: true));
    }
  }

  void _onResetSubmission(
    ResetSubmissionEvent event,
    Emitter<PasswordEntryState> emit,
  ) {
    emit(state.copyWith(isSubmitting: false));
  }
}
