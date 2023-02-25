//
//  Constants.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import UIKit

class BasketChoosedModel: NSObject {
    
    var alreadyAddShoppingCArt :Bool = false
    
    var iconName : String?
    
    var title : String?
    
    var desc : String?
    
    var count: Int = 1
    
    var newPrice : String?
    
    var oldPrice : String?
    
    var selected: Bool = true

override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}

