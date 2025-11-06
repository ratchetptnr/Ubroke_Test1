# Ubroke 2.0 MVP — System Architecture & Visual Summary

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                          UBROKE 2.0 MVP                         │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    FRONTEND (Next.js)                    │  │
│  │                                                          │  │
│  │  ┌─────────────┐  ┌──────────────┐  ┌──────────────┐   │  │
│  │  │ Onboarding  │→ │    Upload    │→ │   Results    │   │  │
│  │  │   Flow      │  │   Interface  │  │  Dashboard   │   │  │
│  │  └─────────────┘  └──────────────┘  └──────────────┘   │  │
│  │                                          ↓              │  │
│  │                                  ┌─────────────────┐   │  │
│  │                                  │  Chat Interface │   │  │
│  │                                  │  (AI Q&A)       │   │  │
│  │                                  └─────────────────┘   │  │
│  └──────────────────────────────────────────────────────────┘  │
│                            ↓                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                 BACKEND (Node.js)                        │  │
│  │                                                          │  │
│  │  ┌──────────────┐      ┌──────────────┐                │  │
│  │  │ File Parser  │      │ AI Integration                │  │
│  │  │ (PDF/Image)  │      │ (Claude API) │                │  │
│  │  └──────────────┘      └──────────────┘                │  │
│  │         ↓                      ↓                        │  │
│  │   Extract: Date           Generate:                    │  │
│  │   Amount, Category        - Insights                   │  │
│  │   Vendor, Type            - Categorization             │  │
│  │                           - Chat Responses             │  │
│  └──────────────────────────────────────────────────────────┘  │
│                            ↓                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              DATABASE (Supabase Postgres)               │  │
│  │                                                          │  │
│  │  ┌─────────────────┐  ┌──────────────────────────────┐ │  │
│  │  │    Users        │  │  UploadedDocuments            │ │  │
│  │  │ ─────────────   │  │ ────────────────────────────  │ │  │
│  │  │ • ID            │  │ • ID                         │ │  │
│  │  │ • Income Range  │  │ • UserID                     │ │  │
│  │  │ • Employment    │  │ • File Path                  │ │  │
│  │  │ • Created_at    │  │ • Parsed Data (JSON)         │ │  │
│  │  └─────────────────┘  │ • Categories                 │ │  │
│  │                       │ • Insights                   │ │  │
│  │  ┌──────────────────┐ │ • Created_at                 │ │  │
│  │  │ ChatHistories    │ └──────────────────────────────┘ │  │
│  │  │ ──────────────   │                                 │  │
│  │  │ • ID             │  ┌──────────────────────────────┐ │  │
│  │  │ • UserID         │  │  FileStorage                 │ │  │
│  │  │ • Messages       │  │ ────────────────────────────  │ │  │
│  │  │ • Context Ref    │  │ • Uploaded PDFs             │ │  │
│  │  │ • Created_at     │  │ • Photos                    │ │  │
│  │  └──────────────────┘  │ • Metadata                  │ │  │
│  │                        └──────────────────────────────┘ │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## User Journey Timeline (MVP)

```
TIMELINE                    USER ACTION              SYSTEM RESPONSE

T=0:00 ─────────────────────────────────────────────────────────
       User Opens App       
                            ↓ Welcome Screen shown
       T=0:30 ─────────────────────────────────────────────────
              User clicks   
              "Continue"    ↓ Quick Profile form (3 questions)
       
       T=1:15 ─────────────────────────────────────────────────
              User answers
              profile Q's    ↓ Upload Screen shown
       
       T=2:00 ─────────────────────────────────────────────────
              User uploads  
              salary slip    ↓ File validated, parsing begins
                            
              (Processing) ┌─ FAST PATH: < 10 sec
                          │  ↓ Results shown immediately
                          │
                          └─ MEDIUM PATH: 10-15 sec
                          │  ↓ Progress bar shows
                          │  ↓ Results shown when done
                          │
                          └─ SLOW PATH: > 15 sec
                             ↓ Queued for background
                             ↓ "Check back later"
       
       T=3:00 ─────────────────────────────────────────────────
              User sees     
              Results       ↓ Expense breakdown displayed
              Dashboard     ↓ Insights shown
              
       T=4:30 ─────────────────────────────────────────────────
              User clicks   
              "Ask AI"      ↓ Chat interface opens
                            
       T=5:00 ─────────────────────────────────────────────────
              User types    
              question      ↓ AI processes with context
                            
       T=6:00 ─────────────────────────────────────────────────
              AI responds   
              with insights ↓ User reads answer
       
       T=7:00+ ─────────────────────────────────────────────────
              User follows  
              suggestions   ↓ Core loop proven
              or uploads    
              more data
       
GOAL: First-time user to "aha" moment (see results + ask question) 
      in < 7 minutes. ✓
```

---

## Data Flow: Upload to Results

