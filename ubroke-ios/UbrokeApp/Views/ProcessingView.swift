import SwiftUI

struct ProcessingView: View {
    var navigateToResults: () -> Void
    var navigateToMergeReview: () -> Void
    
    @EnvironmentObject var viewModel: UploadViewModel
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 12) {
                    Text("Processing Statements")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("AI is analyzing your documents...")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                
                // Progress Circle
                ZStack {
                    Circle()
                        .stroke(lineWidth: 12)
                        .opacity(0.1)
                        .foregroundColor(.blue)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(viewModel.progress / 100, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.blue)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: viewModel.progress)
                    
                    VStack(spacing: 4) {
                        Text("\(Int(viewModel.progress))%")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Complete")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(width: 180, height: 180)
                .padding(.vertical, 20)
                
                // Steps
                VStack(alignment: .leading, spacing: 20) {
                    ProcessingStep(title: "Uploading documents", isCompleted: viewModel.currentStep > 1, isActive: viewModel.currentStep == 1)
                    ProcessingStep(title: "Extracting text (OCR)", isCompleted: viewModel.currentStep > 2, isActive: viewModel.currentStep == 2)
                    ProcessingStep(title: "Identifying transactions", isCompleted: viewModel.currentStep > 3, isActive: viewModel.currentStep == 3)
                    ProcessingStep(title: "Categorizing expenses", isCompleted: viewModel.currentStep > 4, isActive: viewModel.currentStep == 4)
                    ProcessingStep(title: "Finalizing results", isCompleted: viewModel.isComplete, isActive: viewModel.currentStep == 5)
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Results Button (appears when complete)
                if viewModel.isComplete {
                    VStack(spacing: 16) {
                        Button(action: navigateToResults) {
                            Text("View Results")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.blue)
                                .cornerRadius(16)
                        }
                        
                        Button(action: navigateToMergeReview) {
                            Text("Review Duplicates (Demo)")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.startProcessing()
        }
    }
}

struct ProcessingStep: View {
    let title: String
    let isCompleted: Bool
    let isActive: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(isCompleted ? .green : (isActive ? .blue : .gray.opacity(0.3)))
                    .frame(width: 24, height: 24)
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.green)
                } else if isActive {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                }
            }
            
            Text(title)
                .font(.body)
                .foregroundColor(isCompleted || isActive ? .primary : .secondary)
                .fontWeight(isActive ? .medium : .regular)
            
            Spacer()
            
            if isActive {
                ProgressView()
                    .scaleEffect(0.8)
            }
        }
    }
}

#Preview {
    ProcessingView(navigateToResults: {}, navigateToMergeReview: {})
        .environmentObject(UploadViewModel())
}
