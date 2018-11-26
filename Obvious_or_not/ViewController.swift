//
//  ViewController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 20/11/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource{
    
    var polls:[Poll] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("called rows", polls.count)
        return polls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! PollTableCell
        let pollTitle = polls[indexPath.row].title
        cell.prepareView(title: pollTitle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let vController = MyViewController()
        //vController.setLabel(label: arrayName[indexPath.row])
        
        //navigationController?.pushViewController(vController, animated: true)
        print("cell clicked!")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! PollTableCell
        print(cell)
        
    }

    //emptyDataset implementation
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "captainObvious")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let myAttrString = NSAttributedString(string: "Fetching some (seamingly) obvious polls")
        return myAttrString
    }
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView.register(PollTableCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        
        
        getArrayPolls(completionHandler: { polls in
            self.polls = polls
            self.tableView.reloadData()
            //https://github.com/dzenbot/DZNEmptyDataSet .reload
        })
        
        self.tableView.emptyDataSetSource = self;
        
        // A little trick for removing the cell separators
        self.tableView.tableFooterView = UIView();
    }
}

extension UIView {
    func addSubviewGrid(_ view: UIView, grid: [Int], collNumber: Int, rowNumber: Int){
        let xCol = CGFloat(grid[0])
        let yCol = CGFloat(grid[1])
        let widthCol = CGFloat(grid[2] - grid[0])
        let heightCol = CGFloat(grid[3] - grid[1])
        
        let xColWidth = self.frame.width / CGFloat(collNumber)
        let yColWidth = self.frame.height / CGFloat(rowNumber)
        view.frame = CGRect(x: xCol * xColWidth, y: yCol * yColWidth, width: widthCol * xColWidth, height: heightCol * yColWidth)
        self.addSubview(view)
    }
}