```
┌─ USER UPLOADS FILE ─────────────────────────────────────┐
│                                                          │
│ FRONTEND VALIDATION                                     │
│ ├─ File type check (PDF, JPG, PNG)                      │
│ ├─ File size check (< 50MB)                             │
│ └─ File preview (if image)                              │
│                                                          │
│ ↓                                                        │
│                                                          │
│ UPLOAD TO STORAGE (Supabase Storage)                    │
│ ├─ Generate unique filename                             │
│ ├─ Store file with metadata                             │
│ └─ Get file path for processing                         │
│                                                          │
│ ↓                                                        │
│                                                          │
│ TRIGGER AI PARSING (Backend API)                        │
│ ├─ Download file                                        │
│ ├─ Convert to text (if PDF) or process image            │
│ ├─ Call Claude API with prompt:                         │
│ │   "Extract transactions from this document.           │
│ │    For each: date, amount, vendor, category."         │
│ └─ Receive structured JSON response                     │
│                                                          │
│ ↓                                                        │
│                                                          │
│ CLASSIFY & AGGREGATE                                    │
│ ├─ Categorize each transaction:                         │
│ │   • Rent & Housing                                    │
│ │   • Food & Delivery                                   │
│ │   • Entertainment                                     │
│ │   • Subscriptions                                     │
│ │   • Transport                                         │
│ │   • Health & Wellness                                 │
│ │   • Other                                             │
│ ├─ Detect recurring transactions                        │
│ └─ Calculate totals & percentages                       │
│                                                          │
│ ↓                                                        │
│                                                          │
│ GENERATE INSIGHTS (AI)                                  │
│ ├─ Compare spending to norms                            │
│ ├─ Flag anomalies ("Food delivery is high")             │
│ ├─ Suggest optimizations ("Save ₹5k by cutting...")     │
│ └─ Store insights as JSON                               │
│                                                          │
│ ↓                                                        │
│                                                          │
│ STORE IN DATABASE                                       │
│ ├─ Save parsed transaction data                         │
│ ├─ Save category breakdown                              │
│ ├─ Save generated insights                              │
│ └─ Link to user & original file                         │
│                                                          │
│ ↓                                                        │
│                                                          │
│ SEND TO FRONTEND                                        │
│ └─ Return results JSON (breakdown + insights)           │
│                                                          │
│ ↓                                                        │
│                                                          │
│ DISPLAY RESULTS                                         │
│ ├─ Render category breakdown with charts                │
│ ├─ Show key insights                                    │
│ ├─ Enable chat with this data as context                │
│ └─ Store in user context for AI chat                    │
│                                                          │
└────────────────────────────────────────────────────────┘
```

---

## Chat Context Management

```
CHAT CONTEXT LAYERS (What AI "Remembers")

┌─ PERSISTENT CONTEXT ────────────────────────┐
│ (Loaded once per session)                   │
│                                             │
│ • User Profile:                             │
│   - Income range (₹5-10L)                   │
│   - Employment type (Salaried)              │
│   - Financial goals                         │
│                                             │
│ • All Uploaded Documents:                   │
│   - Document date ranges                    │
│   - Parsed transaction summaries             │
│   - Category totals                         │
│   - Key insights from each                  │
│                                             │
│ • Historical Context:                       │
│   - Previous months analyzed                │
│   - Spending trends                         │
│   - Known recurring items                   │
│                                             │
└─────────────────────────────────────────────┘
                    ↓ SENT WITH EACH CHAT MESSAGE ↓
┌─ CHAT CONTEXT ──────────────────────────────┐
│ (Sent with user message to Claude)          │
│                                             │
│ System Prompt:                              │
│ "You are a friendly AI finance advisor.     │
│  You have access to their expense data.     │
│  Answer specific to THEIR numbers.          │
│  Be honest about limits.                    │
│  Suggest one action per response."          │
│                                             │
│ User Data:                                  │
│ • Their recent spending breakdown           │
│ • Income estimate                           │
│ • Top categories                            │
│ • Previous questions & answers              │
│                                             │
│ User Message:                               │
│ "Why am I spending so much on food?"        │
│                                             │
└─────────────────────────────────────────────┘
                    ↓ AI PROCESSES ↓
┌─ AI RESPONSE ───────────────────────────────┐
│                                             │
│ "You spent ₹8,500 on food (18% of total).  │
│  That's above average. Here's why...        │
│  Here's how to save..."                     │
│                                             │
│ [Specific to their data, not generic]       │
│                                             │
└─────────────────────────────────────────────┘
```

---

## Error Handling Map

