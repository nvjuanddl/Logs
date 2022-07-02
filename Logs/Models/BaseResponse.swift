//
//  BaseResponse.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let results: T
}
