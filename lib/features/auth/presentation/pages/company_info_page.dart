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
import '../../domain/repositories/auth_repository.dart';
import '../bloc/company_info/company_info_bloc.dart';
import '../bloc/company_info/company_info_event.dart';
import '../bloc/company_info/company_info_state.dart';

class CompanyInfoPage extends StatelessWidget {
  final String email;
  final String password;

  const CompanyInfoPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CompanyInfoBloc(getIt<AuthRepository>(), email, password),
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: BlocListener<CompanyInfoBloc, CompanyInfoState>(
              listenWhen: (previous, current) =>
                  current.registrationSuccess && !previous.registrationSuccess,
              listener: (context, state) {
                if (state.registrationSuccess && context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.thankYou,
                    (route) => false,
                  );
                }
              },
              child: BlocConsumer<CompanyInfoBloc, CompanyInfoState>(
                listenWhen: (previous, current) =>
                    current.errorMessage != null &&
                    current.errorMessage != previous.errorMessage,
                listener: (context, state) {
                  if (state.errorMessage != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!.tr()),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.isSubmitting) {
                    return LoadingWidget(
                      message: 'auth.creating_workspace'.tr(),
                    );
                  }
                  return _buildBody(context, state);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildBody(BuildContext context, CompanyInfoState state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              AuthHeader(
                title: 'auth.enter_company_name'.tr(),
                subtitle: 'auth.sign_up_subtitle'.tr(),
                showWavingHand: true,
              ),
              SizedBox(height: 75.h),
              Text(
                'auth.company_or_team_name'.tr(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              StateDrivenTextField(
                value: state.companyName,
                onChanged: (value) {
                  context.read<CompanyInfoBloc>().add(
                    CompanyNameChangedEvent(value),
                  );
                },
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'auth.workspace_name'.tr(),
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: SvgPicture.asset(
                      AppAssets.iconWorkspace,
                      width: 16.w,
                      height: 16.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 28.w),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      'auth.workspace_domain'.tr(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(minWidth: 100.w),
                  filled: false,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 22.h),
              Text(
                'auth.your_first_name'.tr(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              StateDrivenTextField(
                value: state.firstName,
                onChanged: (value) {
                  context.read<CompanyInfoBloc>().add(
                    FirstNameChangedEvent(value),
                  );
                },
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'auth.enter_first_name'.tr(),
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: SvgPicture.asset(
                      AppAssets.iconText,
                      width: 16.w,
                      height: 16.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 28.w),
                  filled: false,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 22.h),
              Text(
                'auth.your_last_name'.tr(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              StateDrivenTextField(
                value: state.lastName,
                onChanged: (value) {
                  context.read<CompanyInfoBloc>().add(
                    LastNameChangedEvent(value),
                  );
                },
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'auth.enter_last_name'.tr(),
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: SvgPicture.asset(
                      AppAssets.iconText,
                      width: 16.w,
                      height: 16.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 28.w),
                  filled: false,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 25.h),
              GestureDetector(
                onTap: state.isValid
                    ? () {
                        context.read<CompanyInfoBloc>().add(
                          SubmitCompanyInfoEvent(),
                        );
                      }
                    : null,
                child: Container(
                  width: double.infinity,
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
                          'auth.create_workspace'.tr(),
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
            SvgPicture.asset(AppAssets.iconLogo, width: 20.w, height: 20.h),
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
  );
}
