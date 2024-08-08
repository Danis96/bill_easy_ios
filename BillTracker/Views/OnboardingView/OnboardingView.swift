//
//  OnboardingView.swift
//  BillTracker
//
//  Created by Danis Preldzic on 7. 8. 2024..
//

import SwiftUI
import SwiftfulRouting

struct OnboardingView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    @Environment(\.router) var router
    
    var body: some View {
        List {
            headline
            mandatorySection
            optionalSection
        }
        .navigationTitle(TextLocalizationUtility.ob_headline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                contineButton
            }
        }
    }
}

extension OnboardingView {
    
    private var headline: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(TextLocalizationUtility.ob_subheadline)
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.7))
        }
    }
    
    private var mandatorySection: some View {
        Section(TextLocalizationUtility.ob_mandatory_data) {
            TextFieldReusable(textBinding: $onboardingVM.firstName, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.ob_fn_hint)
            TextFieldReusable(textBinding: $onboardingVM.lastName, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.ob_ln_hint)
            TextFieldReusable(textBinding: $onboardingVM.address, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.ob_address_hint)
            genderRadioButtons
            dateOfBirthPicker
        }
    }
    
    private var optionalSection: some View {
        Section(TextLocalizationUtility.ob_optional_data) {
            TextFieldReusable(textBinding: $onboardingVM.city, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.ob_city_hint)
            TextFieldReusable(textBinding: $onboardingVM.zip, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.ob_zip_hint)
                .keyboardType(.numberPad)
            TextFieldReusable(textBinding: $onboardingVM.state, showIconOverlay: .constant(false), hintText: TextLocalizationUtility.ob_state_hint)
        }
    }
    
    private var contineButton: some View {
        VStack {
            Spacer()
            ButtonReusable(buttonTitle: TextLocalizationUtility.ob_button_title) {
                Task {
                    do {
                        let error = await onboardingVM.setUserOnboardingData()
                        if let error = error {
                            router.showBasicAlert(text: error)
                        } else {
                            router.showScreen(.push) { _ in
                                RouteGenerator.shared.getRoute(route: .Home)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var dateOfBirthPicker: some View {
        DatePicker(TextLocalizationUtility.ob_dob_hint, selection: $onboardingVM.dob, displayedComponents: .date)
            .datePickerStyle(CompactDatePickerStyle())
            .padding()
    }
    
    private var genderRadioButtons: some View {
        HStack {
            RadioButtonReusable(selectedGender: $onboardingVM.selectedGender, gender: .male)
            RadioButtonReusable(selectedGender: $onboardingVM.selectedGender, gender: .female)
            RadioButtonReusable(selectedGender: $onboardingVM.selectedGender, gender: .other)
        }
        .frame(height: 60)
    }
    
}

#Preview {
    RouterView { _ in
        OnboardingView()
            .environmentObject(OnboardingViewModel())
    }
}
