import Combine
import SwiftUI

class ChannelVM: ObservableObject {
    private var cancellable: AnyCancellable?
    @Published var token: String = ""

    func initialize() {
        cancellable?.cancel()
        cancellable = GraphQLClient.shared.caller()
            .flatMap { caller in caller.agoraToken(channelName: "alpha") }
            .sink(receiveCompletion: { _ in
            }, receiveValue: { val in
                self.token = val
                print(self.token)
            })
    }
}

struct ChannelView: View {
    @ObservedObject var vm = ChannelVM()
    @State var isAudioMuted = true
    @State var isVideoMuted = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                if vm.token.isEmpty {
                    ActivityIndicator()
                } else {
                    AgoraView(isAudioMuted: $isAudioMuted, isVideoMuted: $isVideoMuted, token: vm.token)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)

            HStack {
                Image(systemName: "mic.circle.fill")
                    .font(.system(size: 64.0))
                    .foregroundColor(self.isAudioMuted ? .gray : .blue)
                    .padding()
                    .onTapGesture {
                        self.isAudioMuted = !self.isAudioMuted
                    }

                Spacer()

                Image(systemName: "video.circle.fill")
                    .font(.system(size: 64.0))
                    .foregroundColor(self.isVideoMuted ? .gray : .blue)
                    .padding()
                    .onTapGesture {
                        self.isVideoMuted = !self.isVideoMuted
                    }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
            vm.initialize()
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
