//
//  WaterContainer.swift
//  WaterApp
//
//  Created by 18745092 on 02.03.2022.
//

import Foundation

struct WaterContainerState {
    let litres: Int
    let name: String
    
    init(waterContainer: WaterContainer) {
        self.litres = waterContainer.litres
        self.name = waterContainer.name
    }
}

final class WaterContainer {
    let capacity: Int
    let name: String
    var litres: Int = 0
    
    init(capacity: Int, name: String) {
        self.capacity = capacity
        self.name = name
    }
    
    func fill() -> WaterTransferResult {
        litres = capacity
        return .fill(container: self.getState())
    }
    
    func empty() -> WaterTransferResult {
        litres = 0
        return .empty(container: self.getState())
    }
    
    func transferTo(_ container: WaterContainer) -> WaterTransferResult {
        let diff = max(0, litres - (container.capacity - container.litres))
        container.litres = min(container.capacity, container.litres + litres)
        litres = diff
        
        return .transfer(fromContainer: self.getState(), toContainer: container.getState())
    }
    
    func getState() -> WaterContainerState {
        return .init(waterContainer: self)
    }
}
