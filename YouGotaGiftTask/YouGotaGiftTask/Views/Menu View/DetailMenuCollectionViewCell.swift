//
//  DetailMenuCollectionViewCell.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 14/01/21.
//

import UIKit

class DetailMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var detailMenuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                detailMenuLabel.textColor = .white
                detailMenuLabel.backgroundColor = .systemPink
                detailMenuLabel.layer.borderWidth = 0
            }
            else {
                detailMenuLabel.textColor = .systemPink
                detailMenuLabel.backgroundColor = .white
                detailMenuLabel.layer.borderWidth = 0.7
                detailMenuLabel.layer.borderColor = UIColor.systemPink.cgColor
            }
        }
    }
    
}
