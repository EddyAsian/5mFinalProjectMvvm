//
//  Constants.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import UIKit
import SnapKit

let screenSize = UIScreen.main.bounds.size

class BasketChoosedViewController: UIViewController,CAAnimationDelegate {
    
    fileprivate var goodArray = [BasketChoosedModel]()
    
    fileprivate let goodLinstCell = "AJToTableViewCell"
    
    fileprivate var addGoodArray = [BasketChoosedModel]()
    
    fileprivate var path : UIBezierPath?
    
    var layer: CALayer?
    
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
        super.viewDidLoad()
        objectsTextInBasket()
        addUiView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutUI()
    }
    
    func addUiView() {
        navigationItem.title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBtn)
        navigationController?.navigationBar.addSubview(amontCart)
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.view.addSubview(cartTableView)
        cartTableView.register(BaskedChoosedTableViewCell.self, forCellReuseIdentifier: goodLinstCell)
    }
    
    @objc fileprivate func cartClick () {
        let controller = BasketFinalBuyViewController()
        controller.addGoodArray = addGoodArray
        present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
    
    private func objectsTextInBasket() {
        for i in 0..<10 {
            let model = BasketChoosedModel()
            model.iconName = "goodicon_\(i)"
            model.title = "\(i * i * 9 + 30) soms"
            model.desc = "Cocktail №\(i + 1) 🍹"
            model.newPrice = "\(i * i * 9)"
            model.oldPrice = "\(i * i * 9)"
            goodArray.append(model)
        }
    }
    
    func layoutUI () {
        cartTableView.snp.makeConstraints { (make) in
            make.width.equalTo(screenSize.width);
            make.height.equalTo(screenSize.height);
            make.top.equalTo(self.view);
            make.right.equalTo(self.view);
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

extension BasketChoosedViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: goodLinstCell
        ) as! BaskedChoosedTableViewCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.goodModel = goodArray[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension BasketChoosedViewController : BasketChoosedTableViewCellDelegate {
    
    func clickTransmitData(_ cell: BaskedChoosedTableViewCell, icon: UIImageView) {
        
        guard let indexPath = cartTableView.indexPath(for: cell) else {
            return
        }
        let redata = goodArray[indexPath.row]
        addGoodArray.append(redata)
        var rect = cartTableView.rectForRow(at: indexPath)
        
        rect.origin.y -= cartTableView.contentOffset.y
        var headRect = icon.frame
        headRect.origin.y = rect.origin.y + headRect.origin.y - 64
        startAnimation(headRect, iconView: icon)
    }
}

extension BasketChoosedViewController  {
    fileprivate func startAnimation(_ rect: CGRect ,iconView:UIImageView) {
        if layer == nil {
            layer = CALayer()
            layer?.contents = iconView.layer.contents
            layer?.contentsGravity = CALayerContentsGravity.resizeAspectFill
            layer?.bounds = rect
            layer?.cornerRadius = layer!.bounds.height * 0.5
            layer?.masksToBounds = true
            layer?.position = CGPoint(x: iconView.center.x, y: rect.maxY)
            UIApplication.shared.keyWindow?.layer.addSublayer(layer!)
            path = UIBezierPath()
            path?.move(to: layer!.position)
            path?.addQuadCurve(to: CGPoint(x: screenSize.width - 25, y: 35), controlPoint: CGPoint(x: screenSize.width * 0.5, y: 80))
        }
        
        groupAnimation()
    }
    
    fileprivate func groupAnimation() {
        cartTableView.isUserInteractionEnabled = false
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path!.cgPath
        animation.rotationMode = CAAnimationRotationMode.rotateAuto
        
        let bigAnimation = CABasicAnimation(keyPath: "transform.scale")
        bigAnimation.duration = 0.5
        bigAnimation.fromValue = 1
        bigAnimation.toValue = 2
        bigAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        let smallAnimation = CABasicAnimation(keyPath: "transform.scale")
        smallAnimation.beginTime = 0.5
        smallAnimation.duration = 1.5
        smallAnimation.fromValue = 2
        smallAnimation.toValue = 0.3
        smallAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation, bigAnimation, smallAnimation]
        groupAnimation.duration = 2
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = CAMediaTimingFillMode.forwards
        groupAnimation.delegate = self ;
        layer?.add(groupAnimation, forKey: "groupAnimation")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if anim == layer?.animation(forKey: "groupAnimation") {
            cartTableView.isUserInteractionEnabled = true
            layer?.removeAllAnimations()
            layer?.removeFromSuperlayer()
            layer = nil
            if self.addGoodArray.count > 0 {
                amontCart.isHidden = false
            }
            
            let goodCountAnimation = CATransition()
            goodCountAnimation.duration = 0.25
            amontCart.text = "\(self.addGoodArray.count)"
            amontCart.layer.add(goodCountAnimation, forKey: nil)
            let cartAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            cartAnimation.duration = 0.25
            cartAnimation.fromValue = -5
            cartAnimation.toValue = 5
            cartAnimation.autoreverses = true
            cartBtn.layer.add(cartAnimation, forKey: nil)
        }
    }
}

