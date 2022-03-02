//
//  WaterTransferResult.swift
//  WaterApp
//
//  Created by 18745092 on 02.03.2022.
//

import Foundation

enum WaterTransferResult {
    case empty(container: WaterContainerState)
    case transfer(fromContainer: WaterContainerState, toContainer: WaterContainerState)
    case fill(container: WaterContainerState)
    
    var actionDescription: String {
        switch self {
        case .empty(let container):
            return "\(container.name) - \(container.litres) litres remain"
        case .transfer(let fromContainer, let toContainer):
            return "\(fromContainer.name) -> \(toContainer.name), litres(now): \(fromContainer.litres) litres - \(toContainer.litres) litres"
        case .fill(let container):
            return "\(container.name) - \(container.litres) litres"
        }
    }
    
    var actionName: String {
        switch self {
        case .empty(_):
            return "Empty"
        case .transfer(_, _):
            return "Transfer"
        case .fill(_):
            return "Fill"
        }
    }
}
