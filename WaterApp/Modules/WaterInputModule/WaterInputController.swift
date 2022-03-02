//
//  WaterInputController.swift
//  WaterApp
//
//  Created by 18745092 on 01.03.2022.
//

import UIKit

protocol IWaterInputController: AnyObject {
    func calculateWater(xValueStr: String, yValueStr: String, neededCapacityStr: String)
}

final class WaterInputController: IWaterInputController {
    weak var view: IWaterInputView?
    let strategyProvider: IWaterStrategyProviderInterface
    private var resultsTableController: ResultsTableController?
    
    init(strategyProvider: IWaterStrategyProviderInterface) {
        self.strategyProvider = strategyProvider
    }
    
    private func validateInputs(xValueStr: String, yValueStr: String, neededCapacityStr: String) {
        guard
            let xValue = Int(xValueStr),
            let yValue = Int(yValueStr),
            let neededCapacityValue = Int(neededCapacityStr),
            xValue != yValue,
            xValue > 0,
            yValue > 0,
            neededCapacityValue > 0
        else {
            view?.displayAlertWithTitle("Error", description: "X != Y, X and Y must be Int values, needed water must be Int value. X, Y, Z > 0")
            return
        }
    }
    
    func calculateWater(xValueStr: String, yValueStr: String, neededCapacityStr: String) {
        guard
            let xValue = Int(xValueStr),
            let yValue = Int(yValueStr),
            let neededCapacityValue = Int(neededCapacityStr)
        else {
            return
        }
        
        validateInputs(xValueStr: xValueStr, yValueStr: yValueStr, neededCapacityStr: neededCapacityStr)
        
        let firstContainer = WaterContainer.init(capacity: xValue, name: "bucket X")
        let secondContainer = WaterContainer.init(capacity: yValue, name: "bucket Y")
        
        guard let strategy = strategyProvider.getStrategyToReachCapacity(neededCapacityValue, firstContainer: firstContainer, secondContainer: secondContainer) else {
            
            view?.displayAlertWithTitle("Error", description: "This task can't be solved. Try other values")
            return
        }
        
        let results = strategy.transferToReachCapacity(firstContainer: firstContainer, secondContainer: secondContainer, capacity: neededCapacityValue)
        resultsTableController = .init(results: results)
        
        self.view?.displayResultsWithDataSource(resultsTableController)
        self.view?.displayAlertWithTitle("Solved", description: "Task successfully solved. \(results.count) steps needed")
    }
}
