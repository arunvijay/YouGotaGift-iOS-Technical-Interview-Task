//
//  ViewController.swift
//  YouGotaGiftTask
//
//  Created by Arun Vijay on 08/01/21.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, HomeViewModelDelegate {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var activityView: UIView!
    
    var categories:[Category]?
    var brands:[Brand]?
    
    var customLayout: CustomLayout? {
      return homeCollectionView?.collectionViewLayout as? CustomLayout
    }
    
    var isLoading: Bool? {
        didSet{
            if isLoading ?? false{
                self.activityView.isHidden = false
            }
            else {
                self.activityView.isHidden = true
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        homeCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityView.isHidden = false
        
        setupCollectionViewLayout()
        
        HomeViewModel.shared.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HomeViewModel.shared.getHomePageData(category: 32, pageNo: 1)
        
    }

    func loadHomaPageData(categories: Array<Category>, brands: Array<Brand>) {
        DispatchQueue.main.async {
            self.categories = categories
            self.brands = brands
            
            self.homeCollectionView.reloadData()
        }
    }
    func loadBrands(brands: Array<Brand>) {
    }
}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands?.count ?? 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomLayout.Element.HomeCollectionViewCell.id, for: indexPath)
        if let homeCell = cell as? HomeCollectionViewCell {
            homeCell.configureCellAt(index: indexPath.item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      switch kind {

      case CustomLayout.Element.header.kind:
        let topHeaderView = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: CustomLayout.Element.header.id,
          for: indexPath
        )
        return topHeaderView

      case CustomLayout.Element.menu.kind:
        let menuView = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: CustomLayout.Element.menu.id,
          for: indexPath
        )
        if let menuView = menuView as? CategoryView {
            menuView.delegate = self
            menuView.configure()
        }
        return menuView

      default:
        fatalError("Unexpected element kind")
      }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.brandDetails = brands?[indexPath.item]
        detailVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

private extension HomeViewController {

  func  setupCollectionViewLayout() {
    guard let collectionView = homeCollectionView, let customLayout = customLayout else { return }

    collectionView.register(
      UINib(nibName: "HeaderView", bundle: nil),
      forSupplementaryViewOfKind: CustomLayout.Element.header.kind,
      withReuseIdentifier: CustomLayout.Element.header.id
    )

    collectionView.register(
      UINib(nibName: "CategoryView", bundle: nil),
      forSupplementaryViewOfKind: CustomLayout.Element.menu.kind,
      withReuseIdentifier: CustomLayout.Element.menu.id
    )

    let sizeVal = (collectionView.frame.self.width/2)-25
    customLayout.settings.itemSize = CGSize(width: sizeVal, height: sizeVal)
    customLayout.settings.headerSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
    customLayout.settings.menuSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3.3)
    
    customLayout.settings.isHeaderStretchy = true
    customLayout.settings.isAlphaOnHeaderActive = true
    customLayout.settings.headerOverlayMaxAlphaValue = CGFloat(0.6)
    customLayout.settings.isMenuSticky = true
    customLayout.settings.isSectionHeadersSticky = true
    customLayout.settings.isParallaxOnCellsEnabled = true
    customLayout.settings.maxParallaxOffset = 60
    customLayout.settings.minimumInteritemSpacing = 16
    customLayout.settings.minimumLineSpacing = 16
  }
}

extension HomeViewController : CategoryViewDelegate {
    func didSelect(category: Category?) {
        let headerView = homeCollectionView.supplementaryView(forElementKind: CustomLayout.Element.header.kind, at: IndexPath(item: 0, section: 0)) as? HeaderView
        
        headerView?.headerCategoryImageView.kf.setImage(with: URL(string: category?.imageLarge ?? ""), placeholder: UIImage())
        headerView?.titleLabel.text = category?.title
        headerView?.captionLabel.text = category?.caption
        if HomeViewModel.shared.getSelectedCategory()?.id != category?.id {
            HomeViewModel.shared.getHomePageData(category: category?.id ?? 0, pageNo: 1)
        }
    }
    
    func reloadCollectionViewDataWithCategoryIndex(_ index: Int) {
    }
}
