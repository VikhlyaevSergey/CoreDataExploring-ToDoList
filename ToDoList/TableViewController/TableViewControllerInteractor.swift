//
//  TableViewControllerInteractor.swift
//  ToDoList
//
//  Created by Сергей Вихляев on 03.05.2020.
//  Copyright (c) 2020 Сергей Вихляев. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TableViewControllerBusinessLogic {
    func prepareDataAndReturnCountOfInsertRows() -> Int // probably hard
    func tableViewChangeBlockAddTask(withTitle title: String) -> ()->()
}

protocol TableViewControllerDataStore {
    var tasks: [Task] { get set }
}

class TableViewControllerInteractor: NSObject, TableViewControllerBusinessLogic, TableViewControllerDataStore {
    
    weak var presenter: TableViewControllerPresentationLogic!
    var coreDataWorker: TableViewControllerWorker?
    
    var tasks: [Task] = []
    
    // MARK: Do something
    
    override init() {
        coreDataWorker = TableViewControllerWorker()
    }
    
    func prepareDataAndReturnCountOfInsertRows() -> Int {
        coreDataWorker?.getSavedTasks(completion: { [weak self] (success, tasks, error) in
            if success {
                guard let tasks = tasks else { return }
                self?.tasks = tasks
            } else {
            
            }
        })
                
        return tasks.count
    }
    
    func tableViewChangeBlockAddTask(withTitle title: String) -> ()->() {
        return { [weak self] in
            
            self?.coreDataWorker?.addTask(withTitle: title, completion: { [weak self] (success, task, error) in
                if success {
                    guard let task = task else { return }
                    self?.tasks.insert(task, at: 0)
                } else {
                    
                }
            })
            
            
        }
    }
}


extension TableViewControllerInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier(), for: indexPath) as! TaskTableViewCell
        
        cell.configure(task: tasks[indexPath.row])
        
        return cell
    }
}
