//
//  CoctailsAppTabBarController.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit

class CoctailsAppTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        setupVC()
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
                               width: width, height: height),
            cornerRadius: height / 2
        )
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
    
    private func setupVC() {
        viewControllers =
        [
            createControllers(for: ProfileViewController(),
                              title: "Profile",
                              image: UIImage(systemName: "person.circle")!),
            createControllers(for: CoctailsMenuViewController(),
                              title: "",
                              image: UIImage(systemName: "house.circle")!),
            createControllers(for: CoctailsMenuViewController(),
                              title: "",
                              image: UIImage(systemName: "trash.circle")!)
        ]
    }
    
    private func createControllers(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.image = image
        return navVC
    }
}

