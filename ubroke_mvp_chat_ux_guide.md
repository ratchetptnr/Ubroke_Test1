# Ubroke 2.0 MVP — Chat Examples & UX Principles

## Chat Response Examples

### Example 1: Spending Analysis
```
User: "Why am I spending so much on food delivery?"

Assistant Response:
You spent ₹8,500 on food delivery this month (18% of ₹47.5k total).
Here's the breakdown:
  • Zomato: ₹4,200 (24 orders)
  • Swiggy: ₹2,800 (16 orders)
  • Restaurants: ₹1,500

That's roughly 1 order every 1.5 days. Typically, people spend 8-12% 
on this category, so you're in the higher range.

Quick math: If you cut to just 15 orders/month instead of 40, 
you'd save ~₹5,000. That's ₹60k/year — enough for a vacation!

Want to strategize how to cut this? I can help.
```

---

### Example 2: Affordability Question
```
User: "Can I afford to buy a MacBook Pro for ₹1,50,000?"

Assistant Response:
Based on your data from January:
  • Monthly income (estimated): ₹60k-75k (from salary slip)
  • Monthly expenses: ₹47.5k
  • Free cash/month: ~₹12.5k-27.5k

Buying a ₹1,50,000 MacBook:
  ✓ YES, you can afford it in installments (₹12.5k/month for 12 months)
  ✓ This won't break your current runway

BUT here's the catch:
  • If you finance it, you'll be left with only ₹0-15k free/month
  • That's risky if something unexpected happens
  
My take: Safe to buy IF you have 3 months emergency fund first. 
Do you have savings set aside?
```

---

### Example 3: Subscription Audit
```
User: "Should I cancel any subscriptions?"

Assistant Response:
You have 6 recurring subscriptions totaling ₹3,800/month (8% of spend):

  1. Netflix ₹649 — Are you using this?
  2. Spotify ₹119 — Check if free tier works
  3. Gym (GymX) ₹1,200 — How often do you go? (Reconsider if <2x/week)
  4. Adobe Creative Cloud ₹1,200 — Work essential or hobby?
  5. Dropbox ₹600 — Could you use free plan?
  6. LinkedIn Premium ₹200 — ROI?

Quick wins:
  • Cancel unused ones = ₹200-300/month
  • Downgrade to free tiers = ₹500/month
  • Total potential savings: ₹700-800/month = ₹9,600/year

Want me to prioritize which ones to cut first?
```

---

### Example 4: Income Context
```
User: "I'm worried about my income. Is it stable?"

Assistant Response:
From your salary slips, I see:
  • Jan salary: ₹65,000
  • Previous months available? (You only uploaded 1 slip)

I'd need to see 3-6 months of salary to spot patterns. 
Are you salaried? If yes, it's typically stable unless there's a red flag.

Upload more salary slips and I can:
  ✓ Show you income trends
  ✓ Flag unusual dips
  ✓ Help you plan based on realistic income

Can you share a few more months?
```

---

### Example 5: Goal-Oriented
```
User: "How much can I save for a vacation in 6 months?"

Assistant Response:
Based on January data:
  • Your free cash/month: ₹12.5k-27.5k (after all expenses)
  • Over 6 months: ₹75k-165k potential savings

But real savings depend on:
  1. Keeping expenses stable (no new major purchases)
  2. If you cut food delivery by half: +₹25k extra
  3. If you cancel unused subscriptions: +₹5k extra

Optimistic scenario (with cuts): ₹1,95,000-2,15,000
Realistic scenario (no changes): ₹1,10,000-1,35,000

For a good vacation, I'd target ₹1,50,000. You can get there 
in 6 months with small tweaks. Want to set a savings goal?
```

---

## Key UX Principles

### Tone & Voice
- **Friendly, not robotic**: "Here's what I see..." not "According to the data model..."
- **Specific, not generic**: Reference actual amounts, names (Zomato, Netflix), dates
- **Actionable, not judgmental**: "Here's a small win:" not "You're overspending"
- **Honest about limits**: "I need more data to say for sure" or "Check with a CA for taxes"

### Data Referencing
- Always ground answers in their actual data
- Show the calculation: "You spent ₹8,500, which is 18% of ₹47,500"
- Link back to source: "According to your January salary slip..."
- Show what we don't know: "I only have 1 month of data, so..."

### Insight Delivery
- Start with the finding, then explain
- Give context (how do they compare to others)
- Suggest one actionable next step
- Ask a follow-up question to keep conversation going

### Error Handling in Chat
- If question can't be answered: "I don't have enough info. Can you tell me...?"
- If it's outside scope: "That's a great question for a certified CA. I can share what I see though..."
- If data is ambiguous: "This is unclear to me. Can you rephrase...?"

---

## User Flow Decision Tree

### After Upload → Results Shown
**User's likely next action:**

