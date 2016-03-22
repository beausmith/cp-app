//
//  Event.swift
//  now
//
//  Created by Jess Lam on 3/20/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import Foundation

// Create Task Object
class Event : NSObject {
    var taskID :  String
    var startTime : Int
    var endTime : Int

    init(
        taskID tid : String,
        startTime st : Int,
        endTime et : Int
    ) {
        taskID = tid
        startTime = st
        endTime = et
    }

    // Retrieve value from NS User defaults
    init(withCoder coder : NSCoder) {
        taskID = coder.decodeObjectForKey("taskID") as! String
        startTime = coder.decodeObjectForKey("startTime") as! Int
        endTime = coder.decodeObjectForKey("endTime") as! Int
    }

    // Append values to NS User defaults
    func encodeWithCoder(coder : NSCoder) {
        coder.encodeObject(taskID, forKey: "taskID")
        coder.encodeObject(startTime, forKey: "startTime")
        coder.encodeObject(endTime, forKey: "endTime")
    }

}
