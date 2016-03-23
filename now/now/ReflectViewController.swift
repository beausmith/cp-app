//
//  ReflectViewController.swift
//  now
//
//  Created by Beau Smith on 3/19/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit
import Charts

class ReflectViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var pieChartView: PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        pieChartView.noDataText = "You need to provide data for the chart."
        pieChartView.noDataTextDescription = "GIVE REASON"
        pieChartView.descriptionText = ""
        pieChartView.drawHoleEnabled = true
        pieChartView.centerText = "March 23"
        //pieChartView.usePercentValuesEnabled = true
        pieChartView.legend.enabled = false

        var taskNames = [String]()
        var taskTimes = [Double]()

        if tasks.count > 0 {
            for task in tasks {
                if task.completed == true {
                    taskNames.append(task.taskName)
                    taskTimes.append(Double(task.time))
                }
            }
        }

        setChart(taskNames, values: taskTimes)
        
        if (self.isViewLoaded() && self.view.window != nil) {
            print("helo")
        } else {
            print("Noe")
        }
    }
    

    func setChart(dataPoints: [String], values: [Double]) {

        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = []

        for i in 0..<dataPoints.count {

            // map times to tasks
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)

            // adjust hue based upon number of tasks
            let hue = CGFloat(i+1)/CGFloat(dataPoints.count)
            let color = UIColor(hue: hue, saturation: 0.6, brightness: 0.75, alpha: 1.0)

            colors.append(color)
        }

        // create dataset to
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Completed Tasks")
        pieChartDataSet.colors = colors
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)

        pieChartView.data = pieChartData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
