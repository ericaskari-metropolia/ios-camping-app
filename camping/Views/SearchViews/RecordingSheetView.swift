//
//  RecordingSheetView.swift
//  camping
//
//  Created by Thu Hoang on 19.4.2023.
//

import SwiftUI

struct RecordingSheetView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @Binding var transcript: String
    
    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        
        if (isRecording == false){
            VStack{
                Button {
                    speechRecognizer.resetTranscript()
                    speechRecognizer.startTranscribing()
                    isRecording = true
                } label: {
                    Text("Start recording")
                }
                
            }
        }else {
            VStack{
                Button {
                    speechRecognizer.stopTranscribing()
                    isRecording = false
                    transcript = speechRecognizer.transcript
                    print(speechRecognizer.transcript)
                } label: {
                    Text("Stop recording")
                }
                
            }
        }
        
    }
}

//struct RecordingSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordingSheetView()
//    }
//}
