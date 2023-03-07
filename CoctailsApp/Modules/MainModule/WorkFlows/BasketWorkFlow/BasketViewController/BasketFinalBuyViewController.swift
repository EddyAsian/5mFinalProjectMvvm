//
//  Constants.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import UIKit

class BasketFinalBuyViewController: UIViewController {
    
    var addGoodArray: [BasketChoosedModel]? {
        didSet {
            
        }
    }
    
    var price: Float = 0.00
    
    fileprivate let shoppingCarCellIdntifier  = "shoppingCarCellIdntifier"
    
    lazy var showCartTableView : UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var bottomView : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor  = UIColor.white
        return bottomView
    }()
    
    lazy var selectButton: UIButton = {
        let selectButton = UIButton(type: UIButton.ButtonType.custom)
        selectButton.setImage(UIImage(named: "check_n"), for: UIControl.State())
        selectButton.setImage(UIImage(named: "check_p"), for: UIControl.State.selected)
        selectButton.setTitle("mark\\unmark", for: UIControl.State())
        selectButton.setTitleColor(UIColor.gray, for: UIControl.State())
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        selectButton.addTarget(self, action: #selector(self.didSelectButton(_:)), for: UIControl.Event.touchUpInside)
        selectButton.isSelected = true
        selectButton.sizeToFit()
        
        return selectButton
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        let attributeText = NSMutableAttributedString(string: "OK\(self.price)0")
        attributeText.setAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], range: NSMakeRange(5, attributeText.length - 5))
        
        label.attributedText = attributeText
        label.sizeToFit()
        return label
    }()
    
    lazy var buyButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("BUY", for: UIControl.State())
        button.setBackgroundImage(UIImage(named: "button_add_cart"), for: UIControl.State())
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        
        button.addTarget(
            self, action: #selector(acceptTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        presentingUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutUI()
        reCalculateGoodCount()
    }
    
    func presentingUI() {
        title = "Order list:"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickBar))
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem?.tintColor = UIColor.orange
        showCartTableView.rowHeight = 80
        
        showCartTableView.register(BasketChShoppingCell.self, forCellReuseIdentifier: shoppingCarCellIdntifier)
        
        view.addSubview(showCartTableView)
        view.addSubview(bottomView)
        bottomView.addSubview(selectButton)
        bottomView.addSubview(totalPriceLabel)
        bottomView.addSubview(buyButton)
        
        for model in addGoodArray! {
            if model.selected != true {
                selectButton.isSelected = false
                break
            }
        }
    }
    
    @objc func clickBar () {
        dismiss(animated: true)
    }
    
    @objc func acceptTapped() {
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Success",
            message: "We hope you will enjoy our Cocktails 🍸 🥃 🍷",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func layoutUI() {
        showCartTableView.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(-49)
        }
        bottomView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(-10)
            make.height.equalTo(49)
//            make.width.equalTo(340)
        }
        
        selectButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(35)
            make.centerY.equalTo(bottomView.snp.centerY)
        }
        
        totalPriceLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(bottomView.snp.center)
            make.top.equalToSuperview().offset(-20)
        }
        
        buyButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-20)
            make.top.equalTo(5)
            make.width.equalTo(88)
            make.height.equalTo(30)
        }
    }
}

extension BasketFinalBuyViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addGoodArray!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingCarCellIdntifier, for: indexPath) as! BasketChShoppingCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.addGoodArray = addGoodArray![indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    
}

extension BasketFinalBuyViewController : BasketChShoppingCellDelegate {
    
    func shopping(_ shopping: BasketChShoppingCell, button: UIButton, label: UILabel) {
        
        guard let indexPath = showCartTableView.indexPath(for: shopping) else {
            return
        }
        
        let data = addGoodArray![indexPath.row]
        
        if button.tag == 10 {
            
            if data.count < 1 {
                return
            }
            
            data.count -= 1
            label.text = "\(data.count)"
            
        } else {
            data.count += 1
            label.text = "\(data.count)"
        }
        reCalculateGoodCount()
    }
    
    func shoppingCalculate() {
        reCalculateGoodCount()
    }
}

extension BasketFinalBuyViewController {
    fileprivate func reCalculateGoodCount() {
        for model in addGoodArray! {
            if model.selected == true {
                price += Float(model.count) * (model.newPrice! as NSString).floatValue
            }
        }
        
        let  attributeText = NSMutableAttributedString(string: "TOTAL: \(self.price)0")
        attributeText.setAttributes(
            [NSAttributedString.Key.foregroundColor:UIColor.red],
            range: NSMakeRange(5, attributeText.length - 5)
        )
        
        totalPriceLabel.attributedText = attributeText
        price = 0
        showCartTableView.reloadData()
    }
    
    @objc fileprivate func didSelectButton(_ btn:UIButton) {
        btn.isSelected = !btn.isSelected
        for model in addGoodArray! {
            model.selected = btn.isSelected
        }
        reCalculateGoodCount()
        showCartTableView.reloadData()
    }
}

