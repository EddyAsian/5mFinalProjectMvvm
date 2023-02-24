//
//  StepperView.swift
//  CoctailsApp
//
//  Created by Eldar on 23/2/23.
//

import UIKit

protocol HidableStepperDelegate: AnyObject {
    func stepperWillHideDecreaseButton()
    func stepperWillRevealDecreaseButton()
    func updateValue(with count: Int)
}

class StepperView: UIControl {
    
    weak var delegate: HidableStepperDelegate?
    
    public enum ButtonType {
        case normal
        case allRounded
        case bottomRounded
        case circular
    }
    
    var type: ButtonType = .circular
    
    var quantityOfItems: Int = 0 {
        didSet {
            delegate?.updateValue(with: quantityOfItems)
            quantityOfItemsLabel.text = "\(quantityOfItems) \(quantityOfItemsUnityOfMeasure)"
        }
    }
    
    var minimumNumberOfItems: Int = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(decrease), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        button.setTitle("  -  ", for: .normal)
        return button
    }()
    
    lazy var additionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(add), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        button.setTitle("  +  ", for: .normal)
        return button
    }()
    
    lazy var spacerView: UIView = {
        let spacerView: UIView = UIView()
        spacerView.backgroundColor = stepperBackgroundColor
        return spacerView
    }()
    
    lazy var quantityOfItemsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = quantityOfItemsUnityOfMeasure
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor.black
        return label
    }()
    
    var additionButtonColor: UIColor = .orange {
        didSet {
            additionButton.backgroundColor = additionButtonColor
        }
    }
    
    var decreaseButtonColor: UIColor = .orange {
        didSet {
            decreaseButton.backgroundColor = decreaseButtonColor
        }
    }
    
    var stepperBackgroundColor: UIColor = .clear {
        didSet {
            backgroundColor = stepperBackgroundColor
        }
    }
    
    var quantityOfItemsLabelFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            quantityOfItemsLabel.font = quantityOfItemsLabelFont
        }
    }
    
    var quantityOfItemsUnityOfMeasure: String = ""
    
    var hiddableView: UIView!
    
    private func sharedInit() {
        clipsToBounds = true
        
        hiddableView = UIView()
        
        spacerView.addSubview(quantityOfItemsLabel)
        
        hiddableView.addSubview(spacerView)
        hiddableView.addSubview(decreaseButton)
        hiddableView.clipsToBounds = false
        
        addSubview(hiddableView)
        addSubview(additionButton)
    }
    
    public override func layoutSubviews() {
        let buttonWidth = frame.height
        
        decreaseButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonWidth)
        additionButton.frame = CGRect(x: frame.width - buttonWidth, y: 0, width: buttonWidth, height: buttonWidth)
        
        let hidableViewWidth = frame.width - frame.height
        if quantityOfItems > 0 {
            hiddableView.frame = CGRect(x: 0, y: 0, width: hidableViewWidth, height: frame.height)
        } else {
            hiddableView.frame = CGRect(x: hidableViewWidth, y: 0, width: hidableViewWidth, height: frame.height)
        }
        spacerView.frame = CGRect(x: frame.height - frame.height / 2, y: 0, width: frame.width - (frame.height * 2) + ((frame.height / 2) * 2), height: frame.height)
        quantityOfItemsLabel.frame.size = CGSize(width: spacerView.frame.size.width * 0.8, height: spacerView.frame.size.height)
        quantityOfItemsLabel.center = CGPoint(x: spacerView.frame.width / 2, y: spacerView.frame.height / 2)
        setupForType()
    }
    
    private func setupForType() {
        switch type {
        case .normal:
            additionButton.layer.cornerRadius = 0
            decreaseButton.layer.cornerRadius = 0
        case .allRounded:
            additionButton.layer.cornerRadius = 8
            decreaseButton.layer.cornerRadius = 8
            layer.cornerRadius = additionButton.layer.cornerRadius
        case .bottomRounded:
            additionButton.layer.cornerRadius = 10
            additionButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
            decreaseButton.layer.cornerRadius = 10
            decreaseButton.layer.maskedCorners = [.layerMinXMaxYCorner]
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case .circular:
            let buttonWidth = frame.height
            additionButton.layer.cornerRadius = buttonWidth / 2
            decreaseButton.layer.cornerRadius = buttonWidth / 2
            layer.cornerRadius = buttonWidth / 2
        }
    }
    
    var isHiddableViewRevealead: Bool = false
    
    @objc func add(_ sender: UIButton) {
        quantityOfItems += 1
        if !isHiddableViewRevealead { revealDecreaseButton() }
    }
    
    @objc func decrease(_ sender: UIButton) {
        quantityOfItems -= 1
        
        if quantityOfItems == minimumNumberOfItems { hideDecreaseButton() }
    }
    
    private func button(withTitle title: String, withColor buttonColor: UIColor) -> UIButton {
        let button = UIButton()
        button.backgroundColor = buttonColor
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }
    
    var animationDuration: Double {
        return Double(layer.frame.width) / 1000
    }
    
    func revealDecreaseButton() {
        delegate?.stepperWillRevealDecreaseButton()
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            options: [.curveEaseIn],
            animations: {
                self.hiddableView.layer.position.x -= self.hiddableView.frame.width
            })
        isHiddableViewRevealead = true
    }
    
    func hideDecreaseButton() {
        delegate?.stepperWillHideDecreaseButton()
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                self.hiddableView.layer.position.x += self.hiddableView.frame.width
            })
        isHiddableViewRevealead = false
    }
    
    override open func prepareForInterfaceBuilder() {
        sharedInit()
    }
}





