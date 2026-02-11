"use client";

import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader } from "@/components/ui/card";
import { CheckCircle2, XCircle } from "lucide-react";

export default function WelcomePage() {
  const router = useRouter();

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white flex items-center justify-center p-4">
      <Card className="w-full max-w-md shadow-lg">
        <CardHeader className="text-center space-y-4 pb-4">
          <div className="flex justify-center">
            <div className="w-16 h-16 bg-primary rounded-full flex items-center justify-center text-white text-2xl font-bold">
              U
            </div>
          </div>
          <h1 className="text-3xl font-bold text-gray-900">UBROKE 2.0</h1>
          <p className="text-lg text-gray-600 font-medium">
            Your Personal Finance Brain
          </p>
          <div className="text-sm text-gray-500 space-y-1">
            <p>(Not a bank. Not a tracker.)</p>
            <p>(Just clarity for your money.)</p>
          </div>
        </CardHeader>

        <CardContent className="space-y-6">
          <div className="border-t border-gray-200 my-4"></div>

          <div className="space-y-4">
            <h2 className="font-semibold text-gray-900">What we do:</h2>
            <div className="space-y-3">
              <div className="flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-green-600 mt-0.5 flex-shrink-0" />
                <p className="text-gray-700">Read your financial docs</p>
              </div>
              <div className="flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-green-600 mt-0.5 flex-shrink-0" />
                <p className="text-gray-700">Show you where money goes</p>
              </div>
              <div className="flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-green-600 mt-0.5 flex-shrink-0" />
                <p className="text-gray-700">Answer your money questions</p>
              </div>
            </div>
          </div>

          <div className="space-y-4">
            <h2 className="font-semibold text-gray-900">What we DON&apos;T do:</h2>
            <div className="space-y-3">
              <div className="flex items-start gap-3">
                <XCircle className="w-5 h-5 text-red-500 mt-0.5 flex-shrink-0" />
                <p className="text-gray-700">Ask for passwords/card info</p>
              </div>
              <div className="flex items-start gap-3">
                <XCircle className="w-5 h-5 text-red-500 mt-0.5 flex-shrink-0" />
                <p className="text-gray-700">Move your money around</p>
              </div>
              <div className="flex items-start gap-3">
                <XCircle className="w-5 h-5 text-red-500 mt-0.5 flex-shrink-0" />
                <p className="text-gray-700">Make decisions for you</p>
              </div>
            </div>
          </div>
        </CardContent>

        <CardFooter className="flex flex-col gap-2 pb-6">
          <div className="border-t border-gray-200 w-full mb-4"></div>
          <Button
            size="lg"
            className="w-full"
            onClick={() => router.push("/profile")}
          >
            Continue →
          </Button>
        </CardFooter>
      </Card>
    </div>
  );
}
