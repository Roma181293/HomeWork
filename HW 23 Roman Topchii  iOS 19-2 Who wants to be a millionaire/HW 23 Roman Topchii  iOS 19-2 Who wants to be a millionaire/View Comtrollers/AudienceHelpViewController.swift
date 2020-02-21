//
//  AudienceHelpViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 21.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import SwiftCharts

class AudienceHelpViewController: UIViewController {
    
    var audienceVotes : (first : Double, second : Double, third : Double, fourth : Double)?
    
    
    var chartView : BarsChart!
    
    @IBOutlet weak var barView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(#function)
        if let votes = self.audienceVotes{
            self.showChart(data : votes)
        }
    }
    
    
    func showChart(data : (first : Double, second : Double, third : Double, fourth : Double)) {
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 60, by: 10)
        )
        
        let frame = CGRect(x: 0, y: 40, width: 350, height: 350)
        
        
        let chart = BarsChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "",
            yTitle: "",
            bars: [
                ("A", data.first * 100),
                ("B", data.second * 100),
                ("C", data.third * 100),
                ("D", data.fourth * 100)
            ],
            color: UIColor(red: 54.0/255.0, green: 41.0/255.0, blue: 67.0/255.0, alpha: 1.0),
            barWidth: 20
        )
        
        self.barView.addSubview(chart.view)
        self.chartView = chart
    }
}
