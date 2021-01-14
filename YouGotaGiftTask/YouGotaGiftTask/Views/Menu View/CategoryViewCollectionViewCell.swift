//
//  MenuViewCollectionViewCell.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 09/01/21.
//

import UIKit

class CategoryViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var selectionArrowImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    var categoryDetails : Category? {
        didSet {
            bgView.backgroundColor = UIColor(hex: categoryDetails?.bgColorCode ?? "")
            if self.isSelected {
                backgroundImageView.isHidden = true
                selectionArrowImageView.isHidden = false
            }
            else {
                backgroundImageView.isHidden = false
                selectionArrowImageView.isHidden = true
            }
            backgroundImageView.kf.setImage(with: URL(string: categoryDetails?.imageSmall ?? ""), placeholder: UIImage())
            categoryNameLabel.text = categoryDetails?.name
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundImageView.isHidden = true
                selectionArrowImageView.isHidden = false
            }
            else {
                backgroundImageView.isHidden = false
                selectionArrowImageView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 8
        backgroundImageView.layer.cornerRadius = 8
    }
    
    

}