//
//import UIKit
//
//class BasketViewController: UIViewController {
//    enum TypeSelected {
//        case takeaway
//        case intheCafe
//    }
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
//        label.textColor = .black
//        label.text = "ЙОЙО"
//        return label
//    }()
//
//    private lazy var historyOfOrdersButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("История", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        button.setTitleColor(.orange, for: .normal)
//        button.addTarget(self, action: #selector(historyTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: screenWidth, height: 90)
//        layout.minimumLineSpacing = 10
//        layout.headerReferenceSize = CGSize(width: screenWidth, height: 130)
//        layout.footerReferenceSize = CGSize(width: screenWidth, height: 240)
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.delegate = self
//        view.dataSource = self
//        view.registerReusable(CellType: OrderCell.self)
//        view.registerReusableView(ViewType: BasketHeaderView.self, type: .UICollectionElementKindSectionHeader)
//        view.registerReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter)
//        view.backgroundColor = Asset.clientBackround.color
//        return view
//    }()
//
//    private let emptyView: UIImageView = {
//        let view = UIImageView()
//        let image = Asset.animal.image
//        view.image = image
//        return view
//    }()
//    UIImage(named: "qwe")
//    private var sum = 0
//
//    // MARK: - injection
//    private var viewModel: BasketViewModelType
//
//    init(vm: BasketViewModelType) {
//        viewModel = vm
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUp()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        collectionView.reloadData()
//    }
//
//    private func setUp() {
//        setUpSubviews()
//        setUpConstaints()
//    }
//
//    private func setUpSubviews() {
//        view.addSubview(titleLabel)
//        view.addSubview(historyOfOrdersButton)
//        view.addSubview(collectionView)
//    }
//
//    private func setUpConstaints () {
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//            make.height.equalTo(35)
//        }
//        historyOfOrdersButton.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel).offset(14)
//            make.trailing.equalToSuperview().offset(-16)
//            make.height.equalTo(20)
//            make.width.equalTo(85)
//        }
//        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(5)
//            make.bottom.trailing.leading.equalToSuperview()
//        }
//    }
//    // MARK: - OBJC functions
//    @objc
//    private func historyTapped() {
//        let historyVC = DIService.shared.getVc(HistoryOrderViewController.self)
//        navigationController?.pushViewController(historyVC, animated: true)
//    }
//
//    private func orderInfo(sum: Int) {
//        self.sum = sum
//    }
//
//    // MARK: - Handlers
//    private func handleOrder() {
//        let dish = viewModel.getDishes()
//
//        let orderDetails = [
//            ListOrderDetailsDto(
//                calcTotal: Int(dish.first?.sum ?? 0.0),
//            chosenGeneralAdditional: nil,
//                id: dish.first?.dishId ?? 0,
//                name: dish.first?.dishName ?? "",
//                price: Int(dish.first?.dishPrice ?? 0.0),
//                quantity: dish.first?.quanitity ?? 0),
//
//            ListOrderDetailsDto(
//            calcTotal: Int(dish.last?.sum ?? 0.0),
//            chosenGeneralAdditional: nil,
//            id: dish.last?.dishId ?? 0,
//            name: dish.last?.dishName ?? "",
//            price: Int(dish.last?.dishPrice ?? 0.0),
//            quantity: dish.last?.quanitity ?? 0)
//        ]
//
//        let order = OrderDTO(branchId: 0,
//                             listOrderDetailsDto: orderDetails,
//                             orderTime: Date(),
//                             orderType: "IN",
//                             tableId: 0)
//    }
//}
//
//// MARK: - Datasource Delegate
//extension BasketViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.getDishes().count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueIdentifiableCell(OrderCell.self, for: indexPath)
//        cell.orderCount = orderInfo
//        cell.display(dish: viewModel.getDishes()[indexPath.row])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            let view = collectionView.dequeuReusableView(ViewType: BasketHeaderView.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
//            return view
//        case UICollectionView.elementKindSectionFooter:
//            let view = collectionView.dequeuReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
//            view.delegate = self
//            return view
//        default:
//            let view = collectionView.dequeuReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
//            return view
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//    }
//}
//
//extension BasketViewController: BasketFooterViewDelegate {
//    func addMoreTap() {
//        tabBarController?.selectedIndex = 0
//    }
//
//    func orderTap() {
//        handleOrder()
//    }
//}


