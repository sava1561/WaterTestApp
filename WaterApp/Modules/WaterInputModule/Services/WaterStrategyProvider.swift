//
//  WaterStrategyProvider.swift
//  WaterApp
//
//  Created by 18745092 on 02.03.2022.
//

import Foundation

protocol IWaterStrategyProviderInterface: AnyObject {
    func getStrategyToReachCapacity(_ capacity: Int, firstContainer: WaterContainer, secondContainer: WaterContainer) -> WaterTransferStrategy?
}

/**
 We have 4 cases of situations
 1. When first is smaller then needed capacity and the capacity is multiple of firstContainer. (2 10 4) (2 100 96)
 2. When first is smaller then needed capacity and not a multiple.(3 10 7) (3 11 7)
 3. When first is bigger then needed capacity and is multiple. (8 180 4) (8 10 2)
 4. When first is bigger and not a multiple. (11 110 9) (11 119 9)
 */
final class WaterStrategyProvider: IWaterStrategyProviderInterface {
    func getStrategyToReachCapacity(_ capacity: Int, firstContainer: WaterContainer, secondContainer: WaterContainer) -> WaterTransferStrategy? {
        let smallContainer = firstContainer.capacity < secondContainer.capacity ? firstContainer : secondContainer
        let bigContainer = firstContainer.capacity < secondContainer.capacity ? secondContainer : firstContainer
        
        guard bigContainer.capacity > capacity else { return nil }
      
        /**
         These conditions can be combined in a smaller number of 'if' but it is better for understanding when they are separated
         */
        if smallContainer.capacity < capacity && capacity % smallContainer.capacity == 0 {
            if bigContainer.capacity % smallContainer.capacity == 0 {
                let numberOfTransfersFromSmallToBig = capacity / smallContainer.capacity
                let numberOfTransferFromBigToSmall = (bigContainer.capacity - capacity) / smallContainer.capacity
                
                return numberOfTransferFromBigToSmall < numberOfTransfersFromSmallToBig ? BigToSmallTransferStrategy() : SmallToBigTransferStrategy()
            } else {
                return SmallToBigTransferStrategy()
            }
        } else if smallContainer.capacity < capacity {
            if (bigContainer.capacity - smallContainer.capacity) % capacity == 0 {
                return BigToSmallTransferStrategy()
            } else {
                return nil
            }
        } else if smallContainer.capacity > capacity && smallContainer.capacity % capacity == 0 {
            if (bigContainer.capacity - smallContainer.capacity) % capacity == 0 {
                return BigToSmallTransferStrategy()
            } else {
                return nil
            }
        } else if (bigContainer.capacity - capacity) % smallContainer.capacity == 0 {
            return BigToSmallTransferStrategy()
        }
        
        
        return nil
    }
}
