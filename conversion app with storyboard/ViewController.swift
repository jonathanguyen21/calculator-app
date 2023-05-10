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

 
class ViewController: UIViewController {
     
    @ IBOutlet weak var calculator_input: UILabel!
    @ IBOutlet weak var calculator_output: UILabel!
    
    let itemsTVC = ItemsTableViewController()
    
    lazy var label: UILabel = {
                
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 32)
            label.text = "Hello World"
            return label
            
        }()
    
    
     
    var workings:String = ""
    var data = Response(data: MyResult(AUD: 1.0, BGN: 0, BRL: 0, CAD: 0, CHF: 0, CNY: 0, CZK: 0, DKK: 0, EUR: 0, GBP: 0, HKD: 0, HRK: 0, HUF: 0, IDR: 0, ILS: 0, INR: 0, ISK: 0, JPY: 0, KRW: 0, MXN: 0, MYR: 0, NOK: 0, NZD: 0, PHP: 0, PLN: 0, RON: 0, RUB: 0, SEK: 0, SGD: 0, THB: 0, TRY: 0, USD: 1, ZAR: 0))
    var conversionsCountry = "USD"
    var convertedCountry = "USD"
    var conversion = 1.0
    
    // trying new function
    func getData() {
        let urlString = "https://api.freecurrencyapi.com/v1/latest?apikey=tcPxuKBrEc5u6hyPql8RrXVfSDfFQvmCbHPAYhzQ"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(Response.self, from: data)
                        self.data.data = decodedData.data
                        print("Data Successfully Retrieved from Conversion API!")
                    } catch {
                        print ("Error! Something went wrong")
                    }
                }
            }
        }.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Loading API and getting values
        getData()
        // Sets up variables to hold values
        clear()
        
        // Modal
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.title = "Show Sheet"
        
        let button = UIButton(configuration: config, primaryAction: UIAction() { _ in
            
            self.itemsTVC.delegate = self
            
            // show sheet
            if let sheet = self.itemsTVC.sheetPresentationController {
                // how much of screen the sheets displays on
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.largestUndimmedDetentIdentifier = .medium
            }
            self.present(self.itemsTVC, animated: true, completion: nil)
        })
        
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //stackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
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
        conversion = self.data.data.AUD
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
                // conversion part
                let expressionConversion = NSExpression(format: workings + "*" + String(conversion))
                let resultConversion = expressionConversion.expressionValue(with: nil, context: nil) as! Double
                let final_result_conversion = format_value(value: resultConversion)
                calculator_output.text = final_result_conversion
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
                // conversion part
                let expressionConversion = NSExpression(format: workings + "*" + String(conversion))
                let resultConversion = expressionConversion.expressionValue(with: nil, context: nil) as! Double
                let final_result_conversion = format_value(value: resultConversion)
                calculator_output.text = final_result_conversion
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

extension ViewController: ItemsTableViewControllerDelegate {
    func itemsTableViewControllerDidSelect(item: String) {

        if let sheet = itemsTVC.sheetPresentationController {
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .medium
            }
        }
        self.label.text = item
    }
}
