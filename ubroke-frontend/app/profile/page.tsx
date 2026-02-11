"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ArrowLeft } from "lucide-react";

export default function ProfilePage() {
  const router = useRouter();
  const [income, setIncome] = useState("");
  const [workType, setWorkType] = useState("");
  const [goal, setGoal] = useState("");

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white flex items-center justify-center p-4">
      <Card className="w-full max-w-md shadow-lg">
        <CardHeader>
          <div className="flex items-center gap-2 mb-4">
            <Button
              variant="ghost"
              size="icon"
              onClick={() => router.back()}
            >
              <ArrowLeft className="h-5 w-5" />
            </Button>
          </div>
          <CardTitle className="text-2xl">Tell us about your money</CardTitle>
        </CardHeader>

        <CardContent className="space-y-6">
          <div className="space-y-3">
            <label className="block text-sm font-semibold text-gray-900">
              1. How much do you make?
            </label>
            <div className="space-y-2">
              {["₹0-2 LPA", "₹2-5 LPA", "₹5-10 LPA", "₹10-20 LPA", "₹20+ LPA"].map(
                (option) => (
                  <label key={option} className="flex items-center space-x-3 cursor-pointer">
                    <input
                      type="radio"
                      name="income"
                      value={option}
                      checked={income === option}
                      onChange={(e) => setIncome(e.target.value)}
                      className="h-4 w-4 text-primary border-gray-300 focus:ring-2 focus:ring-primary"
                    />
                    <span className="text-sm text-gray-700">{option}</span>
                  </label>
                )
              )}
            </div>
          </div>

          <div className="space-y-3">
            <label className="block text-sm font-semibold text-gray-900">
              2. What&apos;s your work type?
            </label>
            <div className="space-y-2">
              {["Salaried", "Freelancer", "Student", "Multiple income sources"].map(
                (option) => (
                  <label key={option} className="flex items-center space-x-3 cursor-pointer">
                    <input
                      type="radio"
                      name="workType"
                      value={option}
                      checked={workType === option}
                      onChange={(e) => setWorkType(e.target.value)}
                      className="h-4 w-4 text-primary border-gray-300 focus:ring-2 focus:ring-primary"
                    />
                    <span className="text-sm text-gray-700">{option}</span>
                  </label>
                )
              )}
            </div>
          </div>

          <div className="space-y-3">
            <label className="block text-sm font-semibold text-gray-900">
              3. What&apos;s your main goal?
            </label>
            <div className="space-y-2">
              {[
                "Understand my spending",
                "Save more money",
                "Make better decisions",
                "Plan for something",
              ].map((option) => (
                <label key={option} className="flex items-center space-x-3 cursor-pointer">
                  <input
                    type="radio"
                    name="goal"
                    value={option}
                    checked={goal === option}
                    onChange={(e) => setGoal(e.target.value)}
                    className="h-4 w-4 text-primary border-gray-300 focus:ring-2 focus:ring-primary"
                  />
                  <span className="text-sm text-gray-700">{option}</span>
                </label>
              ))}
            </div>
          </div>

          <div className="border-t border-gray-200 pt-6 flex gap-3">
            <Button
              variant="outline"
              className="flex-1"
              onClick={() => router.push("/upload")}
            >
              Skip
            </Button>
            <Button
              className="flex-1"
              onClick={() => router.push("/upload")}
            >
              Let&apos;s Start →
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
