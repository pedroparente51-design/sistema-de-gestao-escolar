-- ============================================
-- ECI PMO – Supabase Database Setup
-- Run this in the Supabase SQL Editor
-- ============================================

-- 1. STUDENTS
CREATE TABLE IF NOT EXISTS students (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    matricula TEXT UNIQUE NOT NULL,
    nome TEXT NOT NULL,
    turma TEXT NOT NULL,
    serie TEXT NOT NULL,
    responsavel TEXT NOT NULL,
    telefone TEXT DEFAULT '',
    data_nascimento TEXT DEFAULT '',
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ
);

-- 2. GRADES
CREATE TABLE IF NOT EXISTS grades (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    student_id UUID REFERENCES students(id) ON DELETE CASCADE,
    disciplina TEXT NOT NULL,
    tipo TEXT DEFAULT 'Prova',
    valor NUMERIC(4,1) NOT NULL,
    bimestre TEXT DEFAULT '1º Bimestre',
    data TEXT,
    observacao TEXT DEFAULT '',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. SEMINARS
CREATE TABLE IF NOT EXISTS seminars (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    titulo TEXT NOT NULL,
    descricao TEXT DEFAULT '',
    data TEXT NOT NULL,
    horario TEXT DEFAULT '',
    turma TEXT NOT NULL,
    disciplina TEXT DEFAULT '',
    local TEXT DEFAULT '',
    alunos_ids UUID[] DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 4. EXAMS
CREATE TABLE IF NOT EXISTS exams (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    disciplina TEXT NOT NULL,
    descricao TEXT DEFAULT '',
    data TEXT NOT NULL,
    horario TEXT DEFAULT '',
    turma TEXT NOT NULL,
    conteudo TEXT DEFAULT '',
    tipo TEXT DEFAULT 'Prova',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 5. OCCURRENCES
CREATE TABLE IF NOT EXISTS occurrences (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    student_id UUID REFERENCES students(id) ON DELETE CASCADE,
    tipo TEXT DEFAULT 'Comportamento',
    descricao TEXT NOT NULL,
    data TEXT,
    gravidade TEXT DEFAULT 'Média',
    registrado_por TEXT DEFAULT 'Administração',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 6. ADMIN USERS
CREATE TABLE IF NOT EXISTS admin_users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 7. WHATSAPP LOG
CREATE TABLE IF NOT EXISTS whatsapp_log (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    student_id UUID,
    student_name TEXT,
    responsavel TEXT,
    telefone TEXT,
    tipo TEXT,
    mensagem TEXT,
    status TEXT,
    enviada_em TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- ROW LEVEL SECURITY (RLS) - Permissive policies
-- ============================================

-- Enable RLS on all tables
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE grades ENABLE ROW LEVEL SECURITY;
ALTER TABLE seminars ENABLE ROW LEVEL SECURITY;
ALTER TABLE exams ENABLE ROW LEVEL SECURITY;
ALTER TABLE occurrences ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE whatsapp_log ENABLE ROW LEVEL SECURITY;

-- Allow full access via anon key (school internal system)
CREATE POLICY "Allow all for students" ON students FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for grades" ON grades FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for seminars" ON seminars FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for exams" ON exams FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for occurrences" ON occurrences FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for admin_users" ON admin_users FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for whatsapp_log" ON whatsapp_log FOR ALL USING (true) WITH CHECK (true);

-- ============================================
-- INDEXES for better performance
-- ============================================
CREATE INDEX IF NOT EXISTS idx_students_matricula ON students(matricula);
CREATE INDEX IF NOT EXISTS idx_students_turma ON students(turma);
CREATE INDEX IF NOT EXISTS idx_grades_student ON grades(student_id);
CREATE INDEX IF NOT EXISTS idx_grades_disciplina ON grades(disciplina);
CREATE INDEX IF NOT EXISTS idx_occurrences_student ON occurrences(student_id);
CREATE INDEX IF NOT EXISTS idx_seminars_turma ON seminars(turma);
CREATE INDEX IF NOT EXISTS idx_exams_turma ON exams(turma);
CREATE INDEX IF NOT EXISTS idx_admin_email ON admin_users(email);
