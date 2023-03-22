
//
//  Constants.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import UIKit
import SnapKit
import Kingfisher

//protocol FavouriteCVCellDelegate :NSObjectProtocol {
//
//    func clickTransmitData(_ cell:FavouriteTableViewCell ,icon: UIImageView)
//}

class FavouriteTableViewCell: UITableViewCell {
    
    public var favouriteCellViewModel: FavouriteCocktailsCellViewModel?
    
//    weak var delegate: FavouriteCVCellDelegate?
    
    
//    public var cellFavouriteViewModel: FavouriteCocktailsCellViewModel? {
//        didSet {
//            productLabel.text = cellFavouriteViewModel?.drinkName
//            cellFavouriteViewModel?.setImageToImageView(imageView: productImage)
//        }
//    }
    
    
//    var goodModel : Drinks? {
//        didSet {
//
//
//
//               cellFavouriteViewModel?.setImageToImageView(imageView: productImage)
//
//
//
//                productLabel.text = cellFavouriteViewModel?.drinkName
//
//
//                descriptionLabel.text = "advavav"
//
////            addCarButton.isSelected = !goodModel!.alreadyAddShoppingCArt
//            layoutIfNeeded()
//        }
//    }
    
//    var collBackIconView: UIImageView?
    
    var productImage: UIImageView = {
        var productImage = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 100,
                height: 100
            ))
            productImage.contentMode = .scaleAspectFit
        productImage.layer.masksToBounds = true
        productImage.layer.cornerRadius = 30
        productImage.clipsToBounds = true
        return productImage
    }()

    var productLabel: UILabel = {
        var productLabel = UILabel()
        productLabel.text = "Fried Rice"
        productLabel.numberOfLines = 0
        productLabel.textAlignment = .center
        productLabel.font = UIFont(name: "Avenir", size: 17)
        productLabel.numberOfLines = 1
        return productLabel
    }()

    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Long text"
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.textColor = ColorConstants.description
        label.numberOfLines = 0
        return label
    }()
    
    
//    fileprivate lazy var addCarButton: UIButton = {
//
//        let addCarButton = UIButton(type: UIButton.ButtonType.custom)
//        addCarButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
//        addCarButton.tintColor = .red
//        addCarButton.addTarget(self, action: #selector(self.addCarButtonClick(_:)), for: UIControl.Event.touchUpInside)
//        return addCarButton
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        makeConstraints()
    }
    
    func setupSubViews() {
        contentView.addSubview(productImage)
        contentView.addSubview(productLabel)
        contentView.addSubview(descriptionLabel)
//        contentView.addSubview(addCarButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc fileprivate func addCarButtonClick(_ btn:UIButton) {
//        addCarButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
//        goodModel!.alreadyAddShoppingCArt = true
//
//        btn.isEnabled = !goodModel!.alreadyAddShoppingCArt
//        delegate?.clickTransmitData(self, icon: productImage)
//
//    }
    
    
    
//    public func configure(with model: Drinks) {
//        func showme() {
//            guard let vc = storyboard?.instantiateViewController(withIdentifier: ChoosedCocktailViewController.id) as? ChoosedCocktailViewController else { fatalError() }
//            vc.completionHandler = { model in
//                self.
//            }
//        }
//
//        guard let url = URL(string: model.image) else { return }
//        productImage.kf.setImage(with: url)
//        productLabel.text = model.name
//        descriptionLabel.text = model.instructions
//    }
    
    
    
    
    
    func configure(with drink: Drinks) {
        productLabel.text = drink.name
        descriptionLabel.text = drink.instructions
        favouriteCellViewModel?.setImageToImageView(imageView: productImage)
        }
    
        


        
   func makeConstraints () {
        productImage.snp.makeConstraints{ maker in
            maker.left.equalToSuperview().offset(10)
            maker.top.equalToSuperview().offset(10)
            maker.width.height.equalTo(120)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(20)
            maker.left.equalTo(productImage.snp.right).offset(10)
            maker.width.height.equalTo(105)
        }

        productLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(productImage.snp.bottom).offset(-7)
            maker.centerX.equalTo(productImage)
            maker.width.equalTo(120)
            maker.height.equalTo(50)
        }
        
//        addCarButton.snp.makeConstraints { (make) -> Void in
//            make.right.equalTo(-12)
//            make.top.equalTo(25)
//            make.width.height.equalTo(30)
//        }
    }
}















