//
//  Constants.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 08/01/21.
//

import Foundation

struct K {
    
    enum Servers {
        case ProductionServer
        case StageServer
        case DevServer
        case TestServer
        
        var baseURL : String {
            switch self {
            case .ProductionServer:
                return "https://emapi-sandbox.yougotagift.com/uae/api/v3"
            case .StageServer:
                return ""
            case .DevServer:
                return ""
            case .TestServer:
                return ""
            }
        }
        
        var apiKey : String {
            switch self {
            case .ProductionServer:
                return "2vq1M9ye4eV6H1Mr"
            case .StageServer:
                return ""
            case .DevServer:
                return ""
            case .TestServer:
                return ""
            }
        }
        
        var apiSecret : String {
            switch self {
            case .ProductionServer:
                return "wnRY14QoA99B4Ae6wn2CU2y8"
            case .StageServer:
                return ""
            case .DevServer:
                return ""
            case .TestServer:
                return ""
            }
        }
    }
    
    struct ServerConfig {
        
        static let server = Servers.ProductionServer
    }
    
    struct APIParameterKey {
        static let apiKey = "api_key"
        static let apiSecret = "api_secret"
        static let pageNo = "page"
        static let category = "category"
        static let id = "id"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
