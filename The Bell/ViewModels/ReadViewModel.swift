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
    var object: ObjectDemo? = nil
    
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
    
    func readObject() {
        
        ref.child("photos/NHObW4UivgzSIta7amD")
            .observe(DataEventType.value) { snapshot in
                do {
                    self.object = try snapshot.data(as: ObjectDemo.self)
                }
                catch {
                    print("cannot convert to ObjectDemo")
                }
            }
        
    }
    
}
