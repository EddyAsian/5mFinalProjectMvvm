//
//  Constants.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import UIKit
import SnapKit

protocol BasketChoosedTableViewCellDelegate :NSObjectProtocol {
    
    func clickTransmitData(_ cell:BaskedChoosedTableViewCell ,icon: UIImageView)
}

class BaskedChoosedTableViewCell: UITableViewCell {
    
    weak var delegate: BasketChoosedTableViewCellDelegate?
    
    var goodModel : BasketChoosedModel? {
        didSet {
            if let iconName  = goodModel?.iconName {
                iconView.image = UIImage(named: iconName)
            }
            if let title = goodModel?.title {
                titleLabel.text = title
            }
            if let desc = goodModel?.desc {
                descLabel.text = desc
            }
            addCarButton.isSelected = !goodModel!.alreadyAddShoppingCArt
            layoutIfNeeded()
        }
    }
    
    var collBackIconView: UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func addCarButtonClick(_ btn:UIButton) {
        goodModel!.alreadyAddShoppingCArt = true
        
        btn.isEnabled = !goodModel!.alreadyAddShoppingCArt
        delegate?.clickTransmitData(self, icon: iconView)
        
    }
    
    fileprivate lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.layer.cornerRadius = 30
        iconView.layer.masksToBounds = true
        return iconView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    fileprivate lazy var descLabel: UILabel = {
        let descLabel  = UILabel()
        descLabel.textColor = UIColor.gray
        return descLabel
    }()
    
    fileprivate lazy var addCarButton: UIButton = {
        
        let addCarButton = UIButton(type: UIButton.ButtonType.custom)
        addCarButton.setBackgroundImage(UIImage(named: "button_add_cart"), for: UIControl.State())
        addCarButton.setTitle("Order", for: UIControl.State())
        addCarButton.addTarget(self, action: #selector(self.addCarButtonClick(_:)), for: UIControl.Event.touchUpInside)
        return addCarButton
    }()
    
    func prepareUI () {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(addCarButton)
        
        iconView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(iconView.snp.right).offset(12)
            
        }
        
        
        descLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalTo(iconView.snp.right).offset(12)
        }
        
        addCarButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-12)
            make.top.equalTo(25)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
}

