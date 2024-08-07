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
    
    var body: some View {
        List {
            headline
            mandatorySection
            optionalSection
        }
        .navigationTitle("Onboarding")
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
            Text("Easily manage and track all your bills in one place, ensuring you never miss a payment.\nPlease fill in the mandatory fields to get started and take control of your finances today.")
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.7))
        }
    }
    
    private var mandatorySection: some View {
        Section("Mandatory data") {
            TextFieldReusable(textBinding: $onboardingVM.firstName, showIconOverlay: .constant(false), hintText: "first name")
            TextFieldReusable(textBinding: $onboardingVM.lastName, showIconOverlay: .constant(false), hintText: "last name")
            TextFieldReusable(textBinding: $onboardingVM.address, showIconOverlay: .constant(false), hintText: "address")
            HStack {
                RadioButtonReusable(selectedGender: $onboardingVM.selectedGender, gender: .male)
                RadioButtonReusable(selectedGender: $onboardingVM.selectedGender, gender: .female)
                RadioButtonReusable(selectedGender: $onboardingVM.selectedGender, gender: .other)
            }
            .frame(height: 60)
            DatePicker("date of birth", selection: $onboardingVM.dob, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
        }
    }
    
    private var optionalSection: some View {
        Section("Optional data") {
            TextFieldReusable(textBinding: $onboardingVM.city, showIconOverlay: .constant(false), hintText: "city")
            TextFieldReusable(textBinding: $onboardingVM.zip, showIconOverlay: .constant(false), hintText: "zip code")
            TextFieldReusable(textBinding: $onboardingVM.state, showIconOverlay: .constant(false), hintText: "state")
        }
    }
    
    private var contineButton: some View {
        VStack {
            Spacer()
            ButtonReusable(buttonTitle: "Continue") {
                
            }
        }
    }
    
}

#Preview {
    RouterView { _ in
        OnboardingView()
            .environmentObject(OnboardingViewModel())
    }
}
