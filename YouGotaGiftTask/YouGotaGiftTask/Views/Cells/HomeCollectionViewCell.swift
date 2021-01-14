//
//  HomeCollectionViewCell.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 11/01/21.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var redemptionTagLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
      super.apply(layoutAttributes)

      guard let attributes = layoutAttributes as? CustomLayoutAttributes else {
        return
      }

//        productImageView.transform = attributes.parallax
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()

//        productImageView.transform = .identity
    }
    
    override func awakeFromNib() {
        containerView.layer.borderWidth = 0.8
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        redemptionTagLabel.layer.borderWidth = 0.5
        redemptionTagLabel.layer.borderColor = UIColor(hex: "FF2F92")?.cgColor
        redemptionTagLabel.layer.cornerRadius = 6
        productImageView.layer.cornerRadius = 5
    }
    
    func configureCellAt(index:Int) {
        if let brandDetails = HomeViewModel.shared.getBrandObjectAtIndex(index: index) {
            if let redTag = brandDetails.redemptionTag {
                redemptionTagLabel.isHidden = false
                redemptionTagLabel.text = " " + redTag + " "
            }
            else {
                redemptionTagLabel.isHidden = true
            }
            
            currencyLabel.text = brandDetails.currency
            productImageView.kf.setImage(with: URL(string: brandDetails.productImage!), placeholder: UIImage())
            nameLabel.text = brandDetails.name
            taglineLabel.text = brandDetails.shortTagline
        }
    }
    
}
