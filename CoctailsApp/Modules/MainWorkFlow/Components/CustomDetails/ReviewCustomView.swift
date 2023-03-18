//
//  ReviewCustomView.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import Cosmos

class ReviewCustomView: UIView {
    
    lazy var borderLine: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var starRatingsView: CosmosView = {
        var view = CosmosView()
        view.rating = 3
        view.settings.totalStars = 3
        view.settings.starSize = 11
        view.settings.emptyBorderColor = .white
        view.settings.filledColor = ColorConstants.likedProductIcon
        view.settings.starMargin = 0.5
        view.settings.updateOnTouch = false
        return view
    }()
    
    lazy var userLabel: UILabel = {
        var label = UILabel()
        label.text = "User"
        label.font = UIFont(name: "Avenir Black", size: 9)
        label.textAlignment = .right
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        var label = UILabel()
        label.text = "Comment"
        label.font = UIFont(name: "Avenir Next Italic", size: 9)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateOfCommentLabel: UILabel = {
        var label = UILabel()
        label.text = "date"
        label.font = UIFont(name: "Avenir Next Italic", size: 7)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        self.addSubview(borderLine)
        self.addSubview(starRatingsView)
        self.addSubview(userLabel)
        self.addSubview(commentLabel)
        self.addSubview(dateOfCommentLabel)
    }
    
    private func setUpConstraints() {
        borderLine.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(4)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(0.5)
        }
        
        starRatingsView.snp.makeConstraints { maker in
            maker.top.equalTo(borderLine).offset(4)
            maker.left.equalToSuperview().offset(85)
        }
        
        userLabel.snp.makeConstraints { maker in
            maker.top.equalTo(starRatingsView.snp.bottom).offset(1)
            maker.left.equalTo(starRatingsView)
            maker.right.equalTo(starRatingsView.snp.right)
            maker.height.equalTo(10)
        }
        
        commentLabel.snp.makeConstraints { maker in
            maker.top.equalTo(userLabel.snp.bottom)
            maker.left.right.equalToSuperview()
        }
        
        dateOfCommentLabel.snp.makeConstraints { maker in
            maker.top.equalTo(commentLabel.snp.bottom)
            maker.left.equalTo(commentLabel)
            maker.right.equalTo(commentLabel.snp.right)
        }
    }
}
