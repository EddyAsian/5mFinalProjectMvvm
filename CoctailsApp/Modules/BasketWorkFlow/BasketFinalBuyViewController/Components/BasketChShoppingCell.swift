//
//  Constants.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import UIKit
import SnapKit

protocol BasketChShoppingCellDelegate : NSObjectProtocol {
    
    func shopping(_ shopping:BasketChShoppingCell ,button: UIButton ,label: UILabel)
    func shoppingCalculate()
}

class BasketChShoppingCell: UITableViewCell {
    
    var addGoodArray : BasketChoosedModel? {
        didSet {
            selectButton.isSelected = addGoodArray!.selected
            
            amountLabel.text = "\(addGoodArray!.count)"
            
            if let iconName = addGoodArray?.iconName {
                iconView.image = UIImage(named: iconName)
            }
            
            if let title = addGoodArray?.title {
                titleLabel.text = title
            }
            
            if let newPrice = addGoodArray?.newPrice {
                newPriceLabel.text = newPrice
            }
            
            if let oldPrice = addGoodArray?.oldPrice {
                oldPriceLabel.text = oldPrice
            }
            layoutIfNeeded()
        }
    }
    
    weak var delegate: BasketChShoppingCellDelegate?
    
    fileprivate lazy var selectButton: UIButton = {
        let selectButton = UIButton(type: UIButton.ButtonType.custom)
        selectButton.setImage(UIImage(named: "check_n"), for: UIControl.State())
        selectButton.setImage(UIImage(named: "check_p"), for: UIControl.State.selected)
        selectButton.addTarget(self, action: #selector(self.chooseClick(_:)), for: UIControl.Event.touchUpInside)
        selectButton.sizeToFit()
        return selectButton
    }()
    
    fileprivate lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.layer.cornerRadius = 30
        iconView.layer.masksToBounds = true
        return iconView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let title = UILabel()
        
        return title
    }()
    
    fileprivate lazy var newPriceLabel: UILabel = {
        let newPriceLabel = UILabel()
        newPriceLabel.textColor = UIColor.red
        return newPriceLabel
    }()
    
    fileprivate lazy var  oldPriceLabel: BasketChPriceLabel = {
        
        let old = BasketChPriceLabel()
        
        old.textColor = UIColor.gray
        
        return old
    }()
    
    fileprivate lazy var addAndsubtraction: UIView = {
        let view = UIView()
        
        view.backgroundColor = ColorConstants.buyNow
        return view
    }()
    
    fileprivate lazy var subtractButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = 10
        btn.setBackgroundImage(UIImage(named: "iconforBack"), for: UIControl.State())
        btn.addTarget(self, action: #selector(self.subtractClick(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var addButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        
        btn.tag = 11
        btn.setBackgroundImage(UIImage(named: "add_icon"), for: UIControl.State())
        btn.addTarget(self, action: #selector(self.subtractClick(_:)), for: UIControl.Event.touchUpInside)
        
        return btn
    }()
    
    fileprivate lazy var amountLabel: UILabel = {
        
        let label  = UILabel()
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareUI () {
        addSubview(selectButton)
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(newPriceLabel)
        addSubview(oldPriceLabel)
        addSubview(addAndsubtraction)
        
        addAndsubtraction.addSubview(subtractButton)
        addAndsubtraction.addSubview(amountLabel)
        addAndsubtraction.addSubview(addButton)
    }
    
    @objc fileprivate func chooseClick(_ CellBtn: UIButton) {
        print("1111:\(CellBtn.isSelected)--- \(!CellBtn.isSelected)")
        CellBtn.isSelected  = !CellBtn.isSelected
        addGoodArray?.selected = CellBtn.isSelected
        delegate?.shoppingCalculate()
    }
    
    @objc fileprivate func subtractClick(_ btn: UIButton) {
        delegate?.shopping(self, button: btn, label: amountLabel)
        //        addAndsubtraction.reloadInputViews()
    }
    
    private func makeConstraints() {
        selectButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        iconView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(42)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.top.equalTo(contentView.snp.top).offset(12)
        }
        
        newPriceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.top).offset(5)
            make.right.equalTo(-12)
        }
        
        oldPriceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(newPriceLabel.snp.bottom).offset(5)
            make.right.equalTo(-12)
        }
        
        addAndsubtraction.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(120)
            make.top.equalTo(40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        subtractButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        amountLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(30)
            make.top.equalTo(0)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        addButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(70)
            make.top.equalTo(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
}















