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
    @IBOutlet var playButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet var startTime: UILabel!
    @IBOutlet var duration: UILabel!
    
    var updater : CADisplayLink! = nil
    
    var playing = true
    
//    var player: AVAudioPlayer = AVAudioPlayer()
    var player: AVAudioPlayer?
    
//    @IBAction func pauseButton(sender: UIBarButtonItem) {
//        player!.pause()
//    }
    @IBAction func playButton(sender: UIBarButtonItem) {
        var playBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: #selector(MediaPlayerViewController.playButton(_:)))
        if playing {
            player!.pause()
            playing = false
        } else {
            player!.play()
            playBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: #selector(MediaPlayerViewController.playButton(_:)))
            playing = true
        }
        var items = toolBar.items!
        items[3] = playBtn
        toolBar.setItems(items, animated: true)
    }
    
    
    @IBAction func stopButton(sender: UIBarButtonItem) {
        player!.stop()
        player!.currentTime = 0;
    }
    
    @IBOutlet var slider: UISlider!
    
    @IBAction func sliderController(sender: UISlider) {
        
        player!.volume = slider.value
    }
    
    @IBOutlet var progressBar: UISlider!
    
    @IBAction func progressController(sender: UISlider) {
        player!.currentTime = Double(progressBar.value)
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
            updater = CADisplayLink(target: self, selector: #selector(MediaPlayerViewController.trackAudio))
            updater.frameInterval = 1
            updater.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
            duration.text = "\(formatTime(player.duration))"
            startTime.text = "\(formatTime(player.currentTime))"
            progressBar.minimumValue = 0
            progressBar.maximumValue = Float(player.duration)
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    func trackAudio() {
//        var normalizedTime = Float(player!.currentTime * 100.0 / player!.duration)
        progressBar.value = Float(player!.currentTime)
        startTime.text = "\(formatTime(player!.currentTime))"
    }
    
    func formatTime(time: NSTimeInterval)->String{
        let current: Int = Int(time)
        let min = current/60
        let sec = abs(current)%60
        let minStr = String(format: "%02d", arguments: [min])
        let secStr = String(format: "%02d", arguments: [sec])
        return minStr+":"+secStr
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
