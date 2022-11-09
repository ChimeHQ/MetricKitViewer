import SwiftUI
import UniformTypeIdentifiers
import Meter

extension UTType {
    static var mxdiagnostic: UTType {
        UTType(importedAs: "com.chimehq.mxdiagnostic")
    }
}

extension DiagnosticPayload {
    static var empty: DiagnosticPayload {
        let date = Date.now
        return DiagnosticPayload(timeStampBegin: date,
                                 timeStampEnd: date,
                                 crashDiagnostics: nil,
                                 hangDiagnostics: nil,
                                 cpuExceptionDiagnostics: nil,
                                 diskWriteExceptionDiagnostics: nil)
    }
}

struct MetricKitViewerDocument: FileDocument {
    var payload: DiagnosticPayload

    init(payload: DiagnosticPayload = .empty) {
        self.payload = payload
    }

    static var readableContentTypes: [UTType] { [.mxdiagnostic] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }

        self.payload = try DiagnosticPayload.from(data: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw CocoaError(.fileWriteUnknown)
    }

    var text: String {
        let data = payload.jsonRepresentation()

        return String(data: data, encoding: .utf8)!
    }

    var crashDiagnostics: [CrashDiagnostic] {
        return payload.crashDiagnostics ?? []
    }

    var cpuExceptionDiagnostics: [CPUExceptionDiagnostic] {
        return payload.cpuExceptionDiagnostics ?? []
    }

	var hangDiagnostics: [HangDiagnostic] {
		return payload.hangDiagnostics ?? []
	}
}