```
Results Shown
    ├─ User feels "aha!" moment (saw their spending breakdown)
    ├─ Immediate options:
    │  ├─ Ask a question → Chat (60% of users)
    │  ├─ Upload another doc → Upload (20% of users)
    │  └─ Leave for now → Dashboard (20% of users)
    │
    └─ If Chat (60%):
       ├─ First question is usually about top spender or surprise
       │  E.g., "Why am I spending so much on food?"
       ├─ Follow-up is usually actionable
       │  E.g., "How can I reduce this?"
       └─ Engagement tends to be 2-3 exchanges, then they leave
```

---

## Return User Flow

### User Opens App Again (After 1-3 days)

```
Dashboard (Home Screen)
    ├─ Show previous upload summary
    │  "January: ₹47.5k spent. Food delivery was your top."
    │
    ├─ User's next action:
    │  ├─ Upload new doc (monthly behavior) → Upload (40%)
    │  ├─ Ask a new question (curiosity) → Chat (35%)
    │  ├─ Look at old breakdown (reference) → Results (15%)
    │  └─ Leave (lost interest) (10%)
    │
    └─ Goal: Get them to ask a question or upload new data
       (Don't show ads, don't ask for ratings, keep it light)
```

---

## MVP Constraints

### What's NOT included:
- ❌ User settings/preferences
- ❌ Notifications/reminders
- ❌ Goal tracking
- ❌ Budget alerts
- ❌ Portfolio/investment tracking (yet)
- ❌ Tax reports
- ❌ Sharing/family features
- ❌ Advanced analytics

### Why cut these:
- Core loop (upload → AI categorizes → chat) is complete without them
- Each adds 1-2 weeks of dev time
- Can validate without them first

---

## Success Metrics for MVP

### Metric 1: First-Use Engagement
**"Do users ask a question after seeing results?"**
- Target: 60%+ of first-time users go to chat after upload
- Metric: (Users who asked question) / (Users who saw results)

### Metric 2: Retention
**"Do users come back within 3 days?"**
- Target: 40%+ open app again within 3 days
- Metric: Day-3 retention

### Metric 3: Depth
**"Do users upload or ask multiple questions?"**
- Target: 50%+ have 2+ interactions (upload or chat)
- Metric: Average interactions per user in first week

### Metric 4: Conversion to Chat
**"Is chat the primary engagement?"**
- Target: Chat > Dashboard in engagement time
- Metric: Time spent in chat vs. dashboard

---

## Launch Checklist

### Must Have (MVP):
- [x] Onboarding (quick profile + context)
- [x] Upload flow (drag & drop + validation)
- [x] AI parsing (categorize expenses)
- [x] Results screen (breakdown + insights)
- [x] Chat interface (Q&A)
- [x] Error handling (invalid files, parse failures)
- [x] Loading states (fast, medium, slow paths)

### Nice to Have (Post-MVP):
- [ ] Dashboard home screen
- [ ] Category deep-dive
- [ ] Notification when slow parse completes
- [ ] "Save" favorite insights
- [ ] Share screenshot of breakdown
- [ ] Simple budget alerts

### Tech Requirements (Post-MVP):
- [ ] Email notifications
- [ ] Background job processing
- [ ] User authentication
- [ ] Data encryption
- [ ] Compliance audit

---

## Design Notes

### Color Palette (for Insights):
- 🔴 Red (high spend, >20% of category): "Alert"
- 🟡 Yellow (moderate, 10-20%): "Watch"
- 🟢 Green (good, <10%): "Healthy"
- ⚪ Gray (low/minimal): "Neglible"

### Typography:
- **Heading**: Bold, clear, gen-Z friendly (not formal)
- **Body**: Readable on mobile, good line height
- **Numbers**: Monospace or bold for clarity (₹8,500 stands out)

### Mobile-First:
- All screens assume iPhone 12/13 (6.1" screen)
- Buttons are 48x48px minimum for thumb-friendly taps
- No horizontal scrolling
- Swipe gestures only where obvious (e.g., back)

---

## AI Model Context Window

### What the AI "Knows" About Each User:
1. Income range (₹0-2L, ₹2-5L, etc.)
2. Employment type (Salaried, Freelancer, Student)
3. All uploaded documents + parsed data
4. All conversation history (in that session)
5. Category breakdown (recurring vs. one-time)

### What the AI Does NOT Know:
- Full account history (only what's uploaded)
- External market data
- Tax law specifics (general awareness only)
- Investment opportunities
- Credit score

### Guardrails:
- Don't suggest: Gambling, betting, risky leverage, MLM
- Always disclaim: "I can make mistakes. Check with a CA for taxes."
- Don't store: Exact amounts from sensitive docs (salary, investment)
- Do protect: Privacy-first, never share anonymized insights

EOF
