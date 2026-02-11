# Ubroke 2.0 - Dummy Frontend

This is a **dummy mobile-first frontend** for the Ubroke 2.0 MVP - a personal finance AI app for Gen Z.

## What's Built

A complete dummy frontend with all the core screens based on the MVP specifications:

### Screens Implemented

1. **Welcome Screen** (`/welcome`)
   - Introduction to the app
   - What Ubroke does and doesn't do
   - Trust-building messaging

2. **Profile Setup** (`/profile`)
   - Quick 3-question onboarding
   - Income range selection
   - Work type and financial goals
   - Can be skipped

3. **Upload Screen** (`/upload`)
   - Drag & drop interface
   - Camera and file browser options
   - File validation info
   - Mobile-friendly

4. **Processing Screen** (`/processing`)
   - Dynamic progress tracking
   - Step-by-step status updates
   - Fast/medium/slow path simulation
   - Success state with preview stats

5. **Results Dashboard** (`/results`)
   - Expense breakdown by category
   - Visual progress bars
   - Category percentages
   - Key insights
   - Actionable next steps

6. **Chat Interface** (`/chat`)
   - AI conversation interface
   - Message history
   - Suggested questions
   - Mobile-optimized input

## Tech Stack

- **Next.js 15** - React framework with App Router
- **TypeScript** - Type safety
- **Tailwind CSS** - Utility-first styling
- **shadcn/ui** - High-quality UI components
- **Lucide React** - Icons

## Getting Started

### Install Dependencies

```bash
npm install
```

### Run Development Server

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

The app will automatically redirect to `/welcome` to start the onboarding flow.

### Build for Production

```bash
npm run build
```

### Start Production Server

```bash
npm start
```

## User Flow

The dummy app simulates this flow:

```
Welcome → Profile Setup → Upload → Processing → Results → Chat
```

Since this is a dummy frontend:
- All navigation works correctly
- File upload is simulated (any click proceeds to processing)
- Processing animation runs for ~5 seconds
- Results show hardcoded sample data
- Chat shows a predefined conversation

## Mobile-First Design

The entire app is designed for mobile screens:
- Optimized for iPhone 12/13 (6.1" screen)
- Responsive layout
- Touch-friendly buttons (min 48x48px)
- Smooth scrolling
- No horizontal overflow

## Key Features

✅ Complete navigation flow between all screens
✅ Mobile-responsive design
✅ Smooth transitions and animations
✅ Progress indicators for processing
✅ Category visualization with progress bars
✅ Chat interface with suggested questions
✅ Clean, Gen-Z friendly UI/UX

## Design Principles (from docs)

- **Friendly, not corporate** - Conversational tone
- **Visual clarity** - Color-coded categories
- **Instant gratification** - Fast feedback loops
- **No judgment** - Helpful, not preachy
- **Actionable insights** - Clear next steps

## Project Structure

```
ubroke-frontend/
├── app/
│   ├── welcome/page.tsx      # Welcome screen
│   ├── profile/page.tsx      # Profile setup
│   ├── upload/page.tsx       # File upload
│   ├── processing/page.tsx   # Processing animation
│   ├── results/page.tsx      # Expense dashboard
│   ├── chat/page.tsx         # AI chat interface
│   ├── layout.tsx            # Root layout
│   ├── page.tsx              # Home (redirects to welcome)
│   └── globals.css           # Global styles
├── components/
│   └── ui/                   # shadcn/ui components
│       ├── button.tsx
│       ├── card.tsx
│       ├── progress.tsx
│       └── radio-group.tsx
└── lib/
    └── utils.ts              # Utility functions
```

## Next Steps (For Real Implementation)

To turn this into a production app, you would need to:

1. **Backend Integration**
   - Connect file upload to actual storage (Supabase Storage)
   - Implement AI parsing with Claude API
   - Set up database for user data

2. **Authentication**
   - Add user signup/login
   - Session management

3. **Real Data Processing**
   - Parse uploaded documents
   - Categorize transactions with AI
   - Store results in database

4. **Chat AI Integration**
   - Connect to Claude API
   - Implement context management
   - Store conversation history

5. **Additional Features**
   - Error handling
   - Loading states
   - Notifications
   - Multi-document support

## License

This is a demonstration frontend built from specification documents.
