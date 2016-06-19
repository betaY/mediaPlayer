//
//  MediaPlayerViewController.swift
//  MediaPlayer
//
//  Created by Beta on 16/6/12.
//  Copyright © 2016年 Beta. All rights reserved.
//

import UIKit
import AVFoundation

class MediaPlayerViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
//    var player: AVAudioPlayer = AVAudioPlayer()
    var player: AVAudioPlayer?
    
    @IBAction func pauseButton(sender: UIBarButtonItem) {
        player!.pause()
    }
    @IBAction func playButton(sender: UIBarButtonItem) {
        player!.play()
    }
    @IBAction func stopButton(sender: UIBarButtonItem) {
        player!.stop()
    }
    
    @IBOutlet var slider: UISlider!
    
    @IBAction func sliderController(sender: UISlider) {
        
        player!.volume = slider.value
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Egoist = NSBundle.init(path: NSBundle.mainBundle().resourcePath!+"/Egoist")
        let egoisturl = Egoist?.URLForResource(self.navigationItem.title!, withExtension: "mp3")
        // init AVURLAsset
        let mp3Asset = AVURLAsset(URL: egoisturl!, options: nil)
        
        for item in mp3Asset.availableMetadataFormats {
            for metadata in mp3Asset.metadataForFormat(item) {
                if let commonkey = metadata.commonKey {
                    if commonkey == "title" {
                        print(metadata.value)
                    }
                    if commonkey == "artist" {
                        print(metadata.value)
                    }
                    if commonkey == "artwork" {
                        print(metadata.value)
                        if let data  = metadata.dataValue {
                            let image = UIImage(data: data)
                            imageView.image = image
                        }
                    }
                }
            }
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        var path = NSBundle.mainBundle().resourcePath!
        
        let test = path+"/"+self.navigationItem.title!+".mp3"
        
        path = path+"/Egoist/"+self.navigationItem.title!+".mp3"
        
        let testurl = NSURL.fileURLWithPath(test)
        let pathurl = NSURL.fileURLWithPath(path)
        
        print(testurl)
        
        let Egoist = NSBundle.init(path: NSBundle.mainBundle().resourcePath!+"/Egoist")
        let egoisturl = Egoist?.URLForResource(self.navigationItem.title!, withExtension: "mp3")
        // init AVURLAsset
        let mp3Asset = AVURLAsset(URL: egoisturl!, options: nil)
        
        for item in mp3Asset.availableMetadataFormats {
            for metadata in mp3Asset.metadataForFormat(item) {
//                print(metadata)
                if let commonkey = metadata.commonKey {
                    if commonkey == "title" {
                        print(metadata.value)
                    }
                    if commonkey == "artist" {
                        print(metadata.value)
                    }
                    if commonkey == "artwork" {
                        print(metadata.value)
                        if let data  = metadata.dataValue {
                            let image = UIImage(data: data)
                        }
                    }
//                    print(metadata.value)
                }
            }
        }
        
//        print(mp3Asset)
        
//        let fileLocation = NSString(string: NSBundle.mainBundle().pathForResource(self.navigationItem.title, ofType: "mp3")!)
//        let name = String( (self.navigationItem.title)?.characters.dropLast(4))
        let url = NSBundle.mainBundle().URLForResource(self.navigationItem.title!, withExtension: "mp3")
        
        
        print(url)
        
//        player = try! AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
        do {
            player = try AVAudioPlayer(contentsOfURL: egoisturl!)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
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
