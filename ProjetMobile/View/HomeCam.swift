//
//  HomeCam.swift
//  ProjetMobile
//
//  Created by Bechir Kefi on 14/11/2023.
//

import SwiftUI

struct HomeCam: View {
    @StateObject var cameraModel = CameraModel()

    var body: some View {
        ZStack {
            CameraPreview(camera: cameraModel)
                .onAppear(perform: cameraModel.checkPermission)

            VStack {
                Spacer() // Push buttons to the bottom

                HStack {
                    Button {
                        if cameraModel.isRecording {
                            cameraModel.stopRecording()
                        } else {
                            cameraModel.startRecording()
                        }
                        cameraModel.isRecording.toggle()
                    } label: {
                        Image("Reels")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("Instagram"))
                            .frame(width: 70, height: 70)
                            .background(
                                Circle()
                                    .stroke(Color.black)
                            )
                            .padding(6)
                            .background(
                                Circle()
                                    .fill(Color.white)
                            )
                    }
                    .padding(.bottom, 20)

                    Spacer()

                    ZStack {
                                  RoundedRectangle(cornerRadius: 10)
                                      .fill(Color.red)
                                      .frame(width: 60,height: 40)
                                      .padding(.horizontal)

                                  Text(formatTime(cameraModel.recordingTime))
                                      .foregroundColor(.white)
                                      .font(.system(size: 16))
                                      .padding(.vertical, 8)
                              }
                }
                .padding(.horizontal)
            }
        }
        .preferredColorScheme(.dark)
    }

    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

struct HomeCam_Previews: PreviewProvider {
    static var previews: some View {
        HomeCam()
    }
}
