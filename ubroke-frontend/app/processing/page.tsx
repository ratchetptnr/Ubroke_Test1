"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { CheckCircle2, Loader2 } from "lucide-react";

export default function ProcessingPage() {
  const router = useRouter();
  const [progress, setProgress] = useState(0);
  const [step, setStep] = useState(1);

  useEffect(() => {
    // Simulate processing steps
    const timer1 = setTimeout(() => {
      setProgress(25);
      setStep(2);
    }, 1000);

    const timer2 = setTimeout(() => {
      setProgress(50);
      setStep(3);
    }, 2000);

    const timer3 = setTimeout(() => {
      setProgress(75);
      setStep(4);
    }, 3000);

    const timer4 = setTimeout(() => {
      setProgress(100);
      setStep(5);
    }, 4000);

    const timer5 = setTimeout(() => {
      router.push("/results");
    }, 5000);

    return () => {
      clearTimeout(timer1);
      clearTimeout(timer2);
      clearTimeout(timer3);
      clearTimeout(timer4);
      clearTimeout(timer5);
    };
  }, [router]);

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white flex items-center justify-center p-4">
      <Card className="w-full max-w-md shadow-lg">
        <CardHeader>
          <div className="text-center space-y-2">
            <div className="flex justify-center">
              {progress === 100 ? (
                <CheckCircle2 className="w-16 h-16 text-green-600" />
              ) : (
                <Loader2 className="w-16 h-16 text-primary animate-spin" />
              )}
            </div>
            <CardTitle className="text-2xl">
              {progress === 100 ? "✅ Analysis Complete!" : "📊 Analyzing..."}
            </CardTitle>
          </div>
        </CardHeader>

        <CardContent className="space-y-6">
          {progress < 100 ? (
            <>
              <div className="space-y-2">
                <Progress value={progress} className="h-2" />
                <p className="text-center text-sm text-gray-600">{progress}%</p>
              </div>

              <div className="space-y-3">
                <div className="flex items-start gap-3">
                  <CheckCircle2
                    className={`w-5 h-5 mt-0.5 flex-shrink-0 ${
                      step >= 2 ? "text-green-600" : "text-gray-300"
                    }`}
                  />
                  <p className="text-gray-700">Step 1: Reading document...</p>
                </div>
                <div className="flex items-start gap-3">
                  <CheckCircle2
                    className={`w-5 h-5 mt-0.5 flex-shrink-0 ${
                      step >= 3 ? "text-green-600" : "text-gray-300"
                    }`}
                  />
                  <p className="text-gray-700">Step 2: Extracting data...</p>
                </div>
                <div className="flex items-start gap-3">
                  <CheckCircle2
                    className={`w-5 h-5 mt-0.5 flex-shrink-0 ${
                      step >= 4 ? "text-green-600" : "text-gray-300"
                    }`}
                  />
                  <p className="text-gray-700">Step 3: Categorizing...</p>
                </div>
                <div className="flex items-start gap-3">
                  <CheckCircle2
                    className={`w-5 h-5 mt-0.5 flex-shrink-0 ${
                      step >= 5 ? "text-green-600" : "text-gray-300"
                    }`}
                  />
                  <p className="text-gray-700">Step 4: Building summary...</p>
                </div>
              </div>

              <div className="border-t border-gray-200 pt-4">
                <p className="text-sm text-gray-600 text-center">
                  Typically takes 10-15 seconds. Hang tight!
                </p>
              </div>

              <Button
                variant="outline"
                className="w-full"
                onClick={() => router.push("/upload")}
              >
                Cancel
              </Button>
            </>
          ) : (
            <>
              <div className="text-center space-y-4">
                <p className="text-gray-700">
                  &quot;Salary_Jan_2024.pdf&quot;
                </p>
                <p className="text-gray-600">Your document is ready.</p>
              </div>

              <div className="border-t border-gray-200 pt-4 space-y-2">
                <div className="bg-green-50 p-4 rounded-lg space-y-2">
                  <p className="text-sm font-semibold text-gray-900">Found:</p>
                  <div className="grid grid-cols-3 gap-4 text-center">
                    <div>
                      <p className="text-2xl font-bold text-primary">47</p>
                      <p className="text-xs text-gray-600">Transactions</p>
                    </div>
                    <div>
                      <p className="text-2xl font-bold text-primary">8</p>
                      <p className="text-xs text-gray-600">Categories</p>
                    </div>
                    <div>
                      <p className="text-2xl font-bold text-primary">6</p>
                      <p className="text-xs text-gray-600">Recurring</p>
                    </div>
                  </div>
                </div>
              </div>

              <Button
                className="w-full"
                size="lg"
                onClick={() => router.push("/results")}
              >
                View Results →
              </Button>
            </>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
