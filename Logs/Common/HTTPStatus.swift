//
//  HTTPStatus.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import Foundation

enum HTTPStatus {
    
    case badRequest
    case internalServerError
    case ok
    case genericError
    case parseError
    case paymentRequired
    case unauthorized
    
    var code: Int {
        switch self {
        case .badRequest: return 400
        case .paymentRequired: return 402
        case .internalServerError: return 500
        case .genericError: return 6220
        case .ok: return 200
        case .parseError: return 3026
        case .unauthorized: return 401
        }
    }
}
