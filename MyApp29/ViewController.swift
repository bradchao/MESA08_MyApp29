//
//  ViewController.swift
//  MyApp29
//
//  Created by user22 on 2017/10/3.
//  Copyright © 2017年 Brad Big Company. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var labelInfo: UILabel!
    let player:MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer

    @IBAction func prev(_ sender: Any) {
        player.skipToPreviousItem()
    }
    
    @IBAction func next(_ sender: Any) {
        player.skipToNextItem()
    }
    
    @IBAction func start(_ sender: Any) {
        player.play()
        
        
    }
    @IBAction func stop(_ sender: Any) {
        print("click")
        //player.pause()
        
        player.setQueue(with: MPMediaItemCollection(items: []))
        
        
    }
    
    @IBAction func fetchList(_ sender: Any) {
        let picker = MPMediaPickerController(mediaTypes: .music)
        
        picker.allowsPickingMultipleItems = true
        picker.delegate = self
        
        show(picker, sender: self)
        
        
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
//        let player:MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
        player.setQueue(with: mediaItemCollection)
        player.beginGeneratingPlaybackNotifications()
        player.play()

        // 此招直接將裝置所有的歌曲 => Queue
        // 另外做 button
        //player.setQueue(with: .songs())
        
        print("play")
        dismiss(animated: true, completion: nil)
        
    }
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController){
        print("cancel")
        
//         player.stop()
//        player.pause()
        
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(changeItem(_:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        
        
    }

    @objc func changeItem(_ sender : Notification){
        print("Change")
        
        if let nowItem = player.nowPlayingItem {
            if let artwork = nowItem.value(forProperty: MPMediaItemPropertyArtwork){
                imgView.image = (artwork as AnyObject).image(at: imgView.bounds.size)
            }
            
            let atitle = nowItem.value(forProperty: MPMediaItemPropertyAlbumTitle)
            let title = nowItem.value(forProperty: MPMediaItemPropertyTitle)
            let artist = nowItem.value(forProperty: MPMediaItemPropertyArtist)
            
            labelInfo.text = "\(atitle!) \n \(title!) \n\(artist!)"
            
            
        }
        
    }
    
    
}

