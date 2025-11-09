import SwiftUI

struct ProfileView: View {
    let navigateBack: () -> Void
    let navigateToUpload: () -> Void

    @State private var selectedIncome = "₹5-10 LPA"
    @State private var selectedWorkType = "Salaried"
    @State private var selectedGoal = "Understand my spending"

    let incomeRanges = ["₹0-2 LPA", "₹2-5 LPA", "₹5-10 LPA", "₹10-20 LPA", "₹20+ LPA"]
    let workTypes = ["Salaried", "Freelancer", "Student", "Multiple income sources"]
    let goals = ["Understand my spending", "Save more money", "Make better decisions", "Plan for something"]

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
                    Spacer()
                }
                .padding()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Tell us about your money")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        // Income section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("1. How much do you make?")
                                .font(.headline)
                                .padding(.horizontal)

                            GlassCard {
                                Picker("Income", selection: $selectedIncome) {
                                    ForEach(incomeRanges, id: \.self) { range in
                                        Text(range).tag(range)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 150)
                            }
                            .padding(.horizontal)
                        }

                        // Work type section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("2. What's your work type?")
                                .font(.headline)
                                .padding(.horizontal)

                            GlassCard {
                                Picker("Work Type", selection: $selectedWorkType) {
                                    ForEach(workTypes, id: \.self) { type in
                                        Text(type).tag(type)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 150)
                            }
                            .padding(.horizontal)
                        }

                        // Goal section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("3. What's your main goal?")
                                .font(.headline)
                                .padding(.horizontal)

                            GlassCard {
                                Picker("Goal", selection: $selectedGoal) {
                                    ForEach(goals, id: \.self) { goal in
                                        Text(goal).tag(goal)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 150)
                            }
                            .padding(.horizontal)
                        }

                        // Action buttons
                        HStack(spacing: 12) {
                            Button(action: navigateToUpload) {
                                Text("Skip")
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(.primary)
                                    .cornerRadius(12)
                            }

                            Button(action: navigateToUpload) {
                                HStack {
                                    Text("Let's Start")
                                        .fontWeight(.semibold)
                                    Image(systemName: "arrow.right")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)

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
    ProfileView(navigateBack: {}, navigateToUpload: {})
}
