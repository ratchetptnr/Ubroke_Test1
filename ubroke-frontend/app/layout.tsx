import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Ubroke 2.0 - Your Personal Finance Brain",
  description: "Upload your financial docs, AI auto-categorizes your spending, chat to understand & optimize.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="font-sans antialiased">{children}</body>
    </html>
  );
}
