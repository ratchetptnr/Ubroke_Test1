"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ArrowLeft, Upload, Camera, FileText } from "lucide-react";

export default function UploadPage() {
  const router = useRouter();
  const [isDragging, setIsDragging] = useState(false);

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(true);
  };

  const handleDragLeave = () => {
    setIsDragging(false);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
    // In a real app, handle file upload here
    router.push("/processing");
  };

  const handleFileSelect = () => {
    // In a real app, open file picker
    router.push("/processing");
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white flex items-center justify-center p-4">
      <Card className="w-full max-w-md shadow-lg">
        <CardHeader>
          <div className="flex items-center gap-2 mb-2">
            <Button
              variant="ghost"
              size="icon"
              onClick={() => router.back()}
            >
              <ArrowLeft className="h-5 w-5" />
            </Button>
            <span className="text-sm text-gray-500">Ubroke</span>
          </div>
          <CardTitle className="text-2xl">Upload Your Financial Docs</CardTitle>
          <p className="text-sm text-gray-600 mt-2">
            Bills, salary slips, bank statements, receipts, etc.
          </p>
        </CardHeader>

        <CardContent className="space-y-6">
          <div
            className={`border-2 border-dashed rounded-lg p-12 text-center transition-colors ${
              isDragging
                ? "border-primary bg-primary/5"
                : "border-gray-300 bg-gray-50"
            }`}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            onDrop={handleDrop}
          >
            <div className="flex flex-col items-center gap-4">
              <Upload className="w-12 h-12 text-gray-400" />
              <div>
                <p className="text-sm font-medium text-gray-700">
                  Drag & drop files here
                </p>
              </div>
            </div>
          </div>

          <div className="text-center text-sm text-gray-500">or</div>

          <div className="grid grid-cols-2 gap-3">
            <Button
              variant="outline"
              className="h-auto py-6 flex flex-col gap-2"
              onClick={handleFileSelect}
            >
              <Camera className="w-6 h-6" />
              <span>Take Photo</span>
            </Button>
            <Button
              variant="outline"
              className="h-auto py-6 flex flex-col gap-2"
              onClick={handleFileSelect}
            >
              <FileText className="w-6 h-6" />
              <span>Browse</span>
            </Button>
          </div>

          <div className="border-t border-gray-200 pt-4 space-y-3">
            <div className="text-sm text-gray-600 space-y-1">
              <p>
                <span className="font-semibold">Accepted:</span> PDF, JPG, PNG
              </p>
              <p>
                <span className="font-semibold">Max size:</span> 50MB each
              </p>
            </div>

            <div className="bg-blue-50 p-3 rounded-lg">
              <p className="text-sm text-gray-700">
                <span className="font-semibold">💡 Tip:</span> Salary slips, bank
                statements, and bills work best.
              </p>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
