//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Сергей Вихляев on 03.05.2020.
//  Copyright © 2020 Сергей Вихляев. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(task: Task) {
        self.textLabel?.text = task.title
    }
    
}
