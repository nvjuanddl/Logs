//
//  Log.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import Foundation

struct Log: Decodable {
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case first
        case last
        case picture
        case image = "large"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .name)
        let imageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .picture)
        let first = try nameContainer.decode(String.self, forKey: .first)
        let last = try nameContainer.decode(String.self, forKey: .last)
        name = first + last
        image = try imageContainer.decode(String.self, forKey: .image)
    }
}
