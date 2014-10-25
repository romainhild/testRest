//
//  ViewController.swift
//  testRest
//
//  Created by Romain Hild on 25/10/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {

    @IBOutlet weak var appsTableView: UITableView!
    
    var tableData = []
    var api = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.api.delegate = self
        api.searchItunesFor("Angry Birds")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        let rowData = tableData[indexPath.row] as NSDictionary
        cell.textLabel.text = rowData["trackName"] as NSString
        
        let urlString = rowData["artworkUrl60"] as NSString
        let imgURL = NSURL(string: urlString)
        
        let imgData: NSData = NSData(contentsOfURL: imgURL!)!
        cell.imageView.image = UIImage(data: imgData)
        
        cell.detailTextLabel?.text = rowData["formattedPrice"] as NSString
        
        return cell
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArr = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = resultsArr
            self.appsTableView!.reloadData()
        })
    }
    
}

