import SwiftUI
import UIKit

/// Ubroke Brand Colors - Gen Z inspired palette based on our purple pig mascot
/// All colors support light and dark mode as per Apple HIG
struct BrandColors {
    
    // MARK: - Primary Brand Colors
    
    /// Lavender Magic - Primary brand color (mascot body)
    static let lavenderLight = Color(red: 0.784, green: 0.643, blue: 0.957) // #C8A4F4
    static let lavenderDark = Color(red: 0.710, green: 0.561, blue: 0.910) // #B58FE8
    
    static var lavender: Color {
        Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(lavenderDark)
                : UIColor(lavenderLight)
        })
    }
    
    /// Purple Power - Accent/CTA color (mascot accents)
    static let purpleLight = Color(red: 0.545, green: 0.361, blue: 0.965) // #8B5CF6
    static let purpleDark = Color(red: 0.624, green: 0.478, blue: 1.0) // #9F7AFF
    
    static var purple: Color {
        Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(purpleDark)
                : UIColor(purpleLight)
        })
    }
    
    // MARK: - Secondary Brand Colors
    
    /// Bubblegum Pink - Secondary brand color (mascot mouth)
    static let pinkLight = Color(red: 0.957, green: 0.447, blue: 0.714) // #F472B6
    static let pinkDark = Color(red: 0.925, green: 0.282, blue: 0.600) // #EC4899
    
    static var pink: Color {
        Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(pinkDark)
                : UIColor(pinkLight)
        })
    }
    
    /// Sunshine Gold - Success/Rewards color (mascot coin)
    static let goldLight = Color(red: 0.984, green: 0.749, blue: 0.141) // #FBBF24
    static let goldDark = Color(red: 0.988, green: 0.827, blue: 0.302) // #FCD34D
    
    static var gold: Color {
        Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(goldDark)
                : UIColor(goldLight)
        })
    }
    
    /// Deep Indigo - Text/Icons color (mascot eyes)
    static let indigoLight = Color(red: 0.298, green: 0.114, blue: 0.584) // #4C1D95
    static let indigoDark = Color(red: 0.427, green: 0.157, blue: 0.851) // #6D28D9
    
    static var indigo: Color {
        Color(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(indigoDark)
                : UIColor(indigoLight)
        })
    }
    
    // MARK: - Gradients
    
    /// Primary brand gradient (Lavender → Pink)
    static var primaryGradient: LinearGradient {
        LinearGradient(
            colors: [lavender, pink],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    /// Vertical brand gradient for backgrounds
    static var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [lavender.opacity(0.15), pink.opacity(0.05)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    /// Button gradient (Purple → Pink)
    static var buttonGradient: LinearGradient {
        LinearGradient(
            colors: [purple, pink],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    /// Success/Reward gradient (Gold based)
    static var successGradient: LinearGradient {
        LinearGradient(
            colors: [gold, gold.opacity(0.7)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    /// Subtle card gradient
    static var cardGradient: LinearGradient {
        LinearGradient(
            colors: [lavender.opacity(0.08), purple.opacity(0.05)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - View Extensions for Easy Access

extension View {
    /// Apply primary brand gradient background
    func brandGradientBackground() -> some View {
        self.background(BrandColors.backgroundGradient)
    }
    
    /// Apply primary brand gradient as foreground
    func brandGradientForeground() -> some View {
        self.overlay(
            BrandColors.primaryGradient
                .mask(self)
        )
    }
}

// MARK: - Button Styles

struct BrandButtonStyle: ButtonStyle {
    var isSecondary: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(BrandColors.purple)
            .cornerRadius(16)
            .shadow(
                color: BrandColors.purple.opacity(configuration.isPressed ? 0.2 : 0.3),
                radius: configuration.isPressed ? 8 : 12,
                x: 0,
                y: configuration.isPressed ? 4 : 6
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct BrandOutlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.medium)
            .foregroundColor(BrandColors.purple)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(BrandColors.purple, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == BrandButtonStyle {
    static var brand: BrandButtonStyle { BrandButtonStyle() }
    static var brandSecondary: BrandButtonStyle { BrandButtonStyle(isSecondary: true) }
}

extension ButtonStyle where Self == BrandOutlineButtonStyle {
    static var brandOutline: BrandOutlineButtonStyle { BrandOutlineButtonStyle() }
}
