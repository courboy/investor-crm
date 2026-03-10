# Daily Scraping Job

## Schedule
- **Time:** 9:00 AM SGT daily
- **Cron ID:** (will be set after creation)

## Sources to Scrape

### Events
1. **Mingtiandi** - https://www.mingtiandi.com/real-estate/events/
2. **ULI Asia Pacific** - https://singapore.uli.org/events/
3. **APREA** - https://aprea.asia/events/
4. **Prestel & Partner** - https://www.prestelandpartner.com/ (check for new forums)

### Contacts/News
1. **Mingtiandi News** - https://www.mingtiandi.com/ (new fund launches, people moves)
2. **PERE News** - https://www.perenews.com/asia/
3. **IPE Real Assets** - https://realassets.ipe.com/
4. **Google News** - "family office" + "real estate" + (Singapore|Seoul|Tokyo|Sydney)

### Markets Focus
- Singapore
- Seoul  
- Tokyo
- Sydney

## Output
- New contacts → Added to Supabase `contacts` table with `stage: 'suggested'`
- New events → Added to Supabase `events` table
- All new items get `created_at` timestamp for "New" badge display

## Notification
- CRM shows "New" badge on items created in last 24 hours
- Badge appears on:
  - Pipeline cards
  - Events table rows
  - Suggested contacts section
