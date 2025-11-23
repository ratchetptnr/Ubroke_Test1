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

// ViewModel for UploadView
class UploadViewModel: ObservableObject {
    @Published var selectedFiles: [SelectedFile] = []
    
    // Processing State
    @Published var progress: Double = 0.0
    @Published var currentStep = 1
    @Published var isComplete = false

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
    
    func reset() {
        selectedFiles = []
        progress = 0.0
        currentStep = 1
        isComplete = false
    }
    
    func startProcessing() {
        // Reset state if needed
        progress = 0.0
        currentStep = 1
        isComplete = false
        
        // Simulate processing
        withAnimation(.linear(duration: 1.0)) {
            progress = 25
            currentStep = 2
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.linear(duration: 1.0)) {
                self.progress = 50
                self.currentStep = 3
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.linear(duration: 1.0)) {
                self.progress = 75
                self.currentStep = 4
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.linear(duration: 1.0)) {
                self.progress = 100
                self.currentStep = 5
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            withAnimation(.spring()) {
                self.isComplete = true
            }
        }
    }
}

struct UploadView: View {
    var navigateBack: () -> Void
    var navigateToProcessing: () -> Void
    var startWithCamera: Bool = false
    
    @EnvironmentObject var viewModel: UploadViewModel
    
    @State private var showingCamera = false
    @State private var showingDocumentPicker = false
    @State private var selectedPhotoItem: PhotosPickerItem?
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
            HStack {
                Button(action: navigateBack) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                }
                Spacer()
                Text("Upload Statements")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                // Balance the back button
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .opacity(0)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Add Your Statements")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Upload bank statements or scan receipts to automatically track your expenses.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        // Camera Button
                        Button(action: { showingCamera = true }) {
                            VStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue.opacity(0.1))
                                        .frame(width: 60, height: 60)
                                    Image(systemName: "camera.fill")
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                }
                                Text("Camera")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
                        }
                        
                        // Photos Button
                        PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                            VStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.purple.opacity(0.1))
                                        .frame(width: 60, height: 60)
                                    Image(systemName: "photo.fill")
                                        .font(.title2)
                                        .foregroundColor(.purple)
                                }
                                Text("Photos")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
                        }
                        
                        // Files Button
                        Button(action: { showingDocumentPicker = true }) {
                            VStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.orange.opacity(0.1))
                                        .frame(width: 60, height: 60)
                                    Image(systemName: "folder.fill")
                                        .font(.title2)
                                        .foregroundColor(.orange)
                                }
                                Text("Files")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Selected Files List
                    if !viewModel.selectedFiles.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Selected Files (\(viewModel.selectedFiles.count))")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(viewModel.selectedFiles) { file in
                                FileCard(file: file) {
                                    viewModel.removeFile(file)
                                }
                            }
                        }
                    } else {
                        // Empty State Hint
                        VStack(spacing: 12) {
                            Image(systemName: "arrow.up")
                                .font(.title)
                                .foregroundColor(.gray.opacity(0.3))
                            Text("Select a file to start")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .background(Color(.systemGray6).opacity(0.5))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 100)
            }
            
            // Bottom Action Bar
            if !viewModel.selectedFiles.isEmpty {
                VStack {
                    Button(action: {
                        navigateToProcessing()
                    }) {
                        Text("Process \(viewModel.selectedFiles.count) Files")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.blue)
                            .cornerRadius(16)
                    }
                    .padding()
                }
                .background(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -4)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            if startWithCamera && viewModel.selectedFiles.isEmpty {
                showingCamera = true
            }
        }
        .sheet(isPresented: $showingCamera) {
            CameraPicker(image: Binding(
                get: { nil },
                set: { if let img = $0 { viewModel.addCameraImage(img) } }
            ))
        }
        .sheet(isPresented: $showingDocumentPicker) {
            DocumentPicker(urls: Binding(
                get: { [] },
                set: { viewModel.addDocuments($0) }
            ))
        }
        .onChange(of: selectedPhotoItem) { _, newItem in
            if let newItem = newItem {
                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        viewModel.addPhotoLibraryImage(image)
                    }
                }
            }
        }
    }
}

struct FileCard: View {
    let file: SelectedFile
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon/Thumbnail
            ZStack {
                if let image = file.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        .clipped()
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.red.opacity(0.1))
                        .frame(width: 50, height: 50)
                    Image(systemName: "doc.fill")
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(file.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                Text(file.type == .photo ? "Image" : "PDF Document")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title3)
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(file.name), \(file.type == .photo ? "Image" : "Document")")
        .accessibilityAction(named: "Delete") {
            onDelete()
        }
    }
}

// MARK: - Camera Picker
struct CameraPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
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
                parent.image = image
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

// MARK: - Document Picker
struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var urls: [URL]
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .image], asCopy: true)
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
            parent.urls = urls
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
