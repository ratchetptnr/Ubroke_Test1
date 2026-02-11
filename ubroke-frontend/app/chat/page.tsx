"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { ArrowLeft, Send } from "lucide-react";

interface Message {
  role: "user" | "assistant";
  content: string;
}

export default function ChatPage() {
  const router = useRouter();
  const [messages, setMessages] = useState<Message[]>([
    {
      role: "assistant",
      content:
        "Hi! I've analyzed your January expenses. Your biggest spend is rent (52%), followed by food delivery (18%). Ask me anything about your money!",
    },
  ]);
  const [input, setInput] = useState("");

  const suggestedQuestions = [
    "Can I afford a ₹5k laptop?",
    "Should I cut any subscriptions?",
    "How much can I save?",
    "Why is my food delivery so high?",
  ];

  const handleSend = () => {
    if (!input.trim()) return;

    const userMessage: Message = { role: "user", content: input };
    setMessages([...messages, userMessage]);

    // Simulate AI response
    setTimeout(() => {
      const aiResponse: Message = {
        role: "assistant",
        content:
          "You spent ₹8,500 on food delivery this month (18% of total). That's higher than the 8-12% most people spend. You had 40 orders total. If you cut to 15 orders/month, you'd save ~₹5,000. That's ₹60k/year — enough for a vacation! Want tips on how?",
      };
      setMessages((prev) => [...prev, aiResponse]);
    }, 1000);

    setInput("");
  };

  const handleSuggestion = (question: string) => {
    setInput(question);
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white flex flex-col">
      {/* Header */}
      <div className="bg-white border-b border-gray-200 p-4 shadow-sm">
        <div className="max-w-md mx-auto flex items-center gap-2">
          <Button
            variant="ghost"
            size="icon"
            onClick={() => router.back()}
          >
            <ArrowLeft className="h-5 w-5" />
          </Button>
          <div>
            <h1 className="text-lg font-semibold">Finance Chat</h1>
            <p className="text-xs text-gray-500">Ask me anything about your money</p>
          </div>
        </div>
      </div>

      {/* Chat Messages */}
      <div className="flex-1 overflow-y-auto p-4">
        <div className="max-w-md mx-auto space-y-4">
          <div className="text-center mb-6">
            <h2 className="text-xl font-bold text-gray-900 mb-2">
              💬 Ask Me Anything About Your Money
            </h2>
          </div>

          {messages.map((message, index) => (
            <div
              key={index}
              className={`flex ${
                message.role === "user" ? "justify-end" : "justify-start"
              }`}
            >
              <Card
                className={`max-w-[80%] p-4 ${
                  message.role === "user"
                    ? "bg-primary text-primary-foreground"
                    : "bg-white"
                }`}
              >
                <div className="space-y-2">
                  <p className="text-xs font-semibold opacity-70">
                    {message.role === "user" ? "You" : "Assistant"}
                  </p>
                  <p className="text-sm">{message.content}</p>
                </div>
              </Card>
            </div>
          ))}
        </div>
      </div>

      {/* Suggested Questions */}
      {messages.length === 1 && (
        <div className="border-t border-gray-200 bg-white p-4">
          <div className="max-w-md mx-auto space-y-3">
            <p className="text-xs font-semibold text-gray-600">
              💡 Suggested questions:
            </p>
            <div className="grid grid-cols-1 gap-2">
              {suggestedQuestions.map((question) => (
                <Button
                  key={question}
                  variant="outline"
                  size="sm"
                  className="text-left justify-start h-auto py-2 text-xs"
                  onClick={() => handleSuggestion(question)}
                >
                  {question}
                </Button>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* Input Area */}
      <div className="border-t border-gray-200 bg-white p-4 shadow-lg">
        <div className="max-w-md mx-auto flex gap-2">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyPress={(e) => e.key === "Enter" && handleSend()}
            placeholder="Type your question..."
            className="flex-1 px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary text-sm"
          />
          <Button
            size="icon"
            className="h-12 w-12"
            onClick={handleSend}
          >
            <Send className="h-5 w-5" />
          </Button>
        </div>
      </div>
    </div>
  );
}
