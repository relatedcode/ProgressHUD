//
//  UIViewController+Spinner.swift
//  app
//
//  Created by Prabhakar G on 11/06/24.
//  Copyright © 2024 KZ. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func showSpinner(text: String? = nil, interactionEnabled: Bool = false) {
        ProgressHUD.colorAnimation = .black
        let navbarHeight = UIApplication.shared.statusBarFrame.size.height + UINavigationController().navigationBar.frame.height
        let tabbarHeight = UITabBarController().tabBar.frame.height + 50
        ProgressHUD.animate(text, AnimationType.circleStrokeSpin, interaction: interactionEnabled, navbarHeight: navbarHeight, tabBarHeight: tabbarHeight)
    }
    
    public func dismissSpinner() {
        ProgressHUD.dismiss()
    }
}
