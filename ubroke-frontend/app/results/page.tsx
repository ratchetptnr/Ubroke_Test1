"use client";

import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ArrowLeft, MessageCircle, Upload } from "lucide-react";

const categories = [
  { name: "Rent & Housing", amount: 25000, percentage: 52, emoji: "🏠", color: "bg-blue-500" },
  { name: "Food & Delivery", amount: 8500, percentage: 18, emoji: "🍕", color: "bg-orange-500", alert: true },
  { name: "Entertainment", amount: 4200, percentage: 9, emoji: "🎮", color: "bg-purple-500" },
  { name: "Subscriptions", amount: 3800, percentage: 8, emoji: "📱", color: "bg-pink-500" },
  { name: "Transport", amount: 2000, percentage: 4, emoji: "🚗", color: "bg-green-500" },
  { name: "Health & Wellness", amount: 1500, percentage: 3, emoji: "💊", color: "bg-teal-500" },
  { name: "Other", amount: 2500, percentage: 6, emoji: "📦", color: "bg-gray-500" },
];

export default function ResultsPage() {
  const router = useRouter();
  const totalAmount = 47500;

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white p-4 pb-20">
      <div className="max-w-md mx-auto space-y-4">
        {/* Header */}
        <div className="flex items-center gap-2">
          <Button
            variant="ghost"
            size="icon"
            onClick={() => router.back()}
          >
            <ArrowLeft className="h-5 w-5" />
          </Button>
          <span className="text-sm text-gray-500">Ubroke</span>
        </div>

        {/* Total Card */}
        <Card className="shadow-lg">
          <CardHeader>
            <CardTitle className="text-xl">📊 Your Expense Breakdown</CardTitle>
            <p className="text-sm text-gray-600">January 2024</p>
          </CardHeader>
          <CardContent>
            <div className="text-center py-4 bg-primary/5 rounded-lg">
              <p className="text-sm text-gray-600 mb-1">Total Analyzed</p>
              <p className="text-4xl font-bold text-primary">₹{totalAmount.toLocaleString()}</p>
            </div>
          </CardContent>
        </Card>

        {/* Categories Card */}
        <Card className="shadow-lg">
          <CardHeader>
            <CardTitle className="text-lg">📈 BY CATEGORY</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {categories.map((category) => (
              <div key={category.name} className="space-y-2">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <span className="text-xl">{category.emoji}</span>
                    <span className="text-sm font-medium text-gray-900">
                      {category.name}
                    </span>
                  </div>
                  <span className="text-sm font-semibold text-gray-900">
                    ₹{category.amount.toLocaleString()}
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <div className="flex-1 h-2 bg-gray-200 rounded-full overflow-hidden">
                    <div
                      className={`h-full ${category.color}`}
                      style={{ width: `${category.percentage}%` }}
                    />
                  </div>
                  <span className="text-xs text-gray-600 w-12 text-right">
                    {category.percentage}%
                  </span>
                </div>
                {category.alert && (
                  <p className="text-xs text-orange-600 pl-7">
                    High spending 🔴
                  </p>
                )}
              </div>
            ))}
          </CardContent>
        </Card>

        {/* Insights Card */}
        <Card className="shadow-lg">
          <CardHeader>
            <CardTitle className="text-lg">💡 INSIGHTS</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="flex items-start gap-2">
              <span className="text-sm">•</span>
              <p className="text-sm text-gray-700">
                Your top spend: Rent (52%)
              </p>
            </div>
            <div className="flex items-start gap-2">
              <span className="text-sm">•</span>
              <p className="text-sm text-gray-700">
                Food delivery is 18% of your total spend — high! 🔴
              </p>
            </div>
            <div className="flex items-start gap-2">
              <span className="text-sm">•</span>
              <p className="text-sm text-gray-700">
                You have 6 recurring costs (subscriptions, gym, etc.)
              </p>
            </div>
          </CardContent>
        </Card>

        {/* Action Buttons */}
        <div className="grid grid-cols-2 gap-3 pt-2">
          <Button
            variant="outline"
            className="h-auto py-4 flex flex-col gap-2"
            onClick={() => router.push("/upload")}
          >
            <Upload className="w-5 h-5" />
            <span>Upload More</span>
          </Button>
          <Button
            className="h-auto py-4 flex flex-col gap-2"
            onClick={() => router.push("/chat")}
          >
            <MessageCircle className="w-5 h-5" />
            <span>Ask AI</span>
          </Button>
        </div>
      </div>
    </div>
  );
}
