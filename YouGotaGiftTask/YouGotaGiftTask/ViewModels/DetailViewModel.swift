//
//  DetailViewModel.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 14/01/21.
//

import Foundation

protocol DetailViewModelDelegate : class {
    func loadDetailPageData(cardDetails:CardDetails?)
}

class DetailViewModel {
    
    private var cardDetails:CardDetails?
    
    public weak var delegate : DetailViewModelDelegate?
    
    public static let shared = DetailViewModel()
    
    open func getCardDetails(cardId:Int) {
        APIHandler.getCardDetails(cardId:cardId) { (result) in
            print("Detail Page ..... \(result)")
            
            switch result {
            case .success(let response):
                self.cardDetails = response
                self.delegate?.loadDetailPageData(cardDetails: self.cardDetails)
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                }
            }
            
        }
    }
    
}
