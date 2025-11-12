import SwiftUI
import PhotosUI

struct UploadView: View {
    let navigateBack: () -> Void
    let navigateToProcessing: () -> Void

    @State private var showingImagePicker = false
    @State private var showingDocumentPicker = false
    @State private var showingCamera = false
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "doc.text.image")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding(.top, 40)

                    Text("Add Transaction")
                        .font(.system(size: 34, weight: .bold))

                    Text("Snap a photo or upload a document to track your expenses")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 60)

                // Action Buttons
                VStack(spacing: 16) {
                    // Camera Button
                    Button(action: {
                        showingCamera = true
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: "camera.fill")
                                .font(.title2)
                                .frame(width: 44)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Take Photo")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text("Capture a bill or receipt")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(20)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .foregroundColor(.primary)

                    // Photo Library Button
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.title2)
                                .frame(width: 44)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Photo Library")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text("Choose from existing photos")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(20)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .foregroundColor(.primary)

                    // Files Button
                    Button(action: {
                        showingDocumentPicker = true
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: "folder")
                                .font(.title2)
                                .frame(width: 44)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Browse Files")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text("PDF, images, and documents")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(20)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .foregroundColor(.primary)
                }
                .padding(.horizontal, 20)

                Spacer()

                // Info footer
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundColor(.green)
                        Text("Secure & Private")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }

                    Text("Accepted: PDF, JPG, PNG • Max 50MB")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 40)
            }
            .background(Color(.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: navigateBack) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            .photosPicker(isPresented: $showingImagePicker, selection: $selectedItem, matching: .images)
            .sheet(isPresented: $showingDocumentPicker) {
                DocumentPicker(onDocumentPicked: {
                    navigateToProcessing()
                })
            }
            .fullScreenCover(isPresented: $showingCamera) {
                CameraPicker(onImageCaptured: {
                    navigateToProcessing()
                })
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                if newValue != nil {
                    navigateToProcessing()
                }
            }
        }
    }
}

// Native Camera Picker
struct CameraPicker: UIViewControllerRepresentable {
    let onImageCaptured: () -> Void
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.dismiss()
            parent.onImageCaptured()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

// Native Document Picker
struct DocumentPicker: UIViewControllerRepresentable {
    let onDocumentPicked: () -> Void
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .image, .png, .jpeg])
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.dismiss()
            parent.onDocumentPicked()
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.dismiss()
        }
    }
}

#Preview {
    UploadView(navigateBack: {}, navigateToProcessing: {})
}
