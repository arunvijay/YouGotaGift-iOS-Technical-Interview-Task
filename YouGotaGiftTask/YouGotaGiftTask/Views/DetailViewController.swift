//
//  DetailViewController.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 14/01/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, DetailViewModelDelegate {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    var customLayout: DetailCustomLayout? {
      return detailCollectionView?.collectionViewLayout as? DetailCustomLayout
    }
    
    var brandDetails : Brand?
    var cardDetails : CardDetails?
    var selectedMenu = 0
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        detailCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
        DetailViewModel.shared.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DetailViewModel.shared.getCardDetails(cardId: self.brandDetails?.id ?? 0)
        
    }

    func loadDetailPageData(cardDetails: CardDetails?) {
        self.cardDetails = cardDetails
        
        DispatchQueue.main.async {
            self.detailCollectionView.reloadData()
        }
    }
    
}

private extension DetailViewController {

  func  setupCollectionViewLayout() {
    guard let collectionView = detailCollectionView, let customLayout = customLayout else { return }

    collectionView.register(
      UINib(nibName: "DetailHeaderView", bundle: nil),
      forSupplementaryViewOfKind: DetailCustomLayout.Element.DetailHeaderView.kind,
      withReuseIdentifier: DetailCustomLayout.Element.DetailHeaderView.id
    )

    collectionView.register(
      UINib(nibName: "DetailMenuView", bundle: nil),
      forSupplementaryViewOfKind: DetailCustomLayout.Element.DetailMenuView.kind,
      withReuseIdentifier: DetailCustomLayout.Element.DetailMenuView.id
    )

    let mainCellWidth = collectionView.frame.self.width
    let mainCellHeight = collectionView.frame.size.height/1.5
    customLayout.settings.itemSize = CGSize(width: mainCellWidth, height: mainCellHeight)
    customLayout.settings.headerSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height/1.8)
    customLayout.settings.menuSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.width/4)
    
    customLayout.settings.isHeaderStretchy = true
    customLayout.settings.isAlphaOnHeaderActive = true
    customLayout.settings.headerOverlayMaxAlphaValue = CGFloat(0.6)
    customLayout.settings.isMenuSticky = true
    customLayout.settings.isSectionHeadersSticky = true
    customLayout.settings.isParallaxOnCellsEnabled = false
    customLayout.settings.maxParallaxOffset = 60
    customLayout.settings.minimumInteritemSpacing = 16
    customLayout.settings.minimumLineSpacing = 16
  }
}

extension DetailViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCustomLayout.Element.DetailPageCollectionViewCell.id, for: indexPath)
        if let detailCell = cell as? DetailPageCollectionViewCell {
            detailCell.selectedIndex = self.selectedMenu
            detailCell.giftCardDetails = self.cardDetails
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      switch kind {

      case DetailCustomLayout.Element.DetailHeaderView.kind:
        let topHeaderView = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: DetailCustomLayout.Element.DetailHeaderView.id,
          for: indexPath
        )
        return topHeaderView

      case DetailCustomLayout.Element.DetailMenuView.kind:
        let menuView = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: DetailCustomLayout.Element.DetailMenuView.id,
          for: indexPath
        )
        if let menuView = menuView as? DetailMenuView {
            menuView.delegate = self
            menuView.configure()
        }
        return menuView

      default:
        fatalError("Unexpected element kind")
      }
    }
}

extension DetailViewController : DetailMenuViewDelegate {
    func didSelectItemAt(index: Int) {
        let headerView = detailCollectionView.supplementaryView(forElementKind: DetailCustomLayout.Element.DetailHeaderView.kind, at: IndexPath(item: 0, section: 0)) as! DetailHeaderView
        
        headerView.productImageView.kf.setImage(with: URL(string: brandDetails?.productImage ?? ""), placeholder: UIImage())
        headerView.nameLabel.text = brandDetails?.name
        selectedMenu = index
        DispatchQueue.main.async {
            self.detailCollectionView.reloadData()
        }
        
        
    }
    
    
}
