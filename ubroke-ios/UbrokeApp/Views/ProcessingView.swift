import SwiftUI

struct ProcessingView: View {
    let navigateToResults: () -> Void

    @State private var progress: Double = 0.0
    @State private var currentStep = 1
    @State private var isComplete = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // Icon
                if isComplete {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                        .transition(.scale.combined(with: .opacity))
                } else {
                    ProgressView()
                        .scaleEffect(2)
                        .tint(.blue)
                }

                // Title
                Text(isComplete ? "✅ Analysis Complete!" : "📊 Analyzing...")
                    .font(.title)
                    .fontWeight(.bold)

                if !isComplete {
                    // Progress bar and percentage
                    VStack(spacing: 12) {
                        ProgressView(value: progress, total: 100)
                            .tint(.blue)
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .padding(.horizontal, 40)

                        Text("\(Int(progress))%")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    // Steps
                    GlassCard {
                        VStack(alignment: .leading, spacing: 16) {
                            ProcessingStep(
                                number: 1,
                                text: "Reading document...",
                                isComplete: currentStep > 1
                            )
                            ProcessingStep(
                                number: 2,
                                text: "Extracting data...",
                                isComplete: currentStep > 2
                            )
                            ProcessingStep(
                                number: 3,
                                text: "Categorizing...",
                                isComplete: currentStep > 3
                            )
                            ProcessingStep(
                                number: 4,
                                text: "Building summary...",
                                isComplete: currentStep > 4
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // Info text
                    Text("Typically takes 10-15 seconds. Hang tight!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                } else {
                    // Complete state
                    VStack(spacing: 16) {
                        Text("\"Salary_Jan_2024.pdf\"")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("Your document is ready.")
                            .font(.body)

                        GlassCard {
                            VStack(spacing: 16) {
                                Text("Found:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                HStack(spacing: 20) {
                                    StatBox(number: "47", label: "Transactions")
                                    StatBox(number: "8", label: "Categories")
                                    StatBox(number: "6", label: "Recurring")
                                }
                            }
                        }
                        .padding(.horizontal, 20)

                        Button(action: navigateToResults) {
                            HStack {
                                Text("View Results")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                    }
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            startProcessing()
        }
    }

    func startProcessing() {
        // Simulate processing
        withAnimation(.linear(duration: 1.0)) {
            progress = 25
            currentStep = 2
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.linear(duration: 1.0)) {
                progress = 50
                currentStep = 3
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.linear(duration: 1.0)) {
                progress = 75
                currentStep = 4
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.linear(duration: 1.0)) {
                progress = 100
                currentStep = 5
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            withAnimation(.spring()) {
                isComplete = true
            }
        }
    }
}

struct ProcessingStep: View {
    let number: Int
    let text: String
    let isComplete: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isComplete ? .green : .gray)
                .font(.system(size: 20))

            Text("Step \(number): \(text)")
                .font(.body)
                .foregroundColor(isComplete ? .primary : .secondary)

            Spacer()
        }
    }
}

struct StatBox: View {
    let number: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Text(number)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.blue)

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProcessingView(navigateToResults: {})
}
