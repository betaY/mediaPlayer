//
//  ViewController.swift
//  musicPlayer
//
//  Created by Beta on 16/6/21.
//  Copyright © 2016年 Beta. All rights reserved.
//

import UIKit
//import AVFoundation
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    
    var musicPlayer: MPMediaPickerController?
    
    @IBOutlet var table: UITableView!
    
//    var song = ["EGOIST - 名前のない怪物", "EGOIST - 想いを巡らす100の事象", "EGOIST - All Alone With You", "EGOIST - Departures〜あなたにおくるアイの歌〜", "EGOIST - Euterpe"]
    var songs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let mediaItems = MPMediaQuery.songsQuery().items
        print(mediaItems)
//        let mediaCollection = MPMediaItemCollection(items: mediaItems!)
//        let player = MPMusicPlayerController.iPodMusicPlayer()
//        player.setQueueWithItemCollection(mediaCollection)
//        player.play()
        for items in mediaItems! {
            print(items.valueForProperty(MPMediaItemPropertyTitle))
            songs.append(items.valueForProperty(MPMediaItemPropertyTitle) as! String)
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
//        print(songs.count)
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        print(indexPath.row)
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toMusicPlayerViewController", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMusicPlayerViewController" {
            let vc = segue.destinationViewController as UIViewController
            let indexPath: NSIndexPath =  table.indexPathForSelectedRow!
            vc.title = songs[indexPath.row]
            
            let mediaItems = MPMediaQuery.songsQuery().items
            let mediaCollection = MPMediaItemCollection(items: mediaItems!)
//            let player = MPMusicPlayerController.systemMusicPlayer()
//            player.setQueueWithItemCollection(mediaCollection)
//            var query = MPMediaQuery.songsQuery()
            let player = MPMusicPlayerController.systemMusicPlayer()
            player.nowPlayingItem = mediaCollection.items[indexPath.row]
            player.play()
        }
    }

}

