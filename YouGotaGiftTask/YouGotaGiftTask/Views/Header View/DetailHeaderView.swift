//
//  DetailHeaderView.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 14/01/21.
//

import UIKit

class DetailHeaderView: UICollectionReusableView {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencySelectionButton: UIButton!
    @IBOutlet weak var selectedAmountLabel: UILabel!
    @IBOutlet weak var minMaxAmountLabel: UILabel!
    
    
    // MARK: - Life Cycle
      public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
      super.apply(layoutAttributes)

      guard let customFlowLayoutAttributes = layoutAttributes as? CustomLayoutAttributes else {
        return
      }

        currencySelectionButton.layer.borderWidth = 0.7
        currencySelectionButton.layer.borderColor = UIColor.white.cgColor
        currencySelectionButton.layer.cornerRadius = currencySelectionButton.frame.size.height/2          
      overlayView?.alpha = customFlowLayoutAttributes.headerOverlayAlpha
    }
    
}
