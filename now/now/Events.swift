//
//  Events.swift
//  now
//
//  Created by Jess Lam on 3/20/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import Foundation

// Create Task Object
class Events : NSObject {
    var taskName :  String
    var categoryName : String
    var startTime : Int
    var endTime : Int
    var completed : Bool
    
    init(
        withTaskName tn : String,
        categoryName cn : String,
        startTime st : Int,
        endTime et : Int,
        totalTime tt : Int,
        completed c: Bool
        ) {
            taskName = tn
            categoryName = cn
            startTime = st
            endTime = et
            completed = c
}

    // Retrieve value from NS User defaults
    init(withCoder coder : NSCoder) {
        taskName = coder.decodeObjectForKey("taskName") as! String
        categoryName = coder.decodeObjectForKey("categoryName") as! String
        startTime = coder.decodeObjectForKey("time") as! Int
        endTime = coder.decodeObjectForKey("time") as! Int
        completed = coder.decodeObjectForKey("completed") as! Bool
}

    // Append values to NS User defaults
    func encodeWithCoder(coder : NSCoder) {
        coder.encodeObject(taskName, forKey: "taskName")
        coder.encodeObject(categoryName, forKey: "categoryName")
        coder.encodeObject(startTime, forKey: "time")
        coder.encodeObject(endTime, forKey: "time")
        coder.encodeObject(completed, forKey: "completed")
    }
}



