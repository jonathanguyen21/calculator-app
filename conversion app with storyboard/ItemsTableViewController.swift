//
//  ItemsTableViewController.swift
//  conversion app with storyboard
//
//  Created by Jonathan Nguyen on 5/10/23.
//

import Foundation
import UIKit

protocol ItemsTableViewControllerDelegate {
    func itemsTableViewControllerDidSelect(item: String, num: Int)
}

class ItemsTableViewController: UITableViewController {
    var num: Int
    
    init(num: Int) {
        self.num = num
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // let items = Range(0...20).map { "\($0)" }
    let countries = ["AUD",
                     "BGN",
                     "BRL",
                     "CAD",
                     "CHF",
                     "CNY",
                     "CZK",
                     "DKK",
                     "EUR",
                     "GBP",
                     "HKD",
                     "HRK",
                     "HUF",
                     "IDR",
                     "ILS",
                     "INR",
                     "ISK",
                     "JPY",
                     "KRW",
                     "MXN",
                     "MYR",
                     "NOK",
                     "NZD",
                     "PHP",
                     "PLN",
                     "RON",
                     "RUB",
                     "SEK",
                     "SGD",
                     "THB",
                     "TRY",
                     "USD",
                     "ZAR"]
    var delegate: ItemsTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.view.backgroundColor = UIColor.lightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = countries[indexPath.row]
        if let delegate = delegate {
            delegate.itemsTableViewControllerDidSelect(item: item, num: num)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(countries[indexPath.row])"
        cell.contentConfiguration = content
        return cell
    }
    
    func isModal() -> Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
}
