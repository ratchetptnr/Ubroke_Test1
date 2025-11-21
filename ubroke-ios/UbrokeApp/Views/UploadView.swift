import SwiftUI
import PhotosUI

// Model for selected files
struct SelectedFile: Identifiable {
    let id = UUID()
    let name: String
    let type: FileType
    let image: UIImage?

    enum FileType {
        case photo
        case document
    }
}

struct UploadView: View {
    let navigateBack: () -> Void
    let navigateToProcessing: () -> Void

    @State private var selectedFiles: [SelectedFile] = []
    @State private var showingImagePicker = false
    @State private var showingDocumentPicker = false
    @State private var showingCamera = false
    @State private var showingManualEntry = false
    @State private var selectedItems: [PhotosPickerItem] = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if selectedFiles.isEmpty {
                    // Empty state
                    VStack(spacing: 24) {
                        Spacer()

                        Image(systemName: "doc.text.image")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)

                        Text("Add Your Documents")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("Add bills, receipts, or bank statements to analyze your spending")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        Spacer()
                    }
                } else {
                    // Files list
                    ScrollView {
                        VStack(spacing: 16) {
                            // Header
                            HStack {
                                Text("\(selectedFiles.count) file\(selectedFiles.count == 1 ? "" : "s") selected")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)

                            // Files grid
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(selectedFiles) { file in
                                    FileCard(file: file, onRemove: {
                                        removeFile(file)
                                    })
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }

                Spacer()

                // Action buttons section
                VStack(spacing: 12) {
                    // Add more section header
                    if !selectedFiles.isEmpty {
                        HStack {
                            Text("Add More")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 4)
                    }

                    // Action buttons - Row 1
                    HStack(spacing: 12) {
                        // Camera
                        Button(action: { showingCamera = true }) {
                            VStack(spacing: 8) {
                                Image(systemName: "camera.fill")
                                    .font(.title2)
                                Text("Camera")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.primary)

                        // Photos
                        Button(action: { showingImagePicker = true }) {
                            VStack(spacing: 8) {
                                Image(systemName: "photo.on.rectangle")
                                    .font(.title2)
                                Text("Photos")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.primary)

                        // Files
                        Button(action: { showingDocumentPicker = true }) {
                            VStack(spacing: 8) {
                                Image(systemName: "folder")
                                    .font(.title2)
                                Text("Files")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.primary)

                        // Manual Entry
                        Button(action: { showingManualEntry = true }) {
                            VStack(spacing: 8) {
                                Image(systemName: "pencil.line")
                                    .font(.title2)
                                Text("Manual")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 20)

                    // Analyze button (only show when files selected)
                    if !selectedFiles.isEmpty {
                        Button(action: navigateToProcessing) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Analyze \(selectedFiles.count) File\(selectedFiles.count == 1 ? "" : "s")")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 20)
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

                ToolbarItem(placement: .principal) {
                    Text("Upload Documents")
                        .font(.headline)
                }
            }
            .photosPicker(
                isPresented: $showingImagePicker,
                selection: $selectedItems,
                maxSelectionCount: 20,
                matching: .images
            )
            .sheet(isPresented: $showingDocumentPicker) {
                DocumentPicker(onDocumentsPicked: { urls in
                    addDocuments(urls)
                })
            }
            .fullScreenCover(isPresented: $showingCamera) {
                CameraPicker(onImageCaptured: { image in
                    addCameraImage(image)
                })
            }
            .sheet(isPresented: $showingManualEntry) {
                AddTransactionView()
            }
            .onChange(of: selectedItems) { oldValue, newValue in
                Task {
                    for item in newValue {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            addPhotoLibraryImage(image)
                        }
                    }
                    selectedItems = []
                }
            }
        }
    }

    func addCameraImage(_ image: UIImage) {
        let file = SelectedFile(
            name: "Photo \(selectedFiles.count + 1)",
            type: .photo,
            image: image
        )
        selectedFiles.append(file)
    }

    func addPhotoLibraryImage(_ image: UIImage) {
        let file = SelectedFile(
            name: "Photo \(selectedFiles.count + 1)",
            type: .photo,
            image: image
        )
        selectedFiles.append(file)
    }

    func addDocuments(_ urls: [URL]) {
        for url in urls {
            let file = SelectedFile(
                name: url.lastPathComponent,
                type: .document,
                image: nil
            )
            selectedFiles.append(file)
        }
    }

    func removeFile(_ file: SelectedFile) {
        selectedFiles.removeAll { $0.id == file.id }
    }
}

// File card component
struct FileCard: View {
    let file: SelectedFile
    let onRemove: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 8) {
                if let image = file.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipped()
                        .cornerRadius(8)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemGray6))
                            .frame(height: 120)

                        Image(systemName: "doc.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                    }
                }

                Text(file.name)
                    .font(.caption)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(8)
            .background(Color(.systemGray6).opacity(0.3))
            .cornerRadius(12)

            // Remove button
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title3)
                    .foregroundColor(.red)
                    .background(Circle().fill(Color.white))
            }
            .offset(x: 8, y: -8)
        }
    }
}

// Native Camera Picker with image return
struct CameraPicker: UIViewControllerRepresentable {
    let onImageCaptured: (UIImage) -> Void
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
            if let image = info[.originalImage] as? UIImage {
                parent.onImageCaptured(image)
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

// Native Document Picker with multiple selection
struct DocumentPicker: UIViewControllerRepresentable {
    let onDocumentsPicked: ([URL]) -> Void
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .image, .png, .jpeg])
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = true
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
            parent.onDocumentsPicked(urls)
            parent.dismiss()
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.dismiss()
        }
    }
}

#Preview {
    UploadView(navigateBack: {}, navigateToProcessing: {})
}
