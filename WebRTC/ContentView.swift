import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    NavigationLink(
                        destination: ChannelView()
                    ) {
                        HStack {
                            Text("Agora WebRTC")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Divider().background(Color.gray.opacity(0.5))
                }
            }
            .navigationBarTitle("メニュー", displayMode: .inline)
        }
    }
}
