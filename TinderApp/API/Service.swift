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
        query.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            snapshot.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                guard user.uid != Auth.auth().currentUser?.uid else { return }
                users.append(user)
                
                if users.count == snapshot.documents.count - 1 {
                    print("DEBUG: Users array count is \(users.count)")
                    completion(users)
                }
            })
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
    
    static func saveSwipe(forUser user: User, isLike: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //let shouldLike = isLike ? 1 : 0
        COLLECT_SWIPES.document(uid).getDocument { (snapshot, error) in
            let data = [user.uid: isLike]
            print("data es \(data), snapshot \(snapshot) y error \(error)")
            if (snapshot?.exists == true) {
                COLLECT_SWIPES.document(uid).updateData(data)
            } else {
                COLLECT_SWIPES.document(uid).setData(data)
            }
        }
    }
}
