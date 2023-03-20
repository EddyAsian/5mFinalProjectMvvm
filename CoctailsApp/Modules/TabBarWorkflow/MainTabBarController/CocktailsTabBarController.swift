//
//  CocktailsAppTabBarController.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit

class CocktailsTabBarController: UITabBarController {
    
    class var identifier: String { String(describing: self) }
    
    private func createControllers(
        from baseVC: UIViewController,
        image: UIImage?
    ) -> UIViewController {
        let itemVC = UINavigationController(rootViewController: baseVC)
        itemVC.tabBarItem.title = title
        itemVC.tabBarItem.image = image
        return itemVC
    }
    
    private func generateItemIcon(from icon: UIImage) -> UIImage {
        icon.resizeImage(to: CGSize(width: 40, height: 40))
    }
    
    private let itemIcons: [UIImage] = [
        UIImage(systemName: "person.circle") ?? UIImage(),
        UIImage(systemName: "house.circle") ?? UIImage(),
        UIImage(systemName: "square.and.arrow.up.circle") ?? UIImage(),
        UIImage(systemName: "heart.circle") ?? UIImage(),
        UIImage(systemName: "cart.circle") ?? UIImage()
    ]
    
    private func setupVC() {
        viewControllers =
        [
            createControllers(
                from: EditProfileVC(),
                image: generateItemIcon(from: itemIcons[0])
            ),
            
            createControllers(
                from: CocktailsMenuViewController(viewModelFactory: DefaultCocktailsMenuViewModelFactory()),
                    image: generateItemIcon(from: itemIcons[1])
            ),
            
            createControllers(
                from: AddDrinkViewController(),
                image: generateItemIcon(from: itemIcons[2])
            ),
            
            createControllers(
                from: FavouriteDrinksViewController(),
                image: generateItemIcon(from: itemIcons[3])
            ),
            
            createControllers(
                from: BasketChoosedViewController(),
                image: generateItemIcon(from: itemIcons[4])
            )
        ]
    }
    
    private func setTabBarAppearance () {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 10
        tabBar.layer.preferredFrameSize()
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + 10
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX,
                                y: tabBar.bounds.minY - positionOnY,
                                width: width,
                                height: height),
            cornerRadius: height / 2
        )
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = ColorConstants.mainWhite.cgColor
        tabBar.tintColor = ColorConstants.tabBarItemAccent
        tabBar.unselectedItemTintColor = ColorConstants.tabBarItemLight
    }
    
    override func loadView() {
        super.loadView()
        setTabBarAppearance()
        setupVC()
    }
}
