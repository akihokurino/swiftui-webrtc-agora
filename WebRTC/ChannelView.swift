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
    
    var body: some View {
        ZStack {
            if vm.token.isEmpty {
                ActivityIndicator()
            } else {
                EmptyView()
            }
        }
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
