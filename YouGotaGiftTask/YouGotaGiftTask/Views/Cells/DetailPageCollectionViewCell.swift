//
//  DetailPageCollectionViewCell.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 14/01/21.
//

import UIKit

class DetailPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var redeemLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var validityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var selectedIndex : Int?
    
    var giftCardDetails : CardDetails? {
        didSet {
            redeemLabel.text = "Redeemable in " + (giftCardDetails?.country?.name ?? "")
            validityLabel.text = "Valid for " + String(format: "%d", (giftCardDetails?.validityInMonths ?? "")) + " months"
            if selectedIndex == 0 {
                descriptionLabel.text = giftCardDetails?.cardDetailsDescription
            }
            else if selectedIndex == 1 {
                descriptionLabel.text = giftCardDetails?.specificTerms
            }
        }
    }
    
}
