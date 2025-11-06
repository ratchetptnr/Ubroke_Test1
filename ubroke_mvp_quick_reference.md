# Ubroke 2.0 MVP — Quick Reference Guide

## Core Value Proposition
**"Upload your financial docs → AI auto-categorizes your spending → Chat to understand & optimize."**

---

## The MVP in 30 Seconds

```
FIRST-TIME USER JOURNEY:
┌─────────────────────────────────┐
│ 1. Welcome Screen (30 sec)      │
│    - Set trust & expectations   │
│                                 │
│ 2. Quick Profile (45 sec)       │
│    - Income range, job, goal    │
│                                 │
│ 3. Upload Docs (1-2 min)        │
│    - Drag/drop salary slip      │
│                                 │
│ 4. Wait for Parse (5-15 sec)    │
│    - AI processes in real-time  │
│                                 │
│ 5. See Results (2-3 min)        │
│    - Expense breakdown          │
│    - Category breakdown         │
│    - Key insights               │
│                                 │
│ 6. Ask Question (2+ min)        │
│    - "Why am I spending on X?"  │
│    - AI answers with context    │
│                                 │
│ TOTAL: ~10-15 minutes to value  │
└─────────────────────────────────┘
```

---

## 5 Core Screens (MVP)

| Screen | Purpose | User Action |
|--------|---------|-------------|
| **Welcome** | Build trust, set tone | "Let's start" → Profile |
| **Profile** | Gather context (3 questions) | Answers income/job/goal → Upload |
| **Upload** | Add financial documents | Drag PDF/photo → Processing |
| **Results** | Show expense breakdown | View categories, see insights → Chat |
| **Chat** | Ask questions about money | Type question → AI response |

---

## Three Parsing Paths

### Fast Path (< 10 seconds)
```
Upload → Processing → Results
(Show instantly, user gets immediate gratification)
```

### Medium Path (10-15 seconds)
```
Upload → Processing (progress bar) → Results
(Show progress, set expectation)
```

### Slow Path (> 15 seconds)
```
Upload → Queue for background
→ Notification when ready → User returns → Results
(Acknowledge, don't frustrate)
```

---

## User Journey Map

### Day 1: First Upload
```
Onboarding → Upload Salary Slip → See Breakdown → Ask AI Question → Leave
```

### Day 3-7: Return User
```
Open App → Dashboard → Upload New Doc OR Ask Existing Question → Leave
```

### Week 2+: Habit Formation (Goal)
```
Multiple uploads + Regular questions = App becomes "go-to" for money decisions
```

---

## Data Flow

```
User Upload
    ↓
File Validation (format, size)
    ├─ Valid? → Parse with AI
    └─ Invalid? → Error, ask retry
    ↓
AI Parsing
    ├─ Extract: Date, Amount, Category, Vendor
    ├─ Classify: Income / Expense / Investment / Tax / Other
    └─ Detect: Recurring vs. One-time
    ↓
Results Generated
    ├─ Total spend breakdown
    ├─ Category percentages
    ├─ Key insights
    └─ Store for future context
    ↓
Display Results
    ├─ Show dashboard
    └─ Enable chat with full context
    ↓
User Interaction
    ├─ Question → AI responds with their data
    └─ Upload → Back to parsing loop
```

---

## AI Personality (Chat)

### Tone
- Friendly, conversational (not corporate)
- Specific to their data (not generic)
- Helpful and actionable (not judgmental)
- Honest about limits ("I need more data...")

### Approach
1. **Listen** to the question
2. **Reference** their actual numbers
3. **Contextualize** (how they compare)
4. **Suggest** one action
5. **Ask** a follow-up

### Example
```
User: "Am I spending too much on food delivery?"

Bad response: "Food delivery is often discretionary."
Good response: "You spent ₹8,500 this month (18% of total). 
That's higher than the 8-12% most people spend. If you cut to 
15 orders/month, you'd save ₹5,000. Want tips on how?"
```

---

## Key Differentiators vs. ChatGPT

| Aspect | ChatGPT | Ubroke |
|--------|---------|--------|
| Context | Generic financial advice | *Your actual* financial data |
| Learning | Forgets each chat | Remembers all docs + chats |
| Accuracy | General knowledge | Specific to your situation |
| Persistence | Stateless | Full history stored |
| UX | Text chat | Chat + structured data |

---

## MVP Out-of-Scope (Explicitly)

### Won't Include:
- ❌ Automation (email parsing, auto-sync)
- ❌ Goals/budgets (yet)
- ❌ Predictions ("You'll save $X by June")
- ❌ Notifications (email/push)
- ❌ Investment advice
- ❌ Tax filing
- ❌ Family accounts
- ❌ Portfolio tracking
- ❌ Gamification

