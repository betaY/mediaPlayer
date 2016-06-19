//
//  ViewController.swift
//  MediaPlayer
//
//  Created by Beta on 16/6/12.
//  Copyright © 2016年 Beta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    
//    var songs = ["EGOIST - 名前のない怪物", "EGOIST - 想いを巡らす100の事象", "EGOIST - All Alone With You", "EGOIST - Departures〜あなたにおくるアイの歌〜", "EGOIST - Euterpe"]
    var songs = [String]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fm = NSFileManager.defaultManager()
        let path = NSBundle.mainBundle().resourcePath!
        let items = try! fm.contentsOfDirectoryAtPath(path+"/Egoist")
        for item in items {
//            let name = String(item.characters.dropLast(4))
            songs.append(String(item.characters.dropLast(4)))
//            songs.append(item)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toMediaPlayerViewController", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMediaPlayerViewController" {
            let VC = segue.destinationViewController as UIViewController
            let indexPath: NSIndexPath = table.indexPathForSelectedRow!
            
            VC.title = songs[indexPath.row]
        }
    }
}

