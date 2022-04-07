//
//  ViewController.swift
//  PlayerTestTask
//
//  Created by Максим Пасюта on 06.04.2022.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController{
        
    var tracks: [URL?] = []
        
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var firstLoadLabel: UILabel!
    @IBOutlet weak var secondLoadLabel: UILabel!
    @IBOutlet weak var crossfadeLabel: UILabel!
    
    @IBOutlet weak var crossfadeSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crossfadeSlider.maximumValue = 10
        crossfadeSlider.minimumValue = 2
    }
    
    
    @IBAction func crossfadeSliderAction(_ sender: Any) {
        crossfadeLabel.text = "Величина кроссфейда: \(Int(crossfadeSlider.value)) с"
    }
    
    @IBAction func addingFirstTrack(_ sender: Any) {
        trackSearch()
    }
    
    @IBAction func addingSecondTrack(_ sender: Any) {
        trackSearch()
    }
    
    @IBAction func playAction(_ sender: Any) {
        
        if tracks.count == 2 {
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            }
            catch(let error) {
                print(error)
            }
            
            Audio.shared.playSounds(firstTrack: tracks.first!, secondTrack: tracks.last!, crossfade: Int(crossfadeSlider.value))
        }
        else {
            Alerts.showErrortAlert(vc: self, message: "Необходимо загрузить оба аудиофайла")
        }
    }
    
    
    private func trackSearch(){
        
        let mediaPickerController = MPMediaPickerController(mediaTypes: .any)
        mediaPickerController.delegate = self
        mediaPickerController.prompt = "Выберите аудиофайл"
        present(mediaPickerController, animated: true)
    }
}

// MARK: MPMediaPickerControllerDelegate

extension ViewController: MPMediaPickerControllerDelegate{
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        dismiss(animated: true) {
            let selectedSongs = mediaItemCollection.items
            guard let song = selectedSongs.first else { return }
            
            if let url = song.value(forProperty: MPMediaItemPropertyAssetURL) as? URL {
                self.tracks.append(url)
                Alerts.showSuccessAlert(vc: self, message: "Аудиофайл загружен")
            }
            else {
                Alerts.showErrortAlert(vc: self, message: "Аудиофайл не загружен")
            }
            if self.tracks.count >= 3{
                self.tracks.remove(at: 0)
            }
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
}
