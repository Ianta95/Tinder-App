//
//  Service.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 07/10/20.
//

import Foundation
import Firebase

struct Service {
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECT_USERS.document(uid).getDocument { (snapshot, error) in
            print("DEBUG: Snapshot \(snapshot?.data())")
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        COLLECT_USERS.getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                
                 if users.count == snapshot?.documents.count {
                    print("DEBUG: Users array count is \(users.count)")
                    completion(users)
                }
            })
        }
    }
    
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
}
