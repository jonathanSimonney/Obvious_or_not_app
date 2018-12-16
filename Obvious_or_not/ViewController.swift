//
//  ViewController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 20/11/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import Reachability

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    var polls:[Poll] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! PollTableCell
        let pollTitle = polls[indexPath.row].title
        cell.prepareView(title: pollTitle)
        if polls[indexPath.row].hasVoted{
            cell.changeBackground(color: .green)
        }else{
            cell.changeBackground(color: .white)
        }
        
        return cell
    }
    
    func getPollController() -> PollController{
        fatalError("you should override this method in the child class!!!")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let vController = MyViewController()
        //vController.setLabel(label: arrayName[indexPath.row])
        
        //navigationController?.pushViewController(vController, animated: true)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! PollTableCell
        let pollController = self.getPollController()
        pollController.setPoll(poll: polls[indexPath.row])
                
        navigationController?.pushViewController(pollController, animated: true)
    }

    //emptyDataset implementation
    //func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
      //  return UIImage(named: "captainObvious")
    //}
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let myAttrString = NSAttributedString(string: "Fetching some (seamingly) obvious polls")
        return myAttrString
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let myAttrString = NSAttributedString(string: "I'm online, give me the polls!")
        return myAttrString
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        self.fetchPollsData()
    }
    
    var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView.register(PollTableCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshPollsData(_:)), for: .valueChanged)
        
        self.view.addSubview(self.tableView)
        
        self.fetchPollsData()
        
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self
        
        // A little trick for removing the cell separators
        self.tableView.tableFooterView = UIView();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.polls = ArchiveUtil.loadPolls()
        self.tableView.reloadData()
    }
    
    @objc private func refreshPollsData(_ sender: Any) {
        // Fetch Weather Data
        fetchPollsData()
    }

    private func fetchPollsData(){
        let reachability = Reachability()
        
        if reachability!.connection != .none{
            getArrayPolls(completionHandler: { polls in
                self.polls = polls
                
                ArchiveUtil.savePolls(polls: polls)
                
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            })
        }else{
            self.refreshControl.endRefreshing()
            AlertHelper.displaySimpleAlert(title: "connection required", message: "looks like you're currently not connected to the net. Please try again when you are to update the poll.", type: .warning)
            self.polls = ArchiveUtil.loadPolls()
            self.tableView.reloadData()
        }
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

