//
//  WaterInputAssembly.swift
//  WaterApp
//
//  Created by 18745092 on 01.03.2022.
//

import UIKit

final class WaterInputAssembly {
    static func makeWaterViewController() -> UIViewController {
        let controller = WaterInputController(strategyProvider: WaterStrategyProvider())
        let viewController = WaterInputViewController(controller: controller)
        controller.view = viewController
        
        return viewController
    }
}
