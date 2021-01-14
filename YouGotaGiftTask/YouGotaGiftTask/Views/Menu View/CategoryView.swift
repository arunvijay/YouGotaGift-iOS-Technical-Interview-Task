//
//  MenuView.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 09/01/21.
//

import Foundation
import UIKit

protocol CategoryViewDelegate : class {
    func didSelect(category : Category)
    func reloadCollectionViewDataWithCategoryIndex(_ index: Int)
}

class CategoryView: UICollectionReusableView {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    convenience init() {
        self.init()
        
    }
    
  // MARK: - Properties
  var delegate: CategoryViewDelegate?
    
    var categories : [Category]? {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    var selectedIndex = 0
  
  // MARK: - View Life Cycle
  override func prepareForReuse() {
    super.prepareForReuse()
    
    delegate = nil
  }
    
    override class func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    func configure() {
        
        categoryCollectionView.allowsSelection = true
        categoryCollectionView.allowsMultipleSelection = false
        
        self.categoryCollectionView.register(UINib(nibName: "CategoryViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryViewCollectionViewCell")
        categories = HomeViewModel.shared.getCategories()
        self.categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
}

// MARK: - CollectionView
extension CategoryView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCollectionViewCell", for: indexPath) as! CategoryViewCollectionViewCell
        cell.categoryDetails = categories?[indexPath.item]
        if indexPath.item == selectedIndex {
            cell.isSelected = true
            categoryNameLabel.text = categories?[indexPath.item].name
        }
        else {
            cell.isSelected = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2.7
        let height = collectionView.frame.size.height - (collectionView.frame.size.height/6)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        selectedIndex = indexPath.item
        categoryNameLabel.text = categories?[indexPath.item].name
        collectionView.reloadData()
        self.delegate?.didSelect(category: categories![indexPath.item])
    }
  
}
