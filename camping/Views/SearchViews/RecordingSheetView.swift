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
    
    @State private var drawingHeight = true
    
    var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
    
    @Binding var transcript: String
    
    var body: some View {
        if (isRecording == false){
            VStack{
                Button {
                    speechRecognizer.resetTranscript()
                    speechRecognizer.startTranscribing()
                    isRecording = true
                } label: {
                    Label("search.startRecording".i18n(), systemImage: "mic.fill.badge.plus")
                        .foregroundColor(.white)
                }
                .padding()
                .background(.black)
                .clipShape(Capsule())
            }
        } else {
            VStack{
                HStack {
                    bar(low: 0.4)
                        .animation(animation.speed(1.5), value: drawingHeight)
                    bar(low: 0.3)
                        .animation(animation.speed(1.2), value: drawingHeight)
                    bar(low: 0.5)
                        .animation(animation.speed(1.0), value: drawingHeight)
                    bar(low: 0.3)
                        .animation(animation.speed(1.7), value: drawingHeight)
                    bar(low: 0.5)
                        .animation(animation.speed(1.0), value: drawingHeight)
                }
                .frame(width: 80)
                .onAppear{
                    drawingHeight.toggle()
                }
                Button {
                    speechRecognizer.stopTranscribing()
                    isRecording = false
                    transcript = speechRecognizer.transcript
                    dismiss()
                    print(speechRecognizer.transcript)
                } label: {
                    Label("search.stopRecording".i18n(), systemImage: "mic.fill.badge.xmark")
                        .foregroundColor(.white)
                }
                .padding()
                .background(.black)
                .clipShape(Capsule())
            }
        }
    }
    
    // Create animation for recording
    func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(.black.gradient)
            .frame(height: (drawingHeight ? high : low) * 64)
            .frame(height: 64, alignment: .bottom)
    }
}

//struct RecordingSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordingSheetView()
//    }
//}
