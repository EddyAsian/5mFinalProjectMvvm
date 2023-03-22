//
//  Constants.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import UIKit
import SnapKit


class FavouriteDrinksNotificationManager {
    private var observer: NSObjectProtocol?
    
    init(observer: NSObject, selector: Selector) {
        self.observer = NotificationCenter.default.addObserver(forName: Notification.Name("FavouriteDrinksUpdated"), object: nil, queue: nil) { notification in
            observer.perform(selector, with: notification)
        }
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}


protocol FavouriteDrinksViewModelFactory {
    func createCocktailsMenuViewModel() -> FavouriteDrinksViewModel
}

class DefaultCocktailsFavouriteMenuViewModelFactory: FavouriteDrinksViewModelFactory {
    func createCocktailsMenuViewModel() -> FavouriteDrinksViewModel {
        return FavouriteDrinksViewModel()
    }
}

class FavouriteDrinksViewController: UIViewController {
    
    private let viewModelFavouriteFactory: FavouriteDrinksViewModelFactory
    
    init(viewModelFavouriteFactory: FavouriteDrinksViewModelFactory) {
        self.viewModelFavouriteFactory = viewModelFavouriteFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var viewModel: FavouriteDrinksViewModel = {
        viewModelFavouriteFactory.createCocktailsMenuViewModel()
    }()
    
    
    private var favouriteDrinksNotificationManager: FavouriteDrinksNotificationManager?
    
    fileprivate var goodArray = [Drinks]()
    
    fileprivate let goodLinstCell = "FavouriteTableViewCell"
    
    fileprivate var addGoodArray = [Drinks]()
    
    fileprivate var path : UIBezierPath?
    
    var layer: CALayer?
    
    private lazy var allDrinksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Favourite ❤️"
        label.font = UIFont(name: "Avenir Next Bold", size: 26)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pageInfoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Check your choosed drinks\n and we will deliver them."
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Roman", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var amontCart : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.white
        label.text = "\(self.goodArray.count)"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 7.5
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.red.cgColor
        label.isHidden = true
        return label
    }()
    
    lazy var cartTableView : UITableView = {
        var tableView = UITableView()
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 30
        return tableView
    }()
    
    lazy var cartBtn : UIButton =  {
        var btn = UIButton()
        btn.setImage(UIImage(named: "button_cart"), for: UIControl.State())
        btn.addTarget(self, action: #selector(self.cartClick), for: UIControl.Event.touchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
    override func viewDidLoad() {
        
        favouriteDrinksNotificationManager = FavouriteDrinksNotificationManager(observer: self, selector: #selector(handleFavouriteDrinksNotification(notification:)))
    }
    
    
    
    
    
    
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorConstants.tabBarItemLight
        //        viewModel.objectsTextInBasket()
        addUiView()
        setupSubViews()
        setUpConstraints()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
    }
    
    private func setupSubViews() {
        view.addSubview(allDrinksTitleLabel)
        view.addSubview(pageInfoSubtitleLabel)
        view.addSubview(cartTableView)
    }
    
    func addUiView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBtn)
        navigationController?.navigationBar.addSubview(amontCart)
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        cartTableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: goodLinstCell)
    }
    
    @objc func handleFavouriteDrinksNotification(notification: Notification) {
        if let userInfo = notification.userInfo,
           let favouriteDrinksArray = userInfo["favouriteDrinksArray"] as? [Drinks] {
            // Use the updated favouriteDrinksArray here...
            print("💚Notification watching from another VC, there are 👉  \(favouriteDrinksArray.count) elements in array: \(favouriteDrinksArray)💚")
            viewModel.getFavouriteDrinksArrayNotification = favouriteDrinksArray
            print("💋there are 👉 \(viewModel.getFavouriteDrinksArrayNotification.count) in array viewModel.getFavouriteDrinksArrayNotification: \(viewModel.getFavouriteDrinksArrayNotification)")
        }
    }
    
    @objc fileprivate func cartClick () {
        //        let controller = BasketFinalBuyViewController()
        //        controller.addGoodArray = addGoodArray
        //        present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        
        cartTableView.reloadData()
        
        print("💋there are 👉 \(viewModel.getFavouriteDrinksArrayNotification.count) in array viewModel.getFavouriteDrinksArrayNotification: \(viewModel.getFavouriteDrinksArrayNotification)")
    }
    
    
    
    func setUpConstraints () {
        
        allDrinksTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
        
        pageInfoSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(allDrinksTitleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(77)
        }
        
        cartTableView.snp.makeConstraints { (make) in
            make.top.equalTo(pageInfoSubtitleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(35)
            make.left.right.bottom.equalToSuperview()
        }
        amontCart.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
        
        amontCart.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-12)
            make.top.equalTo(10.5)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
}

extension FavouriteDrinksViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Number of rows: \(viewModel.getFavouriteDrinksArrayNotification.count)")

        return viewModel.getFavouriteDrinksArrayNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: goodLinstCell, for: indexPath) as! FavouriteTableViewCell
        let drink = viewModel.getFavouriteDrinksArrayNotification[indexPath.row]
        cell.configure(with: drink)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

//extension FavouriteDrinksViewController : FavouriteCVCellDelegate {
//
//    func clickTransmitData(_ cell: FavouriteTableViewCell, icon: UIImageView) {
//
//        guard let indexPath = cartTableView.indexPath(for: cell) else {
//            return
//        }
//
//        goodArray.remove(at: indexPath.row)
//        cartTableView.deleteRows(at: [indexPath], with: .left)
//    }
//}
