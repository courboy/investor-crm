-- Investor CRM Schema - Run in Supabase SQL Editor
-- https://supabase.com/dashboard/project/nkftwhmwowbopyhfjigl/sql

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE contacts (
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
    investment_criteria JSONB DEFAULT '{}',
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
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    url TEXT,
    type TEXT DEFAULT 'Conference',
    format TEXT DEFAULT 'In-person',
    location TEXT,
    date DATE,
    date_end DATE,
    cost TEXT,
    attendee_profile TEXT,
    speakers TEXT[] DEFAULT '{}',
    suitability_score INTEGER DEFAULT 5,
    suitability_notes TEXT,
    attending BOOLEAN,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE deals (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT,
    location TEXT,
    status TEXT DEFAULT 'Active',
    size TEXT,
    price TEXT,
    description TEXT,
    shared_with UUID[] DEFAULT '{}',
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE deals ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow all for authenticated" ON contacts FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for authenticated" ON events FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for authenticated" ON deals FOR ALL TO authenticated USING (true) WITH CHECK (true);
