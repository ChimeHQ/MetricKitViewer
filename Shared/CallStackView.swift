import SwiftUI
import Meter

struct CallStackView: View {
    let callStack: CallStack
	let offsetAsLoadAddress: Bool

    func frameView(_ frame: Frame) -> Text {
        // 1   Chime                                    0x1005b5244 TextChangeMonitoringServer.adjustState(with:error:) + 840 (TextChangeMonitoringServer.swift:133)

		let binary = frame.binary(withOffsetAsLoadAddress: offsetAsLoadAddress)

		let binaryName = binary?.name ?? "<unknown>"
		let loadAddress = String(binary?.loadAddress ?? 0, radix: 16)
        let address = String(frame.address, radix: 16)
        let symbol = frame.symbolInfo?.first?.symbol ?? ""

        let value = "\(binaryName)    0x\(loadAddress)    0x\(address)    \(symbol)"

        return Text(value)
    }

    var attributed: Bool {
        return callStack.threadAttributed ?? false
    }

    var body: some View {
		VStack(alignment: .leading) {
            Text("attributed: " + attributed.description)
                .textSelection(.enabled)
            ForEach((0..<callStack.frames.count), id: \.self) { index in
                frameView(callStack.frames[index])
                    .textSelection(.enabled)
            }.font(.body.monospaced())
        }
    }
}

struct CallStackView_Previews: PreviewProvider {
    static var previews: some View {
        CallStackView(callStack: CallStack(threadAttributed: true, rootFrames: []), offsetAsLoadAddress: true)
    }
}
