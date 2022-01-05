import AgoraRtcKit
import Foundation
import SwiftUI

struct AgoraView: UIViewControllerRepresentable {
    @Binding var isAudioMuted: Bool
    @Binding var isVideoMuted: Bool
    let token: String

    func makeUIViewController(context: Context) -> AgoraViewController {
        let agoraViewController = AgoraViewController(token: token)
        return agoraViewController
    }

    func updateUIViewController(_ uiViewController: AgoraViewController, context: Context) {
        uiViewController.toggleAudioMute(isMuted: isAudioMuted)
        uiViewController.toggleVideoMute(isMuted: isVideoMuted)
    }
}

class AgoraViewController: UIViewController {
    let token: String

    var agoraKit: AgoraRtcEngineKit?
    var localView: UIView!
    var remoteView: UIView!

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initializeAndJoinChannel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = view.bounds
        localView.frame = CGRect(x: view.bounds.width - 90, y: 0, width: 90, height: 160)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        agoraKit?.leaveChannel(nil)
        AgoraRtcEngineKit.destroy()
    }

    func toggleAudioMute(isMuted: Bool) {
        agoraKit?.muteLocalAudioStream(isMuted)
    }

    func toggleVideoMute(isMuted: Bool) {
        if isMuted {
            agoraKit?.disableVideo()
        } else {
            agoraKit?.enableVideo()
        }
    }

    private func initView() {
        remoteView = UIView()
        view.addSubview(remoteView)
        localView = UIView()
        view.addSubview(localView)
    }

    private func initializeAndJoinChannel() {
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: Env["AGORA_APP_ID"]!, delegate: self)
        agoraKit?.enableVideo()
        agoraKit?.muteLocalAudioStream(true)

        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.renderMode = .hidden
        videoCanvas.view = localView
        agoraKit?.setupLocalVideo(videoCanvas)

        agoraKit?.joinChannel(byToken: token, channelId: "alpha", info: nil, uid: 0, joinSuccess: { _, _, _ in
        })
    }
}

extension AgoraViewController: AgoraRtcEngineDelegate {
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        agoraKit?.setupRemoteVideo(videoCanvas)
    }
}
