//
//  UserManager.swift
//  BillTracker
//
//  Created by Danis Preldzic on 6. 8. 2024..
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let instance = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userID: String) -> DocumentReference {
        userCollection.document(userID)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        //        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        //        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userID: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userID: String) async throws -> DBUser {
        try await userDocument(userID: userID).getDocument(as: DBUser.self)
    }
    
//    func updateUserPremiumStatus(userID: String, isPremium: Bool) async throws {
//        let data: [String : Any] = [
//            DBUser.CodingKeys.isPremium.rawValue: isPremium
//        ]
//        try await userDocument(userID: userID).updateData(data)
//    }
//    
//    func addUserPreferences(userID: String, preference: String) async throws {
//        let data: [String : Any] = [
//            DBUser.CodingKeys.preferences.rawValue: FieldValue.arrayUnion([preference])
//        ]
//        try await userDocument(userID: userID).updateData(data)
//    }
//    
//    func removeUserPreferences(userID: String, preference: String) async throws {
//        let data: [String : Any] = [
//            DBUser.CodingKeys.preferences.rawValue: FieldValue.arrayRemove([preference])
//        ]
//        try await userDocument(userID: userID).updateData(data)
//    }
//    
//    func addMovie(userID: String, movie: Movie) async throws {
//        guard let data = try? encoder.encode(movie) else { throw URLError(.badURL) }
//        
//        let dict: [String : Any] = [
//            DBUser.CodingKeys.favouriteMovie.rawValue: data
//        ]
//        try await userDocument(userID: userID).updateData(dict)
//    }
//    
//    func removeMovie(userID: String, movie: Movie) async throws {
//        let data: [String : Any?] = [
//            DBUser.CodingKeys.favouriteMovie.rawValue: nil
//        ]
//        try await userDocument(userID: userID).updateData(data as [AnyHashable : Any])
//    }
    
}