```
USER ACTION → VALIDATION CHECK → ERROR? → RESPONSE

Upload File
    ├─ Type invalid (not PDF/JPG/PNG)
    │  └─ Show: "File type not supported. Try PDF or JPG."
    │
    ├─ Size too large (> 50MB)
    │  └─ Show: "File too large. Max 50MB."
    │
    └─ Valid → Proceed to parsing

Parse File
    ├─ Parsing takes < 10 sec
    │  └─ Show results immediately
    │
    ├─ Parsing takes 10-15 sec
    │  └─ Show progress bar
    │
    ├─ Parsing takes > 15 sec
    │  └─ Queue background, notify user later
    │
    └─ Parse fails (unreadable doc)
       └─ Show: "Couldn't read this. Try clearer photo/PDF."

Chat Question
    ├─ Question is ambiguous
    │  └─ Response: "Can you clarify what you mean by...?"
    │
    ├─ Outside scope (crypto advice, betting)
    │  └─ Response: "I can't advise on that. Check a CA."
    │
    ├─ Needs more data
    │  └─ Response: "I need more months of data. Can you upload...?"
    │
    └─ Answerable → Provide specific advice
```

---

## Database Schema (Simplified)

```
USERS TABLE
├─ id (UUID)
├─ email
├─ income_range (enum: '0-2L', '2-5L', etc.)
├─ employment_type (enum: 'salaried', 'freelancer', etc.)
├─ primary_goal (string)
├─ created_at
└─ updated_at

UPLOADED_DOCUMENTS TABLE
├─ id (UUID)
├─ user_id (FK → USERS)
├─ file_path (storage URL)
├─ original_filename
├─ file_type (PDF, JPG, PNG)
├─ parsed_data (JSON)
│  ├─ transactions: [
│  │   {date, amount, vendor, category, recurring}
│  │ ]
│  ├─ category_totals: {rent: 25000, food: 8500, ...}
│  ├─ total_amount: 47500
│  └─ document_date_range: {start, end}
├─ insights (JSON)
│  ├─ flagged_items: [{category, reason, amount}]
│  ├─ recommendations: [text]
│  └─ summary: text
├─ parse_status (pending, completed, failed)
├─ parse_duration_ms (integer)
├─ created_at
└─ updated_at

CHAT_HISTORIES TABLE
├─ id (UUID)
├─ user_id (FK → USERS)
├─ messages: [
│  {role: 'user', content: text, timestamp},
│  {role: 'assistant', content: text, timestamp}
│ ]
├─ context_ref_documents (array of document IDs used)
├─ created_at
└─ updated_at
```

---

## Deployment Pipeline

```
LOCAL DEVELOPMENT
    ↓
    npm run dev (Runs on localhost:3000)
    ↓ TEST LOCALLY ↓
    
PUSH TO GIT
    ↓
    git push origin main
    ↓
VERCEL AUTO-DEPLOY
    ├─ Detects Next.js
    ├─ Installs dependencies
    ├─ Runs build
    ├─ Deploys to Vercel edge
    └─ Live at ubroke.vercel.app
    
DATABASE (Supabase)
    ├─ Cloud Postgres instance
    ├─ Auto-backups enabled
    └─ Connected via env variable
    
FILE STORAGE (Supabase Storage)
    ├─ Bucket: "user-documents"
    ├─ Public or private based on auth
    └─ Auto-cleanup for failed parses
    
LLM API (Claude)
    ├─ API key stored in .env
    ├─ Calls routed through backend
    └─ Costs tracked per user
```

---

## Success Scenarios

### Scenario 1: User Loves It (Happy Path) ✓
```
Day 1: Upload salary slip
       → See breakdown (food delivery is 18%)
       → Ask "How do I reduce this?"
       → Get actionable tips
       → Feels empowered

Day 3: Upload credit card statement
       → Ask "Can I afford a new phone?"
       → Get honest answer with runway analysis
       → Makes informed decision

Day 7: Habit formed
       → "I always ask Ubroke before buying"
       → Recommended to friend
       → Using app 2-3x per week

METRIC: ✓ Chat activation 70%+ / ✓ D3 retention 50%+
```

### Scenario 2: User Finds It Confusing (Fix Path)
```
Day 1: Upload document
       → Parse fails (can't read it)
       → Shows clear error + suggestion
       → Re-uploads clearer image
       → Works

Day 2: Sees results but doesn't know what to do
       → Doesn't click "Ask AI"
       → App shows suggested questions
       → Clicks one, gets answer
       → Understands value

ACTION: Add tooltips, guided tour, suggested questions
        to improve adoption
```

### Scenario 3: User Loses Interest (Kill Signal)
```
Day 1: Upload works, sees results
       → Doesn't ask questions
       → Closes app

Day 7: Doesn't return
       → No engagement

METRIC: ✗ Chat activation < 30% / ✗ D3 retention < 20%
ACTION: Interview users, pivot messaging or features
```

---

## Next Steps from Here

1. **Validate this flow** with 3-5 target Gen Z users
   - Do they understand the value prop?
   - Do they want to upload docs?
   - Do they ask questions about results?

2. **Start coding** the MVP using these specs
   - Use flowchart for navigation
   - Use screen specs for design
   - Use quick reference for tone

3. **Launch quickly** (4-6 weeks)
   - Get real users in first
   - Iterate based on behavior

4. **Measure ruthlessly**
   - Track every metric mentioned
   - Kill features that don't serve core loop
   - Double down on what works

---

Good luck! 🚀
