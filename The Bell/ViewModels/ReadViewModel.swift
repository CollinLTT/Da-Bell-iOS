//
//  readViewModel.swift
//  The Bell
//
//  Created by Collin on 12/3/22.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class ReadViewModel: ObservableObject {
    
    var ref = Database.database().reference()
    
    
    @Published
    var value: String? = nil
    
    @Published
    var allPhotos: ObjectDemo? = nil
    
    @Published
    var allClips: ObjectDemo? = nil
    
    @Published
    var object: ObjectDemo? = nil
    
    @Published
    var listObject = [ObjectDemo]()
    
    func readValue() {
        
        ref.child("link/link").observeSingleEvent(of: DataEventType.value) { snapshot in
            self.value = snapshot.value as? String ?? "Load Failed"
        }
        
    }
    
    func observeDataChange() {
        
        ref.child("link/link").observe(DataEventType.value) { snapshot in
            self.value = snapshot.value as? String ?? "Load Failed"
        }
        
    }
    
    func readAllPhotos() {
        
        ref.child("photos").observeSingleEvent(of: .value) { snapshot in
            
            for case let child as DataSnapshot in snapshot.children {
                
                guard let dict = child.value as? [String:Any] else {
                    
                    print("Error")
                    return
                }
                
                let date_created = dict["date_created"] as Any
                let date_created_formatted = dict["date_created_formatted"] as Any
                let is_photo = dict["is_photo"] as Any
                let path = dict["path"] as Any
                
                print(date_created)
                print(date_created_formatted)
                print(is_photo)
                print(path)
            }
        }
        
    }
    
    func readAllClips() {
        
        ref.child("shortclips").observeSingleEvent(of: .value) { snapshot in
            
            for case let child as DataSnapshot in snapshot.children {
                
                guard let dict = child.value as? [String:Any] else {
                    
                    print("Error")
                    return
                }
                
                let date_created = dict["date_created"] as Any
                let date_created_formatted = dict["date_created_formatted"] as Any
                let is_photo = dict["is_photo"] as Any
                let path = dict["path"] as Any
                
                print(date_created)
                print(date_created_formatted)
                print(is_photo)
                print(path)
            }
        }
        
    }
    
    func readObject() {
        
        ref.child("photos") //-NH0bW4UivgzSIta7amD
            .observe(DataEventType.value) { snapshot in
                do {
                    self.object = try snapshot.data(as: ObjectDemo.self)
                }
                catch {
                    print("cannot convert to ObjectDemo")
                }
            }
        
    }
    
    func observeListObject() {
        ref.observe(.value) { parentSnapshot in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            self.listObject = children.compactMap({snapshot in
                return try? snapshot.data(as: ObjectDemo.self)
            })
        }
    }
    
}
