//
//  Service.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 07/10/20.
//

import Foundation
import Firebase

struct Service {
    
    // Obtener usuario
    static func fetchUser(withUid uid: String, completion: @escaping(User?) -> Void) {
        print("Iniciara busqueda con \(uid)")
        COLLECT_USERS.document(uid).getDocument { (snapshot, error) in
            print("DEBUG: Snapshot \(snapshot?.data())")
            guard let dictionary = snapshot?.data() else {
                completion(nil)
                return
            }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    // Obtener usuarios
    static func fetchUsers(forCurrentUser user: User, completion: @escaping([User]) -> Void) {
        var users = [User]()
        let query = COLLECT_USERS
            .whereField("age", isGreaterThanOrEqualTo: user.minSeekingAge)
            .whereField("age", isLessThanOrEqualTo: user.maxSeekingAge)
        
        fetchSwipes { swipedUserIDs in
            query.getDocuments { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                snapshot.documents.forEach({ (document) in
                    let dictionary = document.data()
                    let user = User(dictionary: dictionary)
                    guard user.uid != Auth.auth().currentUser?.uid else { return }
                    guard swipedUserIDs[user.uid] == nil else { return }
                    users.append(user)
                })
                completion(users)
            }
        }
    }
    // Obtener save user data
    static func saveUserData(user: User, completion: @escaping(Error?) -> Void) {
        let data = ["uid": user.uid,
                          "fullname": user.name,
                          "age": user.age,
                          "email" : user.email,
                          "imageURLs": user.imageURLs,
                          "bio" : user.bio,
                          "profession": user.profession,
                          "minSeekingAge": user.minSeekingAge,
                          "maxSeekingAge": user.maxSeekingAge] as [String: Any]
        COLLECT_USERS.document(user.uid).setData(data, completion: completion)
    }
    
    
    
    // Subir imagen
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG: Error subiendo la foto: \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    // Salvar swipe
    static func saveSwipe(forUser user: User, isLike: Bool, completion: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECT_SWIPES.document(uid).getDocument { (snapshot, error) in
            let data = [user.uid: isLike]
            print("data es \(data), snapshot \(snapshot) y error \(error)")
            if (snapshot?.exists == true) {
                COLLECT_SWIPES.document(uid).updateData(data, completion: completion)
            } else {
                COLLECT_SWIPES.document(uid).setData(data, completion: completion)
            }
        }
    }
    // Checar si existe match
    static func checkIfMatchExists(forUser user: User, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECT_SWIPES.document(user.uid).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else { return }
            guard let didMatch = data[currentUid] as? Bool else { return }
            completion(didMatch)
        }
        
    }
    // Obtener swipes
    private static func fetchSwipes(completion: @escaping([String: Bool]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECT_SWIPES.document(uid).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() as? [String: Bool] else {
                completion([String: Bool]())
                return
            }
            
            completion(data)
        }
    }
    // Subir match
    static func uploadMatch(currentUser: User, matchedUser: User) {
        guard let profileImageUrl = matchedUser.imageURLs.first else { return }
        guard let currentUserProfileImageUrl = currentUser.imageURLs.first else { return }
        let matchedUserData = ["uid": matchedUser.uid, "name": matchedUser.name, "profileImageUrl": profileImageUrl]
        COLLECT_MATCHES_MSS.document(currentUser.uid).collection("matches").document(matchedUser.uid).setData(matchedUserData)
        let currentUserData = ["uid": currentUser.uid, "name": currentUser.name, "profileImageUrl": currentUserProfileImageUrl]
        COLLECT_MATCHES_MSS.document(matchedUser.uid).collection("matches").document(currentUser.uid).setData(currentUserData)
    }
    // Obtener Matches
    static func fetchMatches(completion: @escaping([Match]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var matches = [Match]()
        COLLECT_MATCHES_MSS.document(uid).collection("matches").getDocuments { (snapshot, error) in
            guard let data = snapshot else { return }
            let matches = data.documents.map({ Match(dictionary: $0.data()) })
            completion(matches)
            
            
        }
    }
    
}
