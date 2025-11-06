# Ubroke 2.0 MVP — Screen-by-Screen Specifications

## Overview
This document details every screen in the MVP, user interactions, error states, and edge cases.

---

## 1️⃣ ONBOARDING FLOW

### Screen 1.1: Welcome Screen
**Purpose:** Build trust, set expectations, clarify what the app does.

**Layout:**
```
┌─────────────────────────────────┐
│                                 │
│  [Logo] UBROKE 2.0              │
│                                 │
│  Your Personal Finance Brain    │
│  (Not a bank. Not a tracker.)   │
│  (Just clarity for your money.) │
│                                 │
│  ─────────────────────────────  │
│                                 │
│  What we do:                    │
│  ✓ Read your financial docs     │
│  ✓ Show you where money goes    │
│  ✓ Answer your money questions  │
│                                 │
│  What we DON'T do:              │
│  ✗ Ask for passwords/card info  │
│  ✗ Move your money around       │
│  ✗ Make decisions for you       │
│                                 │
│  ─────────────────────────────  │
│                                 │
│        [Continue →]             │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- Tone: Friendly, non-corporate, honest
- Reassure about data safety upfront
- Set expectation: "You're in control"

**Interaction:**
- Tap [Continue] → Go to Screen 1.2

---

### Screen 1.2: Quick Profile Setup
**Purpose:** Gather minimal context so AI can personalize responses.

**Layout:**
```
┌─────────────────────────────────┐
│ ← Back                          │
│                                 │
│ Tell us about your money        │
│                                 │
│ 1. How much do you make?        │
│    ○ ₹0-2 LPA                   │
│    ○ ₹2-5 LPA                   │
│    ○ ₹5-10 LPA                  │
│    ○ ₹10-20 LPA                 │
│    ○ ₹20+ LPA                   │
│                                 │
│ 2. What's your work type?       │
│    ○ Salaried                   │
│    ○ Freelancer                 │
│    ○ Student                    │
│    ○ Multiple income sources    │
│                                 │
│ 3. What's your main goal?       │
│    ○ Understand my spending     │
│    ○ Save more money            │
│    ○ Make better decisions      │
│    ○ Plan for something         │
│                                 │
│ ────────────────────────────────│
│                                 │
│  [Skip] or [Let's Start →]     │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- Income ranges, not exact amounts (privacy-first)
- All questions optional (not blockers)
- Skip is fine — AI learns from documents anyway

**Interactions:**
- Select options → [Let's Start] → Go to Screen 2.1 (Upload)
- Or [Skip] → Go to Screen 2.1 directly

---

## 2️⃣ UPLOAD & PROCESSING FLOW

### Screen 2.1: Upload Screen
**Purpose:** Make uploading documents as frictionless as possible.

**Layout:**
```
┌─────────────────────────────────┐
│ ← Back      Ubroke              │
│                                 │
│ Upload Your Financial Docs      │
│ (Bills, salary slips, bank      │
│  statements, receipts, etc.)    │
│                                 │
│ ─────────────────────────────── │
│                                 │
│        ┌──────────────┐         │
│        │              │         │
│        │  📁 Drag &   │         │
│        │  drop files  │         │
│        │  here        │         │
│        │              │         │
│        └──────────────┘         │
│                                 │
│     or                          │
│                                 │
│  [📸 Take Photo]  [📂 Browse]  │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ Accepted: PDF, JPG, PNG         │
│ Max size: 50MB each             │
│                                 │
│ 💡 Tip: Salary slips, bank     │
│    statements, and bills work   │
│    best.                        │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- Make it visual and inviting (drag & drop preferred)
- Show what's accepted upfront
- Reassure with tip about best file types

**Interactions:**
- Drag & drop file → Go to Screen 2.2
- [📸 Take Photo] → Open camera → Capture → Go to Screen 2.2
- [📂 Browse] → File picker → Select → Go to Screen 2.2

**Validation:**
- File type check (PDF, JPG, PNG only) → If invalid, show error (see 2.3a)
- File size check (< 50MB) → If too large, show error (see 2.3a)

---

### Screen 2.2: Upload Success + Processing Starts
**Purpose:** Confirm upload, show processing has begun.

**Layout:**
```
┌─────────────────────────────────┐
│                                 │
│      ✅ File Uploaded!          │
│                                 │
│  "Salary_Jan_2024.pdf"          │
│                                 │
│  We're analyzing your document. │
│  This usually takes 5-15        │
│  seconds.                       │
│                                 │
│ ─────────────────────────────── │
│                                 │
│  [Progress indicator spinning]  │
│                                 │
│  Scanning for transactions...   │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ [Upload Another]  [Cancel]      │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- Show filename for clarity
- Set expectation: "5-15 seconds"
- Allow upload another while processing (queue multiple)

**Interactions:**
- [Upload Another] → Back to Screen 2.1 (can add more docs)
- [Cancel] → Stop processing, go back to Screen 2.1
- System auto-progresses to next screen based on parsing speed

---

### Screen 2.3a: Error — Invalid File
**Purpose:** User uploaded unsupported file type or too large.

**Layout:**
```
┌─────────────────────────────────┐
│                                 │
│      ❌ Oops!                   │
│                                 │
│  We couldn't read this file.    │
│                                 │
│  Reason:                        │
│  [- File type not supported]    │
│   [- File too large (>50MB)]    │
│                                 │
│ ─────────────────────────────── │
│                                 │
│  What to try:                   │
│  • Convert to PDF or JPG        │
│  • Take a clearer photo         │
│  • Make sure file is under 50MB │
│                                 │
│ ─────────────────────────────── │
│                                 │
│     [Try Again] [Go Back]       │
│                                 │
└─────────────────────────────────┘
```

**Interactions:**
- [Try Again] → Back to Screen 2.1
- [Go Back] → Back to previous screen

---

### Screen 2.3b: Processing — Fast Path (< 10 seconds)
**Purpose:** Parse complete, show results immediately.

**Layout:**
```
┌─────────────────────────────────┐
│                                 │
│      ✅ Analysis Complete!      │
│                                 │
│  Your document is ready.        │
│                                 │
│ ─────────────────────────────── │
│                                 │
│  Found:                         │
│  💰 Transactions: 47            │
│  📊 Categories: 8               │
│  📈 Recurring: 6                │
│                                 │
│ ─────────────────────────────── │
│                                 │
│   [View Results →]              │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- Show what was found to build confidence
- Simple preview stats

**Interactions:**
- [View Results →] → Go to Screen 3.1 (Results)

---

### Screen 2.3c: Processing — Medium Path (10-15 seconds)
**Purpose:** Parsing in progress with visual feedback.

**Layout:**
```
┌─────────────────────────────────┐
│                                 │
│  📊 Analyzing...                │
│                                 │
│ ═════════════════════ 75%       │
│                                 │
│  Step 1: Reading document...✓   │
│  Step 2: Extracting data...✓    │
│  Step 3: Categorizing...(in)    │
│  Step 4: Building summary...    │
│                                 │
│ ─────────────────────────────── │
│                                 │
│  Typically takes 10-15 seconds. │
│  Hang tight!                    │
│                                 │
│ ─────────────────────────────── │
│                                 │
│      [Cancel]                   │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- Real progress bar (not fake)
- Show steps for reassurance
- "Hang tight" is friendly tone

**Interactions:**
- [Cancel] → Stop processing, go back to Screen 2.1
- Auto-progress to Results (Screen 3.1) when done

---

### Screen 2.3d: Processing — Slow Path (> 15 seconds)
**Purpose:** Parsing too slow, move to background, notify user later.

**Layout:**
```
┌─────────────────────────────────┐
│                                 │
│  ⏳ Taking a Bit Longer         │
│                                 │
│  We're still analyzing your     │
│  document. It's a tricky one!   │
│                                 │
│ ─────────────────────────────── │
│                                 │
│  Here's what happens next:      │
│                                 │
│  1. We'll finish analyzing in  │
│     the background             │
│  2. You'll get a notification  │
│     when it's ready (email +   │
│     in-app)                    │
│  3. Come back to see your      │
│     results!                   │
│                                 │
│ ─────────────────────────────── │
│                                 │
│      [Got It, See You Later]   │
│                                 │
│  or                             │
│                                 │
│      [Stay & Wait]              │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- Don't make user feel bad for slow file
- Set expectation about notification
- Give them choice to wait or leave

**Interactions:**
- [Got It, See You Later] → Go to Screen 1.2 (Dashboard)
- [Stay & Wait] → Show progress bar, wait for completion, then Screen 3.1

---

### Screen 2.3e: Error — Parse Failed
**Purpose:** AI couldn't understand the document (corrupted, blurry, not financial).

**Layout:**
```
┌─────────────────────────────────┐
│                                 │
│      ❌ Couldn't Read This      │
│                                 │
│  We tried our best, but this    │
│  document is too tricky for us. │
│                                 │
│ ─────────────────────────────── │
│                                 │
│  Why this might happen:         │
│  • Photo is too blurry          │
│  • Document is corrupted        │
│  • It's not a financial doc     │
│                                 │
│ ─────────────────────────────── │
│                                 │
│  What to try:                   │
│  1. Re-scan/take clearer photo  │
│  2. Use original PDF if you     │
│     have it                     │
│  3. Try a different document    │
│                                 │
│ ─────────────────────────────── │
│                                 │
│  [Try Another] [Skip This]      │
│                                 │
└─────────────────────────────────┘
```

**Interactions:**
- [Try Another] → Back to Screen 2.1
- [Skip This] → Remove this file, go back to Screen 2.1

---

## 3️⃣ RESULTS FLOW

### Screen 3.1: Expense Breakdown Dashboard
**Purpose:** Show the "aha" moment — where money actually goes.

**Layout:**
```
┌─────────────────────────────────┐
│ ← Back      Ubroke              │
│                                 │
│ 📊 Your Expense Breakdown       │
│    January 2024                 │
│                                 │
│ ═══════════════════════════════ │
│                                 │
│ Total Analyzed: ₹47,500         │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ 📈 BY CATEGORY                  │
│                                 │
│ 🏠 Rent & Housing      ₹25,000  │
│    ████████████ 52%             │
│                                 │
│ 🍕 Food & Delivery     ₹8,500   │
│    ██████ 18%                   │
│                                 │
│ 🎮 Entertainment       ₹4,200   │
│    ████ 9%                      │
│                                 │
│ 📱 Subscriptions       ₹3,800   │
│    ███ 8%                       │
│                                 │
│ 🚗 Transport           ₹2,000   │
│    ██ 4%                        │
│                                 │
│ 💊 Health & Wellness  ₹1,500    │
│    ██ 3%                        │
│                                 │
│ Other                  ₹2,500   │
│    ██ 6%                        │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ 💡 INSIGHTS                     │
│                                 │
│ • Your top spend: Rent (52%)    │
│                                 │
│ • Food delivery is 18% of your  │
│   total spend — high! 🔴       │
│                                 │
│ • You have 6 recurring costs    │
│   (subscriptions, gym, etc.)   │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ [Ask AI]  [Upload More]         │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- Show totals, percentages, and visuals
- Highlight anomalies (high food delivery spend)
- Keep insights simple and actionable
- Colors help: high spend = 🔴, OK = 🟡, good = 🟢

**Interactions:**
- [Ask AI] → Go to Screen 4.1 (Chat)
- [Upload More] → Go to Screen 2.1 (Upload)
- ← Back → Go to Screen 1.2 (Dashboard)
- Tap on category → Expand to see transaction details (optional)

---

### Screen 3.2: Category Detail View (Optional, on tap)
**Purpose:** Deep dive into specific category.

**Layout:**
```
┌─────────────────────────────────┐
│ ← Back     Food & Delivery      │
│                                 │
│ 🍕 Food & Delivery              │
│    Total: ₹8,500                │
│    18% of your spending         │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ 📊 Breakdown:                   │
│    Zomato      ₹4,200  (49%)    │
│    Swiggy      ₹2,800  (33%)    │
│    Restaurants ₹1,500  (18%)    │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ 📅 Recent Transactions:         │
│                                 │
│ Jan 28  Zomato   - ₹450         │
│ Jan 27  Swiggy   - ₹280         │
│ Jan 26  Zomato   - ₹520         │
│ Jan 25  Restro   - ₹1200        │
│ Jan 24  Zomato   - ₹380         │
│                                 │
│ ─────────────────────────────── │
│                                 │
│     [Ask AI About This]         │
│                                 │
└─────────────────────────────────┘
```

**Interactions:**
- [Ask AI About This] → Go to Screen 4.1 (Chat) with pre-filled context about food spending

---

## 4️⃣ CHAT FLOW

### Screen 4.1: Chat Interface
**Purpose:** Let user ask questions about their finances in natural language.

**Layout:**
```
┌─────────────────────────────────┐
│ ← Back      Finance Chat        │
│                                 │
│ 💬 Ask Me Anything About Your   │
│    Money                        │
│                                 │
│ ═══════════════════════════════ │
│                                 │
│ [Chat history scrolls up]       │
│                                 │
│ Assistant:                      │
│ Hi! I've analyzed your January  │
│ expenses. Your biggest spend is │
│ rent (52%), followed by food    │
│ delivery (18%). Ask me anything │
│ about your money!               │
│                                 │
│ User:                           │
│ Why is my food delivery so high?│
│                                 │
│ Assistant:                      │
│ You spent ₹8,500 on food        │
│ delivery this month, which is   │
│ 18% of your total spend. That's │
│ notably high — most people      │
│ spend 8-12% on this.            │
│                                 │
│ You had 24 orders from Zomato   │
│ and 16 from Swiggy. That's      │
│ roughly 1 order every other     │
│ day. Here's a small win: if you │
│ cut this to 10 orders/month,    │
│ you'd save ~₹6k.                │
│                                 │
│ User:                           │
│ How can I reduce this? [cursor] │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ 💬 Type your question...        │
│                                 │
│ [Send ➤]                        │
│                                 │
│ ─────────────────────────────── │
│                                 │
│ 💡 Suggested questions:         │
│ "Can I afford a ₹5k laptop?"    │
│ "Should I cut any subscriptions?"│
│ "How much can I save?"          │
│                                 │
└─────────────────────────────────┘
```

**Content Notes:**
- AI tone: helpful, specific, not preachy
- Reference actual numbers from their data
- Give actionable suggestions
- Show suggested questions to guide first-time users

**Interactions:**
- Type message → [Send ➤] → AI responds
- Tap suggested question → Auto-fills, can edit, send
- ← Back → Go to previous screen (Screen 3.1 or 1.2)

---

### Screen 4.2: Chat Response Examples

#### Example 1: Spending Question
```
User: "Why am I spending so much on subscriptions?"