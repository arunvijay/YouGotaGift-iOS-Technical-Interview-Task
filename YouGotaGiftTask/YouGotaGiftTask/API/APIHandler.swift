//
//  APIHandler.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 08/01/21.
//

import Foundation
import Alamofire

class APIHandler {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                                completion(response.result)
        }
    }
    
    static func getHomeData(category:Int, pageNo:Int, completion:@escaping(Result<HomePage, AFError>)->Void) {
        performRequest(route: APIRequest.getHomePageData(category:category, pageNo: pageNo), completion: completion)
    }
    
    static func getCardDetails(cardId:Int, completion:@escaping(Result<CardDetails, AFError>)->Void ) {
        performRequest(route: APIRequest.getCardDetails(cardId: cardId), completion: completion)
    }
    
}

