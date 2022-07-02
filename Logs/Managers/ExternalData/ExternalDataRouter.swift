//
//  ExternalDataRouter.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import Foundation
import Alamofire

enum ExternalDataRouter<T: Encodable> {
    
    case logsList(T)
    
    var baseURL: URL {
        return URL(string: "https://randomuser.me")!
    }
        
    var method: HTTPMethod {
        switch self {
        case .logsList: return .get
        }
    }
    
    var path: String {
        switch self {
        case .logsList: return "/api/"
        }
    }
    
    var parameters: T? {
        switch self {
        case .logsList: return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let encoder: ParameterEncoder = method == .get ? URLEncodedFormParameterEncoder.default : JSONParameterEncoder.default
        let request = try URLRequest(url: baseURL.appendingPathComponent(path), method: method, headers: [:])
        return try parameters.map { try encoder.encode($0, into: request) } ?? request
    }
}
