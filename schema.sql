CREATE TABLE IF NOT EXISTS users (
 id SERIAL PRIMARY KEY, username VARCHAR(80) UNIQUE NOT NULL, password_hash TEXT NOT NULL,
 name VARCHAR(160) NOT NULL, role VARCHAR(30) NOT NULL CHECK(role IN ('Admin','Doctor','Therapist','Front Office','Marketing')),
 active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS patients (
 id SERIAL PRIMARY KEY, patient_code VARCHAR(30) UNIQUE NOT NULL, first_name VARCHAR(100) NOT NULL, last_name VARCHAR(100) NOT NULL,
 dob DATE, gender VARCHAR(20), marital_status VARCHAR(30), occupation TEXT, phone VARCHAR(30) NOT NULL, email VARCHAR(160), address TEXT,
 emergency_name VARCHAR(160), emergency_phone VARCHAR(30), blood_group VARCHAR(10), allergies TEXT, past_history TEXT, medications TEXT,
 family_history TEXT, known_conditions TEXT, prakriti VARCHAR(30), vikriti TEXT, patient_type VARCHAR(20) NOT NULL DEFAULT 'Normal',
 lead_source VARCHAR(80), referred_by TEXT, status VARCHAR(30) NOT NULL DEFAULT 'New', created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS leads (
 id SERIAL PRIMARY KEY, lead_code VARCHAR(30) UNIQUE NOT NULL, name VARCHAR(160) NOT NULL, phone VARCHAR(30), email VARCHAR(160), source VARCHAR(80),
 status VARCHAR(30) NOT NULL DEFAULT 'New', owner_id INTEGER REFERENCES users(id), follow_up_date DATE, follow_up_time TIME, follow_up_type VARCHAR(30),
 follow_up_note TEXT, lost_reason TEXT, created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS therapists (
 id SERIAL PRIMARY KEY, name VARCHAR(160) UNIQUE NOT NULL, gender VARCHAR(20) NOT NULL, active BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE IF NOT EXISTS leaves (
 id SERIAL PRIMARY KEY, therapist_id INTEGER REFERENCES therapists(id) ON DELETE CASCADE, leave_date DATE NOT NULL, half_day_start TIME, half_day_end TIME, reason TEXT
);
CREATE TABLE IF NOT EXISTS rooms (
 id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL, steam BOOLEAN NOT NULL DEFAULT FALSE
);
CREATE TABLE IF NOT EXISTS therapies (
 id SERIAL PRIMARY KEY, name VARCHAR(160) UNIQUE NOT NULL, duration_min INTEGER NOT NULL, price NUMERIC(12,2) NOT NULL DEFAULT 0,
 steam_required BOOLEAN NOT NULL DEFAULT FALSE, gender_preference VARCHAR(20) NOT NULL DEFAULT 'Any', category VARCHAR(80)
);
CREATE TABLE IF NOT EXISTS appointments (
 id SERIAL PRIMARY KEY, appointment_code VARCHAR(40) UNIQUE NOT NULL, patient_id INTEGER REFERENCES patients(id), date DATE NOT NULL, start_time TIME NOT NULL,
 duration_min INTEGER NOT NULL, appointment_type VARCHAR(30) NOT NULL, doctor_id INTEGER REFERENCES users(id), therapist_id INTEGER REFERENCES therapists(id),
 room_id INTEGER REFERENCES rooms(id), therapy_id INTEGER REFERENCES therapies(id), notes TEXT, status VARCHAR(30) NOT NULL DEFAULT 'Scheduled', created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS invoices (
 id SERIAL PRIMARY KEY, invoice_no VARCHAR(40) UNIQUE NOT NULL, patient_id INTEGER REFERENCES patients(id), invoice_date DATE NOT NULL,
 status VARCHAR(20) NOT NULL DEFAULT 'Pending', payment_method VARCHAR(30), created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS invoice_items (
 id SERIAL PRIMARY KEY, invoice_id INTEGER REFERENCES invoices(id) ON DELETE CASCADE, description TEXT NOT NULL, quantity NUMERIC(12,2) NOT NULL,
 unit_price NUMERIC(12,2) NOT NULL, gst NUMERIC(5,2) NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS audit_log (
 id BIGSERIAL PRIMARY KEY, user_id INTEGER REFERENCES users(id), action VARCHAR(80) NOT NULL, entity VARCHAR(80), entity_id TEXT, details JSONB, created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_appointments_date ON appointments(date);
CREATE INDEX IF NOT EXISTS idx_appointments_therapist ON appointments(therapist_id,date,start_time);
CREATE INDEX IF NOT EXISTS idx_appointments_room ON appointments(room_id,date,start_time);
CREATE INDEX IF NOT EXISTS idx_leads_status ON leads(status);
CREATE INDEX IF NOT EXISTS idx_patients_phone ON patients(phone);
