import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/timezone_helper.dart';
import '../../../../../core/utils/validators.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'company_info_event.dart';
import 'company_info_state.dart';

class CompanyInfoBloc extends Bloc<CompanyInfoEvent, CompanyInfoState> {
  final AuthRepository _authRepository;
  final String email;
  final String password;

  CompanyInfoBloc(this._authRepository, this.email, this.password)
    : super(const CompanyInfoState()) {
    on<CompanyNameChangedEvent>(_onCompanyNameChanged);
    on<FirstNameChangedEvent>(_onFirstNameChanged);
    on<LastNameChangedEvent>(_onLastNameChanged);
    on<SubmitCompanyInfoEvent>(_onSubmit);
  }

  void _onCompanyNameChanged(
    CompanyNameChangedEvent event,
    Emitter<CompanyInfoState> emit,
  ) {
    emit(state.copyWith(companyName: event.companyName, errorMessage: null));
  }

  void _onFirstNameChanged(
    FirstNameChangedEvent event,
    Emitter<CompanyInfoState> emit,
  ) {
    emit(state.copyWith(firstName: event.firstName, errorMessage: null));
  }

  void _onLastNameChanged(
    LastNameChangedEvent event,
    Emitter<CompanyInfoState> emit,
  ) {
    emit(state.copyWith(lastName: event.lastName, errorMessage: null));
  }

  Future<void> _onSubmit(
    SubmitCompanyInfoEvent event,
    Emitter<CompanyInfoState> emit,
  ) async {
    if (!state.isValid) return;

    final tenancyName = state.companyName.trim();
    final firstName = state.firstName.trim();
    final lastName = state.lastName.trim();

    final tenantError = Validators.validateTenantName(tenancyName);
    if (tenantError != null) {
      final key = tenantError.contains('required')
          ? 'validation.tenant_name_required'
          : tenantError.contains('start')
          ? 'validation.tenant_name_start_letter'
          : 'validation.tenant_name_invalid';
      emit(state.copyWith(errorMessage: key));
      return;
    }
    final firstError = Validators.validateName(
      firstName,
      fieldName: 'First name',
    );
    if (firstError != null) {
      final key = firstError.contains('letters')
          ? 'validation.first_name_letters'
          : 'validation.first_name_required';
      emit(state.copyWith(errorMessage: key));
      return;
    }
    final lastError = Validators.validateName(lastName, fieldName: 'Last name');
    if (lastError != null) {
      final key = lastError.contains('letters')
          ? 'validation.last_name_letters'
          : 'validation.last_name_required';
      emit(state.copyWith(errorMessage: key));
      return;
    }

    final timezone = TimezoneHelper.getDefaultTimezone();

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final availabilityResult = await _authRepository.checkTenantAvailability(
      tenancyName,
    );
    Either availabilityEither = availabilityResult;

    await availabilityEither.fold(
      (failure) async {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: 'errors.something_went_wrong',
          ),
        );
      },
      (isAvailable) async {
        if (!isAvailable) {
          emit(
            state.copyWith(
              isSubmitting: false,
              errorMessage: 'errors.tenant_not_available',
            ),
          );
          return;
        }
        final editionsResult = await _authRepository.getEditions();
        await editionsResult.fold(
          (failure) async {
            emit(
              state.copyWith(
                isSubmitting: false,
                errorMessage: 'errors.something_went_wrong',
              ),
            );
          },
          (editions) async {
            final validEditions = editions.where((e) => e.id > 0).toList();
            if (validEditions.isEmpty) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  errorMessage: 'errors.no_valid_edition',
                ),
              );
              return;
            }
            final editionId = validEditions.first.id;
            final registerResult = await _authRepository.registerTenant(
              email: email,
              firstName: firstName,
              lastName: lastName,
              password: password,
              tenantName: tenancyName,
              editionId: editionId,
              timezone: timezone,
            );
            await registerResult.fold(
              (failure) async {
                emit(
                  state.copyWith(
                    isSubmitting: false,
                    errorMessage: 'errors.something_went_wrong',
                  ),
                );
              },
              (_) async {
                final authResult = await _authRepository.authenticate(
                  email: email,
                  password: password,
                  tenantName: tenancyName,
                  timezone: timezone,
                );
                authResult.fold(
                  (failure) {
                    emit(
                      state.copyWith(
                        isSubmitting: false,
                        errorMessage: 'errors.something_went_wrong',
                      ),
                    );
                  },
                  (_) {
                    emit(
                      state.copyWith(
                        isSubmitting: false,
                        registrationSuccess: true,
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
