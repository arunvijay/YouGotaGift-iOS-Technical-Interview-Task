//
//  DetailMenuView.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 14/01/21.
//

import UIKit

protocol DetailMenuViewDelegate : class {
    func didSelectItemAt(index : Int)
}

class DetailMenuView: UICollectionReusableView {
    
    @IBOutlet weak var detailMenuCollectionView: UICollectionView!

    var selectedIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var delegate: DetailMenuViewDelegate?
    
    func configure() {
        
        detailMenuCollectionView.allowsSelection = true
        detailMenuCollectionView.allowsMultipleSelection = false
        
        self.detailMenuCollectionView.register(UINib(nibName: "DetailMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailMenuCollectionViewCell")
        
        self.detailMenuCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
}

extension DetailMenuView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMenuCollectionViewCell", for: indexPath) as! DetailMenuCollectionViewCell
        
        switch indexPath.item {
        case 0:
            cell.detailMenuLabel.text = "About Gift"
        case 1:
            cell.detailMenuLabel.text = "Terms"
        default:
            cell.detailMenuLabel.text = ""
        }
        
        if indexPath.item == selectedIndex {
            cell.isSelected = true
        }
        else {
            cell.isSelected = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2.2
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        selectedIndex = indexPath.item
        collectionView.reloadData()
        self.delegate?.didSelectItemAt(index: indexPath.item)
    }
    
}
