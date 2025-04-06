import SwiftUI
import AVFoundation

struct RunView: View {
    @Binding var entries: [Entry]
    @Binding var screen: ContentView.Screen

    private let timeboxDurationSeconds = 30 * 60 // 30 minutes in seconds
    
    @State var entry: Entry?
    @State private var isTimerRunning = false
    @State private var timeRemaining = 0
    @State private var timer: Timer?
    @State private var audioPlayer: AVAudioPlayer?
    
    func moveToEntryScreen() {
        screen = .entry
    }
    
    func startTimer() {
        isTimerRunning = true
        timeRemaining = timeboxDurationSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                playSound()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "timer-complete", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error)")
        }
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }

    var body: some View {
        VStack {
            if let entry {
                Text(entry.thing)
                    .font(.largeTitle)
                    .padding([.bottom], 50.0)
                
                if isTimerRunning {
                    Text(formatTime(Int(timeRemaining)))
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                        .padding(.bottom, 20)
                } else {
                    Button("Timebox") {
                        startTimer()
                    }
                    .font(.title2)
                    .padding(.bottom, 20)
                }
                
                HStack {
                    Button("Done") {
                        stopTimer()
                        self.entry = nil
                        entries.removeAll { thing in
                            thing.id == entry.id
                        }
                        ContentView.saveToUserDefaults(entries)
                        if entries.isEmpty {
                            moveToEntryScreen()
                        }
                    }
                    Spacer()
                    Button("Done/Keep") {
                        stopTimer()
                        self.entry = nil
                    }
                }.padding([.leading, .trailing], 50.0)
                
            } else {
                Button("Roll!") {
                    entry = entries.randomElement()
                }
            }
        }
    }
}

#Preview {
    @State var entries = ["greeble", "bork", "splunge"]
        .map(Entry.init)
    @State var screen = ContentView.Screen.run
    return RunView(entries: $entries, screen: $screen)
}
