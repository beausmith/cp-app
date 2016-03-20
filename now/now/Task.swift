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
    var completed : Bool
    
    init(
        withTaskName tn : String,
        categoryName cn : String,
        time t: Int,
        completed c: Bool
    ) {
        taskName = tn
        categoryName = cn
        time = t
        completed = c
    }
    
    // Retrieve value from NS User defaults
    init(withCoder coder : NSCoder) {
        taskName = coder.decodeObjectForKey("taskName") as! String
        categoryName = coder.decodeObjectForKey("categoryName") as! String
        time = coder.decodeObjectForKey("time") as! Int
        completed = coder.decodeObjectForKey("completed") as! Bool
    }
    
    // Append values to NS User defaults
    func encodeWithCoder(coder : NSCoder) {
        coder.encodeObject(taskName, forKey: "taskName")
        coder.encodeObject(categoryName, forKey: "categoryName")
        coder.encodeObject(time, forKey: "time")
        coder.encodeObject(completed, forKey: "completed")
    }
}