### Why Not:
These are all Phase 2+. MVP must prove users care about: **"Understand my spending + Chat about it."**

---

## Success Metrics

### For MVP Launch:
1. **Upload Completion Rate**: 80%+ of new users upload at least 1 doc
2. **Chat Activation**: 60%+ of users who see results ask at least 1 question
3. **Day 3 Retention**: 40%+ return within 3 days
4. **Conversation Depth**: 2+ questions per engaged user (first week)

### Red Flags (Kill Criteria):
- Upload completion < 50%
- Chat activation < 30%
- Day 3 retention < 20%
- Average session < 2 minutes

---

## Tech Stack (Recommended)

### Frontend
- **Framework**: Next.js 14 (App Router)
- **Styling**: Tailwind CSS
- **Charts**: Recharts (for expense breakdown)
- **Upload**: TurboUpload or native browser API

### Backend
- **Database**: Supabase (Postgres + Auth + Storage)
- **AI/LLM**: Claude API or OpenAI
- **File Processing**: Node.js (pdf-parse, sharp for images)
- **Background Jobs**: BullMQ or Supabase Edge Functions

### Deployment
- **Web**: Vercel (Next.js native)
- **Database**: Supabase cloud
- **Storage**: Supabase Storage or S3

### Cost Estimate (First Month)
- Vercel: ~$20-50
- Supabase: ~$100-200 (file storage, API calls)
- LLM API (Claude): ~$50-200 (depends on usage)
- **Total: ~$200-500 (pre-revenue)**

---

## Onboarding Copy (Reference)

### Welcome Screen
```
"Meet your AI finance brain.
Not a bank. Not a tracker.
Just honest clarity about your money."
```

### Upload Screen
```
"Dump your bills, salary slips, and receipts here.
We'll read them and show you exactly where your money goes."
```

### Results Screen
```
"Here's your money, by category. 
Below, ask me anything."
```

### Chat Prompt
```
"Ask me anything: 'Why am I spending so much on X?' 
'Can I afford Y?' 'How do I save more?'"
```

---

## MVP Launch Timeline (Estimate)

### Week 1-2: Build Core
- Onboarding flow
- Upload + validation
- Basic parsing (hardcoded categories)
- Results display

### Week 3: Add AI
- Claude API integration
- Smart categorization
- Insight generation

### Week 4: Polish + Chat
- Chat interface
- Error handling
- Loading states
- Mobile responsive

### Week 5: Launch
- Deploy to Vercel
- Invite first 10-50 users
- Iterate based on feedback

**Total: 5 weeks (1 solo dev or small team)**

---

## First 50 Users: Acquisition Strategy

### Where to Find Gen Z with Money Anxiety:
1. **Reddit**: r/IndianPersonalFinance, r/teenagers, r/jobs
2. **Twitter**: Personal finance / budgeting communities
3. **LinkedIn**: Young professionals discussing salary/career
4. **Direct outreach**: Friends, friend groups, college networks
5. **Hacker News / Product Hunt**: Tech-savvy early adopters

### Launch Messaging:
```
"Stop guessing where your money goes.
Upload your salary slip. Get instant clarity.
Ask our AI anything about your finances.
(It's free. Try it.)"
```

---

## Next Steps (After MVP Validation)

### If users love it (60%+ chat activation + 40% D3 retention):
- [ ] Email notifications for anomalies
- [ ] Simple goal setting (save X by Y date)
- [ ] Recurring transaction detection + alerts
- [ ] Multi-month trend analysis
- [ ] "What if" scenarios (spend less on X)
- [ ] Family/shared accounts

### If users don't engage:
- [ ] Talk to them: Why didn't they ask questions?
- [ ] Maybe the parsing isn't good? → Fix categorization
- [ ] Maybe they want dashboards over chat? → Pivot UX
- [ ] Maybe they want predictions? → Retarget messaging

---

## Key Quote (For You)

> "The MVP isn't a product — it's a question machine.
> You're proving that Gen Z will ask their AI about money decisions.
> Everything else flows from that."

---

## Files Reference

1. **ubroke_mvp_flowchart.mermaid** — Visual flowchart of all screens & decision points
2. **ubroke_mvp_screen_specs.md** — Detailed specs for every screen (layout, copy, interactions)
3. **ubroke_mvp_chat_ux_guide.md** — Chat examples, tone, principles, and launch checklist

**Use these together**: Flowchart for navigation, Screen Specs for design, UX Guide for content & tone.

---

Good luck building! 🚀
