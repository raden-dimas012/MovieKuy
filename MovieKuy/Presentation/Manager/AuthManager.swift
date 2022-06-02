//
//  AuthManager.swift
//  MovieKuy
//
//  Created by Raden Dimas on 28/05/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

enum FireBaseAuthErrors: Error {
    case failedToRegister
    case failedToLogin
}

class AuthManager {
    static let shared = AuthManager()
    let database = Firestore.firestore()
    let auth = Auth.auth()
    
    func signUp(
        email: String,
        username: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { [weak self] result,error in
            guard result != nil,error == nil else {
                completion(.failure(FireBaseAuthErrors.failedToRegister))
                return
            }

            let data = [
                "email": email,
                "username": username
            ]
            
            self?.database.collection("users").document(username).setData(data) { error in
                guard error == nil else {
                    completion(.failure(FireBaseAuthErrors.failedToRegister))
                    return
                }
                completion(.success(()))
            }
        }
    }
    
//    func registerAccountWith(
//        email: String,
//        password: String,
//        completion: @escaping (Result<Void, Error>) -> Void
//    ) {
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            guard let _ = result, error == nil else {
//                completion(.failure(FireBaseAuthErrors.failedToRegister))
//                return
//            }
//            FirestoreManager.shared.insertUserRecordToDatabaseWith(email: email) { result in
//                completion(.success(()))
//            }
//        }
//    }
    
    
    func signIn(
        username: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        database.collection("users").document(username).getDocument { [weak self] snapshot, error in
            guard let email = snapshot?.data()?["email"] as? String, error == nil else {
                return
            }
            
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard error == nil else {
                    completion(.failure(FireBaseAuthErrors.failedToLogin))
                    return
                }
                completion(.success(()))
            })
        }
    }
    
    
//    func loginAccountWith(
//        email: String,
//        password: String,
//        completion: @escaping (Result<Void, Error>) -> Void
//    ) {
//        Auth.auth().signIn(withEmail: email, password: password) { _, error in
//            guard error == nil else {
//                completion(.failure(FireBaseAuthErrors.failedToLogin))
//                return
//            }
//            completion(.success(()))
//        }
//    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
}

