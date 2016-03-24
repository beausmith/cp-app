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

    // Set Nav Bar to use the light theme
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        // set label Attribute
        pieChartView.noDataText = "You need to provide data for the chart."
        pieChartView.noDataTextDescription = "GIVE REASON"
        pieChartView.descriptionText = ""
        pieChartView.drawHoleEnabled = true
        pieChartView.holeColor = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1)


        //pieChartView.centerText = "TODAY"
        //pieChartView.usePercentValuesEnabled = true

        pieChartView.legend.enabled = false

        pieChartView.backgroundColor = UIColor.clearColor()

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

    }

    func setChart(dataPoints: [String], values: [Double]) {

        var dataEntries: [ChartDataEntry] = []
        let colors: [UIColor] = [
            UIColor(red: 10/255, green: 79/255, blue: 179/255, alpha: 1),
            UIColor(red: 18/255, green: 186/255, blue: 161/255, alpha: 1),
            UIColor(red: 19/255, green: 18/255, blue: 216/255, alpha: 1),
            UIColor(red: 237/255, green: 81/255, blue: 7/255, alpha: 1),
        ]

        for i in 0..<dataPoints.count {

            // map times to tasks
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)

            // adjust hue based upon number of tasks
//            let hue = CGFloat(i+1)/CGFloat(dataPoints.count)
            //let color = colors[i]

//            colors.append(color)
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
