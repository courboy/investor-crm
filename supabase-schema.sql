-- Investor CRM Database Schema
-- Run this in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Contacts table
CREATE TABLE IF NOT EXISTS contacts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    title TEXT,
    company TEXT,
    type TEXT DEFAULT 'Unknown',
    linkedin TEXT,
    email TEXT,
    phone TEXT,
    location TEXT,
    stage TEXT DEFAULT 'research',
    investment_criteria JSONB DEFAULT '{"sectors": [], "geography": [], "ticketSize": ""}',
    relationship_strength TEXT DEFAULT 'cold',
    source TEXT,
    introduced_by TEXT,
    can_intro_to TEXT[] DEFAULT '{}',
    notes TEXT,
    ai_comments TEXT,
    last_contacted DATE,
    next_follow_up DATE,
    meeting_notes JSONB DEFAULT '[]',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    created_by UUID REFERENCES auth.users(id),
    team_id UUID
);

-- Events table
CREATE TABLE IF NOT EXISTS events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    url TEXT,
    type TEXT DEFAULT 'Conference',
    format TEXT DEFAULT 'In-person',
    location TEXT,
    date DATE,
    date_end DATE,
    cost TEXT,
    early_bird_deadline DATE,
    attendee_profile TEXT,
    speakers TEXT[] DEFAULT '{}',
    suitability_score INTEGER DEFAULT 5,
    suitability_notes TEXT,
    attending BOOLEAN,
    roi TEXT,
    contacts_made UUID[] DEFAULT '{}',
    notes TEXT,
    source TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    created_by UUID REFERENCES auth.users(id),
    team_id UUID
);

-- Deals table
CREATE TABLE IF NOT EXISTS deals (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT,
    location TEXT,
    status TEXT DEFAULT 'Active',
    size TEXT,
    price TEXT,
    yield TEXT,
    description TEXT,
    key_features TEXT[] DEFAULT '{}',
    target_investor_profile JSONB DEFAULT '{"sectors": [], "geography": [], "minTicket": "", "investorTypes": []}',
    shared_with UUID[] DEFAULT '{}',
    interested_investors UUID[] DEFAULT '{}',
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    created_by UUID REFERENCES auth.users(id),
    team_id UUID
);

-- Users/Team members table (for tracking who made changes)
CREATE TABLE IF NOT EXISTS team_members (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id),
    email TEXT NOT NULL UNIQUE,
    name TEXT,
    role TEXT DEFAULT 'member',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_contacts_stage ON contacts(stage);
CREATE INDEX IF NOT EXISTS idx_contacts_type ON contacts(type);
CREATE INDEX IF NOT EXISTS idx_events_date ON events(date);
CREATE INDEX IF NOT EXISTS idx_deals_status ON deals(status);

-- Row Level Security (RLS)
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE deals ENABLE ROW LEVEL SECURITY;

-- Policies: Allow all authenticated users to read/write (small team, no need for complex permissions)
CREATE POLICY "Authenticated users can read contacts" ON contacts FOR SELECT TO authenticated USING (true);
CREATE POLICY "Authenticated users can insert contacts" ON contacts FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Authenticated users can update contacts" ON contacts FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Authenticated users can delete contacts" ON contacts FOR DELETE TO authenticated USING (true);

CREATE POLICY "Authenticated users can read events" ON events FOR SELECT TO authenticated USING (true);
CREATE POLICY "Authenticated users can insert events" ON events FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Authenticated users can update events" ON events FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Authenticated users can delete events" ON events FOR DELETE TO authenticated USING (true);

CREATE POLICY "Authenticated users can read deals" ON deals FOR SELECT TO authenticated USING (true);
CREATE POLICY "Authenticated users can insert deals" ON deals FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Authenticated users can update deals" ON deals FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Authenticated users can delete deals" ON deals FOR DELETE TO authenticated USING (true);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers for updated_at
CREATE TRIGGER update_contacts_updated_at BEFORE UPDATE ON contacts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_deals_updated_at BEFORE UPDATE ON deals FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
