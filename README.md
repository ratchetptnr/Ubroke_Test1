# Ubroke 2.0 MVP — Complete Specification Package

## 🎯 What Is This?

This is a **complete, ship-ready MVP specification** for Ubroke 2.0 — a personal finance AI app for Gen Z.

The problem: Gen Z earns money but has no idea where it goes.
The solution: Upload documents → AI auto-categorizes spending → Chat to understand & optimize.

## 📦 What's Included

This package contains **6 comprehensive documents** that cover everything from UX flows to technical architecture:

| Document | Purpose | Audience |
|----------|---------|----------|
| **Flowchart** (Mermaid) | Visual navigation of entire app | Designers, Product Managers |
| **Screen Specs** (Markdown) | Detailed design for every screen | UI/UX Designers, Frontend Devs |
| **Chat & UX Guide** (Markdown) | AI personality, tone, examples | AI Engineers, Product Managers |
| **System Architecture** (Markdown) | Technical data flow & infrastructure | Backend Devs, DevOps, Architects |
| **Quick Reference** (Markdown) | TL;DR summary of everything | Everyone (start here!) |
| **This Index** (Markdown) | How to use all the documents | Navigation |

## 🚀 Quick Start

### For Designers:
1. Read `ubroke_mvp_quick_reference.md` (5 min)
2. Open `ubroke_mvp_flowchart.mermaid` (visual overview)
3. Use `ubroke_mvp_screen_specs.md` to design

### For Developers:
1. Read `ubroke_mvp_quick_reference.md` (5 min)
2. Study `ubroke_mvp_system_architecture.md` (data flow)
3. Reference `ubroke_mvp_screen_specs.md` for interactions

### For Product Managers:
1. Skim `ubroke_mvp_quick_reference.md` (5 min)
2. Review `ubroke_mvp_flowchart.mermaid` (understand structure)
3. Check `ubroke_mvp_chat_ux_guide.md` (success metrics)

## 🎮 The MVP in 60 Seconds

```
USER JOURNEY:
1. Welcome Screen (30 sec)
   ↓
2. Quick Profile Setup (45 sec)
   ↓
3. Upload Financial Documents (1-2 min)
   ↓
4. AI Parses & Categorizes (5-15 sec)
   ↓
5. Results Dashboard Shows Breakdown (1 min)
   ├─ "You spent ₹47.5k this month"
   ├─ "Food delivery is 18% — that's high"
   └─ "Here are your top 5 spending categories"
   ↓
6. User Asks Question (2+ min)
   └─ "How do I reduce food delivery spending?"
   ↓
7. AI Responds With Context
   └─ "You spent ₹8.5k (40 orders). If you cut to 15 orders..."

RESULT: User gets instant clarity on their finances + actionable advice
TIME: ~10-15 minutes to value
```

## 🔑 Core Value Proposition

**"Don't guess where your money goes. Upload your documents, ask questions, make better decisions."**

