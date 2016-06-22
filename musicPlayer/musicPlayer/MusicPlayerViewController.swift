//
//  MusicPlayerViewController.swift
//  musicPlayer
//
//  Created by Beta on 16/6/22.
//  Copyright © 2016年 Beta. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicPlayerViewController: UIViewController, MPMediaPickerControllerDelegate{

    var myMusicPlayer: MPMusicPlayerController?
    let player = MPMusicPlayerController.systemMusicPlayer()
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(player.nowPlayingItem?.albumTitle)
        imageView.image = player.nowPlayingItem?.artwork?.imageWithSize(imageView.frame.size)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
