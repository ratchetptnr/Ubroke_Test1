import SwiftUI

struct UploadView: View {
    let navigateBack: () -> Void
    let navigateToProcessing: () -> Void

    @State private var isDragging = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Navigation bar
                HStack {
                    Button(action: navigateBack) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                    Text("Ubroke")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.leading, 8)
                    Spacer()
                }
                .padding()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Upload Your Financial Docs")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Bills, salary slips, bank statements, receipts, etc.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)

                        // Upload area
                        Button(action: navigateToProcessing) {
                            VStack(spacing: 16) {
                                Image(systemName: "arrow.up.doc.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.blue.opacity(0.6))

                                Text("Drag & drop files here")
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                Text("or tap to browse")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.ultraThinMaterial)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(
                                                style: StrokeStyle(lineWidth: 2, dash: [8])
                                            )
                                            .foregroundColor(.blue.opacity(0.3))
                                    )
                            )
                        }
                        .padding(.horizontal)

                        // Quick action buttons
                        HStack(spacing: 12) {
                            Button(action: navigateToProcessing) {
                                VStack(spacing: 12) {
                                    Image(systemName: "camera.fill")
                                        .font(.title)
                                        .foregroundColor(.blue)

                                    Text("Take Photo")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 120)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
                                )
                            }

                            Button(action: navigateToProcessing) {
                                VStack(spacing: 12) {
                                    Image(systemName: "doc.text.fill")
                                        .font(.title)
                                        .foregroundColor(.blue)

                                    Text("Browse")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 120)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
                                )
                            }
                        }
                        .padding(.horizontal)

                        // Info card
                        GlassCard {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Accepted:")
                                        .fontWeight(.semibold)
                                    Text("PDF, JPG, PNG")
                                        .foregroundColor(.secondary)
                                }

                                HStack {
                                    Text("Max size:")
                                        .fontWeight(.semibold)
                                    Text("50MB each")
                                        .foregroundColor(.secondary)
                                }

                                Divider()
                                    .padding(.vertical, 4)

                                HStack(alignment: .top, spacing: 8) {
                                    Text("💡")
                                        .font(.title3)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Tip:")
                                            .fontWeight(.semibold)
                                        Text("Salary slips, bank statements, and bills work best.")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                        Spacer()
                            .frame(height: 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    UploadView(navigateBack: {}, navigateToProcessing: {})
}
