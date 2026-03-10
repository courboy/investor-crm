# Investor CRM

Pipeline and relationship management for Evo Lake's investor outreach.

## Features

### Phase 1 - Core CRM ✅
- **Contact Management**: Full contact cards with name, title, company, type, investment criteria
- **Kanban Pipeline**: Drag-drop contacts through stages (Research → Outreach → Responded → Meeting → Active → Closed)
- **Relationship Tracking**: Warm/cold indicators, last contacted dates, follow-up reminders
- **Meeting Notes**: Log conversations and interactions
- **Quick Actions**: One-click contact logging, follow-up setting, stage changes

### Phase 2 - Events & Research ✅
- **Events Calendar**: Track industry events with suitability scoring (1-10)
- **Attendance Tracking**: Mark events as attending/not attending
- **AI Research**: Sub-agents research contacts and forum attendees
- **Suggested Contacts**: AI-generated leads from forum scraping

### Phase 3 - Deal Integration ✅
- **Deal Management**: Track active deals with type, location, size, price
- **Deal Matching**: Find investors matching each deal's criteria
- **Investor Filtering**: Filter by sector, geography, ticket size

## Data Structure

```
projects/investor-crm/
├── index.html           # Main application
├── data/
│   ├── contacts.json    # Contact database
│   ├── events.json      # Events database
│   └── deals.json       # Deals database
├── research/
│   ├── contact-research.json   # AI research on contacts
│   ├── forum-attendees.json    # Scraped forum attendees
│   └── events-research.json    # Detailed event info
└── README.md
```

## Usage

### Running Locally
```bash
cd ~/.openclaw/workspace/projects/investor-crm
python -m http.server 8080
# Open http://localhost:8080
```

### Adding Contacts
1. Click "Add Contact" button
2. Fill in name, company, type, LinkedIn, etc.
3. Contact appears in Research stage

### Moving Through Pipeline
- Drag contact cards between columns
- Or use stage dropdown in contact detail modal

### Logging Contact
1. Click contact card
2. Click "Log Contact"
3. Enter notes — auto-updates last contacted date

### Deal Matching
1. Go to "Deal Matching" tab
2. Click a deal
3. See matching investors based on sector/geography criteria

## Pipeline Stages

| Stage | Color | Description |
|-------|-------|-------------|
| Suggested | Gray | AI-suggested, not yet reviewed |
| Research | Yellow | Researching background |
| Outreach | Blue | Initial outreach sent |
| Responded | Purple | They've responded |
| Meeting Set | Pink | Meeting scheduled |
| Active | Green | Active relationship |
| Closed (Won) | Bright Green | Converted to investor |
| Closed (Lost) | Red | Not proceeding |
| Dormant | Dark Gray | Inactive, may revive |

## Contact Types

- Family Office
- Investment Manager
- Private Equity
- Sovereign Wealth / Pension
- Asset Manager
- Developer
- Corporate
- Advisor/Lawyer

## Event Suitability Scoring

Events are scored 1-10 based on:
- Investor concentration (vs. service providers)
- Target profile match (FOs interested in RE)
- Decision-maker access (principals/CIOs vs. junior)
- Networking quality
- Cost-benefit ratio

**10/10** = Must attend (Family Office Forums)
**7-9** = High priority
**5-6** = Consider
**< 5** = Skip unless specific reason

## Data Persistence

Currently uses localStorage for persistence. Data persists across browser sessions but not across devices.

For production deployment, would migrate to Supabase (like DealAtlas).

## Integration Points

- **Howard can add contacts**: Via updating data/contacts.json
- **Howard can update research**: Via research/*.json files
- **Manual entry**: Via Add Contact/Add Deal forms

## Seeded Data

From Becca's MIPIM contacts (March 2026):
- 17 contacts (including Michelle Ling from HKL)
- 11 events
- 2 active deals (Seoul Office, Sydney Industrial)

## Next Steps

- [ ] Merge AI research results when sub-agents complete
- [ ] Add more suggested contacts from forum scraping
- [ ] Implement email template generation
- [ ] Add calendar integration for follow-ups
- [ ] Build outreach sequence automation
