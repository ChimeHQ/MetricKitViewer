import SwiftUI
import Meter

extension CrashDiagnostic {
    static var empty: CrashDiagnostic {
        let metaData = CrashMetaData(deviceType: "blah",
                                     applicationBuildVersion: "blah",
                                     applicationVersion: "blah",
                                     osVersion: "blah",
                                     platformArchitecture: "blah",
                                     regionFormat: "balh",
                                     virtualMemoryRegionInfo: nil,
                                     exceptionType: nil,
                                     terminationReason: nil,
                                     exceptionCode: nil,
                                     signal: nil)
        return CrashDiagnostic(metaData: metaData,
                               callStackTree: CallStackTree(callStacks: [], callStackPerThread: true))
    }
}

struct CrashDiagnosticView: View {
    let diagnostic: CrashDiagnostic

    var appVersion: String {
        return diagnostic.metaData.applicationVersion
    }

    var appBuildVersion: String {
        return diagnostic.metaData.applicationBuildVersion
    }

	var osVersion: String {
		return diagnostic.metaData.osVersion
	}

    var body: some View {
        VStack {
            Text("Version: \(appVersion) (\(appBuildVersion)) \(diagnostic.metaData.platformArchitecture)")
			Text("OS: \(osVersion)")

            ScrollView {
                ForEach((0..<diagnostic.callStackTree.callStacks.count), id: \.self) { index in
                    CallStackView(callStack: diagnostic.callStackTree.callStacks[index])
                        .padding()
                }
            }
        }
    }
}

struct CrashDiagnosticView_Previews: PreviewProvider {
    static var previews: some View {
        CrashDiagnosticView(diagnostic: .empty)
    }
}
