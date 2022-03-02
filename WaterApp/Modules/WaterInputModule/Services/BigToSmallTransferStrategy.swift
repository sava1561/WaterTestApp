//
//  BigToSmallTransferStrategy.swift
//  WaterApp
//
//  Created by 18745092 on 02.03.2022.
//

import Foundation

final class BigToSmallTransferStrategy: WaterTransferStrategy {
    func transferToReachCapacity(firstContainer: WaterContainer, secondContainer: WaterContainer, capacity: Int) -> [WaterTransferResult] {
        let smallContainer = firstContainer.capacity < secondContainer.capacity ? firstContainer : secondContainer
        let bigContainer = firstContainer.capacity < secondContainer.capacity ? secondContainer : firstContainer
        
        let numberOfTransfersNeeded = (bigContainer.capacity - capacity) / smallContainer.capacity
        
        var result: [WaterTransferResult] = []
        result.append(bigContainer.fill())
        
        for index in 0..<numberOfTransfersNeeded {
            result.append(bigContainer.transferTo(smallContainer))
            
            if index != numberOfTransfersNeeded - 1 {
                result.append(smallContainer.empty())
            }
        }
        
        return result
    }
}
