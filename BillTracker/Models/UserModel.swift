//
//  UserModel.swift
//  BillTracker
//
//  Created by Danis Preldzic on 6. 8. 2024..
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

struct DBUser: Codable {
    
    let userId: String
    let isAnonymous: Bool?
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    var isPremium: Bool?
    var gender: String?
    var firstName: String?
    var lastName: String?
    var dob: Date?
    var address: String?
    var finishedOnboarding: Bool?
    var city: String?
    var state: String?
    var zipCode: String?
    
    init(
        userID: String,
        isAnonymous: Bool? = nil,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil,
        gender: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        dob: Date? = nil,
        address: String? = nil,
        finishedOnboarding: Bool? = false,
        city: String? = nil,
        state: String? = nil,
        zipCode: String? = nil
    ) {
        self.userId = userID
        self.email = email
        self.isAnonymous = isAnonymous
        self.photoUrl = photoUrl
        self.dateCreated = Date()
        self.isPremium = isPremium
        self.gender = gender
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.address = address
        self.finishedOnboarding = finishedOnboarding
        self.zipCode = zipCode
        self.state = state
        self.city = city
    }
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uuid
        self.email = auth.email
        self.isAnonymous = auth.isAnonimous
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isPremium = false
        self.gender = nil
        self.firstName = nil
        self.lastName = nil
        self.dob = nil
        self.address = nil
        self.finishedOnboarding = false
        self.zipCode = nil
        self.state = nil
        self.city = nil
    }
    
    func updateOnboardingData(addressValue: String,fnValue: String,lnValue: String,stateValue: String, zipValue: String, cityValue: String, dobValue: Date, genderValue: String ) -> DBUser {
        DBUser(userID: userId, isAnonymous: isAnonymous, email: email, photoUrl: photoUrl, dateCreated: dateCreated, isPremium: isPremium, gender: genderValue, firstName: fnValue, lastName: lnValue, dob: dobValue, address: addressValue, finishedOnboarding: true, city: cityValue, state: stateValue, zipCode: zipValue)
    }

    func updateAnonymous() -> DBUser {
        DBUser(userID: userId, isAnonymous: false, email: email, photoUrl: photoUrl, dateCreated: dateCreated, isPremium: isPremium, gender: gender, firstName: firstName, lastName: lastName, dob: dob, address: address, finishedOnboarding: finishedOnboarding, city: city, state: state, zipCode: zipCode)
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "is_premium"
        case gender = "gender"
        case firstName = "first_name"
        case lastName = "last_name"
        case dob = "date_of_birth"
        case address = "address"
        case finishedOnboarding = "finished_onboarding"
        case zipCode = "zip_code"
        case state = "state"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.dob = try container.decodeIfPresent(Date.self, forKey: .dob)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.finishedOnboarding = try container.decodeIfPresent(Bool.self, forKey: .finishedOnboarding)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.zipCode = try container.decodeIfPresent(String.self, forKey: .zipCode)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.gender, forKey: .gender)
        try container.encodeIfPresent(self.firstName, forKey: .firstName)
        try container.encodeIfPresent(self.lastName, forKey: .lastName)
        try container.encodeIfPresent(self.dob, forKey: .dob)
        try container.encodeIfPresent(self.address, forKey: .address)
        try container.encodeIfPresent(self.finishedOnboarding, forKey: .finishedOnboarding)
        try container.encodeIfPresent(self.state, forKey: .state)
        try container.encodeIfPresent(self.zipCode, forKey: .zipCode)
        try container.encodeIfPresent(self.city, forKey: .city)
    }
}
