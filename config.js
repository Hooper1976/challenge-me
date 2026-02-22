// Supabase Configuration
const SUPABASE_URL = "https://rfejtxzkahelavltsidv.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJmZWp0eHprYWhlbGF2bHRzaWR2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3NzcyOTMsImV4cCI6MjA4NzM1MzI5M30.pmOns_VkC2XztdgLTIdb_ZvSpo6Ci0OvOhUpbgnJbgc";

// Diese Datei wird später von den HTML Seiten geladen um die DB Verbindung zu nutzen.
export const supabaseClient = {
    url: SUPABASE_URL,
    key: SUPABASE_ANON_KEY
};
