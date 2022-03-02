//
//  WaterTransferStrategy.swift
//  WaterApp
//
//  Created by 18745092 on 02.03.2022.
//

import Foundation

protocol WaterTransferStrategy: AnyObject {
    func transferToReachCapacity(firstContainer: WaterContainer, secondContainer: WaterContainer, capacity: Int) -> [WaterTransferResult]
}
