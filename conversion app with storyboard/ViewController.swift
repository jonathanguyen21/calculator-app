//
//  ViewController.swift
//  conversion app with storyboard
//
//  Created by Jonathan Nguyen on 2/22/23.
//

import UIKit
import Foundation

extension String {
    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
}

struct Response: Codable {
    let data: MyResult
}

struct MyResult: Codable {
    let AUD: Double
    let BGN: Double
    let BRL: Double
    let CAD: Double
    let CHF: Double
    let CNY: Double
    let CZK: Double
    let DKK: Double
    let EUR: Double
    let GBP: Double
    let HKD: Double
    let HRK: Double
    let HUF: Double
    let IDR: Double
    let ILS: Double
    let INR: Double
    let ISK: Double
    let JPY: Double
    let KRW: Double
    let MXN: Double
    let MYR: Double
    let NOK: Double
    let NZD: Double
    let PHP: Double
    let PLN: Double
    let RON: Double
    let RUB: Double
    let SEK: Double
    let SGD: Double
    let THB: Double
    let TRY: Double
    let USD: Double
    let ZAR: Double
}

class ViewController: UIViewController {

    
    @IBOutlet weak var calculator_input: UILabel!
    
    @IBOutlet weak var calculator_output: UILabel!
    
    var workings:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Loading API and getting values
        let url = "https://api.freecurrencyapi.com/v1/latest?apikey=tcPxuKBrEc5u6hyPql8RrXVfSDfFQvmCbHPAYhzQ"
        getData(from: url)
        
        // Sets up variables to hold values
        clear()
    }
    
    // Uses api and loads data into variables
    private func getData(from url: String) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            // have data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("failed to convert")
                print(error)
            }
            
            guard let json = result else {
                return
            }
            
            print(json.data.USD)
            print(json.data.CAD)
            print(json.data.BGN)
        })
            
        task.resume()
        
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
        if (workings.isEmpty == false && !operators.contains(String(workings.last!))) {
            if (contains_operators(value: workings) != "false") {
                equal_button(self)
                add_to_workings(value: "/")
            }
            else {
                add_to_workings(value: "/")
            }
        }
        else if (workings.isEmpty == false && operators.contains(String(workings.last!))) {
            if (String(workings.last!).numberOfOccurrencesOf(string: ".") > 0) {
                equal_button(self)
                add_to_workings(value: "+")
                return
            }
            delete_button(self)
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
        if (workings.isEmpty == false && !operators.contains(String(workings.last!))) {
            if (contains_operators(value: workings) != "false") {
                equal_button(self)
                add_to_workings(value: "*")
            }
            else {
                add_to_workings(value: "*")
            }
        }
        else if (workings.isEmpty == false && operators.contains(String(workings.last!))) {
            if (String(workings.last!).numberOfOccurrencesOf(string: ".") > 0) {
                equal_button(self)
                add_to_workings(value: "*")
                return
            }
            delete_button(self)
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
        if (workings.isEmpty == false && !operators.contains(String(workings.last!))) {
            if (contains_operators(value: workings) != "false") {
                equal_button(self)
                add_to_workings(value: "-")
            }
            else {
                add_to_workings(value: "-")
            }
        }
        else if (workings.isEmpty == false && operators.contains(String(workings.last!))) {
            if (String(workings.last!).numberOfOccurrencesOf(string: ".") > 0) {
                equal_button(self)
                add_to_workings(value: "-")
                return
            }
            delete_button(self)
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
        if (workings.isEmpty == false && !operators.contains(String(workings.last!))) {
            if (contains_operators(value: workings) != "false") {
                equal_button(self)
                add_to_workings(value: "+")
            }
            else {
                add_to_workings(value: "+")
            }
        }
        else if (workings.isEmpty == false && operators.contains(String(workings.last!))) {
            if (String(workings.last!).numberOfOccurrencesOf(string: ".") > 0) {
                equal_button(self)
                add_to_workings(value: "+")
                return
            }
            delete_button(self)
            add_to_workings(value: "+")
        }
    }
    
    //Checks if a string contains any operators
    // Returns operator if it contains it, the string "false" otherwise
    func contains_operators(value: String) -> String {
        if (value.contains(String("+"))) {
            return "+"
        }
        else if (value.contains(String("-"))) {
            return "-"
        }
        else if (value.contains(String("*"))) {
            return "*"
        }
        else if (value.contains(String("/"))) {
            return "/"
        }
        return "false"
    }
    
    @IBAction func decimal_button(_ sender: Any) {
        let contains_operator = contains_operators(value: workings)
        if (!workings.contains(".")) {
            add_to_workings(value: ".")
        }
        else if (contains_operator != "false") {
            
            // Splits equation into two from the operator
            // then checks if second half of equation contains a "."
            // if not it adds one decimal to it
            let separated_equation = workings.components(separatedBy: contains_operator)
            if (separated_equation[1].numberOfOccurrencesOf(string: ".") == 0) {
                add_to_workings(value: ".")
            }
        }
    }
    
    @IBAction func zero_button(_ sender: Any) {
        add_to_workings(value: "0")
    }
    
    @IBAction func equal_button(_ sender: Any) {
        if (!workings.isEmpty) {
            
            // if operator is at end of string remove it
            if (operators.contains(String(workings.last!))) {
                workings = String(workings.dropLast())
            }
            
            // if division do floating point
            if (workings.contains("/") && !workings.contains(".")) {
                workings.insert(contentsOf: ".0", at: workings.range(of: "/")!.lowerBound)
                let expression = NSExpression(format: workings)
                let result = expression.expressionValue(with: nil, context: nil) as! Double
                let final_result = format_value(value: result)
                workings = final_result
                calculator_input.text = final_result
                calculator_output.text = final_result
            }
            else {
                // if . is at end of string add 0 to finish calculation
                if (String(workings.last!) == ".") {
                    let contains_operator = contains_operators(value: workings)
                    if (contains_operator == "/" || contains_operator == "*") {
                        let tok = workings.components(separatedBy: contains_operator)
                        if (tok[1] == ".") {
                            workings = String(workings.dropLast())
                            workings = String(workings.dropLast())
                        }
                    }
                    else {
                        workings += "0"
                    }
                }
                let expression = NSExpression(format: workings)
                let result = expression.expressionValue(with: nil, context: nil) as! Double
                let final_result = format_value(value: result)
                workings = final_result
                calculator_input.text = final_result
                calculator_output.text = final_result
            }
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

