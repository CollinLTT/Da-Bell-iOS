//
//  ObjectDemo.swift
//  The Bell
//
//  Created by Collin on 12/3/22.
//

import Foundation

class ObjectDemo: Encodable, Decodable {
    
   // var id: String = ""
    var date_created: String = ""
    var date_created_formatted: String = ""
    var is_photo: Bool = true
    var path: String = ""
}

extension Encodable{
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
