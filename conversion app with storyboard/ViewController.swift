//
//  ViewController.swift
//  conversion app with storyboard
//
//  Created by Jonathan Nguyen on 2/22/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var calculator_input: UILabel!
    
    @IBOutlet weak var calculator_output: UILabel!
    
    var workings:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clear()
    }
    
    func clear() {
        
        workings = ""
        calculator_input.text = ""
        calculator_output.text = ""
        
    }
    
    @IBAction func clear_button(_ sender: Any) {
        clear()
    }

    @IBAction func delete_button(_ sender: Any) {
        if (!workings.isEmpty)
        {
            workings.removeLast()
            calculator_input.text = workings
        }
    }
    
    
    @IBAction func swap_button(_ sender: Any) {
    }
    
    func add_to_workings(value: String) {
        workings = workings + value
        calculator_input.text = workings
    }
    
    let operators = ["/", "*", "-", "+"]
    
    @IBAction func divide_button(_ sender: Any) {
        if (!operators.contains(String(workings.last!)) && !workings.isEmpty) {
            add_to_workings(value: "/")
        }
    }
    
    @IBAction func seven_button(_ sender: Any) {
        add_to_workings(value: "7")
    }
    
    
    @IBAction func eight_button(_ sender: Any) {
        add_to_workings(value: "8")
    }
    
    @IBAction func nine_button(_ sender: Any) {
        add_to_workings(value: "9")
    }
    
    @IBAction func mutiply_button(_ sender: Any) {
        if (!operators.contains(String(workings.last!)) && !workings.isEmpty) {
            add_to_workings(value: "*")
        }
    }
    
    @IBAction func four_button(_ sender: Any) {
        add_to_workings(value: "4")
    }
    
    @IBAction func five_button(_ sender: Any) {
        add_to_workings(value: "5")
    }
    
    @IBAction func six_button(_ sender: Any) {
        add_to_workings(value: "6")
    }
    
    @IBAction func minus_button(_ sender: Any) {
        if (!operators.contains(String(workings.last!)) && !workings.isEmpty) {
            add_to_workings(value: "-")
        }
    }
    
    @IBAction func one_button(_ sender: Any) {
        add_to_workings(value: "1")
    }
    
    @IBAction func two_button(_ sender: Any) {
        add_to_workings(value: "2")
    }
    
    @IBAction func three_button(_ sender: Any) {
        add_to_workings(value: "3")
    }
    
    @IBAction func addition_button(_ sender: Any) {
        if (!operators.contains(String(workings.last!)) && !workings.isEmpty) {
            add_to_workings(value: "+")
        }
    }
    
    @IBAction func decimal_button(_ sender: Any) {
        if (!workings.contains(".")) {
            add_to_workings(value: ".")
        }
    }
    
    @IBAction func zero_button(_ sender: Any) {
        add_to_workings(value: "0")
    }
    
    @IBAction func equal_button(_ sender: Any) {
        if (!workings.isEmpty && !operators.contains(String(workings.last!))) {
            let expression = NSExpression(format: workings)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let final_result = format_value(value: result)
            workings = final_result
            calculator_input.text = final_result
        }
        else if (operators.contains(String(workings.last!))) {
            workings = String(workings.dropLast())
            let expression = NSExpression(format: workings)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let final_result = format_value(value: result)
            workings = final_result
            calculator_input.text = final_result
        }
        
    }
    
    func format_value(value: Double) -> String {
        if (value.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", value)
        }
        else {
            return String(format: "%.2f", value)
        }
    }
}

