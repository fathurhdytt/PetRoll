import AVFoundation

class SoundController: ObservableObject {
    
    private var player: AVAudioPlayer?
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            print("✅ Audio session disiapkan")
        } catch {
            print("❌ Gagal menyiapkan audio session: \(error.localizedDescription)")
        }
    }

    func playMusic() {
        if let path = Bundle.main.path(forResource: "music-petroll", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.numberOfLoops = -1 // Loop terus
                player?.volume = 1.0
                player?.play()
                print("✅ Musik berhasil diputar")
            } catch {
                print("❌ Gagal memutar musik: \(error.localizedDescription)")
            }
        } else {
            print("❌ File tidak ditemukan: music-petroll.mp3")
        }
    }

    func toggleMute() {
        guard let player = player else { return }
        player.volume = player.volume == 0 ? 1.0 : 0.0
    }
}
