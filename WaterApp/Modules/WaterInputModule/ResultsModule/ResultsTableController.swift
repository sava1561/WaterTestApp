//
//  ResultsTableController.swift
//  WaterApp
//
//  Created by 18745092 on 02.03.2022.
//

import Foundation
import UIKit

final class ResultsTableController: NSObject, UITableViewDataSource {
    private let results: [WaterTransferResult]
    private let cellId = "defaultCell"
    
    init(results: [WaterTransferResult]) {
        self.results = results
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? .init(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = results[indexPath.row].actionName
        cell.detailTextLabel?.text = results[indexPath.row].actionDescription
        
        return cell
    }
}
