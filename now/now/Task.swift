//
//  Task.swift
//  now
//
//  Created by Jeremie Lim on 3/13/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import Foundation


// Create Task Object
class Task : NSObject {
    var taskName :  String
    var categoryName : String
    var time : Int
    
    init(withTaskName tn : String, categoryName cn :  String, andTime t: Int) {
        taskName = tn
        categoryName = cn
        time = t
    }
    
    // Retrieve value from NS User defaults
    init(withCoder coder : NSCoder) {
        taskName =  coder.decodeObjectForKey("taskName") as! String
        categoryName =  coder.decodeObjectForKey("categoryName") as! String
        time = coder.decodeObjectForKey("time") as! Int
    }
    
    // Append values to NS User defaults
    func encodeWithCoder(coder : NSCoder) {
        coder.encodeObject(taskName, forKey: "taskName")
        coder.encodeObject(categoryName, forKey: "categoryName")
        coder.encodeObject(time, forKey: "time")
    }
}