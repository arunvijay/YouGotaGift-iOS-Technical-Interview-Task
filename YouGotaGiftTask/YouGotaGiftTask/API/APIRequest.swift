//
//  APIRequest.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 08/01/21.
//

import Foundation
import Alamofire

enum APIRequest : URLRequestConvertible {
    
    case getHomePageData(category:Int, pageNo:Int)
    case getCardDetails(cardId:Int)
    
    
    // MARK: - HTTPMethod
    
    private var method : HTTPMethod {
        switch self {
        case .getHomePageData, .getCardDetails:
            return .get
        }
    }
    
    // MARK: - Path
    private var path : String {
        switch self {
        case .getHomePageData:
            return "/brands/featured/"
        case .getCardDetails(let cardIdaaa):
            return String("/brands/v5/\(cardIdaaa)/")
        }
    }
    
    // MARK: - Parameters
    private var parameters : Parameters? {
        switch self {
        case .getHomePageData(let category, let pageNo):
            return [K.APIParameterKey.apiKey:K.ServerConfig.server.apiKey, K.APIParameterKey.apiSecret:K.ServerConfig.server.apiSecret, K.APIParameterKey.category:category, K.APIParameterKey.pageNo:pageNo]
        case .getCardDetails:
            return [K.APIParameterKey.apiKey:K.ServerConfig.server.apiKey, K.APIParameterKey.apiSecret:K.ServerConfig.server.apiSecret]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try K.ServerConfig.server.baseURL.asURL()
        
        if method == .get {
            return getURLRequestForGETWith(parameters: parameters!, baseURL: url)
        }
                
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
                
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
 
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
    func getURLRequestForGETWith(parameters:Parameters, baseURL:URL) -> URLRequest {
        
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: String(describing: value))
            }
        let percentEncodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        components?.percentEncodedQuery = percentEncodedQuery
        var request = URLRequest(url: (components?.url!)!)
        
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return request
    }
}
