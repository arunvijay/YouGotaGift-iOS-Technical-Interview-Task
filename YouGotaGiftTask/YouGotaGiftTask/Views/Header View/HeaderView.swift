//
//  HeaderView.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 09/01/21.
//

import Foundation

import UIKit

final class HeaderView: UICollectionReusableView {
    
  // MARK: - IBOutlets
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var headerCategoryImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var howItWorksButton: UIButton!
    
  // MARK: - Life Cycle
    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)

    guard let customFlowLayoutAttributes = layoutAttributes as? CustomLayoutAttributes else {
      return
    }

        howItWorksButton.layer.borderWidth = 0.7
        howItWorksButton.layer.borderColor = UIColor.white.cgColor
        
    overlayView?.alpha = customFlowLayoutAttributes.headerOverlayAlpha
  }
    
}