### Why Gen Z Will Use It:
- ✅ No manual entry (upload, don't fill forms)
- ✅ Instant gratification (see breakdown immediately)
- ✅ Non-judgmental (AI clarifies, doesn't lecture)
- ✅ Practical advice (specific to their situation)

### Why It's Different from ChatGPT:
- 🧠 Has their actual financial data (not generic advice)
- 📊 Intelligent parsing (auto-categorizes documents)
- 💾 Persistent memory (remembers all docs + chats)
- 🎯 Context-aware responses (specific to their situation)

## 📊 Success Metrics

For MVP to be considered successful:

| Metric | Target | Why |
|--------|--------|-----|
| Upload Completion | 80%+ | Can users get past first friction? |
| Chat Activation | 60%+ | Do they find value in asking questions? |
| Day 3 Retention | 40%+ | Does the app stick? |
| Questions/User | 2+ | Do they come back with more questions? |

**Red flags (kill signals):**
- Upload completion < 50%
- Chat activation < 30%
- Day 3 retention < 20%

## 🛠️ Tech Stack (Recommended)

```
Frontend:  Next.js 14 + Tailwind CSS
Backend:   Node.js (Next.js API routes)
Database:  Supabase (Postgres + Storage)
AI/LLM:    Claude API (Anthropic)
Deploy:    Vercel

Estimated monthly cost: $200-500 (pre-revenue)
```

## 📅 Build Timeline

- **Week 1-2:** Onboarding + Upload UI
- **Week 3:** Parsing & Results Display
- **Week 4:** Claude Integration + Chat
- **Week 5:** Polish & Deploy
- **Total:** 5 weeks for 1-2 developers

## 🎯 What's Intentionally NOT Included

✗ Email notifications
✗ Goals/budgets
✗ Recurring transaction alerts
✗ Investment tracking
✗ Tax filing
✗ Family accounts
✗ Advanced analytics

**Why?** These don't serve the core loop. Validate the MVP first, then add based on user demand.

## 📂 File Descriptions

### `ubroke_mvp_flowchart.mermaid`
Visual flowchart of the entire app showing all screens, decision points, and edge cases. Open in any markdown viewer or GitHub.

### `ubroke_mvp_screen_specs.md`
Detailed specifications for every screen including layout mockups, content, interactions, and error states.

### `ubroke_mvp_chat_ux_guide.md`
Chat examples, AI personality guide, UX principles, user flow decision trees, success metrics, and launch checklist.

### `ubroke_mvp_system_architecture.md`
High-level architecture diagrams, data flow from upload to results, database schema, deployment pipeline, and technical decisions.

### `ubroke_mvp_quick_reference.md`
TL;DR summary covering the 5 core screens, 3 parsing paths, user journey, data flow overview, and launch strategy.

### `ubroke_mvp_index.md`
Meta-document explaining how to use all the files and what each covers.

## 🚀 Next Steps

### Before You Code:
- [ ] Validate assumptions with 3-5 Gen Z users
- [ ] Ask: "Would you upload docs? Would you ask it questions?"
- [ ] Adjust based on feedback
- [ ] Get team alignment on core loop

### To Start Building:
- [ ] Set up Next.js + Supabase project
- [ ] Follow screen specs to build UI
- [ ] Integrate Claude API for parsing
- [ ] Deploy to Vercel
- [ ] Invite first 10 beta users

### To Validate:
- [ ] Track metrics daily
- [ ] Watch users interact (record sessions if possible)
- [ ] Listen to their questions
- [ ] Iterate on chat responses
- [ ] Scale what works

## 💡 Key Insights

1. **The MVP isn't about perfection** — it's about proving Gen Z will ask an AI about their finances *if they have context*.

2. **The differentiation isn't the chat** — it's the intelligent parsing of their documents. ChatGPT can't do that.

3. **The magic happens in the chat** — but only after they see the results. Chat is the engagement layer.

4. **Speed matters** — 5-15 seconds for parsing is acceptable. Longer and they'll lose patience.

5. **Copy matters** — Gen Z hates corporate finance speak. "You're spending too much" becomes "Here's a small win."

## 📞 Questions?

Each document is self-contained but they reference each other. Here's the recommended reading order:

1. **Quick Reference** (5 min overview)
2. **Flowchart** (visual navigation)
3. **Screen Specs** (design details)
4. **Chat UX Guide** (personality & metrics)
5. **System Architecture** (technical deep dive)

## ✅ Checklist for Launch

- [ ] All 5 core screens built
- [ ] File upload working
- [ ] Claude API parsing documents
- [ ] Results displayed correctly
- [ ] Chat interface working
- [ ] Error states handled
- [ ] Mobile responsive
- [ ] Deployed to production
- [ ] First 10 beta users onboarded
- [ ] Metrics tracking set up

## 🎊 Final Thoughts

You've got a clear vision (personal finance AI), a real problem (Gen Z doesn't understand money), and now a ship-ready spec.

The only thing left is **execution**.

Start building. Get real users. Iterate. 

Good luck! 🚀

---

**Last Updated:** November 2025
**Status:** Ready to Build
**Team Size:** 1-2 developers recommended
**Timeline:** 5 weeks to MVP
