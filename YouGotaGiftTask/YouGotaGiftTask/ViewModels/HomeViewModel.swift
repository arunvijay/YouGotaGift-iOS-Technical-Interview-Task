//
//  HomeViewModel.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 08/01/21.
//

import Foundation

protocol HomeViewModelDelegate : class {
    func loadHomaPageData(categories:Array<Category>, brands:Array<Brand>)
    func loadBrands(brands:Array<Brand>)
    
    var isLoading:Bool? { get set }
}

extension HomeViewModelDelegate {
    func loadloadBrands(brands:Array<Brand>) {
        
    }
}

class HomeViewModel {
    
    private var categories:[Category]?
    private var brands:[Brand]?
    private var selectedCategory:SelectedCategory?
    
    public weak var delegate : HomeViewModelDelegate?
    
    public static let shared = HomeViewModel()
    
    open func getHomePageData(category:Int, pageNo:Int) {
        self.delegate?.isLoading = true
        APIHandler.getHomeData(category: category, pageNo: pageNo) { (result) in
            print("Home Page Result ..... \(result)")
            
            switch result {
            case .success(let response):
                self.categories = response.categories
                self.brands = response.brands
                self.selectedCategory = response.selectedCategory
                self.delegate?.isLoading = false
                self.delegate?.loadHomaPageData(categories: response.categories ?? [Category](), brands: response.brands ?? [Brand]())
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                }
            }
            
        }
    }
    
    open func getCategories() -> [Category] {
        return categories ?? [Category]()
    }
    
    open func getBrands() -> [Brand] {
        return brands ?? [Brand]()
    }
    
    open func isSelectedIndex(index:Int) -> Bool {
        return categories?[index].id == self.selectedCategory?.id
    }
    
    open func getSelectedCategory() -> SelectedCategory? {
        return self.selectedCategory
    }
    
    open func getBrandObjectAtIndex(index:Int) -> Brand? {
        return brands?[index] ?? nil
    }
    
    open func getCategoryObjectAtIndex(index:Int) -> Category? {
        return categories?[index] ?? nil
    }
}

