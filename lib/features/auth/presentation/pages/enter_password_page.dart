import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/state_driven_text_field.dart';
import '../../../../core/di/injection.dart';
import '../../../../config/routes/app_routes.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/password_entry/password_entry_bloc.dart';
import '../bloc/password_entry/password_entry_event.dart';
import '../bloc/password_entry/password_entry_state.dart';

class EnterPasswordPage extends StatefulWidget {
  const EnterPasswordPage({super.key});

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  bool _complexityRequested = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PasswordEntryBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is PasswordComplexityLoaded,
        listener: (context, state) {
          if (state is PasswordComplexityLoaded) {
            final c = state.passwordComplexity;
            context.read<PasswordEntryBloc>().add(
              SetPasswordComplexityEvent(
                requiredLength: c.requiredLength,
                requireDigit: c.requireDigit,
                requireLowercase: c.requireLowercase,
                requireUppercase: c.requireUppercase,
                requireNonAlphanumeric: c.requireNonAlphanumeric,
              ),
            );
          }
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current is AuthError,
          listener: (context, state) {
            if (state is AuthError && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('errors.something_went_wrong'.tr())),
              );
            }
          },
          builder: (context, authState) {
            if (!_complexityRequested && authState is! AuthLoading) {
              _complexityRequested = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  context.read<AuthBloc>().add(
                    const GetPasswordComplexityEvent(),
                  );
                }
              });
            }
            if (authState is AuthLoading) {
              return Scaffold(body: LoadingWidget(message: 'loading'.tr()));
            }
            return BlocListener<PasswordEntryBloc, PasswordEntryState>(
              listenWhen: (previous, current) =>
                  current.isSubmitting && !previous.isSubmitting,
              listener: (context, state) {
                if (state.isSubmitting && mounted) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.companyInfo,
                    arguments: {
                      'email': state.email,
                      'password': state.password,
                    },
                  ).then((_) {
                    if (context.mounted) {
                      context.read<PasswordEntryBloc>().add(
                        const ResetSubmissionEvent(),
                      );
                    }
                  });
                }
              },
              child: BlocBuilder<PasswordEntryBloc, PasswordEntryState>(
                builder: (context, state) => _buildContent(context, state),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PasswordEntryState state) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      AuthHeader(
                        title: 'auth.enter_strong_password'.tr(),
                        subtitle: 'auth.sign_up_subtitle'.tr(),
                        showWavingHand: true,
                      ),
                      SizedBox(height: 80.h),
                      Text(
                        'auth.your_work_email'.tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.iconEmail,
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: StateDrivenTextField(
                              value: state.email,
                              onChanged: (value) {
                                context.read<PasswordEntryBloc>().add(
                                  EmailChangedEvent(value),
                                );
                              },
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'auth.email_hint'.tr(),
                                hintStyle: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                ),
                                filled: false,
                              ),
                            ),
                          ),
                          if (state.showEmailClear) ...[
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () {
                                context.read<PasswordEntryBloc>().add(
                                  const ClearEmailEvent(),
                                );
                              },
                              child: SvgPicture.asset(
                                AppAssets.iconClearEmail,
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'auth.your_password'.tr(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.iconPassword,
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: StateDrivenTextField(
                              value: state.password,
                              onChanged: (value) {
                                context.read<PasswordEntryBloc>().add(
                                  PasswordChangedEvent(value),
                                );
                              },
                              obscureText: !state.isPasswordVisible,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'auth.password_hint'.tr(),
                                hintStyle: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                ),
                                filled: false,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {
                              context.read<PasswordEntryBloc>().add(
                                const TogglePasswordVisibilityEvent(),
                              );
                            },
                            child: SvgPicture.asset(
                              AppAssets.iconPasswordVisible,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ],
                      ),
                      if (state.showPasswordValidation) ...[
                        SizedBox(height: 16.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: state.passwordStrength,
                            backgroundColor: AppColors.border,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              state.strengthColor,
                            ),
                            minHeight: 6.h,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              state.passwordStrength >= 1.0
                                  ? AppAssets.iconValid
                                  : AppAssets.iconWarning,
                              width: 16.w,
                              height: 16.h,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'auth.not_enough_strong'.tr(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        _buildValidationRow(
                          'validation.password_min_length'.tr(
                            namedArgs: {'length': '${state.requiredLength}'},
                          ),
                          state.hasMinLength,
                        ),
                        SizedBox(height: 8.h),
                        _buildValidationRow(
                          'validation.password_uppercase'.tr(),
                          state.hasUppercase,
                        ),
                        SizedBox(height: 8.h),
                        _buildValidationRow(
                          'validation.password_digit'.tr(),
                          state.hasDigit,
                        ),
                        SizedBox(height: 8.h),
                        _buildValidationRow(
                          'validation.password_lowercase'.tr(),
                          state.hasLowercase,
                        ),
                        SizedBox(height: 8.h),
                        _buildValidationRow(
                          'validation.password_special_char'.tr(),
                          state.hasSpecial,
                        ),
                      ],
                      SizedBox(height: 40.h),
                      GestureDetector(
                        onTap: state.isValid
                            ? () {
                                context.read<PasswordEntryBloc>().add(
                                  const SubmitPasswordEvent(),
                                );
                              }
                            : null,
                        child: Container(
                          height: 52.h,
                          decoration: BoxDecoration(
                            color: state.isValid
                                ? AppColors.primary
                                : AppColors.disabled,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Spacer(),
                                Text(
                                  'auth.confirm_password_button'.tr(),
                                  style: AppTextStyles.button.copyWith(
                                    color: AppColors.textWhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  AppAssets.iconEnter,
                                  width: 20.w,
                                  height: 20.h,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.textWhite,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'stay_organized_with'.tr(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SvgPicture.asset(
                      AppAssets.iconLogo,
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'app_name'.tr(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidationRow(String text, bool isValid) {
    return Row(
      children: [
        SvgPicture.asset(
          isValid ? AppAssets.iconValid : AppAssets.iconNotValid,
          width: 16.w,
          height: 16.h,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