//
////
////  Constants.swift
////  CoctailsApp
////
////  Created by Eldar on 21/2/23.
////
//
//import UIKit
//import SnapKit
//
//protocol FavouriteCVCellDelegate :NSObjectProtocol {
//
//    func clickTransmitData(_ cell:FavouriteTableViewCell ,icon: UIImageView)
//}
//
//class FavouriteTableViewCell: UITableViewCell {
//
//    weak var delegate: FavouriteCVCellDelegate?
//
//    var goodModel : BasketChoosedModel? {
//        didSet {
//            if let iconName  = goodModel?.iconName {
//                iconView.image = UIImage(named: iconName)
//            }
//            if let title = goodModel?.title {
//                titleLabel.text = title
//            }
//            if let desc = goodModel?.desc {
//                descLabel.text = desc
//            }
//            addCarButton.isSelected = !goodModel!.alreadyAddShoppingCArt
//            layoutIfNeeded()
//        }
//    }
//
//    var collBackIconView: UIImageView?
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        prepareUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    @objc fileprivate func addCarButtonClick(_ btn:UIButton) {
//        goodModel!.alreadyAddShoppingCArt = true
//
//        btn.isEnabled = !goodModel!.alreadyAddShoppingCArt
//        delegate?.clickTransmitData(self, icon: iconView)
//
//    }
//
//    fileprivate lazy var iconView: UIImageView = {
//        let iconView = UIImageView()
//        iconView.layer.cornerRadius = 30
//        iconView.layer.masksToBounds = true
//        return iconView
//    }()
//
//    fileprivate lazy var titleLabel: UILabel = {
//        let titleLabel = UILabel()
//        return titleLabel
//    }()
//
//    fileprivate lazy var descLabel: UILabel = {
//        let descLabel  = UILabel()
//        descLabel.textColor = UIColor.gray
//        return descLabel
//    }()
//
//    fileprivate lazy var addCarButton: UIButton = {
//
//        let addCarButton = UIButton(type: UIButton.ButtonType.custom)
//        addCarButton.setBackgroundImage(UIImage(named: "button_add_cart"), for: UIControl.State())
//        addCarButton.setTitle("Order", for: UIControl.State())
//        addCarButton.addTarget(self, action: #selector(self.addCarButtonClick(_:)), for: UIControl.Event.touchUpInside)
//        return addCarButton
//    }()
//
//    func prepareUI () {
//        contentView.addSubview(iconView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(descLabel)
//        contentView.addSubview(addCarButton)
//
//        iconView.snp.makeConstraints { (make) -> Void in
//            make.left.equalTo(12)
//            make.top.equalTo(10)
//            make.width.equalTo(60)
//            make.height.equalTo(60)
//        }
//
//        titleLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(contentView.snp.top).offset(10)
//            make.left.equalTo(iconView.snp.right).offset(12)
//
//        }
//
//
//        descLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(titleLabel.snp.bottom).offset(12)
//            make.left.equalTo(iconView.snp.right).offset(12)
//        }
//
//        addCarButton.snp.makeConstraints { (make) -> Void in
//            make.right.equalTo(-12)
//            make.top.equalTo(25)
//            make.width.equalTo(80)
//            make.height.equalTo(30)
//        }
//    }
//}











//
////
////  BasketCollectionViewCell.swift
////  CocktailsApp
////
////  Created by Eldar on 12/2/23.
////
//
//import UIKit
//import SnapKit
//import Kingfisher
//
//class FavouriteCVCell: UICollectionViewCell {
//
//    var coctail: Drinks?
//
//    static let reuseID = String(describing: FavouriteCVCell.self)
//
//    var productImage: UIImageView = {
//        var productImage = UIImageView(
//            frame: CGRect(
//                x: 0,
//                y: 0,
//                width: 100,
//                height: 100
//            ))
//        productImage.contentMode = .scaleAspectFit
//        productImage.layer.masksToBounds = true
//        productImage.layer.cornerRadius = 30
//        productImage.clipsToBounds = true
//        return productImage
//    }()
//
//    var productLabel: UILabel = {
//        var productLabel = UILabel()
//        productLabel.text = "Fried Rice"
//        productLabel.numberOfLines = 0
//        productLabel.textAlignment = .center
//        productLabel.font = UIFont(name: "Avenir", size: 17)
//        productLabel.numberOfLines = 1
//        return productLabel
//    }()
//
//    lazy var descriptionLabel: UILabel = {
//        var label = UILabel()
//        label.text = "Long text"
//        label.font = UIFont(name: "Avenir Next", size: 14)
//        label.textColor = ColorConstants.description
//        label.numberOfLines = 0
//        return label
//    }()
//
//    //    var productBuyNowButton: UIButton = {
//    //        var button = UIButton(type: .system)
//    //        button.backgroundColor = ColorConstants.buyNow
//    //        button.setTitleColor(.white, for: .normal)
//    //        button.setTitle("Buy now", for: .normal)
//    //        button.titleLabel?.textColor = .white
//    //        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .semibold)
//    //        button.titleLabel?.textAlignment = .left
//    //        button.layer.cornerRadius = 7
//    //        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
//    //        button.layer.shadowOpacity = 0.2
//    //        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//    //        button.layer.shadowOffset = CGSize(width: 0, height: 4)
//    //        button.layer.shadowOpacity = 1
//    //        button.layer.shadowRadius = 4
//    //        button.layer.masksToBounds = false
//    //
//    //        button.addTarget(
//    //            self,
//    //            action: #selector(addToCart),
//    //            for: .touchUpInside
//    //        )
//    //        return button
//    //    }()
//
//    private lazy var stepperControl: StepperView = {
//        var stepper = StepperView()
//        stepper.minimumNumberOfItems = 0
//        stepper.additionButtonColor = UIColor.systemGreen
//        stepper.decreaseButtonColor = .darkGray
//        return stepper
//    }()
//
//    //    @objc
//    //    func addToCart() {
//    //        print("add to cart. buy")
//    //    }
//
//    private func setUpConstraints() {
//        productImage.snp.makeConstraints{ maker in
//            maker.left.equalToSuperview().offset(-50)
//            maker.top.equalToSuperview().offset(10)
//            maker.width.height.equalTo(120)
//        }
//
//        descriptionLabel.snp.makeConstraints { maker in
//            maker.top.equalToSuperview().offset(20)
//            maker.left.equalToSuperview().offset(100)
//            maker.width.height.equalTo(105)
//        }
//
//        productLabel.snp.makeConstraints{ maker in
//            maker.top.equalTo(productImage.snp.bottom).offset(-7)
//            maker.centerX.equalTo(productImage)
//            maker.width.equalTo(120)
//            maker.height.equalTo(50)
//        }
//
//        //        productBuyNowButton.snp.makeConstraints { maker in
//        //            maker.top.equalTo(productLabel.snp.bottom).offset(-10)
//        //            maker.centerX.equalTo(productLabel)
//        //            maker.width.equalTo(80)
//        //            maker.height.equalTo(25)
//        //        }
//
//        //        stepperControl.snp.makeConstraints { maker in
//        //            maker.centerX.equalTo(productBuyNowButton).inset(-28)
//        //            maker.top.equalTo(productLabel.snp.bottom).offset(-10)
//        //              maker.width.equalTo(78)
//        //              maker.height.equalTo(22)
//        //          }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = ColorConstants.cellBack
//        setUpUI()
//    }
//
//    private func setUpUI() {
//        setUpSubviews()
//        setUpConstraints()
//    }
//
//    private func setUpSubviews() {
//        self.addSubview(productImage)
//        self.addSubview(descriptionLabel)
//        self.addSubview(productLabel)
//        //        self.addSubview(productBuyNowButton)
//        //        self.addSubview(stepperControl)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    //
//    //    func chooseCollection(_ product: Drinks) {
//    //        coctail = product
//    //        let drinks = Drinks(
//    //            name: product.name,
//    //            image: product.image,
//    //            instructions: product.instructions
//    //        )
//    //
//    ////        DatabaseManager.shared.setCocktailsToDataBase(
//    ////            collection: "User",
//    ////            document: "List of Cocktails",
//    ////            withData: drinks.dictionary
//    ////        )
//    //    }
//
//    //    func displayInfo(product: Drinks) {
//    //        coctail = product
//    //        productLabel.text = product.name
//    //        productImage.kf.setImage(with: URL(string: product.image))
//    //        chooseCollection(product)
//    //    }
//    public func configure(with model: Drinks) {
//        //        func showme() {
//        //            guard let vc = storyboard?.instantiateViewController(withIdentifier: ChoosedCocktailViewController.id) as? ChoosedCocktailViewController else { fatalError() }
//        //            vc.completionHandler = { model in
//        //                self.
//        //            }
//        //        }
//
//        guard let url = URL(string: model.image) else { return }
//        productImage.kf.setImage(with: url)
//        productLabel.text = model.name
//        descriptionLabel.text = model.instructions
//    }
//
//    //    func displayInfo(product: Drinks) {
//    //        coctail = product
//    //        productLabel.text = product.name
//    //        productImage.kf.setImage(with: URL(string: product.image))
//    //        chooseCollection(product)
//    //    }
//}
//
//
