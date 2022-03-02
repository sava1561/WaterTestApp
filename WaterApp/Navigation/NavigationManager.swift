//
//  NavigationManager.swift
//  WaterApp
//
//  Created by 18745092 on 01.03.2022.
//

import UIKit

final class NavigationManager {
    private let window: UIWindow?
    private var navigationController: UINavigationController?
    
    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        guard let window = window else {
            return
        }
        
        let controller = UINavigationController()
        controller.setNavigationBarHidden(true, animated: false)
        
        navigationController = controller
        
        UIView.transition(with: window, duration: 0.2, options: .curveLinear, animations: {
            window.rootViewController = controller
        }, completion: nil)
    }
    
    func startWaterInputFlow() {
        let waterVC = WaterInputAssembly.makeWaterViewController()
        
        self.navigationController?.pushViewController(waterVC, animated: true)
    }
}
