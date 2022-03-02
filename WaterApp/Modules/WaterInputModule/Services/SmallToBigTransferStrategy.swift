//
//  SmallToBigTransferStrategy.swift
//  WaterApp
//
//  Created by 18745092 on 02.03.2022.
//

import Foundation

final class SmallToBigTransferStrategy: WaterTransferStrategy {
    func transferToReachCapacity(firstContainer: WaterContainer, secondContainer: WaterContainer, capacity: Int) -> [WaterTransferResult] {
        let smallContainer = firstContainer.capacity < secondContainer.capacity ? firstContainer : secondContainer
        let bigContainer = firstContainer.capacity < secondContainer.capacity ? secondContainer : firstContainer
        
        let numberOfTransfersNeeded = capacity / firstContainer.capacity
        
        var result: [WaterTransferResult] = []
        result.append(smallContainer.fill())
        
        for index in 0..<numberOfTransfersNeeded {
            result.append(smallContainer.transferTo(bigContainer))
            
            if index != numberOfTransfersNeeded - 1 {
                result.append(smallContainer.fill())
            }
        }
        
        return result
    }
}
